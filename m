Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbbC3K7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 30 Mar 2015 06:59:23 -0400
Date: Mon, 30 Mar 2015 12:59:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH v2 0/6] pci.h/pci_ids.h related cleanups
Message-ID: <1427712964-16155-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

A bunch of drivers pull in linux/pci.h or linux/pci_ids.h without actually
using any PCI APIs.

Clean this up, drop the includes.

These patches were split out from bigger pci_ids.h exporting patchset.

I think the pci tree is easiest to use for these changes.
Please review, and consider for 4.1.

Changes from v1:
	patches are unchanged
	drop amd patch - applied on driver specific tree
	added acks for brcm80211

Michael S. Tsirkin (6):
  crypto/ccp: drop linux/pci dependencies
  input/serio: drop pci_ids dependency
  media/fintek: drop pci_ids dependency
  brcm80211: drop pci dependency
  brcm80211: drop pci_ids include
  staging/olpc: drop pci dependencies

 drivers/crypto/ccp/ccp-ops.c                     | 2 --
 drivers/input/serio/gscps2.c                     | 1 -
 drivers/media/rc/fintek-cir.c                    | 1 -
 drivers/net/wireless/brcm80211/brcmfmac/bcmsdh.c | 2 --
 drivers/net/wireless/brcm80211/brcmfmac/sdio.c   | 1 -
 drivers/staging/olpc_dcon/olpc_dcon.c            | 2 --
 6 files changed, 9 deletions(-)

-- 
MST

