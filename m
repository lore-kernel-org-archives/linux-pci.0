Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790474;
	b=R2hhx1QNyJsNScoXIQGc7uASSPcjID9BDZdWT9Po9jlIuOwiIJDvoAGDtion1EV48o01
	 GA24ai3OlFa3bEYaZ3DBC2psaWmO8V+KNBpW93lqLx1s8OhEjXY9BALAETjUqSrbgUTS1
	 pZYdT96OwRAQtusWau0qXZWUG40GnGX3M6FHtQ5YCgNztgS0dGhaWNIfZBnaAZv9yO0Tr
	 f+xLVLGzQN2PpUVZ/KVXcTXQ0vvFUw+N8UgsW2Qbrc03Mzp0uM5dR9RgRM4EG+JND3KiE
	 SRMyG4wHq2wy4Mjg78Hk6thJBPCHSSmamxJN5JP+Bl9FRKiX35fM1tfvzzeTr2IqFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lVQeGD9agzy0mh5pcwZtPylSjLuXqaDKZw1i3CUR2Tk=;
	b=Onaw+yP/s0WHjCtq74/zQbTA9vnfj+pIJG5Jr4tSPtVHdomSywaHBSfvgI2qITyqNBMf
	 zzj0edT5plkIf6pd3LCaZTpQh/tCDJE5vkpl6ye8hw/Giept/TUKhdCrtW5PGzb1tCjkn
	 bV8WbKKcjSioPlLyyb/HcvdoNyMFBqpTlc0YqefnpaHC6qARCma5UJwU966m/DlCXEsIC
	 Wzv74+IxOHYiNhwbOG87GXYvR2pvFERj+Gwa3Rm5HRY1LB0fiBtL/utUB66kFtmEisgqo
	 nbK3c7gpaX0DabQ1TkyRsKPmnsmj022Vma8ACCzBAtFz0gmJqaVN34jCNNx69gAkd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ssso1Gle;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cH4i+qHv;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1988606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 14:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1988606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ssso1Gle;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cH4i+qHv
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1Lqr686002
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 14:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lVQeGD9agzy0mh5pcwZtPylSjLuXqaDKZw1i3CUR2Tk=; b=Ssso1GleEDHSTzLM
	sp2sNzcakwartjCQnM5P/CTfPdLeWreJp+TnQUMCfuUd5uFHkbz3w/8UvlJEjcdg
	Wn7blh3ANiIZLPngdjrVmgBgKFBDQJzuA9h5BYc6bk9f1plVNKSF1R9959ZbAOae
	SBooI9zvxysI4jwGmNuJxPmSSrKem8YWvFaKKMe2goff71qDxUYW8KKcT0udk4kh
	l8A4JAY/jwzRy6sig+uQQIL3P98H+jqXm1ROvhgbl03L+sNMwnv+9EqubscZpE62
	h0DMKdRBtnPTEJu99y9w5oPceP+i9k5VAQopRBcr3xu69Fy61SXssxTw5F28rriG
	0Xk9vQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49bewa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 14:41:12 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-386a0f79047so8789249eec.1
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 06:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795790472; x=1796395272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lVQeGD9agzy0mh5pcwZtPylSjLuXqaDKZw1i3CUR2Tk=;
        b=cH4i+qHvWtghUOuIDKphBJGjGOWzdm/RrN7ah3U3Acs6u+3y8klNmHghB1dmjxC4EA
         jm3eCjI+CDPUmxOAa3chO6cX6LaL3O5RxQmh6eyXEQj0VDby1X7JvFxLv4CAJ0hvmMjl
         dOKeLd6TFrp4UEjm5e5JX3o3Za0zeQLJpRF4c0DVbVihwMw+8/4nVl2sdXFG5WvJ7Hnl
         SU5hwggF87sPBtyZLEQxfs1F5d2eYneTmq5WZBz4o4WqBPSa3tFRSK3b0+28ZG73PeBw
         Z3eiPqw7hyf3SXPBIWOKRM/Pa+hDyoubyGObe2NTYd+zXr/s0OgAtdZ+WGCGioCNNznp
         dCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790472; x=1796395272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lVQeGD9agzy0mh5pcwZtPylSjLuXqaDKZw1i3CUR2Tk=;
        b=jx859XLjamPkJ8q+FhO4sXLakBdY5cgLQnH73P09wFulp/UwR0WI717ox7iIPOd9jZ
         H8reY3tGSnqMDMSvPfPoU0KH/Co2FKTp9qSqM8OwbM/Pveqf9iIEAIr2iHJbI5pxrtS7
         lTi+pIFNysMB4rzPDK9OodqvGzKhACGzXB6S/lEORbejWgEvDAxRuCW3mHKrTC6VpJDY
         qouzTOrjgwU8pksOx30tuTRkY4ezo7BUwaCngXkttpSOMG95Z2Y5MJ+ChV12RBqOwD7v
         d0/xt3QEt5OCCWURwJkECJ/P6DREEUMbyD+gxjX94XagjBMUgA8UzXwwGRtPWQcpwTkW
         kDeA==
