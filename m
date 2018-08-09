Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727515AbeHJBag (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Aug 2018 21:30:36 -0400
Date: Thu, 9 Aug 2018 18:03:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
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
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v8 0/4] Add parameter for disabling ACS redirection for
 P2P
Message-ID: <20180809230332.GH113140@bhelgaas-glaptop.roam.corp.google.com>
References: <20180730161840.13733-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730161840.13733-1-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 10:18:36AM -0600, Logan Gunthorpe wrote:
> Changes since v6:
> * Fixed order of operations for device specific disable function as
>   noticed by Alex
> * Rebased onto v4.18-rc5 (no conflicts)
> 
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

I reorganized this a bit and split the quirk code into a couple
patches an put the result on my pci/peer-to-peer branch for v4.19.

I think the result is equivalent, but let me know if I made a mistake.

Bjorn
