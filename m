Return-Path: <oneukum@suse.com>
Return-Path: <oneukum@suse.com>
Message-ID: <1475738689.12201.2.camel@suse.com>
Subject: Re: USB hot-plug not working (ASUS TP301UA-C4028T)
From: Oliver Neukum <oneukum@suse.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
  "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman
 <mathias.nyman@linux.intel.com>, Pierre de Villemereuil <flyos@mailoo.org>,
 Alan Stern <stern@rowland.harvard.edu>,  linux-pci@vger.kernel.org, USB
 list <linux-usb@vger.kernel.org>
Date: Thu, 06 Oct 2016 09:24:49 +0200
In-Reply-To: <20161005204119.GA5961@wunner.de>
References: <57F4B9C5.60600@linux.intel.com>
	 <Pine.LNX.4.44L0.1610051030310.1880-100000@iolanthe.rowland.org>
	 <20161005185401.GA30607@localhost> <20161005204119.GA5961@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-10-05 at 22:41 +0200, Lukas Wunner wrote:
> The PCI core doesn't allow runtime PM by default.  Rather it calls
> pm_runtime_forbid() when the device is added (see pci_pm_init(),
> called
> indirectly from pci_device_add()).  PCI drivers need to explicitly
> call
> pm_runtime_allow(), typically from their ->probe hook.
> 
> If this xHC cannot signal wakeup, it shouldn't allow runtime PM in the
> first place.  Simple as that.

Presumably it can generate PME, just not in D0. The XHCI driver
could, albeit with a slight layering violation, check
that specific combination. But why put the code for a potentially
common problem into xhci?

	Regards
		Oliver
