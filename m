Return-Path: <SRS0=1VDW=YZ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=1VDW=YZ=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 11 Jan 2017 11:54:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Amir Levy <amir.jer.levy@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v4 2/8] PCI: Allow runtime PM on Thunderbolt ports
Message-ID: <20170111095450.GK2330@lahna.fi.intel.com>
References: <cover.1483806825.git.lukas@wunner.de>
 <7ddaaa371101208db7b8bc4dcc2f44c056645923.1483806825.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7ddaaa371101208db7b8bc4dcc2f44c056645923.1483806825.git.lukas@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 08, 2017 at 09:41:45AM +0100, Lukas Wunner wrote:
> Currently PCIe ports are only allowed to go to D3 if the BIOS is dated
> 2015 or newer to avoid potential issues with old chipsets.  However for
> Thunderbolt we know that even the oldest controller, Light Ridge (2010),
> is able to suspend its ports to D3 just fine.
> 
> We're about to add runtime PM for Thunderbolt on the Mac.  Apple has
> released two EFI security updates in 2015 which encompass all machines
> with Thunderbolt, but the achieved power saving should be made available
> to users even if they haven't updated their BIOS.  To this end,
> special-case Thunderbolt in pci_bridge_d3_possible().
> 
> This allows the Thunderbolt controller to power down but the root port
> to which the Thunderbolt controller is attached remains in D0 unless
> the EFI update is installed.  Users can pass pcie_port_pm=force on the
> kernel command line if they cannot install the EFI update but still want
> to benefit from the additional power saving of putting the root port
> into D3.  In practice, root ports can be suspended to D3 without issues
> at least on 2012 Ivy Bridge machines.
> 
> If the BIOS cut-off date is ever lowered to 2010, the Thunderbolt
> special case can be removed.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
