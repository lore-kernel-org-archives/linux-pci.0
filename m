Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2823D9DA2
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274914; cv=none; b=M5YC9kqiGWRzwJjrgkEC/cUn5lUC+Xt1NXY5bC8JixkUJJfvzx+8dnNEo5mrrBuXC0kVXpWxYcNxjEDo3xLJ/Vf+DgmjbVOxfmtXwYDNTgirPQQOFh/o9OvrWWOzwcQa41dX25SRrZm7/v1aGZvUv6K3LXylVQw8S0yiYHuHDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274914; c=relaxed/simple;
	bh=sxTOeNZUCJiaLQF43tM6RQQ8yErITtuQ1DjdECwZa5A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ndet4zWr6qf4R78N2FNX8n7O9vrQ2632JC97X6RcMEYIusp+Pev15eFvYD3C/BJeMeLHqaf3pknMQ/jXlpcDkXmFctIXMZDEeSjD6KodFgBf6fd9X/0HMKhPeBKj4P+Y0SLVAFIGioMGVqRjkq06pNRwkz1M/XlkmcGM8aUEGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zl66O9O6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isjDmeqy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zl66O9O6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isjDmeqy"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K9lhHj267056
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sRQ+frqKGg6yviczCOuRmF
	JXb9EFREKQHuap6tZIl1Q=; b=Zl66O9O6yQDMjWRBijau+OX8I//BUkL2xHKjp3
	DZHD7FATKCZqIvzrFFGBxIgpZaYDkN6Unl/KVyYaCCjpvaedOdKeeBYPMaF4DEep
	HmZBY0+BCn08IELNaQGFTSgiD+yaSjwA3LjeGslunnlE7LVLAhOzeYGKZeJ1BQMy
	TeWfPVGKGULcnIY9SlTl5aJm2AtZVIHSzZPEWpKmpsyIdZt1esF7SZBDsKHZ0UJs
	Iuu7DsNbqnUt4UrRo3w9hgZ/AhsKD9g7VEhQiVNIjP+yxKYQ1b0LEt7TBSLXqOTy
	t2D62+8YJkVCqQMQv7gF1sxw8X10ZnRTq+9fh1VD5f4eUSIw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9amxr8gr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 11:01:52 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6961e8fa90bso12344836eaf.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 04:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274912; x=1779879712; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRQ+frqKGg6yviczCOuRmFJXb9EFREKQHuap6tZIl1Q=;
        b=isjDmeqy4LPJKRHEmSY8a7VaEtsqgu6lcLvVB+Uv4BZo+tNoH1CRcqoN3MPoVKh7Wo
         XdJ8eucMjZsQF+MMfQccN6AiQaQAz26CAIWvy2abZkTbkAI6LaZINuSyN33h2AWkU1ah
         svVStGFkE83S4bvq6PTLs0DXNVzhseSQ4vfTG2YXmcbAyWjg0VK5K4/xSlD4OO3PkAps
         RaGZf3BDa+jebqo3TRonewKiTDjnDSPVWPo+l1zD504iQSOYKI56ZKGPxectVa0bJE2s
         UJQvZr7ZOmO5GsO8vDtnJvdXizkprP7aw0bvDa75BK5SMGeaRMxiXCLrpnS1stweJ+k/
         kZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274912; x=1779879712;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRQ+frqKGg6yviczCOuRmFJXb9EFREKQHuap6tZIl1Q=;
        b=aZ7EwZdrhBDmX30xjc0aEjDRJJBdOJ/g8/uuAi5EznxA1pFS2bR37z+Uo0S86YNUin
         kp6Ui7C4NYlH7pD2505UojIN4+NTZk0afDf1h/SkXO/UG1bmmyQXXi33J5eRCFEC3X7Z
         v4/hiHRL2QTWxfw3b/xl3M9JI/9jPuMJpZkOLEp5y3qhpl76YYbIcoO+418+pa8Xmd5w
         U8rcjn7NpYlk4wxp4QYBXoXVfBlQ2ryg+AQ3Zh5h2J/xtHf9EsyY/Dt6pIMBeDzoczA9
         pk+tf71e6msyf9uxMyg4IjfhXv1KOP71dBMV4D/7bhMYNwRdXvLuCKavtKtFNSgnzYGU
         fXnw==
X-Gm-Message-State: AOJu0YxCoREv1CtrmAEP4854J4vjmBs65NOFrVp9k+yOtZwOLM7ihypM
	bt5kfK0POlhmrTvSa1XHYisN/LawF8vkat2cu49i2D0yfuvMRkYcG9yfgDvHrp3Ojwt3fjsF+u1
	1+0ujNTnHcxgQcn1HaSTs17QkqA7EsUKJq9e1TozrjfPd2FoAF42wNngx+qs/+Qg=
X-Gm-Gg: Acq92OE2APM9FSAyqlmjtmCyg7j04tEWi3f7vshRIoQtRmABoJ0eBS5GK6NB7Gq+NF9
	BNonvfQrSIOVfdPsq/gWobu3cUSkWRRYs25eDaEiDRfTu4+Y0AgrNTTa0sWh6yjTg73csLULiGl
	NakJ/ek3h5IVb6wob/uctfOpsYOvcoE7tRatX2TpKW2VJrY9PAzrsudrXiZxKssPnvkSgPHnQrY
	C6bgvBTTZaNjFWa0yCQ/kgaodmb1L3i9kC5IGujEIt/JE0gfUgvk5hiIjd+BjQou5SbHRaXVkGU
	lqAfHTf+PUedOS2ZZhBjuiRUqHiPpoLWD0WpIhho9zALkkTv71mdAbRtDJJNBEGfborbRRV0hLh
	ZArArmJnDJGtkSgcazYr5uswaWlZf9848JO4crCsr47FCTGoYjX/7Vgg9BDunqoAdli0ZA4tkfW
	w1g13/pm0Zpp7+kEv5
