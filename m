Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50802 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757845AbaISU4T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 19 Sep 2014 16:56:19 -0400
Received: by mail-pa0-f51.google.com with SMTP id fa1so827756pad.10
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2014 13:56:19 -0700 (PDT)
Date: Fri, 19 Sep 2014 14:56:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Grant Likely <grant.likely@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v11 04/10] PCI: OF: Fix the conversion of IO ranges into
 IO resources.
Message-ID: <20140919205613.GG19374@google.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-5-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411003825-21521-5-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 18, 2014 at 02:30:19AM +0100, Liviu Dudau wrote:
> The ranges property for a host bridge controller in DT describes
> the mapping between the PCI bus address and the CPU physical address.
> The resources framework however expects that the IO resources start
> at a pseudo "port" address 0 (zero) and have a maximum size of IO_SPACE_LIMIT.
> The conversion from pci ranges to resources failed to take that into account.
> 
> In the process move the function into drivers/of/address.c as it now
> depends on pci_address_to_pio() code and make it return an error code.

I think you're talking about of_pci_range_to_resource().  Can you split
this into one patch that moves it from of_address.h to of/address.c without
changing its functionality, and a second one that does the actual change?

Bjorn
