Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:40418 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbaEUDbT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 May 2014 23:31:19 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Wed, 21 May 2014 09:01:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id C4750E004B
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 09:01:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4L3VceK53936198
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 09:01:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4L3VCsL011260
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 09:01:13 +0530
Date: Wed, 21 May 2014 11:31:11 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, talal@mellanox.com,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	amirv@mellanox.com, eugenia@mellanox.com,
	Guo Chao <yan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>
Subject: Re: [PATCH v10 0/4] PCI: Restrict 64-bit prefetchable bridge windows
 to 64-bit resources
Message-ID: <20140521033111.GA8419@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1397752819-17326-1-git-send-email-yinghai@kernel.org>
 <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140520033233.11972.49094.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

I tried to apply it on the lastest upstrea, but seems not work.

Which tree should I apply to? This one ?
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

On Mon, May 19, 2014 at 09:45:45PM -0600, Bjorn Helgaas wrote:
>I'd like to merge these for v3.16.  The first is Yinghai's v9 patch
>unchanged except to resolve minor merge conflicts, write a changelog, and
>fold in the mem64_mask removal posted previously as [1].
>
>The rest are cleanups and comment changes to try to make the code more
>readable.
>
>This does fix a real bug -- in some cases we can't assign space to large
>64-bit BARs even though there is plenty of 64-bit space available.  But I
>am concerned that we are giving up performance in some cases (32-bit
>prefetchable resources below a bridge with a 64-bit prefetchable window
>will no longer be prefetchable).  With some additional work, it should be
>possible to get that performance back.
>
>Comments welcome.
>
>[1] http://lkml.kernel.org/r/CAE9FiQUKYMPvXLsk84o-gH-j0-wiJGL0Wt1aTW2o4FPSm0PvbQ@mail.gmail.com
>
>---
>
>Bjorn Helgaas (3):
>      PCI: Change pbus_size_mem() return values to be more conventional
>      PCI: Simplify __pci_assign_resource() coding style
>      PCI: Add resource allocation comments
>
>Yinghai Lu (1):
>      PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources
>
>
> drivers/pci/setup-bus.c |  207 +++++++++++++++++++++++++++++++++--------------
> drivers/pci/setup-res.c |   41 +++++++--
> 2 files changed, 176 insertions(+), 72 deletions(-)

-- 
Richard Yang
Help you, Help me

