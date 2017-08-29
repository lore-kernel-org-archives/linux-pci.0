Return-Path: <SRS0=tUeC=77=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=tUeC=77=h08.hostsharing.net=foo00@kernel.org>
Date: Tue, 29 Aug 2017 15:38:52 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mason <slash.tmp@free.fr>, Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Possible regression between 4.9 and 4.13
Message-ID: <20170829133852.GA13355@wunner.de>
References: <87a82qbyv5.fsf@linux.intel.com>
 <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <59A56C15.2000403@linux.intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 04:28:53PM +0300, Mathias Nyman wrote:
> Then again it might be a bit too drastic to kill xhci just because
> we read 0xffffffff once from a mmio xhci register. Maybe we should
> return an error a couple times before actually tearing down xhci.
> 
> This tight check was originally done to detect pci hotplug removed
> hosts as soon as possible.

Just make pci_dev_is_disconnected() public to detect PCI hot removal.
We *know* when the device was hot removed, so I think there's no need
to guess that based on reading "all ones" from mmio (which may happen
for entirely legitimate reasons unrelated to hot removal).

Thanks,

Lukas
