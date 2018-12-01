Return-Path: <SRS0=IfUz=OK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32062C04EB9
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 17:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B1F2081C
	for <linux-pci@archiver.kernel.org>; Sat,  1 Dec 2018 17:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUMNPSnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B1F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeLBEot (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:44:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLBEot (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 1 Dec 2018 23:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lh0EZ0c2CU5068qPf2AbEQHB4VOR+VcLe9am/jFMM3w=; b=XUMNPSnNProh9yjZZB+FS2t6YT
        3Dn6CpRQS7SFx9PMpjlLVY6CBM/TQB43THK7Ls0BuYiPGS3t5WhTJ/zInaOjNkZtpEJkIRoxmRydl
        otsZoHG1kNZULpT5q0CdqI4cYGhuaGjXqGWkaP1zD4TzD2XoD4b4acQBN7Z9+EhQ7s26ZosHN6Ntz
        AUTNWVrdaaOSfL+ZPdhd1no02aZ5/vjESfuhQ6o3PKvIVzlJm3Wej4mTOU2kp9vRXDZ5+zwED3VMG
        pPiWszrj5JiCbgeftzTzhU5C5OJJo9lDB5AR5edQ/raSndFQtuqs9rhmJ5FYKZ2NtcUYiTPAEo7pe
        5grwtkAA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gT97B-0003dK-Vf; Sat, 01 Dec 2018 17:31:39 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Logan Gunthorpe <logang@deltatee.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] pci: p2pdma: clean up documentation and kernel-doc
Message-ID: <9f17c653-07dd-bf00-a4a2-fccbd9470603@infradead.org>
Date:   Sat, 1 Dec 2018 09:31:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos, spellos, and grammar in p2pdma.rst and p2pdma.c.

Fix return value(s) in function pci_p2pmem_alloc_sgl().

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/driver-api/pci/p2pdma.rst |    4 ++--
 drivers/pci/p2pdma.c                    |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- lnx-420-rc4.orig/Documentation/driver-api/pci/p2pdma.rst
+++ lnx-420-rc4/Documentation/driver-api/pci/p2pdma.rst
@@ -49,7 +49,7 @@ For example, in the NVMe Target Copy Off
   in that it exposes any CMB (Controller Memory Buffer) as a P2P memory
   resource (provider), it accepts P2P memory pages as buffers in requests
   to be used directly (client) and it can also make use of the CMB as
-  submission queue entries (orchastrator).
+  submission queue entries (orchestrator).
 * The RDMA driver is a client in this arrangement so that an RNIC
   can DMA directly to the memory exposed by the NVMe device.
 * The NVMe Target driver (nvmet) can orchestrate the data from the RNIC
@@ -111,7 +111,7 @@ that's compatible with all clients using
 If more than one provider is supported, the one nearest to all the clients will
 be chosen first. If more than one provider is an equal distance away, the
 one returned will be chosen at random (it is not an arbitrary but
-truely random). This function returns the PCI device to use for the provider
+truly random). This function returns the PCI device to use for the provider
 with a reference taken and therefore when it's no longer needed it should be
 returned with pci_dev_put().
 
--- lnx-420-rc4.orig/drivers/pci/p2pdma.c
+++ lnx-420-rc4/drivers/pci/p2pdma.c
@@ -422,7 +422,7 @@ static int upstream_bridge_distance_warn
  *
  * Returns -1 if any of the clients are not compatible (behind the same
  * root port as the provider), otherwise returns a positive number where
- * a lower number is the preferrable choice. (If there's one client
+ * a lower number is the preferable choice. (If there's one client
  * that's the same as the provider it will return 0, which is best choice).
  *
  * For now, "compatible" means the provider and the clients are all behind
@@ -493,7 +493,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
  * @num_clients: number of client devices in the list
  *
  * If multiple devices are behind the same switch, the one "closest" to the
- * client devices in use will be chosen first. (So if one of the providers are
+ * client devices in use will be chosen first. (So if one of the providers is
  * the same as one of the clients, that provider will be used ahead of any
  * other providers that are unrelated). If multiple providers are an equal
  * distance away, one will be chosen at random.
@@ -580,7 +580,7 @@ EXPORT_SYMBOL_GPL(pci_alloc_p2pmem);
  * pci_free_p2pmem - free peer-to-peer DMA memory
  * @pdev: the device the memory was allocated from
  * @addr: address of the memory that was allocated
- * @size: number of bytes that was allocated
+ * @size: number of bytes that were allocated
  */
 void pci_free_p2pmem(struct pci_dev *pdev, void *addr, size_t size)
 {
@@ -617,7 +617,7 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_virt_to_bus
  * @nents: the number of SG entries in the list
  * @length: number of bytes to allocate
  *
- * Returns 0 on success
+ * Return: %NULL on error or &struct scatterlist pointer and @nents on success
  */
 struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length)
@@ -673,7 +673,7 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_free_sgl);
  *
  * Published memory can be used by other PCI device drivers for
  * peer-2-peer DMA operations. Non-published memory is reserved for
- * exlusive use of the device driver that registers the peer-to-peer
+ * exclusive use of the device driver that registers the peer-to-peer
  * memory.
  */
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
@@ -733,7 +733,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg);
  * @use_p2pdma: returns whether to enable p2pdma or not
  *
  * Parses an attribute value to decide whether to enable p2pdma.
- * The value can select a PCI device (using it's full BDF device
+ * The value can select a PCI device (using its full BDF device
  * name) or a boolean (in any format strtobool() accepts). A false
  * value disables p2pdma, a true value expects the caller
  * to automatically find a compatible device and specifying a PCI device
@@ -784,7 +784,7 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_enable_stor
  *		whether p2pdma is enabled
  * @page: contents of the stored value
  * @p2p_dev: the selected p2p device (NULL if no device is selected)
- * @use_p2pdma: whether p2pdme has been enabled
+ * @use_p2pdma: whether p2pdma has been enabled
  *
  * Attributes that use pci_p2pdma_enable_store() should use this function
  * to show the value of the attribute.


