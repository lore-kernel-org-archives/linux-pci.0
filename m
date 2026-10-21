Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590694;
	b=iyCMqV2+S7lRhhAACGT5QzeR6rrAxIHSW6YUVvn7h6552LyLzF9xeERiwnFwYFDalEnh
	 Dl2CU2r+Wd8oXw/0o1CGRYABhWQvT9RzRYXj6wH/VeqOGWO3fPwtI3i0bgRiAcpw4OPC+
	 Sd4Wt3CYLUeaemYb+9WrrTsT18SgcDZ36Meek6adxiowP4DewX4NTvc60RkB/jNvL33CB
	 2eLv4ZQhuV8PyjNBSiWQLOC+RG+KEel+3YkTo8uYADyYXmnYlUhGbja6gFBBcUrLancpI
	 qwGb01UpClHDKAnlf214yjQh6+BAWj3+md4YsxBI13PZ5sMu4Kr94sX1LXZPNaKwWng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590694;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6ic9YLfgNTNC8LbkgAOfvr1E7rxhwKyo7fVG4O6cpK8=;
	b=bIEl9wcHib3Q/66FkRj8zY77JO20pOyOxs2yAuaZcUkCPeflXNBQ9zForUPv7G/agZPe
	 eOSr9ZJQpuIFxtmqLsyOrBk39jELNlY+p9hDn7sQRHuW7zj4XdSdBY0NN47E1i/vtuR9H
	 HtQ5R0XuKK6IJjxAxhUdw9IxeLdW8hRGaZUeeI2ArMwTABenl1xRZlZPUlb7w5iXi4zj4
	 HO18ayPSDgXs7XLJW8vEbVSJ+XSJL8qr+9NRp28wd1XSF/dy8o38pSYwY/UQM/+FFqLNL
	 Eeb55cRU5Um/eb8yxQcZvhPjN+eNZfvrQTWu8YEUBjrCQiqMeLCFZM654C4WsgA+YrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xkws2U00;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNEfIIJs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86384606A323
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86384606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xkws2U00;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UNEfIIJs
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBgB8F3225476
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6ic9YLfgNTNC8LbkgAOfvr
	1E7rxhwKyo7fVG4O6cpK8=; b=Xkws2U00vMsA1S3OJf+Kw6noOrg8AI/CvYPANc
	Sg666KXvUcVP+7qkx5tMz1s7O5nH052OysjUeUuAZJaa2bC+aSOEnTEvn12XVcXB
	HBw3mrJQLkStrg9YO4fjzdphRMJ+ZmJ7+XzOTeU4sb1I/yHZ1Oj76rE6gnXj5D5u
	P5FsgZTvzzDXBHu3mmah2LBznuvNXLGPGiWfA64eY9NiP+LzBpLEj2R2v4qErKgm
	R18rFPtJLX95IPycmcNBo5UFDutfxwBTn8GnLNlwH6elY5Ys9HExEpl3m9Dk6Z9P
	t4FRo/q3uzReAdm85y9F5MqH+MPdosxVOkbCvelxBDoNxmgw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79bx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 13:51:32 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35a04491c56so818709eec.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 06:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792590692; x=1793195492; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ic9YLfgNTNC8LbkgAOfvr1E7rxhwKyo7fVG4O6cpK8=;
        b=UNEfIIJs4Ycd3woFQgfVGa04dQ1czRhid+p7gU531tuGOXSSe9JJ+72UaqU1ncr1YS
         J/CN3CCTvRHsN6VFhFrNDzM74VXnTjNyTiKYekuD06TKqMSfEzlec7kXwEFofpp80FCW
         rPK5ybdPVIaR9xJEwTFCFc1YdyBbDnm4YBRmBCDzagT6+vYGHcCGwpHMTefaHAmf0R7p
         8JYYfmEHkNAwD2OZChpoWylEQlnN4EHPqsp5zeP3mnkxvPnciR/r1jRkXDP3GGp5ljao
         1oxyO3r/a4R9nyZ6TanC7BzTvxfhG1DmTX8HjXKudDv6/YA/c6QjNpyjNO6dRF1N2r3J
         HWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590692; x=1793195492;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ic9YLfgNTNC8LbkgAOfvr1E7rxhwKyo7fVG4O6cpK8=;
        b=Urpqk4mJARjzcN9a3FnnJyIWKTn0K5AJaWBJKj3XJqiyBzd4jh5zpAKIpTQ8/VLzNy
         Wuj/1Lq8kyfCP5nu1K7icCPeOKmZQe/5z/vldFVhi7n1LH0Lv9UvX5SyWT60dD2qvb5T
         vv6F1pcUa8cXRfZxm5Bxu/AuYH1suShElq0H8mKazC56Y2Je0KzvvYZcYgX/um+UEpnT
         DplerkNxU/st9NaE2tyIYM8VxQocAu+hJ53nPa9CqQtQ55XtxfIPJNHLmobB1bIYeK1s
         milc/+Ip2744sNAAxlgWMy16uxdUdFe9fkuoxp0OfKemaIj4a8rtl9nc1vR54G0t66fd
         NIbQ==
X-Gm-Message-State: AFq9FYLdP8S5pTn8GcEL7qlbUj4mZW/nnrWCwfO3EKXKXlBQcISAF8Nx
	AlCTwOImn6/7ezl7hqR59JXDo14b21VsdXyo+LHcaUkgjPAjMHObct+hQuREaGqATKeSuRFrcHM
	4fkT73U+vPmVn8I1pgqvL2uzCV0PYSd6Kji+v4oif7tfKxA2l6lSloB1OK5lL5c3kuwK6Gv0=
