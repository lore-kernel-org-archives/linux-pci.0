Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:58368 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbaCSR0m (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Mar 2014 13:26:42 -0400
Received: by mail-pb0-f42.google.com with SMTP id rr13so9220728pbb.15
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2014 10:26:41 -0700 (PDT)
Date: Wed, 19 Mar 2014 11:26:37 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jouni =?iso-8859-1?Q?Mett=E4l=E4?= <jtmettala@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Yinghai Lu <yinghai@kernel.org>,
	Guo Chao <yan@linux.vnet.ibm.com>,
	David Airlie <airlied@linux.ie>,
	Aaron Durbin <adurbin@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, dri-devel@lists.freedesktop.org
Subject: [GIT PULL] PCI updates for v3.14
Message-ID: <20140319172637.GA1355@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

This is a fix for an AGP regression exposed by e501b3d87f00 ("agp: Support
64-bit APBASE"), which we merged in v3.14-rc1.  We've warned about the
conflict between the GART and PCI resources and cleared out the PCI
resource for a long time, but after e501b3d87f00, we still *use* that
cleared-out PCI resource.  I think the GART resource is incorrect, so this
patch removes it.


The following changes since commit ac93ac7403493f8707b7734de9f40d5cb5db9045:

  PCI: Don't check resource_size() in pci_bus_alloc_resource() (2014-03-12 11:19:20 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v3.14-fixes-3

for you to fetch changes up to 707d4eefbdb31f8e588277157056b0ce637d6c68:

  Revert "[PATCH] Insert GART region into resource map" (2014-03-18 14:26:12 -0600)

----------------------------------------------------------------
PCI updates for v3.14:

  Resource management
    - Revert "Insert GART region into resource map"

----------------------------------------------------------------
Bjorn Helgaas (1):
      Revert "[PATCH] Insert GART region into resource map"

 arch/x86/kernel/aperture_64.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)
