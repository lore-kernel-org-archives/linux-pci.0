Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 13 Aug 2018 17:14:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 07/17] x86/pci: add Hygon PCI vendor and northbridge
 support
Message-ID: <20180813221436.GN113140@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1533989492.git.puwen@hygon.cn>
 <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0b8f3a7c5ba8b4f496f8f790e3dafa8d612ffc81.1533989492.git.puwen@hygon.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 11, 2018 at 09:27:42PM +0800, Pu Wen wrote:
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
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
>  arch/x86/Kconfig         |  2 +-
>  arch/x86/kernel/amd_nb.c | 51 ++++++++++++++++++++++++++++++++++++++++++------
>  arch/x86/pci/amd_bus.c   |  6 ++++--
>  include/linux/pci_ids.h  |  2 ++
>  4 files changed, 52 insertions(+), 9 deletions(-)

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2950223..d0e98a9 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -511,6 +511,8 @@
>  #define PCI_DEVICE_ID_AMI_MEGARAID	0x9010
>  #define PCI_DEVICE_ID_AMI_MEGARAID2	0x9060
>  
> +#define PCI_VENDOR_ID_HYGON		0x1d94

Please add this entry so pci_ids.h remains sorted by Vendor ID, then Device
ID, as the comment at the top suggests.

With that changed,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

>  #define PCI_VENDOR_ID_AMD		0x1022
>  #define PCI_DEVICE_ID_AMD_K8_NB		0x1100
>  #define PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP	0x1101
> -- 
> 2.7.4
> 
