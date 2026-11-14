Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618812;
	b=LmF14LN6p5tGwmSutio+pE4RY7uTOBmmSun5WEE1UgpuBT9Zc/663RD0TlUfA7wqh2Dg
	 wBxfjSNLVRXLI5TvwVsIAkK1LJQaAv1CMjBha1cztaMNYcFqk3huG2gyAIafvhyT9tO62
	 qA39bpbWe0AKI5GgiK2zpOlDAYoiexIPpawsueI+qYiAklERRLv3lUlSxOKUY1URI1rjU
	 GS5aink1+6+C25okGxzkePlhBBiEmUhQdTAp0BNUlveZKkHaBicQVP/D0AwdbbIgU5Er5
	 +uyUNqizD5mDZZ1U4KJReMfqwAGR+7wn+zrD4cI1z77FcZm4lZCu8jrPn/UeETq36pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618812;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2l7a9FO0SEOjp6R61ar4S2cjWp3e1qo59RxK3Y3Hkz0=;
	b=QFvhmNp/b9qk5a31K9r1PKTTj4sADkf3yDbeoFKYSyNNOWiwG7DYG+Suw/ZbQtaDxheN
	 tZwm2ieCd/RfriDp+lP7TdaGZpzcHUbC92hfoWYJrPS8pL51EFw1x9FuT7qk5dlrt8wol
	 Ttw9cvLXvYPG2JT8ITKFNPXCTiL77/MAJzCwYf9Zbn/zH/p2DeBjLbtw3LZVlGLIEvb4b
	 +AOgj2XiaR92ZE21p6CMfaDzRFXiSktzRGtas5MY5cbwl/sOnZfJpYLo53nnhgnBqZb7c
	 GPG/pPy6SA0vqrJyT14MUnhqEtVZL1S6ZVf662x+rWMlreq1TAslaqRwix3C/6aUebA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I9mSvnqb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gJWHrj1a;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D3606A330
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275D3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I9mSvnqb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gJWHrj1a
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADMbckn1853328
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2l7a9FO0SEOjp6R61ar4S2cjWp3e1qo59RxK3Y3Hkz0=; b=I9mSvnqbty4lHCSv
	1V595++OyJ0Z7aRn6JLT1RWafjthvzluXt7l7lECWu7HIM+tHjC+r/f8R+Q1C/zU
	ONKicF/m1XRxxqPKr99YWutec/3+Z0cv9qnDTRR3N3newo2P8weSkVIgcbNRwhK3
	ddhEyHjVcHJLiFmxHYk7jA8bby1bC/u0+PRYtZ8FcK5QoCwHjUAA6jTD7yfQlQo6
	YaYZ6YhcpYB3j85AB0kTyxy8INxP730SOy+zt75XRZgVOeE1o/fbp060PO4+BBwV
	TcMvIqREBnAxOmVUeFIOmUWrG9tPym38R2bAP5mdMC93Jb5f+SrOaQAmlqe9mZZV
	0eaZag==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxahj0nap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:13:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36ecd5db581so2089992eec.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 17:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794618808; x=1795223608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2l7a9FO0SEOjp6R61ar4S2cjWp3e1qo59RxK3Y3Hkz0=;
        b=gJWHrj1aWR4K3UaBmcUAajKuAOA7CcUd5hD3gqQEwKtWXqd6qK8Ot6lm1XohogntqZ
         jcIP9GjgD2V6Em99K5mdv0iHfgnCtciABAClQGnIhKqKgxOuO3NnxYsuDIRJD1yV8yZ1
         ym7dwpdwUtpU36YrsUMcVhkTJywE9Rka6FUmEw/CSEMIByPCp1ZuwpHt4Tvr44lMM9be
         FKibJl36IzFu8jFtgEv99zFhPeUssJ82ohF7w8T68ULj61ufRKv+N1MzHRpHfebbrQjc
         ZV3rgGa4MKQgnzmTMRN1zlHOi0iBVWXrcjgNm6uht0bn57Q8L+nnnDrwuY6bmw2DQc7r
         YFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794618808; x=1795223608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2l7a9FO0SEOjp6R61ar4S2cjWp3e1qo59RxK3Y3Hkz0=;
        b=2P3hnLS2NSkNsT/qskSQbI6v0lbhCLz5I6rQfENj0hQ2kytac6hzp+h41iYE3qKBFY
         sIqtZQKPcp2REZ2KBOXwgqRx4+y4y9d2HpM1XNEEvGiUFFz5YsXlBUfdR7LbY1TnIBtZ
         2x6wpq/PC0qLst0htRkxV7YZigU89mkFIbKY++6cZUA6xK//RIhgN2dsDfpl4DIh8YC9
         B46t5B6fF5kDCahikTaOoJHph9SI0YwFs6Yw6ssM3fAiDJOTw4gf4lFXrNjSPXJwJ8xI
         Sgil1tzdEbiy2IOOc4QjnHGYBdBp7128HSevX+iuIduT6wI9+pQoQaJKMoThuVEBE9GH
         T6mw==
