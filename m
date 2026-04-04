Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315963451BA
	for <linux-pci@vger.kernel.org>; Sat,  4 Apr 2026 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292794; cv=none; b=GGqFqtk1F3PITYZ63D9wcOoZ06YDnlHsHVZf8CQUdnSSaJ8j7u2WrMDvtAjK01mjqaxGuLSrilwSJSTkMqeIjATAiKD5uvtnu63xIPvUejYDApszc+RIcXCY2GgMfSj23QYSb9Zrv6GF+meWpMWHrdj0lYOYKPPk8qVj3f5Vn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292794; c=relaxed/simple;
	bh=cLSMdyjO0adghxbWrzhTn9AZjVp8pKccOC2A/dtndtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ONWWFn/asMnFUU0+1x1uLe2stbOS8r7lA6UVMjsaWACoL0vKPqvICn6OkJbsawM6XLpI9Pv3VtW7z2mxy0RSYwNjF2h96DUC0UfmfjiWPdXceNKJysLYXpXaYi1PC6Q6lVNguR1kvuW+7RzT/LWavZvzpRvvUCl8BlFsShVNdBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WvkKoBXT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EuiXWe18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvkKoBXT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuiXWe18"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6340h3kq1345813
	for <linux-pci@vger.kernel.org>; Sat, 4 Apr 2026 08:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iUX5v+rwAN0X+mqB/JXSwM4VegcAMMvX06bkHKATt7E=; b=WvkKoBXTi3gfi1Kg
	JwHAIAhOEizVXJWWPd/YVufSzV2+W4pgr/iV8OTQCK0SHrPl7mPbmW+9Ru52x62Y
	Azng5k3bPhR3ICidSyZwTUWDpU1N0c92ozdnKSuAPe8O7QYtwEhhthiNYvNbxGZV
	4GW6Itnxy8L+DEJxAABrYA7uVX2kt5g2UDK27Syrvr5K7urRyST4zz5aq+KjS0b2
	Ziyl4qQDdtJe3HDqIID3lMsJguvhUe7VV4BzYAejYJC1lGf98sUtnpTnujUGT5En
	d2RpfCc7Jsa0wy3V7GURDakUkRZ6WksHAFmJy3BKxt+xjFZ4vCAFb9Daoap5UkY2
	PGz+lg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4darbfgrak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 08:53:12 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2489af602so24097775ad.1
        for <linux-pci@vger.kernel.org>; Sat, 04 Apr 2026 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775292792; x=1775897592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUX5v+rwAN0X+mqB/JXSwM4VegcAMMvX06bkHKATt7E=;
        b=EuiXWe18lwtRqkA+GawkNgsCPVvBpBf2uBKoF0+XFjXYS+GMlIO/n+yvnyEWfaKsgR
         omUyM4hS6YzOGlltHD27+RvCrtiCUobFCTuHmuWLZNHo/XcMKcInwoJOigmhCjvtuXR4
         fjyxfBdiqDtoqF/K0B1n77o/V26jnj29BrSPSm1QvrTNGQ7uzJU3tN9vGNtW3YFxSLVQ
         Us9XfkyhXDkzKjTtH1JFsl8yDNIrVP2ERDP/v3U5f9HhtvQdHgfNRJhZHWsEgvkBWc9C
         wm40hBfKI5coYMaXjydi5R5zHUYUCVw2jn6XogC3ktGPAiOy7Lpj4A2sZ+5PaZpe3WKf
         hJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775292792; x=1775897592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iUX5v+rwAN0X+mqB/JXSwM4VegcAMMvX06bkHKATt7E=;
        b=Omp1Vm1HorI3kimHLAwdc50g5MtbjhPzXsBsm7OIY3Hvvg9YR2HZkGSLH0i1W/LjuS
         vUXrDb6ugNQXsGIh/jLR5Xov9jDno6KG7wrCbuAVQZwZGC82elaqtU2EjL6gdhRcUjkH
         FB1D56RGjQY1B8xj8NeXqIy513oUQZvG/U+2TIJFpzy7kZir4lrjy2U0izamiVT4YWiF
         knKtnKBUlUsrKJamt2jDpBDd9Gn71vAfrvfoZkG6Hoxz8Lzl2bxQoAa3Bwn4E6CWEk9A
         dr06lU4TLuCpzg7ulOz9zPLHT0T5l8hS4FT/MxogJBQd/lKc2WVLDPbUOy7kqVKKS98Q
         95cw==
X-Gm-Message-State: AOJu0YzMUJlK0UfHxH/P+3Fsvkdl97355BM3OhKlPnKoBCIOI+tKK0Dz
	WUwy6cc2vo0LObnIINO1pe4PhvoxcvhFNnA2l0bODDATtOsptdP89lzwqYE45bEkW2DDdEqe3qR
	dE+pccnmlPJQOf7N0uI0T+jPrbYlxqSJGceXc7nAmb7Kd0nIm0lKd8v/JIeAytpNaTIJiPak=
