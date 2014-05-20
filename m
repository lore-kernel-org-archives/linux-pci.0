Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41820 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaETDps (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 23:45:48 -0400
Received: by mail-ie0-f177.google.com with SMTP id y20so3391776ier.8
        for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 20:45:47 -0700 (PDT)
Subject: [PATCH v10 0/4] PCI: Restrict 64-bit prefetchable bridge windows to
 64-bit resources
To: Yinghai Lu <yinghai@kernel.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: talal@mellanox.com, Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Date: Mon, 19 May 2014 21:45:45 -0600
Message-ID: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <1397752819-17326-1-git-send-email-yinghai@kernel.org>
References: <1397752819-17326-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'd like to merge these for v3.16.  The first is Yinghai's v9 patch
unchanged except to resolve minor merge conflicts, write a changelog, and
fold in the mem64_mask removal posted previously as [1].

The rest are cleanups and comment changes to try to make the code more
readable.

This does fix a real bug -- in some cases we can't assign space to large
64-bit BARs even though there is plenty of 64-bit space available.  But I
am concerned that we are giving up performance in some cases (32-bit
prefetchable resources below a bridge with a 64-bit prefetchable window
will no longer be prefetchable).  With some additional work, it should be
possible to get that performance back.

Comments welcome.

[1] http://lkml.kernel.org/r/CAE9FiQUKYMPvXLsk84o-gH-j0-wiJGL0Wt1aTW2o4FPSm0PvbQ@mail.gmail.com

---

Bjorn Helgaas (3):
      PCI: Change pbus_size_mem() return values to be more conventional
      PCI: Simplify __pci_assign_resource() coding style
      PCI: Add resource allocation comments

Yinghai Lu (1):
      PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources


 drivers/pci/setup-bus.c |  207 +++++++++++++++++++++++++++++++++--------------
 drivers/pci/setup-res.c |   41 +++++++--
 2 files changed, 176 insertions(+), 72 deletions(-)
