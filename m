Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40990 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752405AbcA2XGs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 29 Jan 2016 18:06:48 -0500
Date: Fri, 29 Jan 2016 17:06:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
Message-ID: <20160129230645.GG12965@localhost>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <569FB210.9090605@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 20, 2016 at 11:13:04AM -0500, Sinan Kaya wrote:
> On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
> > 
> > We want to get rid of PCI_PROBE_ONLY on ARM/ARM64:
> 
> For platforms that does not have UEFI BIOS, it makes sense to remove the probe only
> option as the firmware is not doing anything.

I don't understand this statement.  It sounds like you mean "non-UEFI
BIOS firmware doesn't assign PCI BARs", but that's not true, so you
must mean something else.

> For server like arm64 platforms, the behavior should be identical to
> x86 world. 

> The UEFI BIOS sets up the resources, kernel uses the resources.

Is there actually a requirement that a UEFI BIOS assign resources to
PCI BARs?   I know that historically, x86 BIOS has set up most or all
PCI BARs.  But I thought there was something in UEFI that relaxed
that, so it would only have to program BARs for the boot and console
devices it actually needed.  But I can't find a spec reference either
way.

Bjorn
