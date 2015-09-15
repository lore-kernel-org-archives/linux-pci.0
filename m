Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52128 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751863AbbIORx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 13:53:27 -0400
Date: Tue, 15 Sep 2015 18:53:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <david.daney@cavium.com>,
	lorenzo.pieralisi@arm.com, marc.zyngier@arm.com
Subject: Re: [PATCH 6/6] PCI: generic: Allow bus default MSI controller to be
 specified.
Message-ID: <20150915175327.GM31157@arm.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-7-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442013719-5001-7-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 12, 2015 at 12:21:59AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> If the device tree node for the bus has a "msi-parent" property, use
> that as the default MSI controller for devices on the bus.  Add device
> tree binding documentation describing the new property.
> 
> This allows the pci-host-generic driver to be used in systems with
> multiple MSI controllers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/host-generic-pci.txt          |  5 +++++
>  drivers/pci/host/pci-host-generic.c                       | 15 +++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)

I don't think you need this anymore with 4.3-rc1. The core IRQ subsystem
should take care of parsing and configuring the MSI parents.

Will
