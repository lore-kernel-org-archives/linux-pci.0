Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316241;
	b=Bae37L0awD9y7M0sq9TYD67JoVN/sTzn6JlBVUz+dJp9QU1KpI2sUnsqw/7V/MEOe7vm
	 RD9BntNOt2aIUPD0Et4EPzVKWKhFMLiWAiguq3pG7wpcxDwsclLGCLjbhgzDBzFY6RtsE
	 SigdO+Rf4AU6PcNhsWve4KHpySuuUUT44h9gRHkltQHjzbviShcVG7Wyvs7GwHWGuugBg
	 NKqSoxvIrFujJxBny0sj3GIalT01w1EeDcCk7OvwRjufv+DHS64XBP6aLmgX1QwUIGthB
	 7rkLpkWva0rXFn3p/PvSpliVkFjb5uLMZkfhjXs4jIwlC8X+/rMYNgBPq5/ABhsTN5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316241;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=u4zLVHnTkobPJ41e1mxux5zeHM9rWie5mC2ac7V2I6I=;
	b=2Wf/GISaQo3fuW07+AL5He2gnGky49XkylFwC6mt2+gp/IpFeqIQ+i91VKb4eqsYwTOC
	 893gmEto+S/9BH3dju+n3vId7PEjR3fFmUeXXaQUIomZPWuwcuy4Gxh1H/TAXJBUMFBax
	 rmLVDhA1T2MADI7x7zO0ZyipdKIKtoQNK4qV2U8SZAYWcU/6YYiieZgHI2cS80pAU2mwL
	 pw6Vlq29wfLHuZivGu1xhn+xSw9/k//oxBae5jT+KTnatwBs9jKXlO1AN7LtFLRSex3km
	 s3ZEd4kMcteBQbYX8SIM3LtxoS4ytM2QIreE1dR6wxBKl6MmzplEda1K1tQUiJSde9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BT39TlH3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bC1grQZz;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D521606A335
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D521606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BT39TlH3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bC1grQZz
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM09AxL1035402
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4zLVHnTkobPJ41e1mxux5zeHM9rWie5mC2ac7V2I6I=; b=BT39TlH3EBk/ld49
	JlixeU1hA0cxiL2kEiY6fmbgKiIyJJB1u8jLSkwOTiFoOVAVkipG31qadW6sB6qv
	vj5esXrGlHynubmJj/UNOn1dOX856oSo4fPOp2uUZd2jpPknF/2vKoFF8kYBtrd7
	JTapXEd+CIhdUzrfb7DBUFnpfyfBYzRwgLwmwAEtExxpVu3s33wqAvVH5Ky+fbym
	gkxsizMBeAgx+CKUjSzORpDDuPueOF7aJQnUkAHDHwAq11zZFZX3V26CrMF5a3m/
	AU7DJ1jlD16OTURtTS0czTaEbdz+TkPT/UJkp5PkweAQF69ir5jqstzTjaBvPUYq
	C2nS5g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34ka2cvc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:57:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so3684799eec.1
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316240; x=1795921040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4zLVHnTkobPJ41e1mxux5zeHM9rWie5mC2ac7V2I6I=;
        b=bC1grQZzedWDax77gPJPXgpcZd6aCRS8X+RMubfUOBTGbl8dZwJL/wcLnARYeCgCeT
         pPLb38AJHPWWI2nHxqYXLPnvcX0so9y56qSFf7lR7tLbMhEp64LQPe20sl1DCvphZiPm
         mVOa7FnvPw/L7NiUdFslA0nw/wg3isNadvHgSyLo7gRbxgm+CY6J2xFWJLFVUfgnxxHA
         ZbEpU5FElLGjlm4UspjU4OPAjp+rMAnbOXSYEFYd/R3rLNGA2KljRN5NS+VKm/KPND5J
         Tf8QHi9rXWnHgINVvLUhrXuSDE2vzRSVkU7xYbGaFcXElxIJI2Et2jySpCMaRKLi2VEC
         y+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316240; x=1795921040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u4zLVHnTkobPJ41e1mxux5zeHM9rWie5mC2ac7V2I6I=;
        b=zYua/fWcXtpeXzntlYRStKivUUk7L3cZneNav/tt5vxpRG9pEv3BLmUBQlGg1KByap
         L4nv2yb9xFvTJpzQyzITOslZ2kI1r2nGfr78yJI96X9xY8gxjM4U+sEuNgXuz/D6xGrf
         GPLJDNF2liJCyRjMaU1ESMTNNH/mmSgTFPVJ4Nf64EX+hnlVBR9UVWEP2HWTmZNp4m1P
         ItntCYhaYdLojEGxvR96NyKcW3EjCeXT44dhGhfAbkWrYr4byvwbY98XgW/lkdoxED2a
         2zQFOsuLkkgTtgYAHyHr0UjYhXVi+JfFxP8RO/JYRc6GUEMoScg/2CPoBHyd2pXPw/Gh
         +7BQ==
