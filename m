Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:45757 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab3E1T4y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 15:56:54 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so8280916pbc.32
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 12:56:54 -0700 (PDT)
Date: Tue, 28 May 2013 12:56:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org, linux-pci@vger.kernel.org, ddutile@redhat.com
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
Message-ID: <20130528125650.5ca5b419@nehalam.linuxnetplumber.net>
In-Reply-To: <1369770790.2646.272.camel@ul30vt.home>
References: <20130528183527.3318.5365.stgit@bling.home>
	<20130528184020.3318.7800.stgit@bling.home>
	<20130528123827.2507c34e@nehalam.linuxnetplumber.net>
	<1369770790.2646.272.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 28 May 2013 13:53:10 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 2013-05-28 at 12:38 -0700, Stephen Hemminger wrote:
> > On Tue, 28 May 2013 12:40:20 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> > > Some PCIe-to-PCI bridges are not fully compliant with the PCIe spec
> > > and do not include a PCIe capability.  pci_is_pcie() is not useful on
> > > these devices, making it difficult to determine where we transition
> > > from a legacy PCI bus to a PCIe link.  PCI-core doesn't want a quirked
> > > bridge test for fear of confusion that a PCIe capability would be
> > > expected, so implement it in IOMMU code.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > 
> > This won't work for me because I run without IOMMU.
> > The overhead of IOMMU setup per-packet significantly impacts network performance.
> 
> You were one of the reporters of this issue:
> 
> http://www.spinics.net/lists/linux-pci/msg19579.html
> 
> Does this not work for you or are you saying this is not relevant to you
> because you no longer attempt to enable the IOMMU?  Thanks,
> 
> Alex
> 

For most usage, I gave up on using IOMMU/SR-IOV.
