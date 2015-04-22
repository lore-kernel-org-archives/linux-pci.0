Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754267AbbDVDCc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 21 Apr 2015 23:02:32 -0400
Message-ID: <55370F45.2030809@jonmasters.org>
Date: Tue, 21 Apr 2015 23:02:29 -0400
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>
CC: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tanmay Inamdar <tinamdar@apm.com>,
	Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>
Subject: Re: [PATCH v5 0/4]PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX termination
 driver
References: <55310050.7000003@arm.com> <cover.1429586144.git.dhdang@apm.com>
In-Reply-To: <cover.1429586144.git.dhdang@apm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/21/2015 12:04 AM, Duc Dang wrote:
> This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
> APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
> to GIC V2M specification for MSI Termination.
> 
> There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
> block supports 2048 MSI termination ports coalesced into 16 physical HW IRQ lines
> and shared across all 5 PCIe ports. As the version 5 of this patch, the total MSI
> vectors this driver supports is reduced to 256 to maintain the correct set_affinity 
> behavior for each MSI.

Quick note that I have tested the previous several versions of this
patch series on several platforms and will test v6 once available with
the pending feedback addressed.

Jon.

