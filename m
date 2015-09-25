Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34874 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbbIYMvq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2015 08:51:46 -0400
Received: by obbzf10 with SMTP id zf10so81002427obb.2
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2015 05:51:46 -0700 (PDT)
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 25 Sep 2015 07:51:43 -0500
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] mvebu PCI fixes and cleanups
Message-ID: <20150925125143.GA25688@localhost>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
 <20150925093858.0af99c28@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150925093858.0af99c28@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 25, 2015 at 09:38:58AM +0200, Thomas Petazzoni wrote:
> Russell,
> 
> On Wed, 23 Sep 2015 18:17:07 +0100, Russell King - ARM Linux wrote:
> > This small series contains a number of fixes and cleanups to the
> > mvebu PCI host code.
> 
> I've tested this series on my Armada XP GP board, with 3 PCIe cards
> connected (one Intel e1000e NIC, one generic AHCI SATA card, and one
> Marvell SATA card), and I saw no obvious regressions. The PCIe devices
> are still properly enumerated, and they seem to work fine. There is no
> change in the 'lspci -vv' output.
> 
> Moreover, I've reviewed the different patches, and they look alright to
> me.
> 
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Bjorn, will you propagate the Tested-by/Reviewed-by to all patches on
> the series, or since I believe you're using patchwork, you want us to
> post Tested-by/Reviewed-by replies to each patch?

I'll propagate them, thanks.  I use patchwork, but really only as a
to-do list.  I actually apply patches from mutt and tweak them using
stgit.

Bjorn
