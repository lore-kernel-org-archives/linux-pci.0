Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbdFNSwP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Jun 2017 14:52:15 -0400
Date: Wed, 14 Jun 2017 13:52:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: Resizeable PCI BAR support V5
Message-ID: <20170614185212.GC20778@bhelgaas-glaptop.roam.corp.google.com>
References: <1496998787-6371-1-git-send-email-deathsimple@vodafone.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1496998787-6371-1-git-send-email-deathsimple@vodafone.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 09, 2017 at 10:59:41AM +0200, Christian König wrote:
> Hi everyone,
> 
> This is the fith incarnation of this set of patches. It enables device
> drivers to resize and most likely also relocate the PCI BAR of devices 
> they manage to allow the CPU to access all of the device local memory at once.

I think this is really v7, isn't it?  I see a v6 posted May 9.

> This is very useful for GFX device drivers where the default PCI BAR is only
> about 256MB in size for compatibility reasons, but the device easily have
> multiple gigabyte of local memory.
> 
> Some changes since V4:
> 1. Rebased on 4.11.

I apply patches to topic branches based on -rc1.  I did apply these by
hand, but it's easier if they apply cleanly to -rc1.

> 2. added the rb from Andy Shevchenko to patches which look complete now.
> 3. Move releasing the BAR and reallocating it on error to the driver side.
> 4. Add amdgpu support for GMC V6 hardware generation as well.
> 
> Please review and/or comment,
> Christian.
> 
