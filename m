Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751162AbdINIGw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Sep 2017 04:06:52 -0400
Date: Thu, 14 Sep 2017 03:06:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: Resizeable PCI BAR support V8
Message-ID: <20170914080650.GA872@bhelgaas-glaptop.roam.corp.google.com>
References: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1499698794-1718-1-git-send-email-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 10, 2017 at 04:59:48PM +0200, Christian König wrote:
> Hi everyone,
> 
> This is the eighth incarnation of this set of patches. It enables device
> drivers to resize and most likely also relocate the PCI BAR of devices 
> they manage to allow the CPU to access all of the device local memory at once.
> 
> This is very useful for GFX device drivers where the default PCI BAR is only
> about 256MB in size for compatibility reasons, but the device easily have
> multiple gigabyte of local memory.
> 
> Some changes since the last version:
> 1. Rebased on Linus current master tree, going to rebase on 4.13-rc1 as soon as that is out.
> 2. Some more documentation on how to use the new functionality in drivers.
> 3. Only re-enable decoding when everything looks good.
> 4. Rename the new amdgpu function to better match what it is doing.
> 
> Bjorn what's you'r feeling on getting this into 4.14?

This seems 99.9% done, but there were some kbuild issues that need to be
resolved.  Or did I miss the resolution of those?

Bjorn
