Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F173DEFF5
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795162; cv=none; b=gatQLaRFb/BQaVwx2RJDgaJljWnySxitSTK/MTihv88DKhu6iN1oVUmBIKgZ5wX9PBd64P9+Xfh48K+2PcC9XSYq4C9ZX+cZeAdvdqaqQavKjXhjY9LOEjMIZ0ZBEUku3OXeO2QDhLbCge22A4NrLpUyFOPF79LJ36JshdZ+y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795162; c=relaxed/simple;
	bh=sL90+oFBg4fpOkodMm1L902AyGzLN79lb95zijStvqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B+fV3sBXfCrVAIChnhJUmAumLo4ZFzkDVzJ5/HZCj0mc5X3nyy3VZzDjezEW2/4fDJ3joBEnuArTwXza+gIuHZO977fLd6E5weV/ddiHiIdN4uRtxMo/uq3LL0yeH7IkKfmVtzB4L58LuteX+6vQfu/Wm17xds7TloaanM+UIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QnbNzXE9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X7KwX2yv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QnbNzXE9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X7KwX2yv"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QA205E004422
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 11:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iFvWnFuFpHGA5DuREJpxWS
	+xk7m8VENTxMWCnWvwfNU=; b=QnbNzXE9kdKgQpF9OSuhkm/74VAUQO857B5NVC
	lUuHrkiIKlI8Q6y9iTHn1NNFewrwO+dl1gSiFvYdYjZqyVB3dLNixoMdh3t+07Mz
	d1kQDF/JVv2qxJzdpw8depaiTk+/BdbZrCdlDSKxuoJ9QNST4lRz9k5s4dNLG/bq
	ri6aBySBdINUjAB78YNSx/twx5krjjYW1yZJO/dPrumUbVAfdN7rVnLol1vPo0a2
	SswUJp+dH5Ilurxiu2w+j7i5I0UqyXDT8ptVs7sYtD8oKFGIHYVTE8C42umOI2Gv
	uxsFCLfiVKOPAufIU0QPwX8ipz5On02rdmNGl5NhTWBI/VXw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm03846-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 11:32:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b4530a90fdso39956295ad.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 04:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779795160; x=1780399960; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFvWnFuFpHGA5DuREJpxWS+xk7m8VENTxMWCnWvwfNU=;
        b=X7KwX2yvhkFMZcSRV+IR7T2cSNJ6d58vrR3oZlnjJavQj1nt3QBpMgJYjC61+WDlzr
         vCHiwNHrHJ+OB7s4xFg19olJ4fJl4gZ1Sw+qazzKxd0vnM+3iAgFEu9PE1QjNo7KR6WE
         HmyLxEc3kQ42qDYnvLm7s92xdTrJLXFrBHUCmJbHYorL5fU2YKehEUUH8zRiHvm5dQll
         6mZ7n9zR+Lg232FFUn6KwBJReTFWf7ekTQ1H8NpoqnDgNPu5fpN9wP0io1FxQLAvnYVO
         VVWMJbXG6BPSQVo2YRcG7UXx8uN+G1Rxs5Jd0/KS3xTDj3wxGNf94t07ES6+RzEewTro
         hvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779795160; x=1780399960;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFvWnFuFpHGA5DuREJpxWS+xk7m8VENTxMWCnWvwfNU=;
        b=hYKfHSkVWR4S9GftuE9D/m0XUJFDIiDBBlFm/De+bKkaeOz1Z/k7zo7ewlSHYws2RR
         mRoTXQZxezodtamVnR3IGnVs7YkDmIhs9nJrHUqvWPggR9Y4MDIJf6IINv6IZsfqUhOy
         HwzdSJgr4BwjMTgAa1jpaaQxRebg2b9ARvdgR8AIb3Kv1fRxMNUPRwDlbT49yzvey10H
         QvnPol/uGCp5rrSA/4/u3Guyi/MxkK3FoNnDnZQA5Bp0kNH1oz8oDPv/zaj7viOofMch
         HO4X1Q3bIQrOhV+HMI50YM1Ni2gOyI7qSJmHboMxKDwSviZLnneqLzb0RqYlYgOPB4IE
         E8FA==
X-Gm-Message-State: AOJu0Yy2+FmhRByIb8AdvibT+tYdcw2FCzWNNXWtsOItOuUO7/GCmjBk
	b1mJ73WVYHx7tDoCTYwrpqGncPfv4YqGDgrWMyFBRciV4jN95cBZrKueGQYOTR0TPqJKeVS/F1X
	QwjTlgaqBLBj6lJmb8iR7ta/hMMN579766GYdGKCvagL+W+dzb6y5LivKOFm9m9bWkPcLjNI=
X-Gm-Gg: Acq92OF7Ldlm1mmauabroPJ/jI034qIiK/hV4qcmRVqH9g+zWjzt2tEPN2woCyMuana
	1ixu+Fb3rGcUD8Ygd2ZCZAycv14/6Ldigch90FHpkhLQhR2SJcJ5u2SPg45tHN92B94zqqzbKfW
	wisSGWBDGVd5dg+2w49NghTHsfeBus1GTe9GfbbSMa+Ie2ywrUYb4sn7oEBsqDH0ImN2DG2IF3G
	qjt7MCtJfH24AfjJofx85dkQXY/vK8fVL4Q1ApFz71yWSDLXxuiviZTlZREqIwzPDPM+Mm4UDu0
	dt3yqIzfs4yqXTlQcsxwlNuypjxPPzccH88Kr77fOeuTMJmslgZpA+KTifGizT2DGGi3aF0+re9
	2vBbHGTBeF9R2AM69bpjqmmsb0valeEoz+hcJeL882hhWjkBh5HPx+GbcAgWcXWvXD3WoTVRyoJ
	LinMTLKECduxxbKKh0vgfR0ohpHrDPj/F0amjZeSwHW3OhFxwueAtNjyqN
