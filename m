Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9217AC433FE
	for <linux-pci@archiver.kernel.org>; Mon, 21 Nov 2022 14:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiKUOjN (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiKUOiL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:38:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793ED93723;
        Mon, 21 Nov 2022 06:38:10 -0800 (PST)
Message-ID: <20221121091327.489131583@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cFx6dbaS3ynUGuWTq2v8hXwBFa/HBDy+17s0E2mkPoM=;
        b=4ntO2jsOMBcMQVVu6K5tb8rs4a5ulGHGJrLiz8k2RdhV7w+ti8dr3UbSXzi+37XYCYbUwW
        TGQKFsaBnrUugaTl6OcHMkorcxIHSo66Tap2KxaECUG8QnwYwpyNrW/V+Y9LR41kR51ymT
        7gyEXjteFWTm4grkGwqIn/SKn6P3DQC7LIxfKwZTMCmDFTIFyokKIXNLq78hN4coNm3gUP
        uNzdo7dXYYscCXCvvLPyX0GRt6Ycq1OefhWSlpan9b+ahh6HqxMeuVQo5wIEx9QTnJq+HF
        AYZhqjlUNOmVDohcSwjeaf5BVFw9KtG6gbcuWTJSquCGvVCa/Z7cZPHkqO73aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=cFx6dbaS3ynUGuWTq2v8hXwBFa/HBDy+17s0E2mkPoM=;
        b=Zm9TCIE+T02R/nWzRR2Cqvo/6OUXrCvX38/MlPUZkdidEN5wxKJbfcb6lnoTR6irL4yDFe
        E2iEh7a/YBECFuBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 18/33] genirq/msi: Provide struct msi_map
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:08 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A simple struct to hold a MSI index / Linux interrupt number pair. It will
be returned from the dynamic vector allocation function and handed back to
the corresponding free() function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi_api.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -18,6 +18,19 @@ enum msi_domain_ids {
 	MSI_MAX_DEVICE_IRQDOMAINS,
 };
 
+/**
+ * msi_map - Mapping between MSI index and Linux interrupt number
+ * @index:	The MSI index, e.g. slot in the MSI-X table or
+ *		a software managed index if >= 0. If negative
+ *		the allocation function failed and it contains
+ *		the error code.
+ * @virq:	The associated Linux interrupt number
+ */
+struct msi_map {
+	int	index;
+	int	virq;
+};
+
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, unsigned int index);
 
 /**

