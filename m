Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794646037;
	b=sNFsu+8RsVbpHM3S0HUNS3fPcno4wJAulHa+4Fq/6NH01rFvtoRw2di4gow/FUQ/fu0e
	 MdT0OzBS4GXe2LcZvNFkOZdvdcbvlv1b15i0zRvwfV2wng/Lshf+5An0D47liTxdvxnXc
	 74jXvu+llgUU+dorFGDCuW/Qrx2J+/HWAKOhsTs5jCI5UefHswlm53pADg41ZlhqyI/2I
	 RSZUowcqTUtW9UQpfXrkdskiW49q/FXXfjtr49Kg429ujL9GbX5hfJuXcrbuGR9ERiKG9
	 w0v3CygyJSv1Dv0PyQT8qWVkkQeOMTbOIfgZDTMVkc7fRgTuuD9fBDYXEnGiPCuuVIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794646037;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+4TIWnAP1NHvk78b7/b/TDbPoMrvRiPIPlb6RetZajg=;
	b=wEreb/NZSEajGrq9A6a4VuwK3BKc3soSOGBowafDNJOepVy7uRDB2t01IS8d2g2101Jn
	 wVMMXM5DUWDyelG986uWxQvtviqJMDX4iVDAqXbL1oqSMsDI31dW0ygntKyMNU78Ap5gN
	 z3gQyKG71uAWU06rDKnuhbxruhLHvjktpOxxKu1f4RMX1+YFTcigflgdwfX1BtuLVa8Ff
	 /1HEzkNdgj6FS7W6ezI/7gSmVJcCN8FJ20gPNOUQWpg5WXpEjEyiKHfayvhpoXFX5Nkny
	 ew9u1uCv++o/hNLOhmVUUjq0kBHaphrNbSz97G3I8U+3iAgqCgj6KvMJ/A8aR2oe4rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D30oXydZ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PI9DU1DV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AC606A330
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F34AC606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D30oXydZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PI9DU1DV
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE61LHO2892065
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=+4TIWnAP1NHvk78b7/b/TDbPoMrvRiPIPlb
	6RetZajg=; b=D30oXydZx6vksrUw7lAQeu4z017zaCGKOx4SSS1ibxn6I7MyVbx
	j5doRoWz2nrC4eXffow8yvNDHGR/UqJK/q7M3eQAR/KTS83wumYOaR0pAIriNZcB
	tr2Bp/ah2QRZ3MXxtaelQqoguJFVaxkumJFrMXfr4UR59QYkNSQ0XdFhi0TlwDCt
	6WZ35DJLqJtI0flZKFONht9aZIknQpniJi6lotvg3SkffMvYo6Y/20UxNuI3Fufu
	r23bBbBs/eQO7WHpuEH33EhW7FPOJoz8LccuLdJJ08dcl04dU1bb4MT9IqMtcoSJ
	WshhPL5UYFobFMF9d30vPI10Dd7pKHb9+aQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx0bxa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 08:47:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed2803f863so14210385ad.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794646034; x=1795250834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+4TIWnAP1NHvk78b7/b/TDbPoMrvRiPIPlb6RetZajg=;
        b=PI9DU1DVwWhRU8BGrHKBh1fHckHhsk0laIPrCoOt9cAMc/Q/SMOSiB1mjkB84e2GNF
         32sJTTEh1irOW50KfuT0/MDpk18BfDtliaF+YLtvRpW6x8Wz/tOqTVCTwzhhdl+1T07U
         uq+283wkn2TYMYj6kj/0cvOXRUwJcyokbZcad6M+GOCIgmnTDO2OdX+rF6LPqkgdkQMe
         nfV+moeFfJTuvQQZ/mRTnm8ZKj979tGRFrxzUAO8/SgDa4c0MJm6Rf9Bg/fjeb6j4x37
         ewO8V9808D/vY1LKLqjYz5Ao3FcOBpHqepUppe2KYE2XpJ/+dQv7gRTbUUzgaYja5oTH
         yViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794646034; x=1795250834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+4TIWnAP1NHvk78b7/b/TDbPoMrvRiPIPlb6RetZajg=;
        b=Dnci2EMJn2mvrsev2du8U4OxgsASDYFUS5wsdqAgxK1X+PhcuM+T0SR8LPMWy4Ht8I
         Bgwcmk+ptp4J+7yZIa+YgtX9a0PomBT8r61XsHeDxpLbMREhdSNy/N1TygLAkFNtTzfO
         RxTN4kKd/31l19ZkCkXst9vCdhyikxNoaAE1JFRTIUv2OH7RZkuXFBo1wDbu0lFcqLhR
         B0L9NgZwqOoNMSg6qAVS9RBJ2k7ose88Ma5XgwMEuSOOyqDoxm5DRb7W0sqMRoA3vdEq
         fkiOmb2r4uDsNrp2ZqiKtel268mqvfldsB680b2fHRpyrhm3bCXIdPEmjefbZ30ogREv
         2NNQ==