X-Forwarded-Encrypted: i=1; AL+hErF96JBWKPR6Z1k9iMsUzdLrbtABh6RCE2c8nJNA0EJ3MwP/PtBsR6F2Mqwss3dqw9CXO51JJE7wLyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LtH2jLSeUykXcypvKMVKLKulTERFbSLj26Rbzfu/F5+0VH0Q3
	HmB0/fFJnPfFv5Doroyz1Q0Uf+H71nswZyQZ5Q6BvNdQ8eXXXWVZoccyPqjZHwJXFWkuH+llrNt
	gBjrJntnbG/baSzhTkOiNshoCH5PCqzAIA5wFyHCPsDvcCKYBBu4w8jhIZ6JvREE=
X-Gm-Gg: AZFdTZdExz77ZmA9POjup41RXGFCmEVnL8JpGV60REdFK0bOg9NfFkm+L6CRVxkkCYY
	p0BebD5IVXiqk3sb7G3QDYEy4kE8/Hf/pca9vdWGFPccTASYIShFwFAyOjov7bYjsrrEdudeEqX
	SIk8PgDK4OYbPvFxmva+7Nkz8SpJKJ72fs+NQodmoId9PTHY0bUy3Kq56yRySI9ohax4DqBnecy
	sP8q4ZOdeQCwD0uDlzQm6n5J/rg6rUEJJhYEF9it0FIJeIUp+cUlzwOXSyg9pQAr0gEJtLOtfSn
	a7u5sZjVL2DSddWX2FkXCbUIv36ldAhUzdoH2kQ0ELqChBm0N+sQKyu4k+2lg0DrUHOLhxtuz1D
	SihDU6GrYZDdPZkSheh5eHfehyyeJc33eP5wBSwbyYds6tyTKaZD5wbzSlNlZ0eM8hwLd+IE8wk
	zAbPmaRoL+
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id 5a478bee46e88-38571223ee7mr8559657eec.40.1795316240052;
        Sat, 21 Nov 2026 18:57:20 -0800 (PST)
X-Received: by 2002:a05:693c:8641:20b0:383:50b7:1d78 with SMTP id 5a478bee46e88-38571223ee7mr8559612eec.40.1795316239376;
        Sat, 21 Nov 2026 18:57:19 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:57:19 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 08:26:20 +0530
