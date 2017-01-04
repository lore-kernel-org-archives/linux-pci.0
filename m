Return-Path: <SRS0=S3u2=YS=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=S3u2=YS=linux.intel.com=mika.westerberg@kernel.org>
Date: Wed, 4 Jan 2017 14:29:39 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Peter Wu <peter@lekensteyn.nl>,
	linux-pci <linux-pci@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dave Airlie <airlied@redhat.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Message-ID: <20170104122939.GQ3353@lahna.fi.intel.com>
References: <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <3913750.OA6IItgEjC@aspire.rjw.lan>
 <20170103222509.GA4499@bhelgaas-glaptop.roam.corp.google.com>
 <16155135.jUckSz7QPL@aspire.rjw.lan>
 <20170104000557.GA13950@bhelgaas-glaptop.roam.corp.google.com>
 <20170104081639.GA21076@wunner.de>
 <83901bcb-1315-fbca-e1e3-960bfefbd9c0@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <83901bcb-1315-fbca-e1e3-960bfefbd9c0@quantumtechnology.info>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 04, 2017 at 11:33:16AM +0100, Kilian Singer wrote:
> Dear all,
> 
> the weird thing is also that when calling:
> 
> echo 0 > /sys/bus/pci/devices/0000:01:00.0/d3cold_allowed
> or
> echo on > /sys/bus/pci/devices/0000:01:00.0/power/control
> 
> on a command line then the command line crashes. The system stays responsive but still
> becomes unresponsive when I lock the screen.

Most probably because the device has already been runtime suspended.
Setting them from command line may be too late.

> Maybe a similar thing are happening in the kernel. Maybe one could use the above fact
> and a timeout to test for the problem and then take measures to deactivate the pm.
> 
> I hope this gives you some more clues.

You could try to run 'lspci -vv' once the machine is unresponsive (if
you can do anything anymore). That should show whether the device and
the root port are still in D3.
