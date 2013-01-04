Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:43915 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3ADTK2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jan 2013 14:10:28 -0500
Received: by mail-vb0-f74.google.com with SMTP id s24so1785825vbi.5
        for <linux-pci@vger.kernel.org>; Fri, 04 Jan 2013 11:10:28 -0800 (PST)
Subject: [PATCH 0/3] drm_pcie_get_speed_cap_mask() cleanups
To: David Airlie <airlied@linux.ie>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Betty Dall <betty.dall@hp.com>,
	Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Fri, 04 Jan 2013 12:10:26 -0700
Message-ID: <20130104190833.4586.16520.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

These are minor cleanups for drm_pcie_get_speed_cap_mask() to use
standard #defines and PCIe capability accessors.  They depend on
a pci_regs.h change (130f1b8f35) that appeared in v3.8-rc2.

They don't address the issue of DRM devices directly below a host
bridge that doesn't appear as a PCI device (the issue Lucas has
been working on).

I'm a little skeptical about the premise of drm_pcie_get_speed_cap_mask()
to begin with.  Link speed seems like something fairly generic that should
be handled in the core, not in individual drivers.  Sec 6.11, "Link Speed
Management", in the PCIe 3.0 spec seems relevant and suggests that the
hardware should automatically use the highest speed supported by both ends
of the link unless software sets a lower maximum via Target Link Speed.

But I can't match up the code, e.g., evergreen_pcie_gen2_enable(), to
anything in the generic PCIe specs, so maybe this driver code is
essentially quirks for misbehaving hardware?

---

Bjorn Helgaas (3):
      drm/pci: Use the standard #defines for PCIe Link Capability bits
      drm/pci: Set all supported speeds in speed cap mask for pre-3.0 devices
      drm/pci: Use PCI Express Capability accessors


 drivers/gpu/drm/drm_pci.c |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)
