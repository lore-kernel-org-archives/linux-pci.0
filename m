Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55378 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752236AbcDZTIy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 Apr 2016 15:08:54 -0400
Date: Tue, 26 Apr 2016 21:08:50 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Hanna Hawa <hannah@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>
Subject: Re: [PATCH v3 0/2] pci: host: new driver for Marvell Armada 7K/8K
 PCIe controller
Message-ID: <20160426210850.13cc8a0e@free-electrons.com>
In-Reply-To: <20160426173144.GB27803@localhost>
References: <1461659506-10387-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<20160426173144.GB27803@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 26 Apr 2016 12:31:44 -0500, Bjorn Helgaas wrote:

> >  create mode 100644 Documentation/devicetree/bindings/pci/pci-armada8k.txt
> >  create mode 100644 drivers/pci/host/pcie-armada8k.c
> 
> Thanks, Thomas, I applied these to pci/host-armada for v4.7.

Thanks!

> I added the tweaks below to use dev_dbg() instead of pr_debug(), use
> dw_pcie_wait_for_link() instead of another hand-coded timeout loop,
> and fix a typo and remove unused constants.

Looks all good, thanks for applying! Just one tiny question below.

>  	/*
>  	 * Interrupts are directly handled by the device driver of the
> -	 * PCI device. However, there are also latched into the PCIe
> +	 * PCI device.  However, they are also latched into the PCIe

Any reason to have two spaces after the dot here?

Thanks again!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
