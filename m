Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <50418769.4030605@gmail.com>
Date: Sat, 01 Sep 2012 11:56:25 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Jiang Liu <jiang.liu@huawei.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	kaneshige.kenji@jp.fujitsu.com
Subject: Re: [PATCH 0/7][RESEND] acpi, pci: hostbridge hotplug support
References: <20120810150955.e4ab3c7f.izumi.taku@jp.fujitsu.com> <CAErSpo5eqyuK_yKshHbDyK5LBBG9cCn1MpmHbqpvVYe6x7AxFg@mail.gmail.com> <CAE9FiQV4M8cAZ71Pxvm8gAXzVuEz_4Yb3akpk7w9JwBH052_rQ@mail.gmail.com> <CAErSpo5ZRapkienpn4ZNWyeC_vfzzxVhmUzViQd0XtAf5ghz2Q@mail.gmail.com> <50400D6E.1050108@huawei.com> <CAErSpo6A_rR=5OREu-OC=ykC_qjeGi7jZOybcurUZBThskp-YA@mail.gmail.com> <5040494E.8080501@huawei.com> <CAErSpo692O3z44b=q3qTjg-Pf4V4F=c-5H5Z_uVsDoQv+ASejQ@mail.gmail.com> <CAE9FiQWtv05guh+oDzAn8CNBr+G8+Wycir7XhAcrgezY5E13Cw@mail.gmail.com>
In-Reply-To: <CAE9FiQWtv05guh+oDzAn8CNBr+G8+Wycir7XhAcrgezY5E13Cw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/01/2012 12:44 AM, Yinghai Lu wrote:
> On Thu, Aug 30, 2012 at 10:42 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>
>> That's true.  I think we should blindly probe for devices only when
>> (1) the system does not have ACPI or (2) the DMI BIOS date is older
>> than some date, e.g., 1 Jan 2013.  For new systems with ACPI, we
>> should only look at the host bridges described in ACPI.
> 
> if those buses do not get scanned, then it should be enough.
> 
> how about just removing pcibios_last_bus probing code?
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 937bcec..3f3c460 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -616,16 +616,6 @@ static void __init __pci_mmcfg_init(int early)
>         if (list_empty(&pci_mmcfg_list))
>                 return;
> 
> -       if (pcibios_last_bus < 0) {
> -               const struct pci_mmcfg_region *cfg;
> -
> -               list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> -                       if (cfg->segment)
> -                               break;
> -                       pcibios_last_bus = cfg->end_bus;
> -               }
> -       }
> -
>         if (pci_mmcfg_arch_init())
>                 pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
>         else {
> 
> 
> also Nehalem *EX* and Westmere *EX* does not support EDAC.
> 
> so if the user with Nehalem/Westmere Desktop version, want to use to
> EDAC, they could just append
> pci=last_bus=255 to get those buses scanned.
I think this is a better solution than non-ACPI root bus hotplug.
--Gerry

