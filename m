Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35176 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbG3Gpt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 02:45:49 -0400
Received: by pdrg1 with SMTP id g1so19297418pdr.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2015 23:45:49 -0700 (PDT)
References: <1438169598-24490-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1438169598-24490-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <256F19A7-C8DB-4744-9E08-70D8EE6BCE6D@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	James Morse <james.morse@arm.com>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Simon Horman <horms@verge.net.au>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@xilinx.com>
From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v4 1/2] ARM: PCI: bios32: replace panic with WARN messages on failures
Date: Thu, 30 Jul 2015 15:45:42 +0900
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015. 7. 29., at PM 8:33, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> In the ARM PCI bios32 layer, failures to dynamically allocate pci_sys_data
> for a PCI bus, or a PCI bus scan failure have to be considered serious
> warnings but they should not trigger a system panic so that at least the
> system is given a chance to be debugged.
> 
> This patch replaces the panic statements with WARN() messages to
> improve error reporting in the ARM PCI bios32 layer.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> ---
> arch/arm/kernel/bios32.c | 10 ++++++----
> 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index fcbbbb1..a5c782c 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -459,8 +459,8 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
> 
>    for (nr = busnr = 0; nr < hw->nr_controllers; nr++) {
>        sys = kzalloc(sizeof(struct pci_sys_data), GFP_KERNEL);
> -        if (!sys)
> -            panic("PCI: unable to allocate sys data!");
> +        if (WARN(!sys, "PCI: unable to allocate sys data!"))
> +            break;
> 
> #ifdef CONFIG_PCI_MSI
>        sys->msi_ctrl = hw->msi_ctrl;
> @@ -489,8 +489,10 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
>                sys->bus = pci_scan_root_bus(parent, sys->busnr,
>                        hw->ops, sys, &sys->resources);
> 
> -            if (!sys->bus)
> -                panic("PCI: unable to scan bus!");
> +            if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
> +                kfree(sys);
> +                break;
> +            }
> 
>            busnr = sys->bus->busn_res.end + 1;
> 
> -- 
> 2.2.1
> 
