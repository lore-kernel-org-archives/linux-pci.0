Return-Path: <SRS0=/l1V=6R=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=/l1V=6R=kernel.crashing.org=benh@kernel.org>
Message-ID: <1500040204.2865.90.camel@kernel.crashing.org>
Subject: Re: [PATCH v4] PCI: Support hibmc VGA cards behind a misbehaving
 HiSilicon bridge
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Alex Williamson
	 <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Daniel Axtens <dja@axtens.net>,
        "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>,
        "Liuxinliang (Matthew Liu)"
 <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
 <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>
Date: Fri, 14 Jul 2017 23:50:04 +1000
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
References: <20170712050811.3620-1-dja@axtens.net>
	 <20170712200430.GI14614@bhelgaas-glaptop.roam.corp.google.com>
	 <EE11001F9E5DDD47B7634E2F8A612F2E40B35F02@FRAEML521-MBX.china.huawei.com>
	 <20170713112938.GI4486@bhelgaas-glaptop.roam.corp.google.com>
	 <20170713151146.53e9644c@w520.home>
	 <1499980882.2865.65.camel@kernel.crashing.org>
	 <EE11001F9E5DDD47B7634E2F8A612F2E40B399B4@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-07-14 at 12:26 +0000, Gabriele Paoloni wrote:
> diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
> index 92f1452..ab3ad9a 100644
> --- a/drivers/gpu/vga/vgaarb.c
> +++ b/drivers/gpu/vga/vgaarb.c
> @@ -1424,6 +1424,14 @@ static int __init vga_arb_device_init(void)
>  
>         list_for_each_entry(vgadev, &vga_list, list) {
>                 struct device *dev = &vgadev->pdev->dev;
> +
> +               /* if no legacy device has been set as default VGA
> +                * device, just pick up the first one in the list */
> +               if (vga_default == NULL) {
> +                       vgaarb_info(dev, "setting as boot VGA device\n");
> +                       vga_set_default_device(vgadev->pdev);
> +               }
> +
>  #if defined(CONFIG_X86) || defined(CONFIG_IA64)
>                 /*
>                  * Override vga_arbiter_add_pci_device()'s I/O based detection 
> 
> Above after we have filled the list of VGA devices by iterating over all
> PCI devices we check if no legacy one has been set as default VGA device
> yet: therefore we set the first VGA device in the list as default one...
> 
> Do you think it would work?

I honestly don't remember all of the details of the arbiter but just
make sure that it won't think that device is enabled for things like
VGA etc... if it's memory/IO decode weren't enabled.

I'd rather we have no default device until a driver actually picks up
though, and then, if we still have no default, use the first driver to
pick up.

Ben.
