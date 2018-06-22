Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] PCI: Allow specifying devices using a base bus and
 path of devfns
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
References: <20180622194315.10475-1-logang@deltatee.com>
 <20180622194315.10475-3-logang@deltatee.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c1278ab2-63a8-19b6-9c8d-fed0b4f94c11@infradead.org>
Date: Fri, 22 Jun 2018 13:01:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180622194315.10475-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 06/22/2018 12:43 PM, Logan Gunthorpe wrote:
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
> [<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*

Please explain the trailing '*'.  I looked thru the code and it doesn't
seem to look for it or care.

> 
> The path can be any segment within the PCI hierarchy of any length and
> determined through the use of 'lspci -t'. When specified this way, it is
> less likely that a renumbered bus will result in a valid device specification
> and the tweak won't be applied to the wrong device.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |   8 +-
>  drivers/pci/pci.c                               | 117 ++++++++++++++++++++----
>  2 files changed, 103 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e783bcefadac..a69947d9e14e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3000,7 +3000,7 @@
>  				or a set of devices (<pci_dev>). These are
>  				specified in one of the following formats:
>  
> -				[<domain>:]<bus>:<slot>.<func>
> +				[<domain>:]<bus>:<slot>.<func>[/<slot>.<func>]*
>  				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
>  
>  				Note: the first format specifies a PCI
> @@ -3009,7 +3009,11 @@
>  				firmware changes, or due to changes caused
>  				by other kernel parameters. If the
>  				domain is left unspecified, it is
> -				taken to be zero. The second format
> +				taken to be zero. Optionally, a path
> +				to a device through multiple slot/function
> +				addresses can be specified after the base
> +				address (this is more robust against
> +				renumbering issues). The second format
>  				selects devices using IDs from the
>  				configuration space which may match multiple
>  				devices in the system.


thanks,
-- 
~Randy
