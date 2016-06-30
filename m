Return-Path: <gxt@mprc.pku.edu.cn>
Return-Path: <gxt@mprc.pku.edu.cn>
Message-ID: <63073.222.29.22.225.1467295281.squirrel@mprc.pku.edu.cn>
In-Reply-To: <20160623164133.GC17987@localhost>
References: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
    <1465383890-13538-5-git-send-email-lorenzo.pieralisi@arm.com>
    <20160622230746.GI25485@localhost>
    <62140.117.114.135.40.1466678343.squirrel@mprc.pku.edu.cn>
    <20160623164133.GC17987@localhost>
Date: Thu, 30 Jun 2016 22:01:21 +0800 (CST)
Subject: Re: [PATCH v3 4/4] ARM/PCI: remove arch specific
     pcibios_enable_device()
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: "Xuetao Guan" <gxt@mprc.pku.edu.cn>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Russell King" <linux@arm.linux.org.uk>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "David Daney" <david.daney@cavium.com>, linux-pci@vger.kernel.org,
        "Will Deacon" <will.deacon@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Yinghai Lu" <yinghai@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Reply-To: gxt@mprc.pku.edu.cn
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
List-ID: <linux-pci.vger.kernel.org>

> On Thu, Jun 23, 2016 at 06:39:03PM +0800, Xuetao Guan wrote:
>> > [+cc Guan]
>> >
>> > On Wed, Jun 08, 2016 at 12:04:50PM +0100, Lorenzo Pieralisi wrote:
>> >> The arm pcibios_enable_device() implementation exists solely
>> >> to prevent enabling PCI resources on PCI_PROBE_ONLY systems, since
>> >> on those systems the PCI resources are currently not claimed (ie
>> >> inserted in the PCI resource tree - which means their parent
>> >> pointer is not correctly set-up) therefore they can not be enabled
>> >> since this would trigger PCI set-ups failures.
>> >>
>> >> After removing the pci=firmware command line option in:
>> >>
>> >> commit 903589ca7165 ("ARM: 8554/1: kernel: pci: remove pci=firmware
>> >> command line parameter handling")
>> >
>> > 903589ca7165 removed "pci=firmware" from ARM and from
>> > Documentation/kernel-parameters.txt (where it was documented as
>> > ARM-specific).
>> >
>> > I think unicore32 copied that code from arm, so unicore32 is one of
>> > the few remaining arches that can set PCI_PROBE_ONLY.  I suspect this
>> > was just copied from arm and may not be necessary on unicore32.
>> >
>> > Guan, can you confirm that PCI_PROBE_ONLY is necessary on unicore32,
>> > or that it can be removed?
>> >
>>
>> Yes, this code was copied from arm, and it's not necessary.
>> It can be removed safely.
>
> Great, thank you!  I'll add the patch below to my pci/resource branch for
> v4.8.  Let me know if you see any issues with it.
>
>
> commit b9b8a53e24649e48c0a8bceb8d9d8fe1cfee018c
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jun 23 11:33:24 2016 -0500
>
>     unicore32/PCI: Remove pci=firmware command line parameter handling
>
>     Remove support for the "pci=firmware" command line parameter, which
> was
>     way to keep the kernel from changing any PCI BAR assignments.  This
> was
>     copied from ARM, but is not actually needed on unicore32.
>
>     The corresponding ARM support was removed by 903589ca7165 ("ARM:
> 8554/1:
>     kernel: pci: remove pci=firmware command line parameter handling").
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sorry for late.

Please add my ack,
Acked-by: GUAN Xuetao <gxt@mprc.pku.edu.cn>

>
> diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
> index d45fa5f..62137d1 100644
> --- a/arch/unicore32/kernel/pci.c
> +++ b/arch/unicore32/kernel/pci.c
> @@ -265,10 +265,8 @@ static int __init pci_common_init(void)
>
>  	pci_fixup_irqs(pci_common_swizzle, pci_puv3_map_irq);
>
> -	if (!pci_has_flag(PCI_PROBE_ONLY)) {
> -		pci_bus_size_bridges(puv3_bus);
> -		pci_bus_assign_resources(puv3_bus);
> -	}
> +	pci_bus_size_bridges(puv3_bus);
> +	pci_bus_assign_resources(puv3_bus);
>  	pci_bus_add_devices(puv3_bus);
>  	return 0;
>  }
> @@ -279,9 +277,6 @@ char * __init pcibios_setup(char *str)
>  	if (!strcmp(str, "debug")) {
>  		debug_pci = 1;
>  		return NULL;
> -	} else if (!strcmp(str, "firmware")) {
> -		pci_add_flags(PCI_PROBE_ONLY);
> -		return NULL;
>  	}
>  	return str;
>  }
>
