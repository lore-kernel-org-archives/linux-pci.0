Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:33706 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbeGLRoW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jul 2018 13:44:22 -0400
From: Thomas Tai <thomas.tai@oracle.com>
To: thomas.tai@oracle.com, bhelgaas@google.com, poza@codeaurora.org
Cc: linux-pci@vger.kernel.org
Subject: [PATCH V2, 0/1] PCI/AER: fix use-after-free in pcie_do_fatal_recovery
Date: Thu, 12 Jul 2018 11:33:42 -0600
Message-Id: <1531416823-17841-1-git-send-email-thomas.tai@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
Thank you very much to review the V1 patch. I reworked the patch as you have suggested. Your suggestion is indeed better and cleaner. Would you please have a look for me?

FYI, I did not clear the device structure in aer_isr_one_error() just to avoid over complicated the fix.

Also, thank you very much to read thru the caller of pcie_do_fatal_recovery() to ensure no one is using the device structure. Really appricated your extra effort.

Thank you,
Thomas
