Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 1 Mar 2018 12:49:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: stop crashing in pci_release_resource v2
Message-ID: <20180301184957.GI13722@bhelgaas-glaptop.roam.corp.google.com>
References: <20180221090715.2853-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180221090715.2853-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 21, 2018 at 10:07:15AM +0100, Christian König wrote:
> Is it entirely possible that the BIOS wasn't able to assign resources to
> a device. In this case don't crash in pci_release_resource() when we try
> to resize the resource.
> 
> v2: keep printing the info that we try to release the BAR
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> CC: stable@vger.kernel.org

I was hoping for a dmesg snippet, but I added a Fixes: tag and applied
this to for-linus for v4.16.

> ---
>  drivers/pci/setup-res.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index e815111f3f81..c0f091614805 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -402,6 +402,10 @@ void pci_release_resource(struct pci_dev *dev, int resno)
>  	struct resource *res = dev->resource + resno;
>  
>  	dev_info(&dev->dev, "BAR %d: releasing %pR\n", resno, res);
> +
> +	if (!res->parent)
> +		return;
> +
>  	release_resource(res);
>  	res->end = resource_size(res) - 1;
>  	res->start = 0;
> -- 
> 2.14.1
> 
