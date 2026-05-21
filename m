Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00839FD9
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779385590; cv=none; b=uYZDXAhj3kzk8LCnmH+YXZiSOLRIy8R1aAgfUo8lxsr9MVLR869KttF7Gj+R8KOnFpI0QtdkSTRt6oXLaSI0U2kjwMZD/6vVqhW6KIdQnboDDY0+Hus8PH5n2gidiuq7ueW2OWJUCSQq1BPXhUFmzVuphXsJ5bCDKJ3xQs1p/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779385590; c=relaxed/simple;
	bh=5/Eh6wPCHUm0+jZOa1kqxHhpX+N1+kXps8MKam+3SrU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QD/9S7lSspDkswmwLASkwxMGTiXNd5Z2GPUD/FTli+RzZ9OQ92bCKJI/cjN2JP3mGMim5ssVkCkxdeU8UQtOIst/nXmRgWgwjhR6Yelc7Rd0VkTdE9BRtUIxFJFAmv4c0CnuyTl8L8zWcaiK1vDFJkl30MWq4XAoG7ARfmaHJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jldDL0Cj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OqOwLAoC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jldDL0Cj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OqOwLAoC"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LGmCoj186589
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 17:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1Tv1KV4V2E+d6FJx3XVzNwtiiaceB2O+rc7
	MvK8GBfQ=; b=jldDL0CjAzWZaDr4IpaevONG9zxLBxUPUNy+zoLbCkLvKV5U3AL
	FVV5eQQZsIq7vxULMooNclWz5lm7Xw0RTebVTM3PF29XJ124Jv60sSvPT1+ds+d2
	+aXqFz5xheNzUyx2X9bg05mbLWfXuOb2bX1zTdLMfRbwLHE9XIYWa1jUuk0RV4a6
	bJkNttPo8qD8NOwaFsbcCa3pNIltWWgNAqdvei9jppRhh2TPV2VRyCh47evGqMda
	JmN20jHZ4hp9IMRgIsjNx1nuZ+DM2E63YPP5cYylGd1T+w69yvx0NbRiw962Occg
	PKNMcEnKbTNEaUh9N6PXcuUgCBpHZxvE8qA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahtn1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 17:46:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2babbeff9e4so68995075ad.0
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779385587; x=1779990387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Tv1KV4V2E+d6FJx3XVzNwtiiaceB2O+rc7MvK8GBfQ=;
        b=OqOwLAoCN7cr0xcy0yDZAmpyle54JbeyFJn4ufJ0Hj1kpQR2PiN2DOee1dF0iXkaEU
         gc/C/r/jDiBr1YFf9Dyv4o+5m4wX7q9fHWaMB1hMIUbQ0chgipgQBLZvFDZEj324RwPV
         kJ9qiUO4MtVP2KAHvYmqyH22vsYVbWewInPZ517GfjfXoyTaphBq6/P38GchW9XKWMcW
         qiDUNsu4arpS0QOqCKwnT20qg/RqpTseb0AglAQrmtffZsSxRRTlrVCqxPG2OlKuaFqj
         cDwC+Xy/3W8sfQvkQNfn1a4s4TYF0WCWWMlZ5kFjp72BgT0CgkLJDZ6xuV5yyfR4ampG
         KILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779385587; x=1779990387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Tv1KV4V2E+d6FJx3XVzNwtiiaceB2O+rc7MvK8GBfQ=;
        b=mXCjgHJ3kVm+Owpppp7/iifh4x6ij46+064sGyWMHTi80l/Vh5friCEeQEw+PQacZp
         fky66ROYJjySs8iGi9Wu3b+p1UXiZwzCM04+kaszPTytPkYXYxx4VlTw0qs1/ZXFUWma
         dkt/FH6GqaPSsha6E09qSG0K1mZ76vBjihhEte2l7q4kAx26sDJ+f/RMttVrrvwOP/oX
         +QettwkFOrSAMHix1arbYfLUEFhaCzrmU/JGL2XWBcxLUp5sdcwfwr9OD4L+YujRtcf6
         lKRIjWDdyVnqcOK/LpDJmH07oafnKmkNf4pWXxKbKS5IFKg7n6xNFNiCDJiVIHuyDNZg
         kxvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+K4jwNLAwj9I5Dp6QcaAzKkxl+dKDC+0JwAyHCxDUu4AGzTty/uC7aQp066QFuzPNSDqfMDrlzaCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIRlNGKA9SO0owoe+OP0TQzuncVNlIAE3+81Gk9DroMGBl9TIV
	fRkaVoAxEmJiuX9VRdU118UjwG/Yoy0W3xrlbj3SJsnx60e3RpVTIPQfge3YBnfiv5yBlcrg7Gk
	9PnksrEADsteDM0eTmhTI3IshyGK0LAbuuo7uYcFAqkEUivEyiaurxxH6KDjIbSg=
