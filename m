Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57736 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099AbbCRUNO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 18 Mar 2015 16:13:14 -0400
Subject: [PATCH v2 1/6] vgaarb: Stub vga_set_legacy_decoding()
From: Alex Williamson <alex.williamson@redhat.com>
To: alex.williamson@redhat.com, kvm@vger.kernel.org
Cc: linux-pci@vger.kernel.org, bsd@redhat.com,
	linux-kernel@vger.kernel.org
Date: Wed, 18 Mar 2015 14:13:12 -0600
Message-ID: <20150318201312.24807.70196.stgit@gimli.home>
In-Reply-To: <20150318200053.24807.74115.stgit@gimli.home>
References: <20150318200053.24807.74115.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

vga_set_legacy_decoding() is defined in drivers/gpu/vga/vgaarb.c,
which is only compiled with CONFIG_VGA_ARB.  A caller would
therefore get an undefined symbol if the VGA arbiter is not
enabled.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Dave Airlie <airlied@redhat.com>
---
 include/linux/vgaarb.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
index c37bd4d..8c3b412 100644
--- a/include/linux/vgaarb.h
+++ b/include/linux/vgaarb.h
@@ -65,8 +65,13 @@ struct pci_dev;
  *     out of the arbitration process (and can be safe to take
  *     interrupts at any time.
  */
+#if defined(CONFIG_VGA_ARB)
 extern void vga_set_legacy_decoding(struct pci_dev *pdev,
 				    unsigned int decodes);
+#else
+static inline void vga_set_legacy_decoding(struct pci_dev *pdev,
+					   unsigned int decodes) { };
+#endif
 
 /**
  *     vga_get         - acquire & locks VGA resources

