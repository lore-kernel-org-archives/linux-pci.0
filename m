Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:16823 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbbIKAJM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 20:09:12 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 08/12] drivers:pci:msi: Store PCI domain (segment) as part of IRQ domain
Date: Fri, 11 Sep 2015 00:01:07 +0000
Message-Id: <1441929670-10058-9-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

In order to allow an MSI IRQ domain to be specific to a PCI domain, add a field
to the struct that tracks the PCI domain.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/msi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index ad939d0..7370225 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -227,6 +227,7 @@ struct msi_domain_ops {
  * @handler_data:	Optional: associated interrupt flow handler data
  * @handler_name:	Optional: associated interrupt flow handler name
  * @data:		Optional: domain specific data
+ * @pci_domain:		Associated PCI domain (segment)
  */
 struct msi_domain_info {
 	u32			flags;
@@ -237,6 +238,7 @@ struct msi_domain_info {
 	void			*handler_data;
 	const char		*handler_name;
 	void			*data;
+	int			pci_domain;
 };
 
 /* Flags for msi_domain_info */
-- 
1.9.1