X-Gm-Gg: Acq92OF70BhOsw5M73c3x5Svuqkwgr7O/HitZSGSSFY8/O2cYwRpBoiswc/pwyRVNvt
	8UDhV0gkBfCyRNU85AZvBZO1R/lQBZXkcSeqvIDpGMZn9txqpY6PjTsX4JJ24RkYpgr1lCKjrSJ
	Caa720bkLh2Ce9gJYba/sN+Kye946RpFpmWwFrw5cMLvrB22ioIh3NfhVyflU9UVC01pBBIo7bV
	EEgpj7fa/NNFWZtpZaw6j7We0tIIu2RQlsM7PahX6idOrsffPb/r5xCt7dN8CrMSkcTQjl8V3yY
	ZwQ0AnYgvpMAMRdBD/z8T05qfT5zlgca2Y8oWfjT66n4NePD3SkfDVVFKqK8uC9RMah370yeki1
	0Q6RmHrA=
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr37526325ad.20.1779385586582;
        Thu, 21 May 2026 10:46:26 -0700 (PDT)
X-Received: by 2002:a17:902:da48:b0:2b2:4bbc:14b0 with SMTP id d9443c01a7336-2bea22b759amr37525755ad.20.1779385585704;
        Thu, 21 May 2026 10:46:25 -0700 (PDT)
Received: from work.. ([120.60.66.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea990105fsm19011775ad.55.2026.05.21.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:46:25 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, mani@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2] PCI: mediatek: Fix IRQ domain leak when port fails to enable
Date: Thu, 21 May 2026 23:16:17 +0530
Message-ID: <20260521174617.17692-1-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE3OCBTYWx0ZWRfX8rz/n6N1qdka
 naJh6zn38kd+5PLDd7TNGmn53rhnk5EFI7mtrss1sQRxaYGbZmPf1kYC5xIAE44e4Vvims+l1VZ
 HMdH14UIPh7YCP5G/KyrHmFaB9M9RUpDAy3wvAEyxGpFHqjDWaCtduwiFvmV5sQVThykixjJmAa
 FmSIb2cUw9tv7fp3nydPxl5Tjiq5pbU6NeAGCBoq1GqgMy4sSpsK12zesDveJsmwJtbdyFH4O6M
 qFsEo4D7X/wNSs83mVcimYvvW49n7z4SPm+hcCpE32HMHYY4KBnvFcb0dxb89gvdOrcQ5huESsR
 8rdzjxD0iuHV1urjn0j0weDLdGaY4XFYeHmkjTMEvJ3xFjfcV+sRt8drkUUYI23X2pm8ViqyynS
 XYXR/1Frdt/mMGmVzRaaPbamGYuXiCg1Ux8H0GFOqncQHHFmbfQSrunsxjusM+peVPFQJrlAmye
 7yutnZPPGMLz0bizklw==
X-Proofpoint-ORIG-GUID: trFIl9k7UYa470bu1vvrZRR9gm3G2yQK
X-Proofpoint-GUID: trFIl9k7UYa470bu1vvrZRR9gm3G2yQK
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f44f3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=F8mVszBSU3svo1NvbJWAvw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=qMEm_45GddOWhgBJpCIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210178

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

When mtk_pcie_enable_port() fails, mtk_pcie_port_free() removes the port
from pcie->ports and frees the port structure. However, the IRQ domains set
up earlier by mtk_pcie_init_irq_domain() are never freed.

Fix this by refactoring mtk_pcie_irq_teardown() into a per-port helper,
mtk_pcie_irq_teardown_port(), and calling it from mtk_pcie_setup() when
mtk_pcie_enable_port() fails. Since the IRQ teardown must only happen in
the probe error path (during resume, child devices may have active MSI
mappings and the NOIRQ context prohibits sleeping locks),
mtk_pcie_enable_port() is changed to return an error code so callers can
distinguish the two paths and act accordingly.

This issue was reported by Sashiko while reviewing the EcoNet EN7528 SoC
support series.

Cc: stable@vger.kernel.org # 5.10
Cc: Caleb James DeLisle <cjd@cjdns.fr>
Fixes: b099631df160 ("PCI: mediatek: Add controller support for MT2712 and MT7622")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

* Used a different approach by refactoring mtk_pcie_irq_teardown() and calling
  mtk_pcie_irq_teardown_port() from mtk_pcie_setup(), as Sashiko flagged some
  potential issues with v1.

 drivers/pci/controller/pcie-mediatek.c | 63 ++++++++++++++++----------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 75722524fe74..907ae4285ecb 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -529,23 +529,27 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 	writel(val, port->base + PCIE_INT_MASK);
 }
 
