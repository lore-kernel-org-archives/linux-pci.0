Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535A493D31
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988326; cv=none; b=oZMqifPlUFIb5kvhpOpdcxljP6cDHlE0Ludtb06XcHFRNEK1W+BklCWVco7E23r9TEsCIIvs8mW8w1SqP9FR051p5kyGy8F0CTnEWklxlNAMxAJ6ZLx5O4Le4BIcubyHg9S7axhiUam/o8RmxMvP9dcfTK/5KQ546JS/Vs+AiEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988326; c=relaxed/simple;
	bh=y7UXgCIKfxY9NVUCZAGjKAqUsicIwGreJw6al5/G0rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CjOFp0cTgpoxKOIvkg8Q1tBkW83b6iDVi8z3yuUugbT386iFfw9hM32FmKZz07BevCxXh5NYh9bO1bFndvtLMgrTgargQ8eKYNjP39wYsExI9KPFD3bHtxcExtfq3QsHkZ3Q7gVlxqFZ1G4e5Yr0/5VfjxYk97WhANnu+eDSdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLdsjBnT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hrd6Z5RI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLdsjBnT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hrd6Z5RI"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAduL52091278
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kF96zxkV0QHMeHE5whjFT+XnK0dBzEGK3CuuftD2fA4=; b=gLdsjBnT8JEozPlp
	ARRjPFtotDc+i10OPbTg9Bq6dnZsZXaBsv1UCCh9II/uFDb+LcgDT6KzoswXhi3C
	QYVvDTuAcZnc3zi0MS/NIIWFglD30V2/CoNYIW9+NCSFVoJxDNBVBL6X1+eRqsmT
	2aS/JS+qbHgzQIhDsW14uDM8oPcosCKyZy+yc3BOJVaBLoo/24MNSyV5i8O8l8m7
	UgR0jOU5tINmshi1fmOyNOQEWjkln3ZVlFyL+J1LYfJENGApfKIq+eWPExZzDxZO
	XBJ3L+nIetYThBlcxNQdnq/pnWUpTgJEluaeIpJWvIUlSvcOZfiKHRrN667SIack
	jgr9tQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtt3wt09m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:58:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc4e496e5c3so2307444a12.0
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789988323; x=1790593123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kF96zxkV0QHMeHE5whjFT+XnK0dBzEGK3CuuftD2fA4=;
        b=Hrd6Z5RIQTLd1vZu6/TYggFtXJ9HiQhygXsDAGSTnbQQPrwJHatndXkS/+8/nO1Da8
         gD+W5CEMlIl0gXR+JSDLKy1hDF792azxkmu8pIeJUvGXQr+cp38Tg2PXOCPLcLCX8+ir
         PjrKmfIaAtiXqJtAdHrBX6WN9C6Ben3tC3AYdwAmGhB42ikqFYDoc7NL+OYpxqQUkcDK
         u4cLOdFqWpONrnG6hpmSj/phINuZNigQqqt6st2Z+m6KpVJ+ZUWOTvmZMng6l5jyVdAK
         vzn8GyLkMUdVJjAbjC1GzrBBC5J29BRI/JL1lBmMPCtKrY4DbcHTm8b85JK05Ngaqpfx
         Nkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789988323; x=1790593123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kF96zxkV0QHMeHE5whjFT+XnK0dBzEGK3CuuftD2fA4=;
        b=eXRKc3Fln1RciA6LfHz4MUEO2VShkQPHQyYiZHVnO1D9ZIsggkyV31/3tOHz5MJWSm
         TrZzqQ4El/AaKEjWpKY7TWSTB6hXBvvz8GXJTcYHFWItaMNTGq+rOMgRK0r3Gc93lGj9
         2LjTpqiFCOATSY2l3FUdHAxWehywIymXu2wo/ZCHgNHgASLiokE7qdVQXZWSXmOp/eRy
         8MHXJV+CsFzzMTaFW6O7o4pQWX8ZcTVkss+rwX+QTbpMAJqFF3TgaBbrrw2X60hUIvEj
         VxLHPTPz2fUrt33u4p6zEybpvpnjVTsXPbWMAbn8HAnPMbJQTC+oDqX6lg4oQW/BY3oX
         UljQ==
X-Forwarded-Encrypted: i=1; AKwUvBydCCDKguf60OWn0mnZEEg9x5U3Ua+F3QqvVkNKJdQ4AXVezalB9yhL/gPM1BfDjlC6lz0HmoYyH2k=@vger.kernel.org
X-Gm-Message-State: AFuF++k5hPTQNEQDxWhlrVt++KhfXTuS6TOHL/4l2Gx9tjd7qxwdlv6O
	m6IXAhPRTIqNuG9yIrHtr93j/82ptoX84j00tW8r9diC4qj2hgi39pNOQ9SdLGlXDgilrbJsVn+
	5iQpVA1R8nui62S0YeXFQnQ3Ysv3ZJo+kFZCjqVoFrj3n2kD8y3PrkUAJFgCPUcU=
