Return-Path: <tn@semihalf.com>
Return-Path: <tn@semihalf.com>
Subject: Re: [UPDATE PATCH V10 2/8] ACPI: Add new IORT functions to support
 MSI domain handling
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
 rjw@rjwysocki.net, helgaas@kernel.org, rafael@kernel.org,
 Lorenzo.Pieralisi@arm.com
References: <1473152938-17388-3-git-send-email-tn@semihalf.com>
 <1473249493-20271-1-git-send-email-tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, hanjun.guo@linaro.org,
 shijie.huang@arm.com, robert.richter@caviumnetworks.com, mw@semihalf.com,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linaro-acpi@lists.linaro.org, andrea.gallo@linaro.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 al.stone@linaro.org, graeme.gregory@linaro.org, ddaney.cavm@gmail.com,
 okaya@codeaurora.org
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <c9c233c4-bb19-df6f-f848-7306af713eb5@semihalf.com>
Date: Wed, 7 Sep 2016 15:01:44 +0200
MIME-Version: 1.0
In-Reply-To: <1473249493-20271-1-git-send-email-tn@semihalf.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 07.09.2016 13:58, Tomasz Nowicki wrote:
> For ITS, MSI functionality consists on building domain stack and
> during that process we need to reference to domain stack components
> e.g. before we create new DOMAIN_BUS_PCI_MSI domain we need to specify
> its DOMAIN_BUS_NEXUS parent domain. In order to manage that process
> properly, maintain list which elements contain domain token
> (unique for MSI domain stack) and ITS ID: iort_register_domain_token()
> and iort_deregister_domain_token(). Then retrieve domain token
> any time later with ITS ID being key off: iort_find_domain_token().
> With domain token and domain type we are able to find corresponding
> IRQ domain.
>
> Since IORT is prepared to describe MSI domain on a per-device basis,
> use existing IORT helpers and implement two calls:
> 1. iort_msi_map_rid() to map MSI RID for a device
> 2. iort_get_device_domain() to find domain token for a device
>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> Conflicts:
> 	drivers/acpi/arm64/iort.c

Rebase leftover ^^^,  sorry.

Tomasz
