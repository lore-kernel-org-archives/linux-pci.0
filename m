Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:38333 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbcDKI4L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 11 Apr 2016 04:56:11 -0400
Date: Mon, 11 Apr 2016 11:56:05 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Zheng, Qi" <qi.zheng@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Zha, Qipeng" <qipeng.zha@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
Message-ID: <20160411085605.GB1727@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
 <0DD381DBF8F68D419C32ACFCEB28EB2521D2B374@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0DD381DBF8F68D419C32ACFCEB28EB2521D2B374@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 11, 2016 at 03:36:41AM +0000, Zheng, Qi wrote:
> > +static int pci_dev_check_d3cold(struct pci_dev *pdev, void *data) {
> > +	bool *d3cold_ok = data;
> > +
> > +	/*
> > +	 * The device needs to be allowed to go D3cold and if it is wake
> > +	 * capable to do so from D3cold.
> > +	 */
> > +	if (pdev->no_d3cold || !pdev->d3cold_allowed)
> > +		*d3cold_ok = false;
> > +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
> > +		*d3cold_ok = false;
> > +
> > +	return !*d3cold_ok;
> >+}
> 
> How about the pme_poll?
> IMHO, if the pme_poll is set for some device, the PCIe port couldn't
> go to sleep as well.

I wasn't sure about that. If the device has pme_poll set, and the bridge
is in D3 (or anything else than D0) the it will not be scanned for PME
(this is done in pci_pme_list_scan()).

My understanding is that pme_poll is a workaround for bridges which do not
forward PME messages upstream properly. Since this whole thing is only
enabled for recent PCIe hardware, I would expect that this works also :)

> > +void pci_bridge_pm_update(struct pci_dev *pdev, bool remove) {
> > +	struct pci_dev *bridge;
> > +	bool d3cold_ok = true;
> > +
> > +	bridge = pci_upstream_bridge(pdev);
> > +	if (!bridge || !pci_bridge_d3_possible(bridge))
> > +		return;
> > +
> > +	pci_dev_get(bridge);
> > +	if (!remove)
> > +		pci_dev_check_d3cold(pdev, &d3cold_ok);
> > +
> > +	if (d3cold_ok) {
> > +		/*
> > +		 * We need to go through all children to find out if all of
> > +		 * them can still go to D3cold.
> > +		 */
> > +		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
> > +			     &d3cold_ok);
> > +	}
> > +	bridge->bridge_d3 = d3cold_ok;
> > +	pci_dev_put(bridge);
> > +}
> 
> IMHO, the PCIe port can go to sleep if all the devices behind it are
> already in D3, not they have the capability to enter D3.

The capability check in pci_pme_capable() means that we expect the
device to be capable of triggering PME from D3cold.

> Besides, why the devices should in D3cold? Why D3hot can't?

Because when you power down a bridge you cannot access config space of
the devices below that bridge anymore. It may also trigger the PCIe link
to go to L2 or L3.