-static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+static void mtk_pcie_irq_teardown_port(struct mtk_pcie_port *port)
 {
-	struct mtk_pcie_port *port, *tmp;
+	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
-		irq_set_chained_handler_and_data(port->irq, NULL, NULL);
+	if (port->irq_domain)
+		irq_domain_remove(port->irq_domain);
 
-		if (port->irq_domain)
-			irq_domain_remove(port->irq_domain);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		if (port->inner_domain)
+			irq_domain_remove(port->inner_domain);
+	}
 
-		if (IS_ENABLED(CONFIG_PCI_MSI)) {
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
-		}
+	irq_dispose_mapping(port->irq);
+}
 
-		irq_dispose_mapping(port->irq);
-	}
+static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
+{
+	struct mtk_pcie_port *port, *tmp;
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_irq_teardown_port(port);
 }
 
 static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -865,7 +869,7 @@ static int mtk_pcie_startup_port_an7583(struct mtk_pcie_port *port)
 	return mtk_pcie_startup_port_v2(port);
 }
 
-static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
 	struct device *dev = pcie->dev;
@@ -874,7 +878,7 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	err = clk_prepare_enable(port->sys_ck);
 	if (err) {
 		dev_err(dev, "failed to enable sys_ck%d clock\n", port->slot);
-		goto err_sys_clk;
+		return err;
 	}
 
 	err = clk_prepare_enable(port->ahb_ck);
@@ -922,11 +926,15 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 		goto err_phy_on;
 	}
 
-	if (!pcie->soc->startup(port))
-		return;
+	err = pcie->soc->startup(port);
+	if (err) {
+		dev_info(dev, "Port%d link down\n", port->slot);
+		goto err_soc_startup;
+	}
 
-	dev_info(dev, "Port%d link down\n", port->slot);
+	return 0;
 
+err_soc_startup:
 	phy_power_off(port->phy);
 err_phy_on:
 	phy_exit(port->phy);
@@ -942,8 +950,8 @@ static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 	clk_disable_unprepare(port->ahb_ck);
 err_ahb_clk:
 	clk_disable_unprepare(port->sys_ck);
-err_sys_clk:
-	mtk_pcie_port_free(port);
+
+	return err;
 }
 
 static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
@@ -1109,8 +1117,13 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
 		return err;
 
 	/* enable each port, and then check link status */
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err) {
+			mtk_pcie_irq_teardown_port(port);
+			mtk_pcie_port_free(port);
+		}
+	}
 
 	/* power down PCIe subsys if slots are all empty (link down) */
 	if (list_empty(&pcie->ports))
@@ -1209,14 +1222,18 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 {
 	struct mtk_pcie *pcie = dev_get_drvdata(dev);
 	struct mtk_pcie_port *port, *tmp;
+	int err;
 
 	if (list_empty(&pcie->ports))
 		return 0;
 
 	clk_prepare_enable(pcie->free_ck);
 
-	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
-		mtk_pcie_enable_port(port);
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
+		err = mtk_pcie_enable_port(port);
+		if (err)
+			mtk_pcie_port_free(port);
+	}
 
 	/* In case of EP was removed while system suspend. */
 	if (list_empty(&pcie->ports))
-- 
2.48.1

