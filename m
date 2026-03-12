Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225263FF8A9
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341034; cv=none; b=PMzJ3Dfu/vJFzpBWsEWM1LK7xgx5FsNj1VeFpxd9BlCAEZABOFnwmoOdGLgaJY/KXR9v1ef9e1JRlHRG1VAkI61+hqfv0LvSscIs486dfT4biPCtivX/jv7wtxw0ZZxSCrPCkOK5v0F30Px6crY+DgZ3Xn/lvObjYc1ntFpKSFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341034; c=relaxed/simple;
	bh=0tXOIBZpahIMNyxmlfBim1P4ONHHre0IuoNhHAjYNZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+/cP3Oo0vvufixRwK1zojNNJjwCxdNviZh1kIxDOe/YWRQKy8mSR1FCFR2JRN+p32XA50MRXToNmFMk1lmeLeGIfqNG8qHeQuzbgTm3FVsLhmxgtmukxcPkefmcJHxx0OrBD5RwIY6W3OSqEm8rqdAuEW0RqDFHidOBVZFN+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAoECN8A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MUP1/5a/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAoECN8A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MUP1/5a/"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CALhcg4026710
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 18:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+HkoqHNIcmwOZo+SK51MwxHYbRzqLjxvTjL
	ro1qNdYQ=; b=TAoECN8Aye7D4KBxiEOgktoqObJEg+36z5lQrQ/gtV/sVgoId21
	jXrRr5QbkEfwmcSPSrUeFPNEM6Uz6QAY8ISrrGuwDCGpvGZVrf9abwUV1KmWivc5
	AafdBTW6n2Tckf+oisYh4IQI7MPQmF1dGCWvchVFhQq1C0LO0GThZVkUb6R5zaEP
	yR2dMOC+G4fxbSZZJtiDFXQySjCiEZBHzUDIr69ImBeLSip+btXj++jybIOErTN9
	bDtHpYOgWaigHQ4MYDAexhx8FxqrKBgp3CdCtCaX+mKqUyzBJf6Pul5WnC7jdNMF
	oY4+l9BeLQJfVXvZ2IS6U4AxXsnSzW233XA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh54u5ke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 18:43:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7fc27cf7so712579485a.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773341031; x=1773945831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HkoqHNIcmwOZo+SK51MwxHYbRzqLjxvTjLro1qNdYQ=;
        b=MUP1/5a/5GifKN2Jyl2N4jK8kZ/fshNjGumuva32nrOYN11RPjZpj5uBWbHCPDsAIi
         6TDpnN3KaQW2xsCXE+kQSCXrH6Sj1qcKKuUZRwVDvZDuw/Mz0/PFW/gxTPb8A6QW9YQe
         lxpIY8jUPb+IkXJeU+xqUrXI2nAHo3CK6I6313DPqIVh4Sy5c7G3yD+dDIO/h5btSXYe
         PzbzCrFvB8wLE5PxZHU8gEVtEV/lLibGh6t5kMck4hdWZObPWOCDMKXhBOVY7qXYWqHS
         UDLOgNhP+dmeDWQtvWKNcsE6kJ/kWbN1EkZkvr/4vEjko74pqdpJMOaiCTC0+qpsKzZ2
         wc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773341031; x=1773945831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HkoqHNIcmwOZo+SK51MwxHYbRzqLjxvTjLro1qNdYQ=;
        b=wcyl3EfqfBQl3gczllnU8WBohWs4+z39Cj1UvxNwUCTWxfi/2S/3PVb5rhcq7XfWjA
         aHJrttWJu0hGSXBQFjDyurQmdsVpn4hvy2q9EFonHHpJOAlt7UTvRTWoG4GUwvtJfJH7
         0NrCKcXVgeQhh2dV4xgBH8zmlvwaVnMmoiB6quUZkJAISHrbjpYWmyZ3s0FkJ42lfYdz
         l/PGwY7ssdrew0thnh/QHTWbstQpaouoE4XubaCHwc2wGGSgRrgGIUTocQPWxmb2haKz
         ZYrFC1Hdlkr/gIcRdmdBUsQcb7eYvkIKZZ/wtg6QKDF9VJQAqFOrdoj0x+Ldhi1xaKk0
         +fbA==
