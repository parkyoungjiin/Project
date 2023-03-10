package com.itwillbs.project.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.project.vo.BuyerVo;
import com.itwillbs.project.vo.ProductVO;

public interface ProductMapper {

	//---------------- 품목 등록 ------------------------------
	int insertProd(ProductVO product);
	
	//------------품목코드 중복 확인---------------------------
	int existCd(int product_cd);

	//--------------품목 그룹 리스트---------------------------
	public List<ProductVO> selectGroupList(String keyword);

	//------------------- 품목 리스트 조회 --------------------
	List<ProductVO> selectPdList(String keyword);

	//----------------- 품목 info (상세)-----------------------
	ProductVO selectProdInfo(int product_cd);

	//--------------------품목 수정----------------------------
	int modifyProd(ProductVO product);

	//--------------------- 개별 파일 삭제------------------------
	int deleteImgFile2(@Param("product_cd")int product_cd,
					  @Param("product_image") String product_image);

	//------------- product_cd 중 가장 큰 값 조회 -----------------
	int selectMaxProdCd(@Param("product_cd")int product_cd);

}
