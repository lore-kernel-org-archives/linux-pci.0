Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54218 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964910AbcFMUFl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 13 Jun 2016 16:05:41 -0400
Date: Mon, 13 Jun 2016 15:05:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Peter Wu <peter@lekensteyn.nl>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 0/5] PCI: Add support for suspending (including
 runtime) of PCIe ports
Message-ID: <20160613200535.GA14934@localhost>
References: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 02, 2016 at 11:17:10AM +0300, Mika Westerberg wrote:
> Current Linux PCI core does not do any kind of power management to PCIe
> ports. This means that we waste energy and consume laptop battery even if
> the port has nothing connected to. These patches aim to change that to the
> right direction.
> 
> Previous versions of the patches can be found below:
> 
>   v1: http://www.spinics.net/lists/linux-pci/msg49313.html
>   v2: http://www.spinics.net/lists/linux-pci/msg50167.html
>   v3: http://www.spinics.net/lists/linux-pci/msg50345.html
>   v4: http://www.spinics.net/lists/linux-pci/msg50665.html
>   v5: http://www.spinics.net/lists/linux-pci/msg50803.html
> 
> This assumes that recent (starting from 2015) PCIe ports are capable of
> transition to D3hot/D3cold. We add a new flag to struct pci_dev 'bridge_d3'
> that is set whenever the PCI core thinks the port can be put to D3. The
> check in pci_pm_suspend_noirq() is then extended to cover devices where
> 'bridge_d3' is set.
> 
> We then add two new functions pci_bridge_d3_device_changed/removed(). These
> are used to set and clear 'bridge_d3' whenever there is a change in device
> power management policy (or if the device is removed). For example when
> userspace forbids the device to enter D3cold pci_bridge_d3_device_changed()
> will clear 'bridge_d3' of the upstream bridge.
> 
> For all PCI ports where 'bridge_d3' is set we also enable and unblock
> runtime PM automatically. Only exception is when the PCIe port claims to
> support hotplug. More information about that is in the changelog of
> patch [5/5].
> 
> Since this also touches xhci, I'm adding Mathias and Greg to check if the
> change looks reasonable.
> 
> Bjorn, if you are fine with these patches, it would be nice to get these to
> linux-next for better testing coverage.

Applied to pci/pm with Rafael's additional acks, thanks, Mika!
