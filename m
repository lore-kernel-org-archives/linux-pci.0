Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V3 00/21] MMCONFIG refactoring and support for ARM64 PCI
 hostbridge init based on ACPI
To: Mark Salter <msalter@redhat.com>, Tomasz Nowicki <tn@semihalf.com>,
	bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com,
	catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	Lorenzo.Pieralisi@arm.com, okaya@codeaurora.org,
	jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452785393.28109.16.camel@redhat.com>
Cc: jchandra@broadcom.com, linaro-acpi@lists.linaro.org,
	linux-pci@vger.kernel.org, Liviu.Dudau@arm.com,
	ddaney@caviumnetworks.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com,
	Suravee.Suthikulpanit@amd.com, jcm@redhat.com,
	wangyijing@huawei.com, tglx@linutronix.de, mw@semihalf.com,
	linux-arm-kernel@lists.infradead.org
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <56982664.5040009@arm.com>
Date: Thu, 14 Jan 2016 16:51:16 -0600
MIME-Version: 1.0
In-Reply-To: <1452785393.28109.16.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/14/2016 09:29 AM, Mark Salter wrote:
> IO resources on Mustang get disabled unless I do:
>
> @@ -126,9 +126,10 @@ static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
>          if (!acpi_dev_resource_len_valid(res->start, res->end, len, true))
>                  res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
>
> +#if 0
>          if (res->end >= 0x10003)
>                  res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
> -
> +#endif
>
> res->end is way beyond 0x10003 on Mustang:
>
>    pci_bus 0000:00: root bus resource [io  0x0000-0xffff window] (bus address [0x10000000-0x1000ffff])

Juno is throwing "No Space" errors too with the following acpi definition.

DWordIo ( // IO window
	ResourceProducer,
	MinFixed,
	MaxFixed,
	PosDecode,
	EntireRange,
	0x00000000,// Granularity
	0x00000000,// Min Base Address
	0x007fffff,// Max Base Address
	0x5f800000, // Translate
	0x00800000, // Length
	,
	,
	,
	TypeTranslation
)

Although, my reading of the ACPI dword section is suspect...