X-Forwarded-Encrypted: i=1; AL+hErHzGG5DCosy90Zj+yLSgXV67G3YkHMe0B6cY7bsUHgqJfpHkeLisjzxzTweiZG6SFjxT+LNiwdFL90=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WLqRN0xVUSGuwUK3B9eZhz1/q/g6108rqK6wUXwolNwJG1BQ/
	PZSs73GpvCF2PXpHKz+gUg010oBi2W67RdR0nxh7LwNNPHCQEgii7bOlYfdFQIH8ckoXvkHRXP9
	/sAG/7pCkhvFAGyqkTg86KTDvNl55/HHne7LO47ebibZ/S8JTxeqhO5iQa/9pPz0=
X-Gm-Gg: AYBFou1bLcXZGVS74CWMbxTsh8Y+ERdBniJ3I6TUqcmfnyfhc1uIQ6+xIz7rXqfI+VV
	2yOfGH1w+wtRB/lTK5R/uC90kaUKdixOBT7/hVBwuYntM/+gU+m5gJpmDv116fLFPWcUnRYWpnm
	0oHtHQg2ohC++E8rgHby0srJUPodJLmqJbB1ausHZvXYWDqMCSoUkUPhB4FucISv2FqxZTg/Rqa
	EsV/nOzEAmAIDOGJlNZkvC79fvoH5vezotkIHq7TWeR0J+gdIXqk8f34UkkMhGMVz0Xj6l1H1Hy
	rb5K/ylOSIEwjbrH/Nn+Hs/vN1adqFgncT1hmbKc6RcmS8wqBoYUGu/JuJ35+Ge/hCL1N3Ocmyn
	37BH0ExF+HiNtjMhbT/df77Ey9P7fY62NkfAWjQ3wEttdbkCDPrVpr2miV2hdq3L9/aVKaRic7q
	WGbUHhxBb7MNd3csspO+ec9dONgIYdy4dyqWHC
X-Received: by 2002:a17:902:d550:b0:2e5:54c6:e5c9 with SMTP id d9443c01a7336-2ee0d666a7cmr51378225ad.2.1794646033670;
        Sat, 14 Nov 2026 00:47:13 -0800 (PST)
X-Received: by 2002:a17:902:d550:b0:2e5:54c6:e5c9 with SMTP id d9443c01a7336-2ee0d666a7cmr51378125ad.2.1794646033184;
        Sat, 14 Nov 2026 00:47:13 -0800 (PST)
Received: from ap-kernel-sh04-lnx.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8d4612sm19454895ad.57.2026.11.14.00.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:47:12 -0800 (PST)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH] PCI: qcom: Mask PARF_INT_ALL_3 events on Nord
Date: Sat, 14 Nov 2026 16:47:00 +0800
Message-ID: <20261114084700.907031-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAzNCBTYWx0ZWRfX0stGbtha0nN9
 yhO0SYCnK3+BNvJ/mZnw/m+7lRcvVuQVWRUKuDrvIK9Mjz+EFoXFXv7VXzNkCz7bgJ+aU8JX5rZ
 IeRRyvv2Gxx7eLJQpx72D9GuYhFxSFjS+E7acUasoCqIvlxy4AdDtoKAq+FIIF70dcm7ZSXOx+P
 k3gNNoRUEeaFZ/l8y8Ie9PHHiGjorgt+m2PSVUowcoB4EW747z8d/D8V+tt2keMpNSsCCZdDGTN
 UeQArUyj2mUd2jdnrOVPx2KrvBjLGVtDB8Gw4da37PgWy+wBrhbtS1TomxvT2HLxfEHuRPyFp68
 jP7GK0RZ40DiRPtDVTPo4ezmISJkEG0zmNEubQlrkvCEjTApQVleBAImL9o+9ldum9VLskeXZ00
 rvCxzLbB3B4K5EA6dZb4fH4yLzsQm9B0KJjx0T97SiOC7BcTUf6ucuBCwvCOaMwLd5wwFQ4apHD
 /R0uufe0V4lRCB70TGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAzNCBTYWx0ZWRfX2eOJOdsIwFH2
 3A1lG/iXxqywyIeCWXxkNcWNEHspspRtD7EmJx1j1lL81BlaHPMzhMqqalFiFh2SUsNy8qHww+d
 ayJdMssLIFxMPEOZ/26B4QJIZo3yRec=
