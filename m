Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56110 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754628AbeFRVzG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jun 2018 17:55:06 -0400
Date: Mon, 18 Jun 2018 15:55:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
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
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 2/3] PCI: Allow specifying devices using a base bus
 and path of devfns
Message-ID: <20180618155504.68e56358@t450s.home>
In-Reply-To: <20180618193636.16210-3-logang@deltatee.com>
References: <20180618193636.16210-1-logang@deltatee.com>
        <20180618193636.16210-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 18 Jun 2018 13:36:35 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> When specifying PCI devices on the kernel command line using a
> BDF, the bus numbers can change when adding or replacing a device,
> changing motherboard firmware, or applying kernel parameters like
> pci=assign-buses. When this happens, it is usually undesirable to
> apply whatever command line tweak to the wrong device.
> 
> Therefore, it is useful to be able to specify devices with a base
> bus number and the path of devfns needed to get to it. (Similar to
> the "device scope" structure in the Intel VT-d spec, Section 8.3.1.)
> 
> Thus, we add an option to specify devices in the following format:
> 
> [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>][/ ...]
> 
> The path can be any segment within the PCI hierarchy of any length and
> determined through the use of 'lspci -t'. When specified this way, it is
> less likely that a renumbered bus will result in a valid device specification
> and the tweak won't be applied to the wrong device.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   8 +-
>  drivers/pci/pci.c                               | 120 ++++++++++++++++++++----
>  2 files changed, 106 insertions(+), 22 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