X-Gm-Gg: AYBFou02xxdaoBnQM6NLwbxMh0IHArvYAjpr1pxC96EuAa9UWu3xv2SQl9chb+Ls1gA
	Kretcp6wnxzhNuZB5Kfay62oJ/CIvnVKq7S4taaQVMM+ARrHF50puWGBiqc6O0FZoPMWeaOUkx4
	MiFRkWxCrSH6AqduzfDh15aJP7HM8TijBiA5sg4Lg0CNvKTlTsLqcKAQhIcSvTinOeKkmPPz7qh
	lscXfOdN9r5FjuFjfomSZYQuMQ0jpzYL3WxIfDjpL6RciRTOM/tMviXYvV1DXEY7cMD0o7I/63u
	3yAuymLmIg0H3zoWxMfeJV+cygp1RXOIXJWh5XDkunqYeupnRh9e9PjVYLahgnST3VqQofvbM5l
	3D2vdLEQ30jBl2l6WxJH6Pai0oc2/s6agAA==
X-Received: by 2002:a05:693c:864e:10b0:361:8d0:6c7a with SMTP id 5a478bee46e88-365fbf86502mr7227548eec.26.1792590692169;
        Wed, 21 Oct 2026 06:51:32 -0700 (PDT)
X-Received: by 2002:a05:693c:864e:10b0:361:8d0:6c7a with SMTP id 5a478bee46e88-365fbf86502mr7227503eec.26.1792590691495;
        Wed, 21 Oct 2026 06:51:31 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cc848fsm7534332eec.13.2026.10.21.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:51:30 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 0/3] power: sequencing: pcie-m2: Add PCIe M.2 Key B
 connector support
Date: Wed, 21 Oct 2026 19:21:21 +0530
Message-Id: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAFnD2GoC/yXMQQqAIBCF4avErBPSwqSrRETaWNPCQisC6e5ZL
 b/H448Q0BMGaLIIHk8KtLoEnmdg5sFNyGhMBlEIyQvB2WYIZW/pYsZKaSutdKlqSP/NY5q/Vtv
 9Dode0OxvAO77Aa7YGxJtAAAA
X-Change-ID: 20261021-pcie6_fix-cf66f4b8b387
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792590686; l=1492;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=D/UvRdvBDBS/Rq/ST/CUi0Wd5LwynsMiqdDmEgI5bRI=;
 b=GA0GHTLmE/SalAfNw5rnP12qL+JshQsAM+buh9CGhLL9xvLCTlyCtqkJr/0RW7F1Si1RVcTQ0
 hf/aDeNqM2qA4j+XzATTEYLZePe/7mYoVq2kN6qI9GE4Y3mgCNdcKLS
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: r3G7yqRzHmcJyjzCKhiz6pnMRxQxFuMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX7oZRqSvtMafg
 4mKvbIjGBLWGTp5L4bEaeKDoYGjdJEk5dPgh3PXMx/xv+lox+IrXjkt6Fat5RX6uiirZhhrdIca
 NxBP2qIMvJ4cQr+KTbMRvHw4SfvDbRA8Qzm7HycTTYVKqZrDS7mufncYa6n7oXJnYhXSiTOATpU
 9rh2Uxv4jhh8qfmIqa8J5/wu8YBxYwOswHCgrooLbTp6Ksy1hRCChhYy6QV/HLU8pTZS5eifBt6
 WpKN8Dv54JHsuGVaCy38T5aozZL1mEE9ueiqg8weWpUImBxUVQte9e/ILCJvCwcK7fRs0ze7saq
 2lMJ2QWWVyhhJzmDX8blTfWSy3gnONbL+dPJ+LU0Hiw3JokMDqAiYNc6SXtGhjFW7dAZ6PxGmUb
 NzY8/6fCcj9PmGIj0wLfQ1by1EF3EFpnuH3qEfE/Cxo8TALAqdtSQcl6sNrL4/St9w1MI2W9cwu
 iHIiImq8hqHCTwlpM0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NSBTYWx0ZWRfX6rza7JuIu+x/
 nxVAUJL2gM2OxVc3FPJ8FNHtc/rqs2FGJiQNRtCmZhP6rdhICzm04RJ77jvhhDvXrHa/Accsl8E
 pJiPb8/5xQ2YnCAgTswLJXKqEq5sHvo=
X-Proofpoint-ORIG-GUID: r3G7yqRzHmcJyjzCKhiz6pnMRxQxFuMQ
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8c364 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=KRKipztoQesxEaMeAmMA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210055

Add support for PCIe M.2 Mechanical Key B connectors, commonly used for
WWAN adapters.

The series introduces a DT binding for the M.2 Key B connector and
extends the PCIe M.2 power sequencing driver to handle the 3.3V/VBAT
supply and the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#/2# signals.

Finally, describe the WWAN M.2 Key B connector on the Glymur CRD and
move the WWAN supply from the PCIe6 controller to the connector. This
allows the PCI pwrctrl framework to manage the slot supply according to
PCI device power-management requirements instead of having the supply
follow the PCIe controller power state.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Krishna Chaitanya Chundru (3):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key B connector
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key B connectors
      arm64: dts: qcom: glymur-crd: Describe the PCIe M.2 Key B connector

 .../bindings/connector/pcie-m2-b-connector.yaml    | 146 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi           |  29 +++-
 drivers/power/sequencing/pwrseq-pcie-m2.c          |  82 ++++++++++++
 4 files changed, 256 insertions(+), 2 deletions(-)
---
base-commit: 2c455ddca7827ad8fa3a64fdbf5a60efb928b46a
change-id: 20261021-pcie6_fix-cf66f4b8b387

Best regards,
--  
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

