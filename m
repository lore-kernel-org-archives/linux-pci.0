Return-Path: <SRS0=mGSb=C3=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=mGSb=C3=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Wed, 29 Nov 2017 09:19:29 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
 bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, adouglas@cadence.com, stelford@cadence.com,
 dgary@cadence.com, kgopi@cadence.com, eandrews@cadence.com,
 sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171129091929.0077ffbc@windsurf.home>
In-Reply-To: <20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
	<2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
	<20171128204114.GE11228@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 28 Nov 2017 14:41:14 -0600, Bjorn Helgaas wrote:

> > + * struct cdns_pcie_rc_data - hardware specific data  
> 
> "cdns" is a weird abbreviation for "Cadence", since "Cadence" doesn't
> contain an "s".

cdns is the official Device Tree binding vendor prefix for Cadence:

$ grep Cadence Documentation/devicetree/bindings/vendor-prefixes.txt
cdns	Cadence Design Systems Inc.

And it is already widely used throughout the kernel for Cadence
drivers. See drivers/watchdog/cadence_wdt.c, drivers/spi/spi-cadence.c,
drivers/i2c/busses/i2c-cadence.c, etc.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