X-Forwarded-Encrypted: i=1; AL+hErE9JBBgk6+DOpNcHkYbEGYOvL5mSI9q3EPCYCv4KShSwffHKheV1IlMV1QZcby2qFVWvEZzpt3sTG0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/BaUNWtt1nRkKMDTBbAp41wVjj1cMA6mGVVqTmQZXPQu5pwHdo
	vX3Mx+c+cN5xVefPPRGpWitCjJs1vK/Xc+LR5F6pxdOc2wnr69NCxU4Bw8ULIM3ZXwJF0Nrk+R7
	UEfvcQP1zvaEeX1OC4uzFO/e3D8AJcMKE+5cZ4TOBisN6A/2w/ikwxD0cVMZStsg=
X-Gm-Gg: AYBFou23DSnF99o9hTWLxASsBcwi6O4ks9s6e1eDsVR4aUZrNl9a0k0wunvpqcAP0zQ
	+9mBHkY2/wkteCHyQdJqCayJ/fzbP+hlSi133WzOp8oszkwLcp/Mma7Yc7v+OZaI3n4apGxRy+J
	TOiBViXvnio0ldD1VW6TfrPOz/jrVXYpZLKFMKbvoCcQkE1gH8aTICVop5+Ow2IpA6akbZoXJDG
	lAfPzdbur5+2X5YUYhZYt3dqTXFmFAwaQwz5+cqv14lPjhsBUvEC6Gj+vQpNrRQgcyhBtHTIoYv
	U0E7tq4fsLCc83X3Vo2UR8GSCXq/tqjv28wyXW1PRzW17/OxC1oXIuQU4J08/3wZ+1ubGHjZ4qJ
	aCvySjfgtdnp7QFcyrJk6a520j/KJbk6+I4XTeeR/AkM/L99gXRX4gGr1+mhi7FEqrz1tzr0vSk
	zXyMyypKA4
X-Received: by 2002:a05:7301:4d10:b0:377:58c0:22a7 with SMTP id 5a478bee46e88-379655d4493mr3179177eec.6.1794618807950;
        Fri, 13 Nov 2026 17:13:27 -0800 (PST)
X-Received: by 2002:a05:7301:4d10:b0:377:58c0:22a7 with SMTP id 5a478bee46e88-379655d4493mr3179154eec.6.1794618807286;
        Fri, 13 Nov 2026 17:13:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10952813eec.3.2026.11.13.17.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:13:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 06:43:04 +0530
Subject: [PATCH v3 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
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
Message-Id: <20261114-monaco_ep-v3-2-7fe227cdfac0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794618790; l=1137;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=s5Y87Am6PDDfuUvVslWLtn/yo2Q7MJcUCKhSdRzo2nI=;
 b=Jk36zBCLoS8UAywAYb2ft0Os2UknwfK1EJL5/lVvHm14BbQvBzWXaiRlezKB7UMZKQQ6d8atA
 ozomEkdv8gGBRRxGGqYHEIiuIdlL9j3swKMKMRm04TlBLJa/Y2CdvER
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfXwQ17vBKujcKj
 X7hclCPIGO0/QWetSI+LTGgKEnXBkv8kM8FcTcDXOwrkb+PRkWnhq7P6hYxEZsJk5OPSJuzaykH
 KIQqN13Gg2k2gEq1Ff4ilj8v28Z/zfbQCH/Glj6rVXdU2C0etpbT5SYmMbbchvBkbC534okuWxV
 MFRreQ0/JXSGTASetm9WJW/ycnvVlKYkr/8F3dOAhV4S+Y4CYuywq6YAtGBAGWWuok5djsPN/TF
 UPK8qPFjjm424PBwGhyHSbiuoqEPegFrdW/Y+7eL0YTeMecrAK4DuUOIEH0RsWJjj51K15wOwVa
 aWj+acfMcAoJ8HT9FI54XqebqHcCUurWGRaM5q6dm5R5ZFOpcGTPi/WO7i7greZ0U1+ccSQjh5K
 +XJ0Lu2HNXPhAeg5nO5fAv26DE9SfH/339tTvssOsx8BPjD22/oVSzCNMFAENhefGh2fhD9Je5J
 LnmWX7dvDiOzPya1yRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAwNCBTYWx0ZWRfX46oXggLk66pj
 Gq+7earEuURfCFHvJ91otrZSZfbLodCfj2t7XMkltnfWwysCw1Y7HrbUyAOa4vI1eZ2rDvlQtMe
 N6di5TKlcOBeD5XD/ULkwmvqNh2Q7AY=
X-Proofpoint-ORIG-GUID: 44cT4MdIZZVuiB1GjLtM3AIbHi4cGLwj
X-Authority-Analysis: v=2.4 cv=Kv/YSmWN c=1 sm=1 tr=0 ts=6af7b5b8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=AUvBg9Asf6StguVY0UIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 44cT4MdIZZVuiB1GjLtM3AIbHi4cGLwj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_07,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140004

The QCS8300 PCIe Endpoint controller is compatible with the SA8775P
PCIe Endpoint controller and uses the same programming model. Document
the QCS8300 compatible string and its fallback to the SA8775P
compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index bed9a40b186b..1ed0b97f883c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -17,6 +17,10 @@ properties:
           - qcom,sar2130p-pcie-ep
           - qcom,sdx55-pcie-ep
           - qcom,sm8450-pcie-ep
+      - items:
+          - enum:
+              - qcom,qcs8300-pcie-ep
+          - const: qcom,sa8775p-pcie-ep
       - items:
           - const: qcom,sdx65-pcie-ep
           - const: qcom,sdx55-pcie-ep

-- 
2.34.1

