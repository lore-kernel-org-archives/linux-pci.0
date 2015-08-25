Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:58320 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbHYSs4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Aug 2015 14:48:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
	catalin.marinas@arm.com, will.deacon@arm.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, hanjun.guo@linaro.org
Subject: Re: [PATCH V2 0/4] PCI: ACPI: Setting up DMA coherency for PCI device from _CCA attribute
Date: Tue, 25 Aug 2015 20:48:24 +0200
Message-ID: <240091906.Gl2z931jjW@wuerfel>
In-Reply-To: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 26 August 2015 00:33:25 Suravee Suthikulpanit wrote:
> This patch adds support to setup DMA coherency for PCI device using
> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
> support for ARM64 which is currently in development.
> 
> Also, this should not affect other architectures that does not define 
> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
> 

We only support ACPI on SBSA compliant platforms, and SBSA mandates
cache-coherent PCI, so I don't think this is actually needed,
just use coherent all the time and do WARN_ON(!CCA) to catch people
that try to incorrectly use ACPI on a non-SBSA platform.

	Arnd
