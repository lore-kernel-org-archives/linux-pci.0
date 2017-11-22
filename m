Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5910 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbdKVXDp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 18:03:45 -0500
Date: Wed, 22 Nov 2017 15:03:35 -0800
From: Neo Jia <cjia@nvidia.com>
To: Christoph Hellwig <hch@infradead.org>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 1/1] Change pci_enable_sriov, pci_disable_sriov and
 pci_reset_function to non-GPL symbol.
Message-ID: <20171122230335.GA1228@nvidia.com>
References: <1510773058-1482-1-git-send-email-cjia@nvidia.com>
 <20171117145504.GA31760@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20171117145504.GA31760@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 17, 2017 at 06:55:04AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 15, 2017 at 11:10:58AM -0800, Neo Jia wrote:
> > This will allow proprietary linux drivers to adopt SR-IOV spec from
> > PCI-SIG, also switch pci_reset_function to non-GPL symbol as it mainly
> > does pci config space access per spec.
> 
> Clear NAK.  Thos were added intentional, and even if they were changed
> your driver would still be a derived work and had to be published under
> a GPLv2-compatible license.

Hi Christoph,

Just to be clear, here the request is to allow proprietary driver continue
supporting Linux OS when adopting SR-IOV - a PCIE virtualization technology
standardized by PCI SIG.

Similar interfaces we have seen inside Linux kernels are pci_enable_msi,
pci_enable_misx_range, which allows proprietary to work when following a PCI SIG
standard.

Thanks,
Neo
