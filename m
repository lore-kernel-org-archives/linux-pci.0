Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0065.outbound.protection.outlook.com ([104.47.40.65]:6688
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935989AbeEYI2s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 May 2018 04:28:48 -0400
Subject: Re: [PATCH 0/3] Add parameter for disabling ACS redirection for P2P
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180524214816.14485-1-logang@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2aec7435-e59b-9ef8-825f-029188f6e549@amd.com>
Date: Fri, 25 May 2018 10:28:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180524214816.14485-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 24.05.2018 um 23:48 schrieb Logan Gunthorpe:
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
> seeing it's done at boot, before IOMMU group creating the IOMMU groups
> will be created correctly based on the bits.
>
> Thanks,
>
> Logan
>
>
> Logan Gunthorpe (3):
>    PCI: Make specifying PCI devices in kernel parameters reusable
>    PCI: Allow specifying devices using a base bus and path of devfns
>    PCI: Introduce the disable_acs_redir parameter

Thanks a lot of taking care of it like that. It looks much cleaner to me 
than just trying to disable ACS without a parameter.

Series is Acked-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.


>
>   Documentation/admin-guide/kernel-parameters.txt |  39 ++-
>   drivers/pci/pci.c                               | 358 ++++++++++++++++++++----
>   2 files changed, 336 insertions(+), 61 deletions(-)
>
> --
> 2.11.0
