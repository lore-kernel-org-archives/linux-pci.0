Return-Path: <SRS0=AkHN=R2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97EC43381
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C4021873
	for <linux-pci@archiver.kernel.org>; Sat, 23 Mar 2019 21:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="I4Ef8XT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfCWVEd (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:04:33 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:52410 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfCWVE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Mar 2019 17:04:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 211C1C86
        for <linux-pci@vger.kernel.org>; Sat, 23 Mar 2019 21:04:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V5zPc5Cw74iP for <linux-pci@vger.kernel.org>;
        Sat, 23 Mar 2019 16:04:26 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id E63DDCBB
        for <linux-pci@vger.kernel.org>; Sat, 23 Mar 2019 16:04:26 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id k2so4795250ioj.2
        for <linux-pci@vger.kernel.org>; Sat, 23 Mar 2019 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5wG4f1fEkLp966T1bSVeSK99W1Qeu2nVeK0taNfKzzQ=;
        b=I4Ef8XT/jnbi+tMmAHG5WICb8qdNlNkhEGeMnG7BX2cTmGzsbQWhpaDzogleFYvnOn
         FTiGI9G++d4xNJ5aq4XKaWU3JUrelm+iFniQ8rZjxWdhm5LST/Dd3EyHgJn2uobP4Ue2
         cqoNk5Bl+C2B+g8lToWMhw+4SDodFTvbBlxbhFM/GYYBuUmOiN7Yp+K8Yw9HuOr3A4v5
         /WELYfLIaJnThcKTxv2kHZJNZmzh5YNVpkYgbwDfL4XRL14z8OTA7FPqFqtkdnR3nkKF
         08Zdij3YbRiPw8FIqp68WCWtGpZg5wpjP3BkfJbsZVI7uXg91tmcxqATbDhF7IkX01N9
         v17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5wG4f1fEkLp966T1bSVeSK99W1Qeu2nVeK0taNfKzzQ=;
        b=Z8tAu7Kni5hkD+KjC/epVDl2lSJYnPnzN30F026nWQv+wT5VnHKDigFG51tc2CjCmf
         Nx6drknIBv9E56aTluiNJpQMf+vMZ3niM5uvjtmfaG6VbvwjX6VezJD4Zkb3/jQu2oTD
         meKIUgpJWlLl0OVGFC2/FEainUD4SamNT2vq8DqTUGe2IrELXIp3RZl/dJlEf5CHhUEW
         Jl5uXUfDfW0zwYJdTYLEb3au7CdG0ipJ09JhIulLBZBa+gbf03NXoHzeYe4JsyRQv2rO
         jEjmT4Imypw8WGYKnP+gSyKsaeHBSpR7+QqAH2EVxROeLugoF9cw3aWISYdMJdJxCrUr
         S7qA==
X-Gm-Message-State: APjAAAUEVxeRNSPk0qDe3cY0ujF0t2cbMOpEERPdeMur8Ozg8Gq3pGwQ
        cKP8GrES/Gcjs0nCxRB9u2as2Lb+pMFyfXbSf6ZMXxkTyp89d/N3W6DjFMRDNjdHjqDUIAd5cOa
        Qh4zaUnIGU6NUhCCwObjtExw2
X-Received: by 2002:a05:660c:711:: with SMTP id l17mr3140861itk.92.1553375066581;
        Sat, 23 Mar 2019 14:04:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxy0U8g+TJEXWruwMJ6yj9GVhNXSU4I56D1uDEFVkrDtIqQ32mirdf4BRi6O68CHL7dEMQkZA==
X-Received: by 2002:a05:660c:711:: with SMTP id l17mr3140846itk.92.1553375066381;
        Sat, 23 Mar 2019 14:04:26 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id c1sm3344399itd.23.2019.03.23.14.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:04:25 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pci: pcie-xilinx: fix a missing-check bug for __get_free_pages
Date:   Sat, 23 Mar 2019 16:04:23 -0500
Message-Id: <20190323210423.8881-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case __get_free_pages fail, the fix returns error upstream
to avoid NULL pointer dereference.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>

---
v1: Return error upstream as suggested by Steven
---
 drivers/pci/controller/pcie-xilinx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 9bd1a35cd5d8..91d8945bfb0c 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -335,15 +335,19 @@ static const struct irq_domain_ops msi_domain_ops = {
 /**
  * xilinx_pcie_enable_msi - Enable MSI support
  * @port: PCIe port information
+ * Return: 0 on success, negative error on failure
  */
-static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
+static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 {
 	phys_addr_t msg_addr;
 
 	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!port->msi_pages)
+		return -ENOMEM;
 	msg_addr = virt_to_phys((void *)port->msi_pages);
 	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
 	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+	return 0;
 }
 
 /* INTx Functions */
@@ -498,6 +502,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
+	int ret;
 
 	/* Setup INTx */
 	pcie_intc_node = of_get_next_child(node, NULL);
@@ -526,7 +531,9 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 			return -ENODEV;
 		}
 
-		xilinx_pcie_enable_msi(port);
+		ret = xilinx_pcie_enable_msi(port);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.17.1

