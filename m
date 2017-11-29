Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753146AbdK2Pz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Nov 2017 10:55:28 -0500
Date: Wed, 29 Nov 2017 09:55:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, sureshp@cadence.com, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171129155521.GA6469@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
 <20171129091929.0077ffbc@windsurf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129091929.0077ffbc@windsurf.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 29, 2017 at 09:19:29AM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 28 Nov 2017 14:41:14 -0600, Bjorn Helgaas wrote:
> 
> > > + * struct cdns_pcie_rc_data - hardware specific data  
> > 
> > "cdns" is a weird abbreviation for "Cadence", since "Cadence" doesn't
> > contain an "s".
> 
> cdns is the official Device Tree binding vendor prefix for Cadence:
> 
> $ grep Cadence Documentation/devicetree/bindings/vendor-prefixes.txt
> cdns	Cadence Design Systems Inc.
> 
> And it is already widely used throughout the kernel for Cadence
> drivers. See drivers/watchdog/cadence_wdt.c, drivers/spi/spi-cadence.c,
> drivers/i2c/busses/i2c-cadence.c, etc.

Hard to argue with that!  Thanks!
