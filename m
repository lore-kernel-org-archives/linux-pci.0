Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46229C46462
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E5F20865
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 04:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="anzz0xEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E5F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeJKMPy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbeJKMPy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 08:15:54 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.4.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278D72087D;
        Thu, 11 Oct 2018 04:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539233426;
        bh=nKyK3MiTrb88AkY8yeTu3MRQLBpj4IMYoZE4VxsHNmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anzz0xEarrgP6cWDvOHK5o4IgZFIWX1tYp2zuQNPXT/Wt/u1eMnw8QSiuQTCVuWOD
         VB1TJ9idAE5A7Mcz0EZ4UAfkrNMwrTuOpp9L4fWAJujLX9iS7+n0D94tURJdVpgkt1
         n4D3nWbMg99zBX7Y7CIPDvTAaw6PsACFDSdmz7ko=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 07/11] IB/hfi1,PCI: switch to __pci_function_locked() for reset request
Date:   Thu, 11 Oct 2018 04:49:59 +0000
Message-Id: <20181011045008.32212-7-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181011045008.32212-1-okaya@kernel.org>
References: <20181011045008.32212-1-okaya@kernel.org>
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
index cf1e847ea02e..d4acdc400ef2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1289,9 +1289,6 @@ void pci_bus_remove_resources(struct pci_bus *bus);
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

