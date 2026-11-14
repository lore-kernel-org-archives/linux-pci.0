Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618804;
	b=Oi4wcgDTQ9N5BbcExY2urshoXtLzTJd9MIjWg3GVINEashUR69bvcI2fb/xx3tW4BLrR
	 Lgb3Omb4XGaaO0XZ3XPThcL1DlGCORgePGeAagBQyrSzLi5pSxRXkh7tpDmKBFH5WeXbg
	 S8zg8qtOKAMU6q5E0Oxc2gY/WAkYVr+dZCKfkYb4k8LE+a8lP/q9sVb8Uj+O+Ym26pLFW
	 IigChvymljVDIB01DW2x+1HgZ/Xxlsx9wP9jcvFwTAfc/p6tv8Y4C5yasRFqcNZa8eOnn
	 Gfp11htAbOSRNtPBGBVG97VjpiarQ+iYb09hdaIK/WhgoX3efJKsjt6617wCAPoVI7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618804;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EjC/Uqu8Fpc5YyfEaSNx3RgivzcI3gmA2KSFjoMigrw=;
	b=PfCEqyj/gpdoz8OCj/AF2BVWeWlqspb1C7JNKTVMIdyj6rvj0M6MMEck8wlmM7tq1CrV
	 psOD2eJmkQEbtDTVcfIuBEimsynUBMy9djTtIkHxeKhPOh+1mHsq17SEl2sMOcMW9ncu+
	 jrY3Nf8+k8sXh27QyS2FjtMaS1lN2K7GXGYmhfMAgP1eA145Mn7NsmHHZPwwBQLspPFdf
	 6+1dfLjHPYNMcMtBBcd+v/RK5FHEF+dmyKQKluWarFOoDRYOQdIIjxtPz+b0SIB36bhiC
	 yiEOOqokWX2tDIfL4vgUoLlwTz9KG89ZGFPHt8MamD0OZh//4hdWKVkyWAvo8CPKFfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CY7JYz4b;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TpX2Usp3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099F606A884
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6099F606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CY7JYz4b;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TpX2Usp3
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMbgOL1853444
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EjC/Uqu8Fpc5YyfEaSNx3RgivzcI3gmA2KSFjoMigrw=; b=CY7JYz4bBwcC7CKk
	4lP+QE1DtXSgTu/2oE89e6SrIMXJY/UzMyuuD3AT9QM9wnaUWUzmSJr7HbWTFcmZ
	BiTN/BOwSHO4L8RA+SjKZf6TQr0JOGj6hx2cZS+C9aFqnU0dOmcSwFr30Lilkddp
	fUUVatB8q2GswZInZx8dzUL3TqzPiNEUwjM+h0CAG5rwglR0Em5Njlvp4+8mYnD5
	pddU5RsO8aX1z9lnpDhnaCtYxWRGH+kBQgCwAj9RX9Vs2neVxcHZ/hBV9VT9WBfX
	GMaB6cxxd1oaQOZNiaEJHbhvaCCLSHCsc813D50DMfvgolAvGe+UjiYNpCE5+wSr
	Rnowlw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxahj0nab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:23 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2338074eec.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794618802; x=1795223602; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EjC/Uqu8Fpc5YyfEaSNx3RgivzcI3gmA2KSFjoMigrw=;
        b=TpX2Usp3gNY6oebVbcqEYaohAacT4YtlLHQ/hILiQE9/T/MFcZiQujg4aR/eM1bKOM
         ZMae2tw+YIYYk2e8QAUeO7IJPaNY132guZOzmvMjic/I55FkSxDx1I9c270i/7Qiv4IG
         OttUdeOaEv6qWTronKDHob2hB7Ny09pndGPihKbi9EgCngDfmNpTPjlUYBDMCYsyKYV4
         fpflsC7pUzXeHDdD2mbrOPaC1aUA6mc4vghS52KUIlyrmhXJde1jZBpRBVdUrKuqtsRG
         ZTpCR8siPYR7amlDXQeqHVaZQJNTZgkmBjcaO5HD5MaGNZE3u+p0rA0QqWDLQhst9h1K
         9zrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618802; x=1795223602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjC/Uqu8Fpc5YyfEaSNx3RgivzcI3gmA2KSFjoMigrw=;
        b=UtajT49r/Za0bc6OTQf/faDQndWrWKDu7scPwJzlX8VbBfT/1LbpZMM0uofKjCxQjf
         zuZ9etPUoJlT1CWmY4OBgiKtvXh09Vdv3P8lKjylp4+uxm/ffrFBgttZrtL5+vWCf9hZ
         TDsecCtTDZz4knVg6zx+VQZn38BVFvw97FjamBUrdpViJPbcOdVL7lxpRjdmtbCc2uZG
         u7RLgiWxwDqcE/iQaK7/sHA+lB8GZbP8iJWbs7zDMnA39w02oELbpZk0Pr1oWPh4sn++
         7lsxl0U+3bVd8u3hxUPZrSYv+P45NeVb/GQELVuKP+vBPAcH4YosgWHbOqegJm5fF615
         5cPQ==
X-Forwarded-Encrypted: i=1; AL+hErGp4zG4GpxkA9YtP/qxezVGWjEefDEkhBcVoV6jEqN+j/Bzan9sSmbMtUAz6j8K9lRo4GSyy8QWcQA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/RrrVmbNLsZtwYbZfrONsP9bGqanb0ggdWRegh5Ih2DC8mvusO
	hwVrMBp33et3n7AaCD1sWy3tosD8oCR7jWdJtMNrelgv7jnxXxVEKKUv9Lqmd5DBsZlnHYluh7/
	JCQEtpigEkkfQZwut+7UDkIuw5hGD0MNzEhYT1AxSpiwbOwkVDYgj4uZYkN4JQvk=
