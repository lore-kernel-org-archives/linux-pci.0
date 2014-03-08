Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:55330 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaCHRQP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 8 Mar 2014 12:16:15 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v6 6/6] pci: Add support for creating a generic host_bridge from device tree
Date: Sat, 8 Mar 2014 18:15:08 +0100
Cc: "linux-pci" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	"linaro-kernel" <linaro-kernel@lists.linaro.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Tanmay Inamdar <tinamdar@apm.com>
References: <1394020137-1830-1-git-send-email-Liviu.Dudau@arm.com> <1394020137-1830-7-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1394020137-1830-7-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201403081815.08829.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 05 March 2014, Liviu Dudau wrote:
> +
> +	pr_debug("Parsing ranges property...\n");
> +	for_each_of_pci_range(&parser, &range) {
> +		/* Read next ranges element */
> +		pr_debug("pci_space: 0x%08x pci_addr:0x%016llx ",
> +				range.pci_space, range.pci_addr);
> +		pr_debug("cpu_addr:0x%016llx size:0x%016llx\n",
> +					range.cpu_addr, range.size);
> +
> +		/*
> +		 * If we failed translation or got a zero-sized region
> +		 * then skip this range
> +		 */
> +		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
> +			continue;
> +
> +		res = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +		if (!res)
> +			return -ENOMEM;
> +
> +		of_pci_range_to_resource(&range, dev, res);
> +
> +		if (resource_type(res) == IORESOURCE_IO)
> +			*io_base = range.cpu_addr;
> +
> +		pci_add_resource_offset(resources, res,
> +				res->start - range.pci_addr);
> +	}

As mentioned regarding the pci_register_io_range() helper, x86
would not enter the 'resource_type(res) == IORESOURCE_IO' code path,
which on the one hand is fine so we can return an error from
pci_register_io_range() there, but I think it will lead to
io_base getting an uninitialized content.

There could also be other reasons why pci_register_io_range() fails,
e.g. because the space is exhausted, and I think we should try to
catch that here and skip the pci_add_resource_offset() and io_base
assignment then.

	Arnd