X-Gm-Message-State: APuU4Z8BXX/PwgXSjUbyAs7CvgZNv1yG/8AlYPR7Qnrh1wm75+N98EFG
	Ur9gFeu36N+kR2VTplmLPa232WI3+xDb69+E0j7FtrOPX3VvtvGeAV9lN6GXJLPIiI6TYMNfUuC
	GfDdOZhoOuiWji1s1jpcV9kU4oIMwAWr9FoHq4kzesi6XbTWVh5xbazSSJTfrefk=
X-Gm-Gg: AZFdTZeOc1Bhbmd+JGM9trb0MCTM4EgPUMzszPwHoAVy6qXb3aT6j+kySo9cLhgl6YT
	JoftjjQfg2YqDGwSsKI+75g/yiAhcECUtW2x9h03fBirMQnnbh8Dtw8nxPkDdWX6Ixjjb8vC/16
	2o/M2TiEW9thYDXOOcx/q5CcgMaF9f2Sx3r6ER8t1llB6Z8W6eU1jSMxDSB8Nh4uzJuOZlBVJpX
	8zPcbAfkseELrRX/7TkZRX9FTJajYdgm3EcUtKJoLTR8a8kMxLL9TU12AlR23GNDXrNHFT30XUj
	Ba2l8KOKTB/8IaW6R/T6vYtozVgUhTnmVFQffhDV0BrA7s0tpTiH2A4SfZFUGTU7hncB0GDrAnS
	iA5D4+01Er5CWEVAEYX26ag55iNsfjuWhOOzl3qYruNNhByny3rIuo4r0iL63aplbxAZ4D9sYGT
	zL9aJ6bw==
X-Received: by 2002:a05:7301:650c:b0:386:cca5:3626 with SMTP id 5a478bee46e88-386cca53bd1mr12721517eec.31.1795790472077;
        Fri, 27 Nov 2026 06:41:12 -0800 (PST)
X-Received: by 2002:a05:7301:650c:b0:386:cca5:3626 with SMTP id 5a478bee46e88-386cca53bd1mr12721485eec.31.1795790471557;
        Fri, 27 Nov 2026 06:41:11 -0800 (PST)
Received: from hu-msarkar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567cafec4sm82970809eec.26.2026.11.27.06.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:41:11 -0800 (PST)
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 20:10:50 +0530
Subject: [PATCH v2 2/2] PCI: qcom: Reinitialize MSI on resume for
 firmware-managed controllers
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
Message-Id: <20261127-pcie-controller-reset-v2-2-17467b64f5f5@oss.qualcomm.com>
References: <20261127-pcie-controller-reset-v2-0-17467b64f5f5@oss.qualcomm.com>
In-Reply-To: <20261127-pcie-controller-reset-v2-0-17467b64f5f5@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rama Krishna <rama.krishna@oss.qualcomm.com>,
        Nitesh Gupta <nitesh.gupta@oss.qualcomm.com>,
        Ayiluri Naga Rashmi <ayiluri.rashmi@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Shazad Hussain <shazad.hussain@oss.qualcomm.com>,
        Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795790457; l=1624;
 i=mrinmay.sarkar@oss.qualcomm.com; s=20250423; h=from:subject:message-id;
 bh=WX7R2eiTg1XRmSTdE1ID9a+HknD/KT/w9md6BbR8JFY=;
 b=iB9pAwj2cwwXHXvZfP2boU6JGBIx0XChK8Hj92BtJ0pmCggskWkOwT81GsjYJTl7rTs4Eji3a
 IUxOtyCrudQAn/CvKuCLsB1UiqrxsW1OAws/yLPfFKlGfbNK2TLNYVw
