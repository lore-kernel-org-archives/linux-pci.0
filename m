Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 3 Jan 2014 14:24:13 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH v5 24/33] x86: Move declaration for mp_register_ioapic()
Message-ID: <20140103212413.GA18987@google.com>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
 <1388707565-16535-25-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388707565-16535-25-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 02, 2014 at 04:05:56PM -0800, Yinghai Lu wrote:
> Address compiling problem that Fengguang report.

Does this fix a problem that's already in the upstream tree?

If it merely fixes a problem that was added somewhere in your patches,
why don't you fold this fix into the patch that added the problem?

If you included more details, like the exact problem report, I could
probably have figured this out myself.

Bjorn

> Reported-by: Fengguang Wu <wfg@linux.intel.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Jiang Liu <jiang.liu@huawei.com>
> ---
>  arch/x86/include/asm/mpspec.h | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
> index b98665f..e9d850e 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -95,10 +95,26 @@ static inline void early_reserve_e820_mpc_new(void) { }
>  #endif
>  
>  int generic_processor_info(int apicid, int version);
> -#ifdef CONFIG_ACPI
> +#ifdef CONFIG_X86_IO_APIC
>  int __mp_register_ioapic(int id, u32 address, u32 gsi_base, bool hot);
>  int mp_unregister_ioapic(u32 gsi_base);
>  extern void mp_register_ioapic(int id, u32 address, u32 gsi_base);
> +#else
> +static inline int __mp_register_ioapic(int id, u32 address, u32 gsi_base,
> +					 bool hot)
> +{
> +	return 0;
> +}
> +static inline int mp_unregister_ioapic(u32 gsi_base)
> +{
> +	return 0;
> +}
> +static inline void mp_register_ioapic(int id, u32 address, u32 gsi_base)
> +{
> +}
> +#endif
> +
> +#ifdef CONFIG_ACPI
>  extern void mp_override_legacy_irq(u8 bus_irq, u8 polarity, u8 trigger,
>  				   u32 gsi);
>  extern void mp_config_acpi_legacy_irqs(void);
> -- 
> 1.8.4
> 
