Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751819AbeDLNUG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Apr 2018 09:20:06 -0400
Date: Thu, 12 Apr 2018 08:20:04 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Message-ID: <20180412132003.GC145698@bhelgaas-glaptop.roam.corp.google.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
 <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 12, 2018 at 10:17:42AM +0100, Lorenzo Pieralisi wrote:
> On Thu, Apr 12, 2018 at 02:44:42AM +0000, Sridhar Pitchai wrote:
> > When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual PCI
> > bus to the guest, Hyper-V always provides unique PCI domain.
> > 
> > commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> > overrode unique domain with the serial number of the first device added to
> > the virtual PCI bus.
> > 
> > The reason for that patch was to have a consistent and short name for the
> > device, but Hyper-V doesn't provide unique serial numbers. Using non-unique
> > serial numbers as domain IDs leads to duplicate device addresses, which
> > causes PCI bus registration to fail.
> > 
> > Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> > domain") so we can reliably support multiple devices being assigned to
> > a guest.
> > 
> > Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> > Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> > Cc: stable@vger.kernel.org
> 
> I am still not happy with this patch.
> 
> -  You do not explain at all the dependency on commit 0c195567a8f6 and
>    you should because that's fundamental, if that patch is not present
>    this revert breaks the kernel as per previous discussions[1].
> -  You are sending this patch to all stable kernels that contain the
>    commit you are fixing - some that may not contain the commit above
>    (that was merged in v4.14), you are breaking those kernels, if not
>    explain me why please

If there's a dependency on 0c195567a8f6, I totally agree that
needs to be cleared up.  I was assuming that turned out to be
irrelevant.

> [1] https://marc.info/?l=linux-pci&m=152158684221212&w=2
