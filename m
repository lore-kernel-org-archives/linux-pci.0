Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0142.outbound.protection.outlook.com ([207.46.100.142]:35968
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751091AbaILKOX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Sep 2014 06:14:23 -0400
Message-ID: <5412C75F.30207@amd.com>
Date: Fri, 12 Sep 2014 05:13:51 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
To: Liviu Dudau <Liviu.Dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh+dt@kernel.org>,
	"Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Will Deacon" <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
CC: Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Device Tree ML" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 09/10] PCI: Assign unassigned bus resources in pci_scan_root_bus()
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-10-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1410184472-17630-10-git-send-email-Liviu.Dudau@arm.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/8/2014 8:54 AM, Liviu Dudau wrote:
> If the firmware has not assigned all the bus resources and
> we are not just probing the PCIe busses, it makes sense to
> assign the unassigned resources in pci_scan_root_bus().
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>   drivers/pci/probe.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef891d2..508cf61 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1953,6 +1953,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>   	if (!found)
>   		pci_bus_update_busn_res_end(b, max);
>
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_assign_unassigned_bus_resources(b);
> +
>   	pci_bus_add_devices(b);
>   	return b;
>   }
>

Liviu,

Besides the check for PCI_PROBE_ONLY here, I think we also need to avoid calling
"pci_enable_resources()" in the "driver/pci/pci.c: pcibios_enable_device()" for
PCI_PROBE_ONLY mode since the resource is not assigned by Linux. Otherwise, the
"drivers/pci/setup-res.c: pci_enable_resource()" would fail w/ error:

     can't enable device: BAR ..... not assigned

Actually, in "arch/arm/kernel/bios32.c:", the weak "pcibios_enable_device()" function
also has the check for PCI_PROBE_ONLY mode before calling pci_enable_resources().

Thanks,

Suravee