X-Forwarded-Encrypted: i=1; AJvYcCX3nuJqg4L/SVJ4KnRUNneTNdn//v1LdmhgmxLT5uiQwbWsDlK02BUxHR7S1WZ4hSGswYS+7SEIIbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvpHt3f+tcl44cPcpFbkKHUuHxQPp+zAl4zoGbcmFx86WvGjG9
	fsvAtVZa9rhxA79TYbhBeMrcqDP8PUm5hef747ICMLU7ddAN0zpM7V0SCUnE1FJTVaCHx+V6HML
	856sSGWcYmt+DVgIBESed/89q6q+E4P+p/8fTSw56NOfJXjurvxjuADF9SKKo8u8=
X-Gm-Gg: ATEYQzxEqhiXFZV8OW9nRPyMUHaKY4KqhAJs0nsUtOeNPTjHEBtYf4ELkebHvVio9vt
	DyCzqQ0C0wqhz8ytRE3Tob6iz6BL8+WDub61Yxr1CpFX1br9qTTvBIzI06HI03kg636grc4iTAo
	JCnlO8vVBhs949PHw0tYxV6I+rWGv5hxnoTPvIqBmnP+swPdEafJNmD/sb5hThOlvDpvzdblYO6
	nuF0Y/4J1xr7CvXV7UAKR3dsYJ/0wrNdkdSsDN98RtpWvLMohKww+pRJBumyZcDanJiGXd5y6w5
	fkKP84USjoQTDY4j5tA3x87bGTahBNZKh574+n25Y6CI0M+Fpi5LetY5jDy1q780MzpFaL6t8KJ
	KOVkEzQF5GNCYK5goMKTYuahYSzr7Nu1MNjsT
X-Received: by 2002:a05:620a:1a0d:b0:8ca:41af:32cb with SMTP id af79cd13be357-8cdb5bb05f4mr106416685a.77.1773341031502;
        Thu, 12 Mar 2026 11:43:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0d:b0:8ca:41af:32cb with SMTP id af79cd13be357-8cdb5bb05f4mr106412285a.77.1773341031010;
        Thu, 12 Mar 2026 11:43:51 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bbb2sm10005040f8f.22.2026.03.12.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:43:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: PCI: fsl,imx6q-pcie: Explicitly deprecate reset-gpio
Date: Thu, 12 Mar 2026 19:43:45 +0100
Message-ID: <20260312184344.42337-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=0tXOIBZpahIMNyxmlfBim1P4ONHHre0IuoNhHAjYNZ8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpswlg93p8yhDunYSI8srtbq0lw5h4i/81CjyGK
 tJwNqZb776JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCabMJYAAKCRDBN2bmhouD
 1zKMD/0VbfX3p0sY7DPP9esiQ8ycSbh3PmD7F2UrbBSAiO0cHHO2LUKqcW6AMzVHx9p99uwQuaU
 ciaFreVVcuJbzwv9r6iJHIpI+IxMTC1C2DITt4tpLG9sFpyQmaFPGp7/l80/dUh0y1ZjTAn3ncL
 B+Iv9G6SMS1oBTcZdW2o9Nmn6aUDoSes84V6e1TERKgNY4L7wV/jfO4l5D3KJNaB7f0qEzQ3ukY
 u3iDqDzYEO2lgIO4PXY2tL5XFceLBFjiTClAbYkP49jeZccSinEgMPtaepHHalTrPRYjNfoQBFY
 Ut2/00fpWMV0Bu6IFOeKNkHbDknlzUFlyrQC0A0xNNHRFlD2z5e8v9RQQGwIcO0ttdL+UlRW4yZ
 STfuSi6mx/niBtDvS1g6v9otU36Z/qcB0sa0RoTvWU7VDsbzZVg3nTL4Qx3kmxBNMbS9JaOMe07
 1BbfxkKpqOlx/HiXM+0+4yZE5MzM9Q6WVPu9W01FKWI8qam8EXNYkw++HUURNSR5OpETp7rR9Of
 1OKo55KWHPpHtDBghA0+tmrkFavuNa1NxHMAR7f8dowIZcszilojKc9aGX0ERxwNEE1NocvNWg5
 A9/OB1TeWSrrQRQ4MuUzKMUwc762SE62NrxLCUkOPrzBrkyRfuZmXTlXkW2SbGy+Oe8fPq4AIRF i8K1ni69MwGq1tg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DSVquf87NTX3fV2FCiCnwiqzyqxI27da
