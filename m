Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750908AbdJXToj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Oct 2017 15:44:39 -0400
Date: Tue, 24 Oct 2017 14:44:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: Resizable PCI BAR support V9
Message-ID: <20171024194438.GB21840@bhelgaas-glaptop.roam.corp.google.com>
References: <20171018135821.3248-1-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171018135821.3248-1-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 18, 2017 at 03:58:16PM +0200, Christian König wrote:
> Hi everyone,
> 
> This is the ninth and hopefully last incarnation of this set of patches. It
> enables device drivers to resize and most likely also relocate the PCI BAR of
> devices they manage to allow the CPU to access all of the device local memory
> at once.
> 
> This is very useful for GFX device drivers where the default PCI BAR is only
> about 256MB in size for compatibility reasons, but the device easily have
> multiple gigabyte of local memory.
> 
> Some changes since the last version:
> 1. Rebased on drm-next, so should be ready to be merged for 4.15.
> 2. The fixup of the 64bit root window on AMD Family 15h CPUs/APUs is only
>    enabled when we compile a kernel supporting that hw.
> 3. Some minor error handling improvements for the amdgpu side. We now
>    gracefully abort driver loading in case of a critical error instead of
>    calling BUG().
> 
> Bjorn any more comments or can we finally get this into 4.15? I will remove the
> version tags from the patches when I send you a pull request if you want this.
> 
> I only work on this as a background task, so sorry for the ~3 month delay
> between each version of the patchset.

I put these (except for the last) on pci/resource for v4.15.  I'd be
happy to merge the last as well if you like.  My tree does not include
drm-next, so there would be a minor conflict when merging upstream.

Bjorn
