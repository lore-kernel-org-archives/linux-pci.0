Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:57256 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeGSUrU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jul 2018 16:47:20 -0400
From: Thomas Tai <thomas.tai@oracle.com>
To: thomas.tai@oracle.com, bhelgaas@google.com, keith.busch@intel.com
Cc: linux-pci@vger.kernel.org, poza@codeaurora.org
Subject: [PATCH V3, 0/1] PCI/AER: fix use-after-free in pcie_do_fatal_recovery
Date: Thu, 19 Jul 2018 14:02:34 -0600
Message-Id: <1532030555-7177-1-git-send-email-thomas.tai@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
I reworked the patch as suggested, would you please kindly
review the patch? By the way, the use-after-free issue would not
impact DPC, according to PCI Express Base Specification
Revision 4.0 Version 0.3 The DPC "capability may be
implemented by a Root Port or a Switch Downstream Port.
It is not applicable to any other Device/Port type."
The use-after-free only happens on a non-bridge device, so
it won't impact root/switch port.

Thank you very much.
Thomas
