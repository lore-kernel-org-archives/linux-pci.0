Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbeGQSWn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 14:22:43 -0400
Date: Tue, 17 Jul 2018 11:48:48 -0600
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
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v7 4/4] PCI: Introduce the disable_acs_redir parameter
Message-ID: <20180717114848.2914d547@t450s.home>
In-Reply-To: <20180717170204.30470-5-logang@deltatee.com>
References: <20180717170204.30470-1-logang@deltatee.com>
        <20180717170204.30470-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 17 Jul 2018 11:02:04 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> In order to support P2P traffic on a segment of the PCI hierarchy,
> we must be able to disable the ACS redirect bits for select
> PCI bridges. The bridges must be selected before the devices are
> discovered by the kernel and the IOMMU groups created. Therefore,
> a kernel command line parameter is created to specify devices
> which must have their ACS bits disabled.
> 
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have it's ACS redirect bits disabled.
> This is similar to the existing 'resource_alignment' parameter.
> 
> The ACS Request P2P Request Redirect, P2P Completion Redirect and P2P
> Egress Control bits are disabled which is sufficient to always allow
> passing P2P traffic uninterrupted. The bits are set after the kernel
> (optionally) enables the ACS bits itself. It is also done regardless of
> whether the kernel sets the bits or not seeing some BIOS firmware is known
> to set the bits on boot.
> 
> If the user tries to disable the ACS redirct for a device without the
> ACS capability, a warning is printed to dmesg.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++
>  drivers/pci/pci.c                               | 76 ++++++++++++++++++++++++-
>  2 files changed, 83 insertions(+), 2 deletions(-)

Thanks for the re-spins!

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
