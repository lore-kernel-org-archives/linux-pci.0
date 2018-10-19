Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB6C67863
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C8221480
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 02:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Ej2xgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C8221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbeJSKPr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbeJSKPr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 06:15:47 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.117.90.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89DB21477;
        Fri, 19 Oct 2018 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539915112;
        bh=l3v8vKI0V8kjFjpRwnfw1GSPx+uqJiQZWnJo40XoNas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5Ej2xgDA7+QBJJI6dNaz9fbdDEXUQU+KyoCmhxvSZgAhGgqBKO+b0eLAHpz/4XWJ
         ELpOJeai2H71wO8rHE2X7dD7+LTIegqT8vMJ2WQX9ze06YTC954LPArSvU5pqBEEZ6
         YWCKSYvyGjulh0qeUkiCfl+DXStXqO7Ho7tfqw2Y=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 7/7] IB/hfi1,PCI: switch to __pci_function_locked() for reset request
Date:   Fri, 19 Oct 2018 02:11:27 +0000
Message-Id: <20181019021132.14743-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181019021132.14743-1-okaya@kernel.org>
References: <20181019021132.14743-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Start using the new reset API rather than the workaround.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 2 +-
 include/linux/pci.h               | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 6c967dde58e7..38f96192e5f0 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -897,7 +897,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * to be implemented to have cleaner interface but this fixes the
 	 * current brokenness
 	 */
-	return pci_bridge_secondary_bus_reset(dev->bus->self);
+	return __pci_reset_function_locked(dev, PCI_RESET_LINK);
 }
 
 /*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8ee4e3c177fe..cfb1018d774e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1291,9 +1291,6 @@ void pci_bus_remove_resources(struct pci_bus *bus);
 int devm_request_pci_bus_resources(struct device *dev,
 				   struct list_head *resources);
 
-/* Temporary until new and working PCI SBR API in place */
-int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
-
 #define pci_bus_for_each_resource(bus, res, i)				\
 	for (i = 0;							\
 	    (res = pci_bus_resource_n(bus, i)) || i < PCI_BRIDGE_RESOURCE_NUM; \
-- 
2.19.0

