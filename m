Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38637 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeGPF1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jul 2018 01:27:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id v15-v6so5691581pff.5
        for <linux-pci@vger.kernel.org>; Sun, 15 Jul 2018 22:01:31 -0700 (PDT)
Subject: Re: [PATCH v6 0/4] Add parameter for disabling ACS redirection for
 P2P
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20180713233158.19528-1-logang@deltatee.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <710e15b2-89f8-a658-656f-84492ef78898@ozlabs.ru>
Date: Mon, 16 Jul 2018 15:01:21 +1000
MIME-Version: 1.0
In-Reply-To: <20180713233158.19528-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/7/18 9:31 am, Logan Gunthorpe wrote:
> Changes since v5:
> * Add a quirk to handle the Intel SPT PCH case (as pointed out by Alex)
> * Warn in the case that we try to disable ACS redirect on a device
>   that doesn't have the ACS capability (also suggested by Alex)
> * Collect reviewed-by tag from Alex
> * Rebased onto v4.18-rc4 (no conflicts)
> 
> Changes since v4:
> * Fixed a couple documentation mistakes spotted by Randy
> 
> Changes since v3:
> * Removed some of the cruft that was copied from the resource_alignment
>   paramater (per Alex)
> * A number of docuemntation fixes as noticed by Alex and Willy
> 
> Changes since v2:
> * Rebased onto v4.18-rc1 (no conflicts)
> * Minor tweaks to the documentation per Andy
> * Removed the "path:" prefix and use the path parsing code
>   for simple devices (as it works the same). Per a suggestion from Alex
> 
> Changes since v1:
> * Reworked pci_dev_str_match_path using strrchr as suggested by Alex
> * Collected Christian's Acks
> 
> --
> 
> Hi,
> 
> As discussed in our PCI P2PDMA series, we'd like to add a kernel
> parameter for selectively disabling ACS redirection for select
> bridges. Seeing this turned out to be a small series in itself, we've
> decided to send this separately from the P2P work.
> 
> This series generalizes the code already done for the resource_alignment
> option that already exists. The first patch creates a helper function
> to match PCI devices against strings based on the code that already
> existed in pci_specified_resource_alignment().
> 
> The second patch expands the new helper to optionally take a path of
> PCI devfns. This is to address Alex's renumbering concern when using
> simple bus-devfns. The implementation is essentially how he described it and
> similar to the Intel VT-d spec (Section 8.3.1).
> 
> The final patch adds the disable_acs_redir kernel parameter which takes
> a list of PCI devices and will disable the ACS P2P Request Redirect,
> ACS P2P Completion Redirect and ACS P2P Egress Control bits for the
> selected devices. This allows P2P traffic between selected bridges and
> seeing it's done at boot, before the IOMMU groups will be created, the
> groups will match the security provided by ACS.


I am pretty sure it's been discussed but just to make sure I understand the
whole picture - why exactly does ACS have to be disabled at the boot time?
We could enable it, for example, for 2 devices in the same VFIO container
if there are in isolatable part of the PCI tree, or we just do not want to
make VFIO containers or QEMU aware of PCI hierarchy (I can see why, just
double checking)? Thanks.




> 
> Thanks,
> 
> Logan
> 
> --
> 
> Logan Gunthorpe (4):
>   PCI: Make specifying PCI devices in kernel parameters reusable
>   PCI: Allow specifying devices using a base bus and path of devfns
>   PCI: Introduce disable_acs_redir quirk
>   PCI: Introduce the disable_acs_redir parameter
> 
>  Documentation/admin-guide/kernel-parameters.txt |  41 +++-
>  drivers/pci/pci.c                               | 310 +++++++++++++++++++-----
>  drivers/pci/quirks.c                            |  78 +++++-
>  include/linux/pci.h                             |   5 +
>  4 files changed, 361 insertions(+), 73 deletions(-)
> 
> --
> 2.11.0
> 


-- 
Alexey
