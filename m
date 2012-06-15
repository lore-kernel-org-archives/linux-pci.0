Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45051 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2FOQvt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jun 2012 12:51:49 -0400
Received: by dady13 with SMTP id y13so4270524dad.19
        for <linux-pci@vger.kernel.org>; Fri, 15 Jun 2012 09:51:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FDB2192.5070709@huawei.com>
References: <1338026043-3968-1-git-send-email-jiang.liu@huawei.com>
	<1338026043-3968-9-git-send-email-jiang.liu@huawei.com>
	<CAE9FiQVHBE7pvaC5aCk-7q_pU3mxSoo5JapQkjG80DcnW16ZxA@mail.gmail.com>
	<4FDB2192.5070709@huawei.com>
Date: Fri, 15 Jun 2012 09:51:48 -0700
Message-ID: <CAE9FiQVWhSZBcZM1DXJaN7rsj64YO=OjzOm6XkUqio5fZ5di+w@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] PCI, x86: add MMCFG information on demand
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Don Dutile <ddutile@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Keping Chen <chenkeping@huawei.com>, linux-pci@vger.kernel.org,
	Jiang Liu <liuj97@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 15, 2012 at 4:50 AM, Jiang Liu <jiang.liu@huawei.com> wrote:
> Hi Yinghai,
>        A formal patch to fix "here cache cfg too early.  should do
> that after pci_mmcfg_reject_broken()". This patch also improves
> readability and fixes two condition compilation issues reported by
> Fengguang. If you are ok with it, I will fold it into
> "[PATCH v7 08/10] PCI, x86: add MMCFG information on demand".
>        Thanks!
>        Gerry
>
> ---
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 7eae174..5eb2ac9 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -142,7 +142,7 @@ extern int __devinit pci_mmconfig_insert(struct device *dev,
>                                         u16 seg, u8 start, u8 end,
>                                         phys_addr_t addr);
>  extern int pci_mmconfig_delete(u16 seg, u8 start, u8 end);
> -#ifdef CONFIG_ACPI
> +#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_MMCONFIG)
>  extern void pci_mmconfig_probe(u8 start);
>  #else
>  static inline void pci_mmconfig_probe(u8 start) { }
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 20ab4f5..636de35 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -636,13 +636,6 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>                }
>        }
>
> -       i = entries * sizeof(*cfg_table);
> -       pci_acpi_mcfg_array = kmalloc(i, GFP_KERNEL);
> -       if (pci_acpi_mcfg_array) {
> -               memcpy(pci_acpi_mcfg_array, cfg_table, i);
> -               pci_acpi_mcfg_entries = entries;
> -       }
> -
>        return 0;
>  }
>
> @@ -699,8 +692,11 @@ out:
>         * Free all MCFG entries if ACPI is enabled. MCFG information will
>         * be added back on demand by the pci_root driver later.
>         */
> -       if (!early && !acpi_disabled && !known_bridge && pci_acpi_mcfg_array)
> -               free_all_mmcfg();
> +       if (!early && !acpi_disabled && !known_bridge &&
> +           !pci_mmcfg_arch_init_failed) {
> +               if (!acpi_pci_cache_mcfg())
> +                       free_all_mmcfg();
> +       }
>  }
>
>  void __init pci_mmcfg_early_init(void)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index f5d2157..93e0f91 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -163,8 +163,34 @@ acpi_status pci_acpi_remove_pm_notifier(struct acpi_device *dev)
>  }
>
>  /* acpi_table_parse() is marked as __init, so cache MCFG info at boot time */
> -int pci_acpi_mcfg_entries;
> -struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
> +static int pci_acpi_mcfg_entries;
> +static struct acpi_mcfg_allocation *pci_acpi_mcfg_array;
> +
> +static int __init pci_cache_mcfg(struct acpi_table_header *header)
> +{
> +       u32 sz;
> +       void *ptr;
> +
> +       if (!header || (header->length <= sizeof(struct acpi_table_mcfg)))
> +               return -EINVAL;
> +
> +       sz = (header->length - sizeof(struct acpi_table_mcfg));
> +       pci_acpi_mcfg_array = kmalloc(sz, GFP_KERNEL);
> +       if (!pci_acpi_mcfg_array)
> +               return -ENOMEM;
> +
> +       ptr = (void *)header + sizeof(struct acpi_table_mcfg);
> +       memcpy(pci_acpi_mcfg_array, ptr, sz);
> +       pci_acpi_mcfg_entries = sz / sizeof (struct acpi_mcfg_allocation);
> +
> +       return 0;
> +}
> +
> +int __init acpi_pci_cache_mcfg(void)
> +{
> +       acpi_table_parse(ACPI_SIG_MCFG, pci_cache_mcfg);
> +       return pci_acpi_mcfg_array ? 0 : -EINVAL;
> +}

still have some problem:
pci_mmcfg_check_reserved==>is_mmconf_reserved

will update cfg->end_bus.

Thanks

Yinghai
