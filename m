Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54581 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751545AbcEDU60 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2016 16:58:26 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] PCI: Put PCIe ports into D3 during suspend
Date: Wed, 04 May 2016 23:01:38 +0200
Message-ID: <2201324.DzICGAcWs8@vostro.rjw.lan>
In-Reply-To: <1461919919-120102-3-git-send-email-mika.westerberg@linux.intel.com>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com> <1461919919-120102-3-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 29, 2016 11:51:57 AM Mika Westerberg wrote:
> Currently the Linux PCI core does not touch power state of PCI bridges and
> PCIe ports when system suspend is entered. Leaving them in D0 consumes
> power which is not good thing in portable devices such as laptops. This may
> also prevent the CPU from entering deeper C-states.
> 
> With recent PCIe hardware we can power down the ports to save power given
> that we take into account few restrictions:
> 
>   - The PCIe port hardware is recent enough, starting from 2015.
> 
>   - Devices connected to PCIe ports are effectively in D3cold once the port
>     is transitioned to D3 (the config space is not accessible anymore and
>     the link may be powered down).
> 
>   - Devices behind the PCIe port need to be allowed to transition to D3cold
>     and back. There is a way both drivers and userspace can forbid this.
> 
>   - If the device behind the PCIe port is capable of waking the system it
>     needs to be able to do so from D3cold.
> 
> This patch adds a new flag to struct pci_device called 'bridge_d3'. This
> flag is set and cleared by the PCI core whenever there is a change in power
> management state of any of the devices behind the PCIe port. When system
> later on is suspended we only need to check this flag and if it is true
> transition the port to D3 otherwise we leave it in D0.
> 
> Also provide override mechanism via command line parameter
> "pcie_port_pm=[off|force]" that can be used to disable or enable the
> feature regardless of the BIOS manufacturing date.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

