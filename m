Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 15 Jun 2015 12:52:16 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: jakeo@microsoft.com
Cc: kys@microsoft.com, linux-kernel@vger.kernel.org,
	devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
	vkuznets@redhat.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, pebolle@tiscali.nl,
	haiyangz@microsoft.com, mebersol@microsoft.com
Subject: Re: [PATCH v2 4/6] drivers:hv: Export a function that maps Linux
 proc num onto Hyper-V proc num
Message-ID: <20150615195216.GB5257@kroah.com>
References: <1434387999-1885-1-git-send-email-jakeo@microsoft.com>
 <1434387999-1885-5-git-send-email-jakeo@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434387999-1885-5-git-send-email-jakeo@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 15, 2015 at 05:06:37PM +0000, jakeo@microsoft.com wrote:
> From: Jake Oshins <jakeo@microsoft.com>
> 
> This patch exports a function which maps Linux processor number onto Hyper-V
> virtual processor number.  This is necessary in order to map message-
> signaled interrupts (MSIs) into a VM, as the hypervisor needs to know the
> right target VP.
> 
> Signed-off-by: Jake Oshins <jakeo@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 16 ++++++++++++++++
>  include/linux/hyperv.h |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 067a469..65e4eb6 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1158,6 +1158,22 @@ int vmbus_allocate_mmio(struct resource **new, struct hv_device *device_obj,
>  }
>  EXPORT_SYMBOL_GPL(vmbus_allocate_mmio);
>  
> +/**
> + * This function returns the mapping between the Linux processor
> + * number and
> + * the hypervisor's virtual processor number, useful in making
> + * hypercalls and such that talk about specific processors.
> + *
> + * @param procnum - in Linux terms

What kind of comment structure is this?  It's not kernel doc :(

And "procnum" sounds like "process number", why not "cpu_number"?