X-Developer-Key: i=mrinmay.sarkar@oss.qualcomm.com; a=ed25519;
 pk=5D8s0BEkJAotPyAnJ6/qmJBFhCjti/zUi2OMYoferv4=
X-Proofpoint-GUID: F0CnRXgScXlqD2wi1znZobrVikqdHUBs
X-Proofpoint-ORIG-GUID: F0CnRXgScXlqD2wi1znZobrVikqdHUBs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX/AjPfYLueKtR
 u72SfOd93zSpSByDnZGCo4036erQKPyl9A96Q3CUMD0s+OOgXd4vTYL1qaNCQgcXFZ6SF6Sc/E2
 Dtl3TcZGvM5rK/OIyM6ydAdJCRSI/js=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1OCBTYWx0ZWRfX+HiyYpXMpUgm
 G+/NmB4iGeM6Epb4oWEa3yUKIbeSp9RSLL8ZZkJGnAb/i94KgQyXkohgZiHEtcsQGRU/IJi7ZmL
 nl5aQjgfPM8POnIKcJpRHwHpR1YZAvMwmfeahWFEGSWSp+XUp4TUBs+TFbZE2IirkY9od0QrDlg
 Z4QqE5iD6IOBdoxGUGx7P1rF55DleUR3vUIr6DPT8yh7XjN9GGyzi9VC4A7+kVNg9WNI0k+yb1c
 Xpwb42NbgwxV9mN2qIW3ad2ec/2gkBsFsTOA9oSWvRNH12a7/3ajRBCYrOgkLJYts/+7V87utZG
 J6/Pj8B5Im9GvtPhAqApBdq+RmbjUjprJwsf1AIFvrZHzLMhPcnwyCPsL3DWqDff8XX84WJAxj/
 UTeiGwe/A0P+/uv2XGfx3ddh28rLcvf4PKe6pBhWISHibWjpXiktY0BIrRgKnXS8vgrdiJRxUfW
 euVYiU4YvnhM/XnKp9Q==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b099688 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VdY5-eERFFFFdNr3g4sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270058

On firmware-managed PCIe controllers, hardware context is lost across
system suspend. While firmware reinitializes the controller through
the power domain framework during resume, the DesignWare MSI registers
are not preserved across the power cycle and must be reprogrammed by
the driver.

Reinitialize the DesignWare MSI configuration during resume for
firmware-managed controllers to restore MSI functionality after
the controller is power-cycled.

Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index fe86b8fbc895..51299dfd574c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2325,6 +2325,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		bridge->msi_domain = true;
 		if (IS_ENABLED(CONFIG_PM_SLEEP))
 			bridge->reset_root_port = qcom_pcie_fw_reset_root_port;
+		dev_set_drvdata(dev, cfg);
 
 		ret = pci_host_probe(bridge);
 		if (ret)
@@ -2552,8 +2553,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	int ret;
 	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(dev);
 
-	if (pcie_cfg && pcie_cfg->firmware_managed)
+	if (pcie_cfg && pcie_cfg->firmware_managed) {
+		struct pci_config_window *cfg = dev_get_drvdata(dev);
+
+		if (cfg && cfg->priv)
+			dw_pcie_msi_init(cfg->priv);
+
 		return 0;
+	}
 
 	pcie = dev_get_drvdata(dev);
 	if (!pcie)

-- 
2.43.0

