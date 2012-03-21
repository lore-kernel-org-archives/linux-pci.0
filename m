Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51636 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab2CUDeW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 20 Mar 2012 23:34:22 -0400
Received: by dajr28 with SMTP id r28so934315daj.19
        for <linux-pci@vger.kernel.org>; Tue, 20 Mar 2012 20:34:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1332260463-13924-6-git-send-email-jiang.liu@huawei.com>
References: <CAE9FiQXC7T7JQRfiry8nHaRYN3ggy9vfzc2jDUzar80hv6pEvw@mail.gmail.com>
	<1332260463-13924-1-git-send-email-jiang.liu@huawei.com>
	<1332260463-13924-6-git-send-email-jiang.liu@huawei.com>
Date: Tue, 20 Mar 2012 20:34:21 -0700
Message-ID: <CAE9FiQVNG+_YuEEKFOxZZV7+hS-XKAacNcQg_+nasiRso1yY+g@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86,IRQ: split out function ioapic_setup_resource()
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>,
	Suresh Siddha <suresh.b.siddha@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
	chenkeping@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 20, 2012 at 9:21 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Split out function ioapic_setup_resource(), which will be used by IOAPIC
> hotplug logic.
>
> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
>  arch/x86/kernel/apic/io_apic.c |   69 ++++++++++++++++++++++------------------
>  1 files changed, 38 insertions(+), 31 deletions(-)
>
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index e5b6ca4..dfb6f45 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -85,6 +85,7 @@ static struct ioapic {
>         * Saved state during suspend/resume, or while enabling intr-remap.
>         */
>        struct IO_APIC_route_entry *saved_registers;
> +       struct resource *resource;
>        /* I/O APIC config */
>        struct mpc_ioapic mp_config;
>        /* IO APIC gsi routing info */
> @@ -3987,7 +3988,7 @@ void __init setup_ioapic_dest(void)
>
>  static struct resource *ioapic_resources;
>
> -static struct resource * __init ioapic_setup_resources(int nr_ioapics)
> +static struct resource * __init ioapic_alloc_resources(int nr_ioapics)
>  {
>        unsigned long n;
>        struct resource *res;
> @@ -4010,6 +4011,7 @@ static struct resource * __init ioapic_setup_resources(int nr_ioapics)
>                res[i].flags = IORESOURCE_MEM | IORESOURCE_BUSY;
>                snprintf(mem, IOAPIC_RESOURCE_NAME_SIZE, "IOAPIC %u", i);
>                mem += IOAPIC_RESOURCE_NAME_SIZE;
> +               ioapics[i].resource = &res[i];
>        }
>
>        ioapic_resources = res;
> @@ -4017,43 +4019,48 @@ static struct resource * __init ioapic_setup_resources(int nr_ioapics)
>        return res;
>  }
>
> -void __init ioapic_and_gsi_init(void)
> +static void ioapic_setup_resource(int idx, struct resource *res, bool hotadd)
>  {
> -       unsigned long ioapic_phys, idx = FIX_IO_APIC_BASE_0;
> -       struct resource *ioapic_res;
> -       int i;
> +       unsigned long ioapic_phys, vaddr;
>
> -       ioapic_res = ioapic_setup_resources(nr_ioapics);
> -       for (i = 0; i < nr_ioapics; i++) {
> -               if (smp_found_config) {
> -                       ioapic_phys = mpc_ioapic_addr(i);
> +       if (hotadd) {
> +               ioapic_phys = mpc_ioapic_addr(idx);
> +       } else if (smp_found_config) {
> +               ioapic_phys = mpc_ioapic_addr(idx);
>  #ifdef CONFIG_X86_32
> -                       if (!ioapic_phys) {
> -                               printk(KERN_ERR
> -                                      "WARNING: bogus zero IO-APIC "
> -                                      "address found in MPTABLE, "
> -                                      "disabling IO/APIC support!\n");
> -                               smp_found_config = 0;
> -                               skip_ioapic_setup = 1;
> -                               goto fake_ioapic_page;
> -                       }
> +               if (!ioapic_phys) {
> +                       printk(KERN_ERR
> +                              "WARNING: bogus zero IO-APIC address found "
> +                              "in MPTABLE, disabling IO/APIC support!\n");
> +                       smp_found_config = 0;
> +                       skip_ioapic_setup = 1;
> +                       goto fake_ioapic_page;
> +               }
>  #endif
> -               } else {
> +       } else {
>  #ifdef CONFIG_X86_32
>  fake_ioapic_page:
>  #endif
> -                       ioapic_phys = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
> -                       ioapic_phys = __pa(ioapic_phys);
> -               }
> -               set_fixmap_nocache(idx, ioapic_phys);
> -               apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
> -                       __fix_to_virt(idx) + (ioapic_phys & ~PAGE_MASK),
> -                       ioapic_phys);
> -               idx++;
> -
> -               ioapic_res->start = ioapic_phys;
> -               ioapic_res->end = ioapic_phys + IO_APIC_SLOT_SIZE - 1;
> -               ioapic_res++;
> +               ioapic_phys = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
> +               ioapic_phys = __pa(ioapic_phys);

where is calling set_fixmap_nocache for fake ioapic one?

> +       }
> +
> +       vaddr = __fix_to_virt(FIX_IO_APIC_BASE_0 + idx);
> +       vaddr += (ioapic_phys & ~PAGE_MASK);
> +       apic_printk(APIC_VERBOSE, "mapped IOAPIC to %08lx (%08lx)\n",
> +               vaddr, ioapic_phys);
> +
> +       res->start = ioapic_phys;
> +       res->end = ioapic_phys + IO_APIC_SLOT_SIZE - 1;
> +}
> +
> +void __init ioapic_and_gsi_init(void)
> +{
> +       int i;
> +
> +       ioapic_alloc_resources(nr_ioapics);
> +       for (i = 0; i < nr_ioapics; i++) {
> +               ioapic_setup_resource(i, ioapics[i].resource, false);
>        }

how about booting system with ioapic device and later hot remove it?

maybe we can just alloc one by one.

Yinghai
