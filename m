Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38820 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576AbbIWTMM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 Sep 2015 15:12:12 -0400
Subject: [PATCH v2 0/2] PCI: Fix pci_claim_bridge_resource() resource
 claiming
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <helgaas@kernel.org>
Cc: kordikmarek@gmail.com,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	airlied@linux.ie, zermond@gmail.com, gob_iron@hotmail.com,
	weiyang.kernel@gmail.com, alexander.deucher@amd.com,
	niaminbox@gmail.com, Yinghai Lu <yinghai@kernel.org>
Date: Wed, 23 Sep 2015 14:12:09 -0500
Message-ID: <20150923191159.21781.66169.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Here's what I intend to apply for this problem.

The first is the fix we've already discussed, and I put this in for-linus
for v4.3 because it should fix the "radeon 0000:01:00.0: Fatal error during
GPU init" problem reported by niam at
https://bugzilla.kernel.org/show_bug.cgi?id=85491#c47 .  That bugzilla was
originally opened for a different problem, since resolved, but c770cb4cb505
("PCI: Mark invalid BARs as unassigned") reintroduced basically the same
problem.

The second patch is just cosmetic to clarify some messages.  I plan to
merge this one for v4.4.

---

Bjorn Helgaas (2):
      PCI: Clear IORESOURCE_UNSET when clipping a bridge window
      PCI: Clear IORESOURCE_UNSET when reverting to firmware-assigned address


 drivers/pci/bus.c       |    2 ++
 drivers/pci/setup-res.c |    2 ++
 2 files changed, 4 insertions(+)
