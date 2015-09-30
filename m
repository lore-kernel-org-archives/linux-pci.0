Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34711 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516AbbI3GfO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2015 02:35:14 -0400
Received: by padhy16 with SMTP id hy16so30591066pad.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 23:35:14 -0700 (PDT)
From: Simon Horman <simon.horman@netronome.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Simon Horman <simon.horman@netronome.com>
Subject: [PATCH repost 0/3] Support Netronome NFP6000 family quirks
Date: Wed, 30 Sep 2015 15:35:04 +0900
Message-Id: <1443594907-16196-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

this short patch-set adds support for Netronome NFP6000 family quirks.

Base:

This patchset is based on the next branch of Bjorn Helgaas's PCI tree.

About NFP6000 Drivers (someone is bound to ask):

My understanding is that Netronome is actively working on preparing to
submit NFP6000 family drivers to mainline.  For now they can be found on
github at https://github.com/Netronome/nfp-drv-kmods

Jason S. McMullan (3):
  PCI: Support PCIe devices with short cfg_size
  PCI: Add Netronome vendor and device IDs
  PCI: Support Netronome NFP6000 family quirks

 drivers/pci/pci-sysfs.c | 18 +++++++++---------
 drivers/pci/quirks.c    | 11 +++++++++++
 include/linux/pci_ids.h |  6 ++++++
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
2.1.4

