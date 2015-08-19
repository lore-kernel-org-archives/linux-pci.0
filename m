Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33853 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbbHSWQ3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2015 18:16:29 -0400
Received: by paccq16 with SMTP id cq16so12073230pac.1
        for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2015 15:16:29 -0700 (PDT)
Date: Wed, 19 Aug 2015 17:16:24 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: David Miller <davem@davemloft.net>
Cc: wangyijing@huawei.com, linux-pci@vger.kernel.org, mroos@linux.ee,
	sparclinux@vger.kernel.org, eric.snowberg@oracle.com,
	benh@kernel.crashing.org
Subject: Re: [PATCH] PCI/ASPM: Fix a NULL pointer crash on sparc64
Message-ID: <20150819221624.GA8150@google.com>
References: <1439808478-23253-1-git-send-email-wangyijing@huawei.com>
 <20150818184943.GA26431@google.com>
 <20150818.121004.1891242587946602543.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150818.121004.1891242587946602543.davem@davemloft.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 18, 2015 at 12:10:04PM -0700, David Miller wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> Date: Tue, 18 Aug 2015 13:49:43 -0500
> 
> > [+cc Dave, Eric, Ben, sparclinux]
> > 
> > On Mon, Aug 17, 2015 at 06:47:58PM +0800, Yijing Wang wrote:
> >> Commit d0751b98dfa3 ("PCI: Add dev->has_secondary_link to
> >> track downstream PCIe links")assumed root port is always
> >> the top device in pcie tree. But on sparc64 V245 and T2000
> >> the pcie tree has no root port device in top level, the
> >> upstream port device is connected directly to root bus.
> >> So we may get NULL parent for this upstream port device.
> >> 
> >> Upstream port ------ Downstream port ------PCIe-PCI bridge
> > 
> > This is an unusual, possibly even illegal, PCIe topology because it
> > lacks a Root Port at the top of the hierarchy.  From lspci output [1]
> > collected by Meelis, the top-level devices are:
> 
> The root port is in the PCI controller on sparc64, and PCI controllers
> don't have actual real PCI configuration space available.
> 
> I used to put dummy PCI bus nodes into the tree and do provide dummy
> software PCI config space methods, but that caused more harm than
> good.

I guess you're talking about what you removed with c26d3c013897
("sparc64: Stop creating dummy root PCI host controller devices."),
which talks about duplicate sysfs and procfs nodes.  Removing the
dummy devices avoids the duplicate node problem, but it doesn't fix
the root cause, so it's probably not the only possible resolution.

We'll probably have to do something ugly like Yijing's patch just
because v4.2 is imminent and I don't want it to be broken.

I don't like it because we have these PCIe links where we only know
about devices on one end of the link, and then we can't manage
ASPM/MPS/etc.  But we've had this situation for several years, so
I guess nobody cares too much about those things on the affected
mahines.

Bjorn
