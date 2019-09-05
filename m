Return-Path: <SRS0=lgne=XA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70CCC3A5AA
	for <linux-pci@archiver.kernel.org>; Thu,  5 Sep 2019 04:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95542208E4
	for <linux-pci@archiver.kernel.org>; Thu,  5 Sep 2019 04:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anastas.io header.i=@anastas.io header.b="CuoyYyQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfIEEcR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Sep 2019 00:32:17 -0400
Received: from alpha.anastas.io ([104.248.188.109]:47881 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfIEEcR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 00:32:17 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 917C57FD2C;
        Wed,  4 Sep 2019 23:22:37 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1567657358; bh=U9Hy1r4wWybxrfqHJoXQcodngTj6V3GZKa4Pdw7Ow9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CuoyYyQ/p51CZjJ3Ii5+QqxX4NYUdEW0g3JdQgjzdrXYEB/cUrDDfErPx+RGI7H7l
         qj2gaXkjw2az0WlGb4010Lp+0TNgZXGAeash2vzAoPl0EroKpFr/Mufa+v9x6mi56Q
         F04N2em4ZETL7P8EyslZ04uX+MsjTw5bozpBn9zctG/HiMPhrgkDw2jQdzMRttIbwr
         xTpFgaSisa6oBMO1U9r6pcSB6v579TjHZez+uMnXfj/K1JLgFrSnMAPvu+RIzE+tMQ
         8A1W4W07HkcRbtJ7yrDDtmlNa8Tj7w0XnFVrygela1x8Vz3d2T0oiJUIudy1r5uz/8
         RVFUIxCTxvb4w==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
        benh@kernel.crashing.org, sbobroff@linux.ibm.com, oohall@gmail.com
Subject: [PATCH 1/2] PCI: Introduce pcibios_fixup_dev()
Date:   Wed,  4 Sep 2019 23:22:14 -0500
Message-Id: <20190905042215.3974-2-shawn@anastas.io>
In-Reply-To: <20190905042215.3974-1-shawn@anastas.io>
References: <20190905042215.3974-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Introduce pcibios_fixup_dev to allow platform-specific code to perform
final setup of a PCI device after it has been registered in sysfs.

The default implementation is a no-op.

Signed-off-by: Shawn Anastasio <shawn@anastas.io>
---
 drivers/pci/probe.c | 14 ++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a3c7338fad86..14eb7ee38794 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2652,6 +2652,17 @@ static void pci_set_msi_domain(struct pci_dev *dev)
 	dev_set_msi_domain(&dev->dev, d);
 }
 
+/**
+ * pcibios_fixup_dev - Platform-specific device setup
+ * @dev: Device to set up
+ *
+ * Default empty implementation. Replace with an architecture-specific
+ * setup routine, if necessary.
+ */
+void __weak pcibios_fixup_dev(struct pci_dev *dev)
+{
+}
+
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 {
 	int ret;
@@ -2699,6 +2710,9 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 	dev->match_driver = false;
 	ret = device_add(&dev->dev);
 	WARN_ON(ret < 0);
+
+	/* Allow platform-specific code to perform final setup of device */
+	pcibios_fixup_dev(dev);
 }
 
 struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82e4cd1b7ac3..83eb0e241137 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -960,6 +960,7 @@ void pcibios_bus_add_device(struct pci_dev *pdev);
 void pcibios_add_bus(struct pci_bus *bus);
 void pcibios_remove_bus(struct pci_bus *bus);
 void pcibios_fixup_bus(struct pci_bus *);
+void pcibios_fixup_dev(struct pci_dev *);
 int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 /* Architecture-specific versions may override this (weak) */
 char *pcibios_setup(char *str);
-- 
2.20.1

