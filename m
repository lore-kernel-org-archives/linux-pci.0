Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:55275 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbaDCWHQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Apr 2014 18:07:16 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so2485091iec.7
        for <linux-pci@vger.kernel.org>; Thu, 03 Apr 2014 15:07:15 -0700 (PDT)
Date: Thu, 3 Apr 2014 16:07:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
	Liviu.Dudau@arm.com, linux-pci@vger.kernel.org, mohit.kumar@st.com
Subject: Re: [PATCH 0/3] ARM: PCI: implement virtual PCI host controller
Message-ID: <20140403220713.GA23545@google.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 04, 2014 at 04:53:01PM +0000, Will Deacon wrote:
> Hello,
> 
> This small set of patches brings PCI support to mach-virt based upon an
> idealised host controller (see patch 2 for more details).
> 
> This has been tested with kvmtool, for which I have a corresponding set
> of patches which you can find in my kvmtool/pci branch at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/kvmtool.git
> 
> Once the arm64 PCI patches from Liviu have stabilised, I plan to port
> this host controller to work there as well.
> 
> The main issue I can see with this code is how to describe configuration
> space in the device-tree. I'm following the ePAPR PCI bindings (SS == 0)
> , but this adds an ugly 'case 0:' line in the pci range parser, which
> also exists in mainline for the pcie-designware.c driver.

There was a long discussion about this (especially 2/3), and I didn't
follow it closely enough to get the resolution, and I don't think I
picked up the patches.

Can you post them again if they're still applicable?

Thanks,
  Bjorn
