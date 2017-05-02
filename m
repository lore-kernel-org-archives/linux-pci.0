Return-Path: <SRS0=sbXM=4I=wunner.de=lukas@kernel.org>
Return-Path: <SRS0=sbXM=4I=wunner.de=lukas@kernel.org>
Date: Tue, 2 May 2017 03:54:05 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Keith Busch <keith.busch@intel.com>,
	Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170502015405.GA13918@wunner.de>
References: <20170208192054.GA31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170208192256.GB31395@bhelgaas-glaptop.roam.corp.google.com>
 <20170209040648.GA1304@wunner.de>
 <20170209150950.GA11905@bhelgaas-glaptop.roam.corp.google.com>
 <20170209182328.GB77900@otc-nc-03>
 <20170209184613.GA78375@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209184613.GA78375@otc-nc-03>
List-ID: <linux-pci.vger.kernel.org>

Hi Ashok,

sorry for the delay, I was swamped with work in the first quarter and am
in the process of slowly going through my backlog...


On Thu, Feb 09, 2017 at 10:46:13AM -0800, Raj, Ashok wrote:
> I did a lspci and captured after a fresh reboot on the slot before 
> attempting a power off via sysfs.
> 
> lspci-at-poweron - values after a cold reset poweron.
> lspci-aft-poweroff - values after a echo 0 > power
> lspci-aft-poweron - values after a echo 1 > power
> 
> i would expect most or all of those values to stay same between poweron
> and after the next sysfs managed poweron. Would be worth taking a look and see 
> if we have any escapes.


(a) Correctable error (Receiver Error) after powering off => harmless.

(b) ASPM L1 enabled on boot, but disabled after powering off and back on
    => I believe Sinan is working on this (+cc).

(c) Autonomous Bandwidth Status is set after powering back on, but the
    speed and width is the same as on boot => harmless.

(d) PME Status is set after powering off and stays set after powering on.
    Weird.  Could you retry with the new pciehp runtime PM series I sent
    out a few hours ago?

Thanks!

Lukas