X-Received: by 2002:a05:6820:4cc2:b0:69b:73d8:60ba with SMTP id 006d021491bc7-69c942e0844mr16305662eaf.21.1779274911888;
        Wed, 20 May 2026 04:01:51 -0700 (PDT)
X-Received: by 2002:a05:6820:4cc2:b0:69b:73d8:60ba with SMTP id 006d021491bc7-69c942e0844mr16305529eaf.21.1779274910402;
        Wed, 20 May 2026 04:01:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: monaco-arduino-monza: Add support for LGA
 WiFi/BT module
Date: Wed, 20 May 2026 13:01:41 +0200
Message-Id: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJWUDWoC/yWN2wqDMBBEf0Xy3JUYL7FSSv+j+BB1bQON0ayXU
 vHfG/Vl4AzMmZUROo3EimBlDmdN2nYeokvA6rfqXgi68cwEFxlPBQdju5+CRTv8IBFgVqNseRS
 3cc78qHfY6u8hfJYnOxwm7x3Pkhk/U4e3CG6nlkvoF0c4gBFQjTAL4BDJhFdNIvM0vj4sUThM6
 lNbY0If9/2rUoSwN3osglmGEbg6YeW2/QFWRIry1gAAAA==
X-Change-ID: 20260520-monza-wireless-e6ce7f013f38
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: CnHuNiEbTd98fmBoHuTjUKmDfSCL6xKA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNiBTYWx0ZWRfX1xiYr4hb4GfT
 N9c1tuUOrGUtKUh6X1KVwHkVdFQMFdKKyGM32jG4GYS1gzGttxCmUZ4Nbno+D2GZ2lqHVjhhu7l
 OWTm61/0KSvbM0bABzhX1RgVJw334ci7/DAruPZoCUIiOjpia8u/4SBrsXgq4e5gLC451asaA+I
 qNfQUrAX3AMhSIECTkDgD/dQBnI0xkheWc4fR9rD8/IzyPyI8LzMDDU1UD9BVgOMh/nxElM9Ffa
 Awirol08V2pc56yQoHOEFlVyBo0ScrMrPQUieH2+Ew3UQt2Gpa5fFPPvep7u4HksQexV4j9d6Gv
 hH+RHb/la0Mdm2bZ8GzPhU9CUT0Qh9rYtfPIEGpdPLMGnS06qpvPLBB2CXWkWGfF9PtjwJ9rGdX
 R6lQGs24xMMcEWds9+jWe/vWvS2lujI/2k4ZYZqqB/q4UYExqFsekGYsuQvkAxTeNmO0C5rY+mD
 s5MSpKWGC84918SIdew==
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a0d94a0 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pLl2yMwwk8GGFzfygZEA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-ORIG-GUID: CnHuNiEbTd98fmBoHuTjUKmDfSCL6xKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200106

This series describes support for the onboard WiFi/Bluetooth module
present on the Arduino VENTUNO Q (monaco) platform.

The board provides LGA pads for a wireless module. On the VENTUNO Q
these pads are populated with an NFA725B module featuring the
QCA2066 WiFi/BT combo chip. While implemented as an LGA footprint,
the design is functionally compatible with the M.2 Key E.

The NFA725B exposes WiFi over PCIe and Bluetooth over a UART.
Both interfaces are gated through the W_DISABLE1# and W_DISABLE2#
signals, as defined by the M.2 specification and handled here via
the pcie-m2 power sequencer.

This series models the hardware using the existing pwrseq framework
and connector bindings, allowing coordinated PCIe and UART bring-up.

Patch 1 registers the QCA2066 PCI device ID (17cb:1103) in the
pwrseq-pcie-m2 serdev ID table so the Bluetooth device is created
automatically when the PCIe function is enumerated.

Patch 2 updates hci_qca to retrieve the "uart" power sequencer
target via the OF graph and use it for Bluetooth power control
instead of a dedicated GPIO.

Patch 3 adds the required Device Tree description for the board.

This series depends on:
https://lore.kernel.org/linux-pci/20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Loic Poulain (3):
      power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
      arm64: dts: qcom: monaco-arduino-monza: Add QCA2066 M.2 WiFi/BT support

 arch/arm64/boot/dts/qcom/monaco-arduino-monza.dts | 65 +++++++++++++++++++++++
 drivers/bluetooth/hci_qca.c                       | 33 +++++-------
 drivers/power/sequencing/pwrseq-pcie-m2.c         |  2 +
 3 files changed, 80 insertions(+), 20 deletions(-)
---
base-commit: aa61612ab641d7d62b0b6889f2c7c9251489f6e3
change-id: 20260520-monza-wireless-e6ce7f013f38
prerequisite-message-id: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com>
prerequisite-patch-id: f4a7d1957c1776051608bf3d808b2786606c1ae2
prerequisite-patch-id: 6cd3c33583a9af16b3f6f71517b16b32d8155b7c
prerequisite-patch-id: 0550c57d69cf112fd4830e62f4388db6f8bf397c
prerequisite-patch-id: cc10d8079e37ef0ba0c33d0984c95d76361df9dd
prerequisite-patch-id: d7f4bb2bb4498ac619e67a94f8b59119a5caaf26
prerequisite-patch-id: c00ce9095b2d3a412229796194828b55642d3d96
prerequisite-patch-id: 09600595c2e80b12eda3aae39af192847d0f03d0
prerequisite-patch-id: a6118ed2894c176780ba933750e1068f2819fa4c
prerequisite-patch-id: 1dee41a33e032094e8dda74ac4e0bada928573d7

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

