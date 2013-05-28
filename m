Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22567 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab3E1Txj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 28 May 2013 15:53:39 -0400
Message-ID: <1369770790.2646.272.camel@ul30vt.home>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search
 function
From: Alex Williamson <alex.williamson@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: iommu@lists.linux-foundation.org, dwmw2@infradead.org,
	joro@8bytes.org, linux-pci@vger.kernel.org, ddutile@redhat.com
Date: Tue, 28 May 2013 13:53:10 -0600
In-Reply-To: <20130528123827.2507c34e@nehalam.linuxnetplumber.net>
References: <20130528183527.3318.5365.stgit@bling.home>
	 <20130528184020.3318.7800.stgit@bling.home>
	 <20130528123827.2507c34e@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-05-28 at 12:38 -0700, Stephen Hemminger wrote:
> On Tue, 28 May 2013 12:40:20 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > Some PCIe-to-PCI bridges are not fully compliant with the PCIe spec
> > and do not include a PCIe capability.  pci_is_pcie() is not useful on
> > these devices, making it difficult to determine where we transition
> > from a legacy PCI bus to a PCIe link.  PCI-core doesn't want a quirked
> > bridge test for fear of confusion that a PCIe capability would be
> > expected, so implement it in IOMMU code.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> This won't work for me because I run without IOMMU.
> The overhead of IOMMU setup per-packet significantly impacts network performance.

You were one of the reporters of this issue:

http://www.spinics.net/lists/linux-pci/msg19579.html

Does this not work for you or are you saying this is not relevant to you
because you no longer attempt to enable the IOMMU?  Thanks,

Alex

