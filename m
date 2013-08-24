Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1376189294-32022-27-git-send-email-yinghai@kernel.org>
References: <1376189294-32022-1-git-send-email-yinghai@kernel.org>
	<1376189294-32022-27-git-send-email-yinghai@kernel.org>
Date: Sat, 24 Aug 2013 08:51:54 +0800
Message-ID: <CANVTcTYhdiptB_sOUyveBfieg0VkTGdor16kCHKkJDemHzcWXw@mail.gmail.com>
Subject: Re: [PATCH v4 26/28] PCI, x86, ACPI: Link acpi ioapic register to ioapic
From: rui wang <ruiv.wang@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/11/13, Yinghai Lu <yinghai@kernel.org> wrote:
> During ioapic hotplug, acpi_register_ioapic will be called.
> Now for x86, that function is blank.
> Fill that will update __mp_register_ioapic to use those ioapic.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
>  arch/x86/kernel/acpi/boot.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 5be15d1..4a5336d 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -707,16 +707,18 @@ EXPORT_SYMBOL(acpi_unmap_lsapic);
>
>  int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
>  {
> -	/* TBD */
> -	return -EINVAL;
> +	unsigned long long id = 0;
> +
> +	acpi_evaluate_integer(handle, "_UID", NULL, &id);

We cannot assume that "_UID" is an integer. "_UID" can be either an
integer or a string. Need to consider the case when it is a string.

Thanks
Rui

> +
> +	return	__mp_register_ioapic(id, phys_addr, gsi_base, true);
>  }
>
>  EXPORT_SYMBOL(acpi_register_ioapic);
>
>  int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
>  {
> -	/* TBD */
> -	return -EINVAL;
> +	return mp_unregister_ioapic(gsi_base);
>  }
>
>  EXPORT_SYMBOL(acpi_unregister_ioapic);
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
