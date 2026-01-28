Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54222D9EDB
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614670; cv=none; b=SthX1bOCqafw7m+2tV3J6FaE+xlT+fDyQ0AwWb0rKDrMJOKmnJnEtJKz1vIvZlyHpVLbOlXUojo+StA4jsmd1uEa+jV55EUK3RUME9JXdaRewSyx9XKl1xeUBj4Y+2el2iQaDCR9igGjdVyUFo5POcii1fHSc0OCrYlURIlL2jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614670; c=relaxed/simple;
	bh=ayAnJWhqvxVqxUb3jotL1noUt0bxhrC/p43Y0YGiw+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G2yqNA7s0UBtoWkRj6Vsws5E4ZrbN0dCMk4EfDfPoPSTo8ts2GhVURy5X0k8Abj53vaDt47cxLGfKwzxZVDrp93hv1qXdlZstZUF9yg4bN39FCcaNagiwYppe0Mlctww1vpAElU6Ege/F76RzGRApWU2wA1NXMFxC25inreIZyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm1I/HQV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Utuq9YgC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm1I/HQV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Utuq9YgC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S91vl83879271
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=; b=pm1I/HQViuD+1Wjj
	US583gRwrpmFHWWZUcIpkChN3JuLgy4e4rdaGCl8H1E9Di0n0On1bdWymUzrfpcs
	35N2dDqOY9HsaBDt+2TH1gjCc6PMTx+LDNeZpGIVbc07qzgv2bpvuuPsxk5olQyD
	9Eyv9AV2rsSlzjBax/Ffr+Twv2ing1ML/DG67qqaWrVU3ynLoVEkjnbwdQB/TqHS
	9eH5ELKPhi7mp36OcuOvZsBJKW3pOO4sztt3cJ6ZeRGrw2qA7hOUXPNghzdeMpfK
	BsJWMUpUnKrFF+s6yBJ3LhSsiPbCTU+Yd1vk3rS1/oyHubMJDnojdLTsmNJVEDI4
	pgptqg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bybyv25qy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 15:37:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0bb1192cbso58332035ad.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Jan 2026 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769614667; x=1770219467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=;
        b=Utuq9YgCF879zM/zcNoTsRxDRmX9ioUO6qfLUvNVJkk/5q4GgK8QQGbpEhX9xz/e28
         Uj4vSRXsycpHzKUX2LFMTiOuQKNGxp1MZY1b4sb153hf3c7z3azr6HzEIVsdz4QJ58OA
         vY42bGPf9moC9qljUmvB6QGj0x3XjuZeGIwHn/d1U4tLzGd+JLK54c2JjOujxx8meSZs
         6KJyqgBNwAs+c0b6aofftOwoq+kQjMgRAPyQIcBMYmgDZl7QwDP74nHBYAwAgWAXkxoa
         rjgBc53fAqrzR3zsDK/5mEkGlJCr2HRA9+rHqNmqxjbrQWsURghXw5NjEdN6o4NfpI/t
         pgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614667; x=1770219467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1SfBbA3M/smVtChdaDHyBs1QmfwqjTWGvIAucfFrNwQ=;
        b=Y1rfLiKJ7UfKK1wB4F2qlVpfrgf4twLGsMQ1HAzZ5va39wxjN5rEReLVyeX8aMxp0H
         InI5L/lZtTX3KiTAa3uqmk4WIwq+ZMxJl+vuQmrlQe57XSSgJTczp+7El6FJo+h0ubBF
         E9FW1cFRntHgRFCP0oIPSvKlQOFWAJcya5oXNgg/kFnrwYQ2UKRKnZV6QHa7M+bqKk7o
         70ZPmLomBMBDSAHa00dQ3FoC2k9GjvHzryjN9W4qUecSck96ct7fz7Xk5J+Il44Dmwgo
         cbnwafyyNW4kMfkOTokrzCkaMAeicx7pt5eNG0iKVjlngyrcwdKTjXa8My7O2bBqk1Uh
         takg==
X-Forwarded-Encrypted: i=1; AJvYcCVsLBjjPCFgjhPfLjXZ81X5nB+HJVI0UWMMKpWfo7FWNzagPlcDFvg115Jwo2639gnQdMKegSXxGjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+WOjsw6Nmecfv2MC7x/Tx7kuQvWmJSmRizFvdCbeNiwvO2usq
	fMtOkd53MHc3WTt/vGLkyTXsf3L+goSWdSmnWdFrw9YuOTyMG9b34i1nsqdgyOslyGGFxbbRtQB
	YkA0VLD1ikWLBhbpyvHQqdRerO40KxexxXh2fJToPo9sNr0CPBbTG8gK0RtmJEzs=