X-Gm-Gg: AYBFou1G84X/hZ1a8kYOLVLhaMMorD0/KH7hT6AI4g0rc8z4J4bvuc77M3TrjSfanJZ
	Z8kQsH66bccpt6hOC5EikFnjbfZqsvI++oShweOW9btmm4y+5x/bO6c2ZlbGHWSBWff+DZFWVmY
	9/a1M4TLxqGjWBRWKEFN0qT/SnWazgKeFLnz1k5gfvcvnrH5XXFX459/mU7/gySCQnWtkO1nZoH
	9RYiOMFXcS+kF0HrmjM+uMJbcSxek+r0lx9R1qpYGuC6dvGMVMCuDnACmF8AkqkIU5VQqarY1Zq
	ngOcWC9MxeGM88njRYmoOSVvO86AQFzUIvqXZC1EYOLv8HPt4LfM8Xcg1Uujr9NTQTiNViyFlMW
	wELhQ7kuoxd1fRVlXuT/pyk6GiLsH4W4tZw==
X-Received: by 2002:a05:6a20:7349:b0:3dd:a195:fa0f with SMTP id adf61e73a8af0-3dda195fd49mr10891305637.52.1789988322645;
        Mon, 21 Sep 2026 03:58:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:7349:b0:3dd:a195:fa0f with SMTP id adf61e73a8af0-3dda195fd49mr10891272637.52.1789988322187;
        Mon, 21 Sep 2026 03:58:42 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm23544128eec.30.2026.09.21.03.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:58:41 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 16:28:13 +0530
Subject: [PATCH 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-monaco_ep-v1-2-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
In-Reply-To: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
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
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789988304; l=1181;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=y7UXgCIKfxY9NVUCZAGjKAqUsicIwGreJw6al5/G0rc=;
 b=p3AYYDk6246yZdu0F0RMdyRce/9hqFxR/O7xU1jhZb6da6nFAmFgT5jmXnQzv3KRyzVQsTQtH
 4BivyinDTthAoQxrZZSB9wiFpIVlMH4CvtXuZM96SJgjjb+BTZEp8DJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE1NyBTYWx0ZWRfX320/1t88xkfu
 VxtkUw9oXSF3PDw03PFz7B23/WzQ3gE2Q8aTcTT6FIYczyIr0CvDB2SL0MPkKmEXejvNVIPr/rw
 znVHm4ABHYr1cSOxtSLAo3RilibQ/bmyrZWRECCBDxAamb4GL/iEEvsWO5Ma0BVLidfMc7ZRhdv
 5nZla7clAmNHwsgEN+9lUy/P4zjkt8Xo3b4IkBTxrUpE7arB8nzcSjDZvo5S4IGzfNi7RmwcwHk
 D3QDGRZzxiCAm/swY0QfsJYJA7E0cIBFJYE/BtQSzG99lLSlsKQVHaDixJpqZZ4VE3ObHHpb1RP
 LWUfFthzpNKhuluoH1mmwEC1G2BrtEJDxUeBoA7+WWmgzGCNXikP/vpRskI1VZ44HiDYlG4IDsU
 JhwN15Q0b6ce8PNdJQzDXM1mS4qrXdw2wkKXKuIzJWpPea0lgrjLd+JdcfqOq9R6b7wbtMOBbSj
 8TVAQMDL4mfGBxEFT8Q==
X-Proofpoint-ORIG-GUID: Gn8N3kdK0rvKyVO8X1N4PSF8jYHDA_go
X-Proofpoint-GUID: Gn8N3kdK0rvKyVO8X1N4PSF8jYHDA_go
X-Authority-Analysis: v=2.4 cv=dakVTnXe c=1 sm=1 tr=0 ts=6ab10de3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=AUvBg9Asf6StguVY0UIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE1NyBTYWx0ZWRfXxxn3nHdEEItd
 SkIoIRuBZWkm9sn+NEJPf5lYe7fivVmTtm5kFOt37VnIfuzTvgXjpQV+VVPPQUB6+F/qyiv7zNz
 OPCeAixdpQ5gSU/kXAtUR4iYf7wGY5c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210157

The QCS8300 PCIe Endpoint controller is compatible with the SA8775P
PCIe Endpoint controller and uses the same programming model. Document
the QCS8300 compatible string and its fallback to the SA8775P
compatible.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index bed9a40b186b..7f9a0bc958d1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -13,10 +13,15 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,qcs8300-pcie-ep
           - qcom,sa8775p-pcie-ep
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

