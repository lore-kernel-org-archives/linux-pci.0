Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59879 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752176AbcD2MH4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2016 08:07:56 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI: Add support for suspending (including runtime) of PCIe ports
Date: Fri, 29 Apr 2016 14:10:59 +0200
Message-ID: <86024359.9LxrAC1gtb@vostro.rjw.lan>
In-Reply-To: <57234999.2040202@intel.com>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com> <57234999.2040202@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, April 29, 2016 02:46:33 PM Mathias Nyman wrote:
> On 29.04.2016 11:51, Mika Westerberg wrote:
> > Current Linux PCI core does not do any kind of power management to PCIe
> > ports. This means that we waste energy and consume laptop battery even if
> > the port has nothing connected to. These patches aim to change that to the
> > right direction.
> >
> > Previous versions of the patches can be found below:
> >
> >    v1: http://www.spinics.net/lists/linux-pci/msg49313.html
> >    v2: http://www.spinics.net/lists/linux-pci/msg50167.html
> >    v3: http://www.spinics.net/lists/linux-pci/msg50345.html
> >    v4: http://www.spinics.net/lists/linux-pci/msg50665.html
> >
> > This assumes that recent (starting from 2015) PCIe ports are capable of
> > transition to D3hot/D3cold. We add a new flag to struct pci_dev 'bridge_d3'
> > that is set whenever the PCI core thinks the port can be put to D3. The
> > check in pci_pm_suspend_noirq() is then extended to cover devices where
> > 'bridge_d3' is set.
> >
> > We then add two new functions pci_bridge_d3_device_changed/removed(). These
> > are used to set and clear 'bridge_d3' whenever there is a change in device
> > power management policy (or if the device is removed). For example when
> > userspace forbids the device to enter D3cold pci_bridge_d3_device_changed()
> > will clear 'bridge_d3' of the upstream bridge.
> >
> > For all PCI ports where 'bridge_d3' is set we also enable and unblock
> > runtime PM automatically. Only exception is when the PCIe port claims to
> > support hotplug. More information about that is in the changelog of
> > patch [4/4].
> >
> > Since this also touches xhci, I'm adding Mathias and Greg to check if the
> > change looks reasonable.
> >
> 
> For the non-functional one-line only xhci change in patch 2/4:
> Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Out of curiosity, does enabling bridge d3 in any way impact #PME
> wakeup signaling initiated by devices behind that bridge?

If the device reports (via the config space) that it is capable of signaling
PME from D3_{cold}, the wakeup signaling won't be affected (as long as the
hardware design follows the spec).

The Mika's patches take that into account AFAICS.

Thanks,
Rafael