X-Gm-Gg: AZuq6aKwGhwYyOethQ/10HoRIrMb+cmMRaoCg9P8MWBCB414B4FS0/N/NDyuM7Uoa3C
	L1InDFQTdoySGfpEpzzibnV5EQWRjmVpHwfp/uIVHSb6OmrgnuVygAs5anVnHbTP/wc0AyvhX6I
	0/CuixLX5GuP31ZN200a2UdiaDhWuIlqjPZ8SyZ7ubyXr89C6xRq6lRHFSfnD8lbRoQiwiJ/d7K
	Ry2qwaKOhC0GPxUWqm3TFiEBZH3DA9YX6tcfIBXlzxNTH81gGHwcZF6m2c0j/vYRVpDa0hQXKPa
	JWH/SUCmMbDF+jNwuHORe+QZxyElfMQ2KfajNXwR06qcSNbLM9YHFvHEfBkyR369SNETGtJZZrT
	nlJI1+Ux3d4aGF7VO5Se3tZlH/KepswD3HPwgRw==
X-Received: by 2002:a17:903:183:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a870e1521cmr59413285ad.57.1769614666350;
        Wed, 28 Jan 2026 07:37:46 -0800 (PST)
X-Received: by 2002:a17:903:183:b0:2a0:bb0a:a5dd with SMTP id d9443c01a7336-2a870e1521cmr59412945ad.57.1769614665732;
        Wed, 28 Jan 2026 07:37:45 -0800 (PST)
Received: from [192.168.1.102] ([120.60.55.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3ee98fsm26371725ad.9.2026.01.28.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 07:37:45 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 21:07:16 +0530
Subject: [PATCH v7 2/2] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-pci-m2-v7-2-9b3a5fe3d244@oss.qualcomm.com>
References: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
In-Reply-To: <20260128-pci-m2-v7-0-9b3a5fe3d244@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=ayAnJWhqvxVqxUb3jotL1noUt0bxhrC/p43Y0YGiw+k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpei01CRkwyRyAd55pohnc7Yxy6JiGTO0PVOqkm
 WPeunI7yGSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaXotNQAKCRBVnxHm/pHO
 9WDuCACcvTLvfMeR/n6MQQCFzYUGzhc5g0cX7wrTE95npc4sFrWjI0wQKvBG0GHgVWJiXlx9dsj
 677q6U/bW9rLCeZulg+DGSW32sg1kLyB68QpFoDAfEjwGFtDHdsJ2TP+v4fLmcfI1GtOYPwQOLM
 96Sj5bs8fyDEWXabaFadqIE/N2sXOkfxVxQxkxiRXovHCJ9BnqEd0kWC5xbZnnR09Ft9Nv6vxKy
 UpUaWQ876MCJXP6+q0e2tyDGPxMT2j3aJU5iQKiFi692tk6jO9IC85Z1qjg3BmCbYqxBL5V4kPO
 DH88TCj5/aoM/cwvGRPqWTQO5/PBzH1leSk9oTvlkaKnlWpC
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: IHRSDcMUAbWza9ETADmG8e91C9y8ytSJ
X-Authority-Analysis: v=2.4 cv=ZZ4Q98VA c=1 sm=1 tr=0 ts=697a2d4b cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=F3mjE3T3/ow0zpRzCzjSvA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=0pvPJS888BSDkZzuOKoA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEyOCBTYWx0ZWRfX0AD6rL59AROO
 U2tTfNNdKjXyYGmt48zczo5Rs+6fZ/7Hoa0lIducSiwcr1lgiuE3wJfG3us/3QG3n3SxxRLKoGi
 uVUeKSJbeqrbKw4JKRdHafbPr6FitSPGp7gwL9X4aWWVDZ1/9b8zcfeGd2BHT6zqLUfeskrA0GE
 Xl1b3TmE5qPpMVMqK3bPJT8jZP/7ljcNI8A/wAbVvgn3b4wZebanxiiF6Mz8MMrj/k4IYK2yTfm
 PLjmeupFxLfd8Ho8j8IAaV9tEuRbPYaVK085O6Snhu/3rr/IUChNLxrFkjeubhFKQtUeR/p1Tpw
 ZG9Kcbg/5YvXeq+PTUEo2Lay1A4kNYq8DFl7/p/3br7mpZK/vBva+P915QiUC/tfKxroMf37b7s
 IvC//NtkzAs3yoXacik92B+/DufUaXPaeb7R1PZVz9y04d/dD22JH8Gp1kG2KJg2TkAQ2XJViIR
 FcCeGWgMn7pac6LnbpQ==
X-Proofpoint-ORIG-GUID: IHRSDcMUAbWza9ETADmG8e91C9y8ytSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280128

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
index 1b91375738a0..6f7dea6746e0 100644
--- a/drivers/pci/pwrctrl/core.c
+++ b/drivers/pci/pwrctrl/core.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/pci-pwrctrl.h>
@@ -295,10 +296,10 @@ static int pci_pwrctrl_create_device(struct device_node *np,
 
 	/*
 	 * Check whether the pwrctrl device really needs to be created or not.
-	 * This is decided based on at least one of the power supplies being
-	 * defined in the devicetree node of the device.
+	 * This is decided based on at least one of the power supplies defined
+	 * in the devicetree node of the device or the graph property.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		dev_dbg(parent, "Skipping OF node: %s\n", np->name);
 		return 0;
 	}

-- 
2.51.0

