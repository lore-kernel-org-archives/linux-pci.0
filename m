Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35530 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607AbaHYV1I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Aug 2014 17:27:08 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so13561427wgh.33
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2014 14:27:07 -0700 (PDT)
From: Mathias Krause <minipli@googlemail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 0/5] x86/PCI: Minor size reduction by marking init code and data as such
Date: Mon, 25 Aug 2014 23:26:34 +0200
Message-Id: <1409001999-23161-1-git-send-email-minipli@googlemail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

this series is a collection of patches trying to mark initialization
code and data of the x86 specific PCI code as such. It also contains
__init annotation cleanups to move them to the spot they belong to
according to include/linux/init.h.

The annotation leads to a nice reduction of run-time memory size. At
least two additional pages can be released after initialization which
are otherwise occupied by code and data no longer needed.

Please apply!

Thanks,

Mathias Krause (5):
  x86/PCI: Mark DMI tables as initialization data
  x86/PCI: Move __init annotation were it belongs to
  x86/PCI: Mark constants of pci_mmcfg_nvidia_mcp55() as __initconst
  x86/PCI: Constify pci_mmcfg_probes[] array
  x86/PCI: Mark PCI BIOS initialization code as such

 arch/x86/pci/common.c          |   20 ++++++++--------
 arch/x86/pci/mmconfig-shared.c |   40 ++++++++++++++++++--------------
 arch/x86/pci/pcbios.c          |    8 +++----
 3 files changed, 36 insertions(+), 32 deletions(-)

-- 
1.7.10.4

