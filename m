Return-Path: <linux-kernel-owner@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
References: <20180730161840.13733-1-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1b911d4b-d8e4-d44d-af1b-8ec1a39983e6@deltatee.com>
Date: Mon, 30 Jul 2018 10:41:43 -0600
MIME-Version: 1.0
In-Reply-To: <20180730161840.13733-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v8 0/4] Add parameter for disabling ACS redirection for
 P2P
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hey,

Oops, I missed finishing this up before sending it sorry:

This is mostly a resend with Alex's tags collected. Bjorn, can you
please consider merging this? All patches have been reviewed and
accepted by Alex.

Thanks,

Logan

--

Changes since v7:
* Collected Alex's Reviewed-by Tags
* Rebased onto v4.18-rc7 (no conflicts)


On 30/07/18 10:18 AM, Logan Gunthorpe wrote:
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
> 
> --
> 2.11.0
> 