X-Gm-Gg: AeBDievIhbUARYJIPEZtImBRza+qgr6R+LpM4e9lMbI8r89viRf4ZsERMtoa2Ydd/Qx
	z5nautS0IgX0zt7al28FQ1AnSTicJ9AvkAfclgYiHBnXJHvqs1WsYPDvHSfUIl5M5ETO4VaVgl6
	j5EFpBxRa1Dkwg7q2cLpyENn9xSyeImaL5x1+E1/QKCFibV/IfHWzClFfoPEHa7CoC1LMdpoJGn
	D/gRFAg2ocg2jh67yKMo4Ad3Fj6QoFVoJ+1/LygI1Jbknh1zjv708yTPUDr+KIgQsgidXbh8dEn
	HGZbrPibw3kbNBMw15RzScnppGtMJ7JF3NpcApwIAOkzsh9HbNJrSIYW9S2k/ZKZU4YK1nGlHWn
	+vfA6rHJl3BctKTitRxof0KyZeHjR7e0/RCsusFf58ne5DjIeGR/KjhMk
X-Received: by 2002:a17:903:b8e:b0:2b0:5450:a910 with SMTP id d9443c01a7336-2b28219df6emr58865635ad.17.1775292791597;
        Sat, 04 Apr 2026 01:53:11 -0700 (PDT)
X-Received: by 2002:a17:903:b8e:b0:2b0:5450:a910 with SMTP id d9443c01a7336-2b28219df6emr58865375ad.17.1775292791080;
        Sat, 04 Apr 2026 01:53:11 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749e2e97sm106883085ad.82.2026.04.04.01.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:53:10 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 04 Apr 2026 14:22:59 +0530
Subject: [PATCH 1/2] PCI: Add pcie_link_is_active() to determine if the
 link is active
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-fix_pci_access-v1-1-416f32c6f7ec@oss.qualcomm.com>
References: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
In-Reply-To: <20260404-fix_pci_access-v1-0-416f32c6f7ec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        manivannan.sadhasivam@oss.qualcomm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Lukas Wunner <lukas@wunner.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775292784; l=7261;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=cLSMdyjO0adghxbWrzhTn9AZjVp8pKccOC2A/dtndtU=;
 b=mufd4JHPj+WA+ZXoNU0SlTovD+ERWWnIHb7zVuhEAoqrB4oi43o+/Md4HTDwTkHPwqaD1GnkB
 pkcAP1w+3olBkxJOpu1LLLpL3QLPldKoa8BoUxzqLgK2hnvaA7kZb9i
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDA3OCBTYWx0ZWRfXy40a5YsHDpHH
 gRsy1vvUSiux9xOFaZwQei03TNjO23q+x4seuHZ5x4Ap8LSaleNnrM0xfI9UF8457TUAGoXJm+T
 ier8ORGJafP4MJALShgHQ6mkKp77/e8Ga9HTipKF+S6uTFZNo1jXPoczk4aI+GSohCzT1MWKD5l
 w5UdkH1ei6R75N1kVEBc+MtE7i7lypD2dIFFC+5uCIIC/VF1iJ1Xjk2FlxtemIGUdPh7fwhxS2Z
 NVucI45Drw+BwfswT0GMf+mm3kUh/350UFpnBJumc8bDx7GMmjKYpTl6mo8sBKKeivctY7AokPV
 g0fPdqe47BdhOjfUvAgISSfADuubxW199C3pwOeAlayzs8KzGlksaK0MMultTXCj6EvmOW9Fn+h
 twTo63rrQ50yckeIdP2grPxt4Ke3gTjVaAF2xPdgwUuEIXRmiG1GxGvCWe5KYINzwEoYCADzCzO
 qrD+NSevsnAMViZb4yA==
X-Proofpoint-ORIG-GUID: 5uiiXvDxui-mmc4jVh5fIRtxH2jG9kt2
X-Proofpoint-GUID: 5uiiXvDxui-mmc4jVh5fIRtxH2jG9kt2
X-Authority-Analysis: v=2.4 cv=I6Zohdgg c=1 sm=1 tr=0 ts=69d0d178 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=DLE-xEQoUa54y48t:21 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_AprYWD3AAAA:8 a=sQS_rdureY0rGLqyAPEA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040078

Add pcie_link_is_active() a common API to check if the PCIe link is active,
replacing duplicate code in multiple locations.

Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
---
This patch is already submitted as part of different series, but this
is dropped from the series. we want to bring this now, to check null
point access issue at pci_store_saved_state() due to linkdown.
Link to previous patch: https://lore.kernel.org/all/20250828-qps615_v4_1-v6-7-985f90a7dd03@oss.qualcomm.com/
---
 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_ctrl.c |  2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 35 ++++-------------------------------
 drivers/pci/pci.c                 | 28 +++++++++++++++++++++++++---
 drivers/pci/pci.h                 |  1 +
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index debc79b0adfb2c8e06aabb765e1741572685100b..79df49cc99463829f563db1dc8014a51ccfac0af 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -186,7 +186,6 @@ int pciehp_query_power_fault(struct controller *ctrl);
 int pciehp_card_present(struct controller *ctrl);
 int pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
