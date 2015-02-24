Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbbBXUMn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 24 Feb 2015 15:12:43 -0500
Subject: [PATCH 0/2] PCI: pci_unignore_hotplug()
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org, airlied@linux.ie,
	alexander.deucher@amd.com, dri-devel@lists.freedesktop.org
Cc: alex.williamson@redhat.com, linux-kernel@vger.kernel.org
Date: Tue, 24 Feb 2015 13:12:27 -0700
Message-ID: <20150224200603.14443.68971.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'd kinda like to use pci_ignore_hotplug() for devices in use by a
user via vfio-pci, but the interface seems only partially implemented
since we can only set ignore_hotplug and not clear it.  This adds the
capability to clear the flag and applies it as seems to be appropriate
to the existing users.  I don't have a system with power control for
a radeon or nouveau device, so I'd certainly appreciate testing.  It
seems though that once the device is in D0, we've passed the critical
point where the device could be accidentally unplugged.  Thanks,

Alex

---

Alex Williamson (2):
      pci: Add reciprocal function for pci_ignore_hotplug()
      nouveau/radeon: Un-ignore hotplug on resume


 drivers/gpu/drm/nouveau/nouveau_drm.c |    1 +
 drivers/gpu/drm/radeon/radeon_drv.c   |    1 +
 include/linux/pci.h                   |    5 +++++
 3 files changed, 7 insertions(+)
