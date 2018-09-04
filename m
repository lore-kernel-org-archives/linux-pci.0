Return-Path: <SRS0=/8CB=LS=alien8.de=bp@kernel.org>
Return-Path: <SRS0=/8CB=LS=alien8.de=bp@kernel.org>
Date: Tue, 4 Sep 2018 16:52:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
	thomas.lendacky@amd.com, pbonzini@redhat.com, helgaas@kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 07/16] x86/pci: add Hygon PCI vendor and northbridge
 support
Message-ID: <20180904145255.GI32615@zn.tnic>
References: <cover.1535459012.git.puwen@hygon.cn>
 <ecd62b5b5e8f406598f2354892929caa87cf7deb.1535459013.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ecd62b5b5e8f406598f2354892929caa87cf7deb.1535459013.git.puwen@hygon.cn>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 29, 2018 at 08:44:18PM +0800, Pu Wen wrote:
> As Hygon register its PCI Vendor ID as a new one "0x1d94", so add a new
> definition PCI_VENDOR_ID_HYGON in include/linux/pci_ids.h.
> 
> Also Hygon PCI Device ID(0x1450/0x1463/0x1464) for Host bridge is added
> to amd_nb.c. And it need to define new arrays for Hygon:
> hygon_root_ids[], hygon_nb_misc_ids[], hygon_nb_link_ids[].
> 
> To enable Hygon north bridge support, add new variable root_ids, and
> assign its value based on whether CPU vendor is AMD or Hygon. Modify
> the CONFIG_AMD_NB to depends on either AMD or Hygon.
> 
> Add Hygon support in amd_postcore_init(), early_root_info_init().

This whole commit message needs to not say *what* the patch does.

> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/Kconfig         |  2 +-
>  arch/x86/kernel/amd_nb.c | 51 ++++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c   |  6 ++++--
>  include/linux/pci_ids.h  |  2 ++
>  4 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c5ff296..733f1ec 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2818,7 +2818,7 @@ endif # X86_32
>  
>  config AMD_NB
>  	def_bool y
> -	depends on CPU_SUP_AMD && PCI
> +	depends on (CPU_SUP_AMD || CPU_SUP_HYGON) && PCI
>  
>  source "drivers/pcmcia/Kconfig"
>  
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index b481b95..d9867b2 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -20,6 +20,10 @@
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  
> +#define PCI_DEVICE_ID_HYGON_18H_ROOT     0x1450
> +#define PCI_DEVICE_ID_HYGON_18H_DF_F3    0x1463
> +#define PCI_DEVICE_ID_HYGON_18H_DF_F4    0x1464

Why are you adding those if you can use the AMD f17h ones? They're the same.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
