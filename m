Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:38288 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbeHMTed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Aug 2018 15:34:33 -0400
From: Thomas Tai <thomas.tai@oracle.com>
To: bhelgaas@google.com, keith.busch@intel.com, poza@codeaurora.org,
        thomas.tai@oracle.com
Cc: linux-pci@vger.kernel.org
Subject: [PATCH 0/1] PCI/AER: prevent pcie_do_fatal_recovery from using device after it is removed
Date: Mon, 13 Aug 2018 10:51:27 -0600
Message-Id: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Keith and Oza,

I want to submit a patch to fix the
commit bd91b56cb3b27492963caeb5fccefe20a986ca8d
PCI/AER: Work around use-after-free in pcie_do_fatal_recovery()

Would you kindly have a look to see if it make sense to you
or not?

Thank you very much,
Thomas