-int pciehp_check_link_active(struct controller *ctrl);
 bool pciehp_device_replaced(struct controller *ctrl);
 void pciehp_release_ctrl(struct controller *ctrl);
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 7805f697a02ceab33cc962587e0ad85c16c0d962..e165e6d810214f26451920976b1f11d32dd162aa 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -269,7 +269,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	/* Turn the slot on if it's occupied or link is up */
 	mutex_lock(&ctrl->state_lock);
 	present = pciehp_card_present(ctrl);
-	link_active = pciehp_check_link_active(ctrl);
+	link_active = pcie_link_is_active(ctrl->pcie->port);
 	if (present <= 0 && link_active <= 0) {
 		if (ctrl->state == BLINKINGON_STATE) {
 			ctrl->state = OFF_STATE;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 4c62140a3cb444b1d29a378099d4c3d377b93d15..abfae48470ce44329d2bf84469e826ab4dea99af 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -221,33 +221,6 @@ static void pcie_write_cmd_nowait(struct controller *ctrl, u16 cmd, u16 mask)
 	pcie_do_write_cmd(ctrl, cmd, mask, false);
 }
 
-/**
- * pciehp_check_link_active() - Is the link active
- * @ctrl: PCIe hotplug controller
- *
- * Check whether the downstream link is currently active. Note it is
- * possible that the card is removed immediately after this so the
- * caller may need to take it into account.
- *
- * If the hotplug controller itself is not available anymore returns
- * %-ENODEV.
- */
-int pciehp_check_link_active(struct controller *ctrl)
-{
-	struct pci_dev *pdev = ctrl_dev(ctrl);
-	u16 lnk_status;
-	int ret;
-
-	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
-	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
-		return -ENODEV;
-
-	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
-	ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
-
-	return ret;
-}
-
 static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 {
 	u32 l;
@@ -468,7 +441,7 @@ int pciehp_card_present_or_link_active(struct controller *ctrl)
 	if (ret)
 		return ret;
 
-	return pciehp_check_link_active(ctrl);
+	return pcie_link_is_active(ctrl_dev(ctrl));
 }
 
 int pciehp_query_power_fault(struct controller *ctrl)
@@ -615,8 +588,8 @@ static void pciehp_ignore_link_change(struct controller *ctrl,
 	 * Synthesize it to ensure that it is acted on.
 	 */
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
-	if (!pciehp_check_link_active(ctrl) || pciehp_device_replaced(ctrl))
-		pciehp_request(ctrl, ignored_events);
+	if (!pcie_link_is_active(pdev) || pciehp_device_replaced(ctrl))
+		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 	up_read(&ctrl->reset_lock);
 }
 
@@ -922,7 +895,7 @@ int pciehp_slot_reset(struct pcie_device *dev)
 	pcie_capability_write_word(dev->port, PCI_EXP_SLTSTA,
 				   PCI_EXP_SLTSTA_DLLSC);
 
-	if (!pciehp_check_link_active(ctrl))
+	if (!pcie_link_is_active(ctrl_dev(ctrl)))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 
 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1044416281aba11bf071ea89488a..1488c93d4e22371480165cb55afc7a0c3cae238e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4756,7 +4756,6 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		return 0;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
-		u16 status;
 
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
 		msleep(delay);
@@ -4772,8 +4771,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
 		if (!dev->link_active_reporting)
 			return -ENOTTY;
 
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &status);
-		if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		if (pcie_link_is_active(dev) <= 0)
 			return -ENOTTY;
 
 		return pci_dev_wait(child, reset_type,
@@ -6116,6 +6114,30 @@ void pcie_print_link_status(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pcie_print_link_status);
 
+/**
+ * pcie_link_is_active() - Checks if the link is active or not
+ * @pdev: PCI device to query
+ *
+ * Check whether the downstream link is currently active. Note it is
+ * possible that the card is removed immediately after this so the
+ * caller may need to take it into account.
+ *
+ * Return: true if link is active, or -ENODEV if the config read fails.
+ */
+int pcie_link_is_active(struct pci_dev *pdev)
+{
+	u16 lnk_status;
+	int ret;
+
+	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
+	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
+		return -ENODEV;
+
+	pci_dbg(pdev, "lnk_status = %#06x\n", lnk_status);
+	return !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
+}
+EXPORT_SYMBOL(pcie_link_is_active);
+
 /**
  * pci_select_bars - Make BAR mask from the type of resource
  * @dev: the PCI device for which BAR mask is made
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce6698514d92500dfea03cc562cdc2..c9a6e5d3de3aeab125d2e456456359aa857e7a19 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -355,6 +355,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
+int pcie_link_is_active(struct pci_dev *dev);
 
 #if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
 void pci_create_legacy_files(struct pci_bus *bus);

-- 
2.34.1