X-Received: by 2002:a17:903:24f:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2beb06dc34dmr208466815ad.36.1779795160184;
        Tue, 26 May 2026 04:32:40 -0700 (PDT)
X-Received: by 2002:a17:903:24f:b0:2ba:4e84:966 with SMTP id d9443c01a7336-2beb06dc34dmr208466435ad.36.1779795159593;
        Tue, 26 May 2026 04:32:39 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b386esm128432695ad.44.2026.05.26.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 04:32:39 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 26 May 2026 17:02:30 +0530
Subject: [PATCH] PCI: qcom: avoid duplicate PERST# GPIO acquisition in
 legacy path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-fix_perst_gpio_handling-v1-1-9170507bb4e9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM2EFWoC/yWMUQrCMBAFr1L220BdjKhXEQm1eYkrkoZsFaH07
 q76OTAzCymaQOnULdTwEpWpGGw3HY23oWQ4icbEPe97z94leYeKpnPIVaZgTnxIyc4PuwQcmQ8
 pktW1wdTf+Xz5sz6vd4zzd0fr+gGaaopKewAAAA==
X-Change-ID: 20260525-fix_perst_gpio_handling-5a4fee9228fd
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a1584d8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=mtmqCDNuwk6juwfAGToA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: 9qlcG_kbD58zDpwp5_Qgd5iVZeS7gY1v
X-Proofpoint-ORIG-GUID: 9qlcG_kbD58zDpwp5_Qgd5iVZeS7gY1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEwMCBTYWx0ZWRfX0iT+6UOD7RAK
 MayVofP6dfy333qzCa1BjxJLR4qUwWhwy3760EQOrEKC+yKCXmOuFc1lUPL0jWlja2y89id8/ZS
 UPA+FTgIqtbpoLPPMq8YPRGSqF37vdQyWkMWYWY9lBjKAclNNKQ6SA9++eDwJ3Txg6Hp2yuFw/p
 EDHm8scC+9iR747nMPX7Rm4jwfnkcT0wkm2rUe6894vbu24US5frXZdpLqi2aPFifrQ2atcmauG
 X9YXS9FJDHAv6luUhibEbTGsTGKg0dbaa8d8H9m1/kSpSTp1v07bF5aJEw7Vga+YRxuMNKnDAJe
 epViEJ564YOoapfuh3tMYR5eOxWAxhD11kP4ISwx1vCEg/LKel6rzS8TeIy0zZ4hJGlDKSMHXnL
 nOwkYOAgeeOvMi4zIIft78IGL4BkU+lly625sSJpImXPWycRoPSOc5ypMCICEPpXQr5w+HeFEXP
 95vH8eK1iB/K4+Fnt+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260100

Commit deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT
configuration") handles the case where the PHY is moved to the Root
Port node while PERST# remains in the RC node by acquiring the PERST#
GPIO during Root Port parsing.

However, on platforms such as IPQ5424, both PERST# and PHY are
described under the RC node and are intended to be handled via the
legacy binding path. Since PERST# is already acquired during Root Port
parsing, attempting to acquire it again in the legacy path fails,
resulting in probe failures as shown below:

[    1.571859] qcom-pcie 18000000.pcie: probe with driver qcom-pcie failed with error -16
[    1.571909] qcom-pcie 10000000.pcie: probe with driver qcom-pcie failed with error -16
[    1.571973] qcom-pcie 20000000.pcie: probe with driver qcom-pcie failed with error -16

Fix this by removing the redundant GPIO acquisition from
qcom_pcie_parse_legacy_binding() and reusing the PERST# descriptor
obtained in qcom_pcie_parse_ports().

While at it, move the warning message to qcom_pcie_parse_perst() to
avoid polluting dmesg when the legacy binding is used.

Fixes: deed8aec62dc ("PCI: qcom: Handle mixed PERST#/PHY DT configuration")
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11fc60489892..77cbd204ac5c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1824,6 +1824,7 @@ static int qcom_pcie_parse_perst(struct qcom_pcie *pcie,
 	int ret;
 
 	if (pcie->reset) {
+		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
 		reset = pcie->reset;
 		goto skip_perst_parsing;
 	}
@@ -1912,8 +1913,6 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 						      GPIOD_OUT_HIGH);
 		if (IS_ERR(pcie->reset))
 			return PTR_ERR(pcie->reset);
-
-		dev_warn(dev, "Reusing PERST# from Root Complex node. DT needs to be fixed!\n");
 	}
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
@@ -1942,7 +1941,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	struct device *dev = pcie->pci->dev;
 	struct qcom_pcie_perst *perst;
 	struct qcom_pcie_port *port;
-	struct gpio_desc *reset;
 	struct phy *phy;
 	int ret;
 
@@ -1950,10 +1948,6 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
-	if (IS_ERR(reset))
-		return PTR_ERR(reset);
-
 	ret = phy_init(phy);
 	if (ret)
 		return ret;
@@ -1970,7 +1964,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
 	INIT_LIST_HEAD(&port->list);
 	list_add_tail(&port->list, &pcie->ports);
 
-	perst->desc = reset;
+	perst->desc = pcie->reset;
 	INIT_LIST_HEAD(&port->perst);
 	INIT_LIST_HEAD(&perst->list);
 	list_add_tail(&perst->list, &port->perst);

---
base-commit: d387b06f7c15b4639244ad66b4b0900c6a02b430
change-id: 20260525-fix_perst_gpio_handling-5a4fee9228fd

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