X-Authority-Analysis: v=2.4 cv=BNG+bVQG c=1 sm=1 tr=0 ts=69b30968 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8 a=VNn6zrWwxK5-OcnvxvAA:9
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: DSVquf87NTX3fV2FCiCnwiqzyqxI27da
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE1MSBTYWx0ZWRfX0dK9lexf7hos
 Gq2fia6kIpbp9IQq8XMOAxr/k87qoO83WhYAXBphYI/zCoxepNl2scTzrNKjgTjBVhdX9Ikw7ok
 qL8NH5hxc3dM4sljv/vvQ67F7MFpRKbKbX8RezaXwDXn+PvXXF2LVn+cLGlMfyirnQpltbPVxeh
 t3RUx2sWmm8wagdfsZDgrnQN0Wm/3sGtbKS1qlNyVp5n6JMDgrKqDpHqoabuCb8dCHxHLVH7qV3
 xvHk8cpBeG7rct2xqHhwpq+jAgN369Y0Jrn2idFwftoGz3Qu349qLwyIMdmBrwcgvVxOjoP0DFZ
 XY4hzIVhcpxpIhmOTJT77y9mYn+nwAVeMAiw9GaPnj93Tn+LLln1j2LLLR6cgpSKP/nXiiIOn1s
 diAFKpRmq5uHFrrSnoHZ8g5qFD7OTOZpAfoapw2Vb1tS16Kn4aPT788C0kdsJuyXM9yj6jU/1Js
 sq1VCg4zhUhIXIAZitQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120151

The binding references snps,dw-pcie-common.yaml which already deprecates
"reset-gpio", however mentioning this property here lacks this mark thus
code is confusing and suggests property is not deprecated.

OTOH, the property cannot be removed from this schema, because it is an
ABI implemented by Linux kernel in gpiolib-of.c in backwards-compatible
map between compatibles, "reset-gpio" and "reset-gpio-active-high"
properties.

This creates code and binding which is not obvious to follow, so rewrite
it and be more explicit about:
1. Deprecation of "reset-gpio",
2. Relation that "reset-gpio-active-high" is used only for that property
   and not proper "reset-gpios".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Cc: Sherry Sun <sherry.sun@nxp.com>

Changes in v2:
1. Rewrite the commit completely after Sherry Sun comments - keep the
   property, but add "not" clause to forbid usavge of
   "reset-gpio-active-high" and "reset-gpios".
2. Because of above not adding Richard's ack.

v1:
https://lore.kernel.org/r/20260311154955.145120-3-krzysztof.kozlowski@oss.qualcomm.com
---
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 12a01f7a5744..12cd1b9f78d0 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -62,6 +62,9 @@ properties:
     description: Should specify the GPIO for controlling the PCI bus device
       reset signal. It's not polarity aware and defaults to active-low reset
       sequence (L=reset state, H=operation state) (optional required).
+      Deprecated, use reset-gpios which respects the polarity expressed in
+      phandle argument.
+    deprecated: true
 
   reset-gpio-active-high:
     description: If present then the reset sequence using the GPIO
@@ -224,6 +227,11 @@ allOf:
             - const: ref
             - const: extref  # Optional
 
+  - not:
+      required:
+        - reset-gpios
+        - reset-gpio-active-high
+
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0

