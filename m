Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18711 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdKYHh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 02:37:57 -0500
Date: Fri, 24 Nov 2017 23:37:51 -0800
From: Neo Jia <cjia@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 1/1] Change pci_enable_sriov, pci_disable_sriov and
 pci_reset_function to non-GPL symbol.
Message-ID: <20171125073751.GA28668@nvidia.com>
References: <1510773058-1482-1-git-send-email-cjia@nvidia.com>
 <20171117145504.GA31760@infradead.org>
 <20171122230335.GA1228@nvidia.com>
 <20171123132300.GA10736@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171123132300.GA10736@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 05:23:00AM -0800, Christoph Hellwig wrote:
> > Just to be clear, here the request is to allow proprietary driver continue
> > supporting Linux OS when adopting SR-IOV - a PCIE virtualization technology
> > standardized by PCI SIG.
> 
> And the anser in the previous mail was pretty clear: no.  And while
> we're at it go talk to your lawyers again that you don't have a derived
> work, because I suspect you do with such intimate entangling.

Hi Christoph,

Right now, Linux kernel is providing PCI kernel interfaces to support
proprietary PCI driver when it follows the standard from PCI SIG spec. 

So here we are just following the precedence of such to enable a SR-IOV capable
device. I treat this no difference to the scenario when a proprietary PCI driver
is used to only support MSI (pci_enable_msi) and later add MSI-X support
(pci_enable_msix_range).

Thanks,
Neo