X-Gm-Gg: AYBFou3hGS0h14DRXlvllFIuo0HN6GTdJ775OiP0sjA8ySND4zXsGhpJC+9GZ2RxKuH
	/n6qPyFGa6J/WgpVoTlQqW4JeV34UDwa/UMLJbxDjdcx1tNzMqtFu0vUOX0xFv0TdxPnlkp0iwK
	3p79sawjSL+qx1exojyyS27xNyAYXjLkXLAYHsXgogCosBoO6VHg6z8Po2zmNOHrU8UxH8LbmMz
	MplpQFY/cuJaKQdNCUI/puGLRYiKoR1o/qSrLhYsylmZsJYUSnPqTLdRzPxkLXogwYvMjlUkk3f
	UEm28ICc2Q23fM9ibzGPIttXTqsib5wc1FDRe+zKsRgwtQfZ07eaFhPT2NoVkltXY9IATKmn4Tw
	2lpJlMDcn6MMuNBVufSFwHIwjMl8S+rY1D9DouzbmWXTfvU81gtYVlo9yUVdymrCnrnFQWh+Hdk
	3NohnlAH8q
X-Received: by 2002:a05:7022:1e0d:b0:1b3:bae1:f5f3 with SMTP id a92af1059eb24-1b503068228mr3231049c88.6.1794618802269;
        Fri, 13 Nov 2026 17:13:22 -0800 (PST)
X-Received: by 2002:a05:7022:1e0d:b0:1b3:bae1:f5f3 with SMTP id a92af1059eb24-1b503068228mr3231019c88.6.1794618801698;
        Fri, 13 Nov 2026 17:13:21 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10952813eec.3.2026.11.13.17.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:13:21 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 06:43:03 +0530
Subject: [PATCH v3 1/6] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add
 qcs8300 16 GT/s PHY
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
Message-Id: <20261114-monaco_ep-v3-1-7fe227cdfac0@oss.qualcomm.com>
References: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
In-Reply-To: <20261114-monaco_ep-v3-0-7fe227cdfac0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794618790; l=1515;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=bU8CCkmWS7rC2poZZ53djxBqRGU6cUp1YOnSmcwnl0c=;
 b=zMfsxTErxY8hECwKm/R99bDrh33rFO98c02vXxvjBrvEcS0wCoMcqiVEOgmOdFGkJv9hG3guR
 H5qzlkBd4oCBl573JqURKYdapEMgFG5Y0lETKX9JhU2KrJXGhQz7T19
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX1GOuYuebGAch
 28d+Rzov+IueS+NyVk9rVYh4zVYk3lZhcbGYBXAJ4f9vrpeV6NA2iQ+1/t1xyNYvGZcYAhGWin6
 ZXga+y6usEPOh2//alphwemsk+PhWCfqV306rPU8R2f9hjc9M/NbZUSSKNwyXu8HgPGMZZ8uRAG
 GrqoNcM/mD20I7h3QBL2xYqgXdggNkkhnXM4P9EC9HFGNWmAp+6Arddf/K4UUMlv9KjINl19O8e
 PKZivwcMIGu1/f9m5XuH44jqRVlUlCt6Epu3OqiYGFx7qTqBfi2EFBraUbGeBOcwlbcep9iFZfR
 40lCRbws09eR18Ljj6z6GFJT5IsQ4vPg7ILP6mVUeV953x1iN2tDebGPDLbZ3SVfemA44r6QiPc
 E8jvnI3At2VQAv19xBuU+udIj1E+32q+EGKUSE84/wB30l+XaZ7fHmP75R9MV8FQPsKtV0Z5yiv
 W2md4mDhSprCY9M2WjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX7R0lUvS/oLcQ
 utN4SOQvEGzs/xhgDbsX4gpw1Mw4mToHpSxfsN/sTswuwOy88dkHbziyenuLFu2dCOyqdsTRxXx
 4ri7rJEQlccrKCMpWhvu6dtID5+kc1c=
X-Proofpoint-ORIG-GUID: S2UD6p_B9uKAQNVB7B58_gAibKsVcD3H
X-Authority-Analysis: v=2.4 cv=Kv/YSmWN c=1 sm=1 tr=0 ts=6af7b5b3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=LyAK_bMyhA_l01y8gmIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: S2UD6p_B9uKAQNVB7B58_gAibKsVcD3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140004

The QCS8300 16 GT/s x4 QMP PCIe PHY was previously described using only
the qcom,sa8775p-qmp-gen4x4-pcie-phy compatible, since no QCS8300-specific
compatible existed for this PHY. This was a mistake, as it left the PHY
undocumented as QCS8300 hardware and indistinguishable from SA8775P in
the binding.

Correct this by documenting a dedicated
"qcom,qcs8300-qmp-gen4x4-pcie-phy" compatible, with
"qcom,sa8775p-qmp-gen4x4-pcie-phy" listed as its fallback compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index c0a3e1f160ad..8d0924fa928d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -24,6 +24,10 @@ properties:
           - enum:
               - qcom,maili-qmp-gen4x1-pcie-phy
           - const: qcom,hawi-qmp-gen4x1-pcie-phy
+      - items:
+          - enum:
+              - qcom,qcs8300-qmp-gen4x4-pcie-phy
+          - const: qcom,sa8775p-qmp-gen4x4-pcie-phy
       - enum:
           - qcom,eliza-qmp-gen3x1-pcie-phy
           - qcom,eliza-qmp-gen3x2-pcie-phy

-- 
2.34.1

