Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 21 Feb 2014 15:27:49 +0100
From: Borislav Petkov <bp@alien8.de>
To: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
	x86@kernel.org, dougthompson@xmission.com, bhelgaas@google.com,
	JBeulich@suse.com, dan.carpenter@oracle.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-pci@vger.kernel.org, Arindam.Nath@amd.com
Subject: Re: [PATCH] amd64_edac: Add support for newer F16h models
Message-ID: <20140221142749.GC11531@pd.tnic>
References: <1392913726-16961-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1392913726-16961-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 10:28:46AM -0600, Aravind Gopalakrishnan wrote:
> Extending ECC decoding support for F16h M30h.
> 
> Tested on F16h M30h with ECC turned on using mce_amd_inj module and
> the patch works fine.
> 
> Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
> Tested-by: Arindam Nath <Arindam.Nath@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c  |  2 ++
>  drivers/edac/amd64_edac.c | 24 ++++++++++++++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  include/linux/pci_ids.h   |  2 ++
>  4 files changed, 31 insertions(+)

...

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 97fbecd..e91ad27 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -528,6 +528,8 @@
>  #define PCI_DEVICE_ID_AMD_15H_NB_F5	0x1605
>  #define PCI_DEVICE_ID_AMD_16H_NB_F3	0x1533
>  #define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
> +#define PCI_DEVICE_ID_AMD_16H_M30H_NB_F3 0x1583
> +#define PCI_DEVICE_ID_AMD_16H_M30H_NB_F4 0x1584

Just put those in arch/x86/include/asm/amd_nb.h as amd64_edac.c includes
it already and you can avoid the pci_ids.h addition. Unless there are
plans to use F{3,4} in other places too...

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
