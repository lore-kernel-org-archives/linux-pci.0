Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbbBXUMq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Feb 2015 15:12:46 -0500
Subject: [PATCH 1/2] pci: Add reciprocal function for pci_ignore_hotplug()
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org, airlied@linux.ie,
	alexander.deucher@amd.com, dri-devel@lists.freedesktop.org
Cc: alex.williamson@redhat.com, linux-kernel@vger.kernel.org
Date: Tue, 24 Feb 2015 13:12:34 -0700
Message-ID: <20150224201233.14443.61523.stgit@gimli.home>
In-Reply-To: <20150224200603.14443.68971.stgit@gimli.home>
References: <20150224200603.14443.68971.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have pci_ignore_hotplug(), but there's no way to undo this
without manipulating the device itself.  It seems like the original
intention of the function is to provide the driver with a way to
ignore hotplug over a specific time window, ex. the time while the
device is powered off.  Once the device is powered on again, the
flag should be cleared to avoid leaving driver cruft on the device.
Add a trivial helper function to enable this.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/pci.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 211e9da..26f9779 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1044,6 +1044,11 @@ static inline void pci_ignore_hotplug(struct pci_dev *dev)
 	dev->ignore_hotplug = 1;
 }
 
+static inline void pci_unignore_hotplug(struct pci_dev *dev)
+{
+	dev->ignore_hotplug = 0;
+}
+
 static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
 				  bool enable)
 {

