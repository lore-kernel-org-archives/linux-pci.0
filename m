Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:61736 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031715AbbD2OmK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2015 10:42:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Jayachandran C. " <jchandra@broadcom.com>
Cc: Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [RFC PATCH 1/2] PCI: generic: remove dependency on hw_pci
Date: Wed, 29 Apr 2015 16:42:01 +0200
Message-ID: <2265507.Ss5WpSD2vL@wuerfel>
In-Reply-To: <20150429142554.GI2992@jayachandranc.netlogicmicro.com>
References: <1430307599-20536-1-git-send-email-jchandra@broadcom.com> <6662179.AoBfCMOsxD@wuerfel> <20150429142554.GI2992@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 29 April 2015 19:55:55 Jayachandran C. wrote:
> On Wed, Apr 29, 2015 at 02:34:20PM +0200, Arnd Bergmann wrote:
> > On Wednesday 29 April 2015 17:09:58 Jayachandran C wrote:
> > > The current code in pci-host-generic.c uses pci_common_init_dev()
> > > from the arch/arm/ to do a part of the PCI initialization, and this
> > > prevents it from being used on arm64.
> > > 
> > > The initialization done by pci_common_init_dev() that is really
> > > needed by pci-host-generic.c can be done in the same file without
> > > using the hw_pci API of ARM.
> > > 
> > > The ARM platform requires a pci_sys_data as sysdata for the PCI bus,
> > > this is be handled by setting up 'struct gen_pci' to embed a
> > > pci_sys_data variable as the first element on the ARM platform.
> > > 
> > > Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> > 
> > This seems very useful
> 
> I have tried to ensure that the new code is as much as possible
> functionally equivalent to the call to pci_common_init_dev on ARM.
> 
> I should have added this as a note to the patch.
> 
> Ideally, I would like this patch to be functionally equivalent
> to the existing code, and make further improvements with follow up
> patches, but I can make the changes you suggest if it is needed.

I believe the driver is only used in virtual machines at the moment,
so it should be easy enough to test the relevant cases on arm32
and make it as simple as possible.

For bisection purposes, it could however be better to start with your
current patch and then follow it up with a second patch that removes
the unnecessary parts again immediately.

	Arnd
