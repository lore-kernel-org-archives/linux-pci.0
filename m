Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbeHFUdu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 16:33:50 -0400
Date: Mon, 6 Aug 2018 13:23:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        stable@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH] PCI: Fix bit definitions for LNKCAP2 register
Message-ID: <20180806182327.GA30691@bhelgaas-glaptop.roam.corp.google.com>
References: <20180803065120.29322-1-felipe.balbi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180803065120.29322-1-felipe.balbi@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Jingoo]

On Fri, Aug 03, 2018 at 09:51:20AM +0300, Felipe Balbi wrote:
> Even thhough commit b891b4dc1eed claimed that original bit definitions
> were wrong, that's not really the case. After verifying PCI
> Specification Revisions 3.0, 3.1 and 4.0, Link Capabilites 2
> Register's bit definitions were always starting from Bit 0.
> 
> This has been causing issues reporting correct link speeds on sysfs.

Can you elaborate on this a bit?  b891b4dc1eed still looks correct to
me.  I'm looking at PCIe r4.0, sec 7.5.3.18, where it shows:

  bit    0  RsvdP
  bits 7:1  Supported Link Speeds Vector
  bit    8  Crosslink Supported
  ...

The text in table 7-32 does say:

  Bit definitions within this field are:

    Bit 0    2.5 GT/s
    Bit 1    5.0 GT/s
    ...

It says "Bit 0" there, but it's referring to bit 0 of the *field*,
which is bits 7:1 of the LNKCAP2 register, so bit 0 of the field is
bit 1 of the 32-bit LNKCAP2 register.

I guess you must be looking at this path, since it's the only generic
path that uses PCI_EXP_LNKCAP2_SLS_2_5GB:

  max_link_speed_show()
    speed = pcie_get_speed_cap(pdev)
      pcie_capability_read_dword(dev, PCI_EXP_LNKCAP2, &lnkcap2)
      if (lnkcap2)
        ...
        else if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
	  return PCIE_SPEED_2_5GT
    PCIE_SPEED2STR(speed)
      ...
      (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s"

We don't extract the Supported Speeds Vector by masking and shifting,
so PCI_EXP_LNKCAP2_SLS_2_5GB and related definitions should be based
on the entire 32-bit register, not just the individual field within
that register.

Can you attach the output of "sudo lspci -vvxxx" for a relevant
device and the contents of the sysfs file that is wrong?

> Fixes: b891b4dc1eed ("PCI: Fix bit definitions of PCI_EXP_LNKCAP2 register")
> Cc: <stable@vger.kernel.org> # v3.8+
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> ---
> 
> PCI Spec References:
> 
> - 4.0 https://members.pcisig.com/wg/PCI-SIG/document/10912?downloadRevision=active
> - 3.1 https://members.pcisig.com/wg/PCI-SIG/document/download/8257
> - 3.0 https://members.pcisig.com/wg/PCI-SIG/document/download/8265
> 
>  include/uapi/linux/pci_regs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 796d12910791..6ad597b3d082 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -652,10 +652,10 @@
>  #define PCI_EXP_DEVSTA2		42	/* Device Status 2 */
>  #define PCI_CAP_EXP_RC_ENDPOINT_SIZEOF_V2	44	/* v2 endpoints without link end here */
>  #define PCI_EXP_LNKCAP2		44	/* Link Capabilities 2 */
> -#define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000002 /* Supported Speed 2.5GT/s */
> -#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000004 /* Supported Speed 5GT/s */
> -#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000008 /* Supported Speed 8GT/s */
> -#define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_2_5GB	0x00000001 /* Supported Speed 2.5GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_5_0GB	0x00000002 /* Supported Speed 5GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_8_0GB	0x00000004 /* Supported Speed 8GT/s */
> +#define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000008 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
>  #define PCI_EXP_LNKCTL2		48	/* Link Control 2 */
>  #define PCI_EXP_LNKCTL2_TLS		0x000f
> -- 
> 2.16.1
> 
