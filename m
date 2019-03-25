Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A982CC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7889A2082F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ri/IWHh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfCYWTV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:19:21 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:42462 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCYWTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 18:19:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id BAD1E172
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 22:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hU_Ro4fxLO9Y for <linux-pci@vger.kernel.org>;
        Mon, 25 Mar 2019 17:19:15 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 8E9F81E6
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 17:19:15 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id l140so2353382ita.4
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2019 15:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wMN6xXX31A6AdzQAJGc2vG9ofT3CoZG7Cbz+jNnp6f8=;
        b=Ri/IWHh+UZOTC7ZjY4+AHxTHHeE03LtftP/f73T6u1Ndc5c/G84oyC5h/XcypurBr/
         m3txydiTyFZKrl9mX6le7RxJygALM1cd+VCRmv553UxKXOPiLu8qlHsLW6VQ/2GnfwF2
         KrkNM+srVDJNlpryuymtMSzPYP3kgwtrXzmHqu+RxPVPspOm7GeAEu+Skr9X5YXgKZLU
         DJta+7ZXNvdYf8U5t4Oiqvrw8GBrbsWn5ZWkM8THTE7wJvHxzX/TSidF6fYMEWa+5fR6
         3zU+Kjn1+zbCNW3i7102e1rCdCkh0VJ4XapJQ7aqKBYlZPptSpcitFAsgaXnscRksF0Q
         Sezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wMN6xXX31A6AdzQAJGc2vG9ofT3CoZG7Cbz+jNnp6f8=;
        b=inQFMBXVqbs9+40Ew6NDWTu/TF2AVpbdMWMX5pzyussIbGfqycpA6UFdiwr3GteZ3I
         AZ0ot+m87prP9s8aJaGt7zlOyOzaBu6ViK8R766YKT9SZW8a2EiuP8qiPCsrwvEw2RGU
         ahqE2W9dK/cQoYMFa6oiJ5mpmQHLZ/z92Rc//yW7q43E9irimMurAtSzHfmkDKiTvNTK
         mQ7SICa1lesU4fKGCZ1+Nw+ZycX2mCY9xTwdVvkVWftcZWYa4IjPmeUf2nhNd8c0R6r4
         Aw/0vgdyMKPDfcRVjvw2P8DvLAUiVTiJ/wJ5JTvUI8sB4CUrSnFSAUUYBvgoYTDhscLC
         gM4A==
X-Gm-Message-State: APjAAAUTW0u3ceWiV1s7IjuksaRWlO6WIlC6uRaNecK5VXsdlLoqMJ9m
        NAv3/jLxKu10m/x2HX50aMm/ahFzuEGqRwoI3oI9Fs/ggWk+oiLUl+7hrpk087YcIE7z9Nz9CNN
        uskXOmacg57HWvp/ABMJy17eH
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr16967275ioc.142.1553552355184;
        Mon, 25 Mar 2019 15:19:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyJpikc1k86UuAZEIpBOenvhqms6j6+SUAXP6kJ8lTR9Ao9sezT7dyXG/DCDzkMGqenPZaMnw==
X-Received: by 2002:a6b:e50d:: with SMTP id y13mr16967256ioc.142.1553552354910;
        Mon, 25 Mar 2019 15:19:14 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id k4sm10043741itc.32.2019.03.25.15.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 15:19:14 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: xilinx: Check for __get_free_pages() failure
Date:   Mon, 25 Mar 2019 17:19:09 -0500
Message-Id: <20190325221909.26315-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190325215105.GB24180@google.com>
References: <20190325215105.GB24180@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If __get_free_pages() fails, the patch returns -ENOMEM to avoid
NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
v3: remove "unlikely", as suggested by Bjorn Helgaas.
v2: caller is redefined to accept the error code, as suggested by
Steven Price <steven.price@arm.com>
---
 drivers/pci/controller/pcie-xilinx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 9bd1a35cd5d8..abc214e94f7c 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -336,14 +336,19 @@ static const struct irq_domain_ops msi_domain_ops = {
  * xilinx_pcie_enable_msi - Enable MSI support
  * @port: PCIe port information
  */
-static void xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
+static int xilinx_pcie_enable_msi(struct xilinx_pcie_port *port)
 {
 	phys_addr_t msg_addr;
 
 	port->msi_pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!port->msi_pages)
+		return -ENOMEM;
+
 	msg_addr = virt_to_phys((void *)port->msi_pages);
 	pcie_write(port, 0x0, XILINX_PCIE_REG_MSIBASE1);
 	pcie_write(port, msg_addr, XILINX_PCIE_REG_MSIBASE2);
+
+	return 0;
 }
 
 /* INTx Functions */
@@ -498,6 +503,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
+	int ret;
 
 	/* Setup INTx */
 	pcie_intc_node = of_get_next_child(node, NULL);
@@ -526,7 +532,9 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
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