Subject: [PATCH 07/11] dt-bindings: PCI: qcom-ep: Add Nord PCIe Endpoint
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-nord_ep-v1-7-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316184; l=2668;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=JAHLcpWrndJ7vGe/EsN0GzNIf7dKlfRU1FzcikKsx5I=;
 b=kghpNVosYGIELkZVpk17V4n6t4JpVd1dJQKucE28HGajI72vINW5LpLNGFPaZ5JvvIGM+RkW8
 7mmpI8gxDj9CTU/PNuAn3ONGLtnOSFqxRWzq6KRvIPQ+7FGZS/vLPe7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX2BhwWIELBj18
 wZ1yRwE3SdVBWPUvTKDvo9U/MrnKBYG4ICPZWhbF+P1pPh893zCLbuds8aVoD+AE3QyHw1mG5JI
 /EKWgGiRSIh+oVK5cSRCNbvdxFMfaeP/esThLHZeQScFD6nsCzAZ2pmOO+TYATrydFF7L7mCHAm
 0FVH94AqO8F6vNIzIxyKqzRwlne9CkRJIRIL6ztzVZhqU5h21G0wQJngaFScwFdx89ys3urvbZO
 OLmawtIyqh7KcmDvRfE0b2UY6M7+3R2ju1ZRc1dYpZu2obwZqT9lwgz0SU4Q9deRkpVzl7cxxyF
 qnIL6G3JVcHJ+6KGd+rbF9qjlUgg0ha67762aXeMC/KNyAplxYVTCLJMk195ldEWdIYMZHu8B2m
 q7ash3d9a2SgC7lOSUdS9Pfa0NfVyklyzc3HpR6LJhqcvgQEvenbGvY3mlvfhlRT4vyGe/Fl0p/
 00+DBnsXLg41wKfNt+g==
X-Authority-Analysis: v=2.4 cv=RJEmjIi+ c=1 sm=1 tr=0 ts=6b025a10 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=FC_8z62UfPBbNpSbB3cA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: bmfGn0Fv-6Ehsl58DEYnDYmsdEpEILhx
X-Proofpoint-ORIG-GUID: bmfGn0Fv-6Ehsl58DEYnDYmsdEpEILhx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfXxIgW5PYGZTZ/
 vSBz7foNz/fX8SBRcER3xK19cVFpv57lZswjGdlIlYYQsOv87jGWffGft8rxvQK7Be4kdh/2usm
 QjqxgxcRNTRnVdQtfdFXMyVwDQ5/jmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220011

Add the qcom,nord-pcie-ep compatible for the PCIe Endpoint controller on
the Qualcomm Nord platform.

Like the other DMA-capable controllers, it has three interrupts, requires
an IOMMU and uses the same five clocks as sa8775p. The instance that
supports MSI-X additionally exposes a dedicated MSI-X BAR as an eighth
"msix" register region, so permit Nord to carry seven or eight reg
entries while leaving the other controllers at seven.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index bed9a40b186b..9a6a7f6f7f62 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,6 +13,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,nord-pcie-ep
           - qcom,sa8775p-pcie-ep
           - qcom,sar2130p-pcie-ep
           - qcom,sdx55-pcie-ep
@@ -31,6 +32,7 @@ properties:
       - description: Memory region used to map remote RC address space
       - description: BAR memory region
       - description: DMA register space
+      - description: MSI-X BAR memory region
 
   reg-names:
     minItems: 6
@@ -42,6 +44,7 @@ properties:
       - const: addr_space
       - const: mmio
       - const: dma
+      - const: msix
 
   clocks:
     minItems: 5
@@ -185,7 +188,39 @@ allOf:
           minItems: 2
           maxItems: 2
         iommus: false
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,nord-pcie-ep
+    then:
+      properties:
+        reg:
+          minItems: 7
+          maxItems: 8
+        reg-names:
+          minItems: 7
+          maxItems: 8
+        interrupts:
+          minItems: 3
+          maxItems: 3
+        interrupt-names:
+          minItems: 3
+          maxItems: 3
+      required:
+        - iommus
+
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,nord-pcie-ep
+                - qcom,sdx55-pcie-ep
+    then:
       properties:
         reg:
           minItems: 7
@@ -263,6 +298,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,nord-pcie-ep
               - qcom,sa8775p-pcie-ep
     then:
       properties:

-- 
2.34.1