X-Proofpoint-ORIG-GUID: 9a74Z5FepJbrjr8Wvkslm-1CJ8g8ACi-
X-Proofpoint-GUID: 9a74Z5FepJbrjr8Wvkslm-1CJ8g8ACi-
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af82012 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=iNQGgZdId2M00zXFBaIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140034

On Nord, the PARF_INT_ALL_3 interrupt group is unmasked out of reset
(PARF_INT_ALL_3_MASK reads 0x43fff), and its events are routed to the
same 'global' IRQ as PARF_INT_ALL. The driver neither handles nor clears
any of them, and the global IRQ handler only looks at
PARF_INT_ALL_STATUS.

Some endpoints send a Device Readiness Status (DRS) message after link
up, e.g. the SK hynix HFS001TFM9X186N NVMe drive (1c5c:1069). This
latches DRS_MSG_RECEIVED (bit 12) in PARF_INT_ALL_3_STATUS and keeps
the level triggered global IRQ asserted. The threaded handler then runs
in a tight loop with PARF_INT_ALL_STATUS reading 0, starving other work
and stalling the boot (RCU/SRCU stall warnings).

Mask all PARF_INT_ALL_3 events and clear any latched status on Nord,
before the global IRQ is requested in probe and again in
qcom_pcie_reset_root_port(), since the register is reset together with
PARF_INT_ALL_MASK. To keep the two writes together, move the
PARF_INT_ALL_MASK programming in probe into the same helper, which now
runs right before devm_request_threaded_irq() instead of after it.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 30 +++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index eba1b2cb30f0..03b2e61fc20f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -73,6 +73,8 @@
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 #define PARF_BDF_TO_SID_CFG			0x2c00
+#define PARF_INT_ALL_3_MASK			0x2d8c
+#define PARF_INT_ALL_3_CLEAR			0x2d90
 
 /*
  * Outbound blocker range registers. The blocked range has a write pair
@@ -294,6 +296,8 @@ struct qcom_pcie_ops {
   * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache
   * snooping
   * @firmware_managed: Set if the Root Complex is firmware managed
+  * @mask_int_all_3: Mask PARF_INT_ALL_3 events, which are unmasked by default
+  * and would otherwise keep the 'global' IRQ asserted
   */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
@@ -301,6 +305,7 @@ struct qcom_pcie_cfg {
 	bool firmware_managed;
 	bool no_l0s;
 	bool disable_cgc;
+	bool mask_int_all_3;
 };
 
 struct qcom_pcie_perst {
@@ -1738,6 +1743,7 @@ static const struct qcom_pcie_cfg cfg_nord = {
 	.override_no_snoop = true,
 	.no_l0s = true,
 	.disable_cgc = true,
+	.mask_int_all_3 = true,
 };
 
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
@@ -1871,6 +1877,22 @@ static int qcom_pcie_set_max_opp(struct device *dev)
 	return ret;
 }
 
+static void qcom_pcie_enable_global_irq_events(struct qcom_pcie *pcie)
+{
+	/*
+	 * The PARF_INT_ALL_3 events (e.g. DRS_MSG_RECEIVED) are unmasked by
+	 * default, but not handled by the driver. Once latched, they keep the
+	 * level triggered 'global' IRQ asserted, so mask and clear them.
+	 */
+	if (pcie->cfg->mask_int_all_3) {
+		writel_relaxed(0, pcie->parf + PARF_INT_ALL_3_MASK);
+		writel_relaxed(~0U, pcie->parf + PARF_INT_ALL_3_CLEAR);
+	}
+
+	writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
+		       pcie->parf + PARF_INT_ALL_MASK);
+}
+
 /*
  * Qcom PCIe controllers only support one Root Port per controller instance. So
  * this function ignores the 'pci_dev' associated with the Root Port and just
@@ -1928,8 +1950,7 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
 	 * non-sticky.
 	 */
 	if (pcie->global_irq)
-		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
-				pcie->parf + PARF_INT_ALL_MASK);
+		qcom_pcie_enable_global_irq_events(pcie);
 
 	qcom_pcie_start_link(pci);
 
@@ -2429,6 +2450,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_host_deinit;
 		}
 
+		qcom_pcie_enable_global_irq_events(pcie);
+
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,
 						IRQF_ONESHOT, name, pcie);
@@ -2438,9 +2461,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_host_deinit;
 		}
 
-		writel_relaxed(PARF_INT_ALL_LINK_DOWN | PARF_INT_MSI_DEV_0_7,
-				pcie->parf + PARF_INT_ALL_MASK);
-
 		pcie->global_irq = irq;
 	}
 
-- 
2.43.0

