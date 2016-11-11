Return-Path: <lukas@wunner.de>
Return-Path: <lukas@wunner.de>
Date: Fri, 11 Nov 2016 07:47:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Rajat Jain <rajatja@google.com>,
	Yinghai Lu <yinghai@kernel.org>, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Check for PCIe capabilities change after
 resume
Message-ID: <20161111064745.GB8178@wunner.de>
References: <20161110185520.19461.9789.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161110231808.GA8155@wunner.de>
 <20161111002448.GC12055@bhelgaas-glaptop.roam.corp.google.com>
 <20161111064417.GA8178@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111064417.GA8178@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 07:44:17AM +0100, Lukas Wunner wrote:
> That quirk needs to be executed after is_hotplug_bridge is set
> and before pciehp_resume() is called for the first time.

Sorry I meant "before pcie portdrv binds to the port".

Lukas
