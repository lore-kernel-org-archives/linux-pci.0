Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7D0C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADC62086E
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 16:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="OrcxbrbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADC62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJXXU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:23:20 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:4343 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Oct 2018 19:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1539187231; x=1570723231;
  h=from:to:cc:subject:date:message-id;
  bh=rKcg/6GA1JlI43fVAWb3EdsFB4aeliKssxEfYAeyWBM=;
  b=OrcxbrbMyP8pU//poRcNeJzSMDemEimqlDSbXTQMfZ9W0uTlXf3/3Fxl
   V9nN+3mikaO09weJFL/NyKqkYJzENB/Uav03MkPfN7WSzX3eK2Wal01lc
   QYm50u/neKj3OdmwL32bkwpoxpUjp+mi9bhSZ0wF6tzt1iuQr2ZDXoW4D
   w=;
X-IronPort-AV: E=Sophos;i="5.54,364,1534809600"; 
   d="scan'208";a="763197798"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Oct 2018 16:00:29 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (iad7-ws-svc-lb50-vlan2.amazon.com [10.0.93.210])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9AG0JdQ073286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Oct 2018 16:00:23 GMT
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id w9AG0IZL022784;
        Wed, 10 Oct 2018 18:00:18 +0200
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id w9AG0IUR022782;
        Wed, 10 Oct 2018 18:00:18 +0200
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2] PCI/IOV: Use VF0 cached config space size for other VFs
Date:   Wed, 10 Oct 2018 18:00:10 +0200
Message-Id: <1539187210-22515-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cache the config space size from VF0 and use it for all other VFs instead
of reading it from the config space of each VF. We assume that it will be
the same across all associated VFs.

This is an optimization when enabling SR-IOV on a device with many VFs.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

---
v1 -> v2:
- Drop the __pci_cfg_space_size (bhelgaas@)
- Extend pci_cfg_space_size to return the cached value for all VFs except
  VF0 (bhelgaas@)
---
 drivers/pci/iov.c   |  2 ++
 drivers/pci/pci.h   |  1 +
 drivers/pci/probe.c | 17 +++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index c5f3cd4e..4238b53 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -133,6 +133,8 @@ static void pci_read_vf_config_common(struct pci_dev *virtfn)
 			     &physfn->sriov->subsystem_vendor);
 	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
 			     &physfn->sriov->subsystem_device);
+
+	physfn->sriov->cfg_size = pci_cfg_space_size(virtfn);
 }
 
 int pci_iov_add_virtfn(struct pci_dev *dev, int id)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e0d152..2f14542 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -285,6 +285,7 @@ struct pci_sriov {
 	u16		driver_max_VFs;	/* Max num VFs driver supports */
 	struct pci_dev	*dev;		/* Lowest numbered PF */
 	struct pci_dev	*self;		/* This PF */
+	u32		cfg_size;	/* VF config space size */
 	u32		class;		/* VF device */
 	u8		hdr_type;	/* VF header type */
 	u16		subsystem_vendor; /* VF subsystem vendor */
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 201f9e5..8c0f428 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1438,12 +1438,29 @@ static int pci_cfg_space_size_ext(struct pci_dev *dev)
 	return PCI_CFG_SPACE_EXP_SIZE;
 }
 
+#ifdef CONFIG_PCI_ATS
+static bool is_vf0(struct pci_dev *dev)
+{
+	if (pci_iov_virtfn_devfn(dev->physfn, 0) == dev->devfn &&
+	    pci_iov_virtfn_bus(dev->physfn, 0) == dev->bus->number)
+		return true;
+
+	return false;
+}
+#endif
+
 int pci_cfg_space_size(struct pci_dev *dev)
 {
 	int pos;
 	u32 status;
 	u16 class;
 
+#ifdef CONFIG_PCI_ATS
+	/* Read cached value for all VFs except for VF0 */
+	if (dev->is_virtfn && !is_vf0(dev))
+		return dev->physfn->sriov->cfg_size;
+#endif
+
 	if (dev->bus->bus_flags & PCI_BUS_FLAGS_NO_EXTCFG)
 		return PCI_CFG_SPACE_SIZE;
 
-- 
2.7.4

