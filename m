Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64179 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbcDKDgq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 Apr 2016 23:36:46 -0400
From: "Zheng, Qi" <qi.zheng@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: "Zha, Qipeng" <qipeng.zha@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
Date: Mon, 11 Apr 2016 03:36:41 +0000
Message-ID: <0DD381DBF8F68D419C32ACFCEB28EB2521D2B374@SHSMSX101.ccr.corp.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
In-Reply-To: <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> +static int pci_dev_check_d3cold(struct pci_dev *pdev, void *data) {
> +	bool *d3cold_ok = data;
> +
> +	/*
> +	 * The device needs to be allowed to go D3cold and if it is wake
> +	 * capable to do so from D3cold.
> +	 */
> +	if (pdev->no_d3cold || !pdev->d3cold_allowed)
> +		*d3cold_ok = false;
> +	if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D3cold))
> +		*d3cold_ok = false;
> +
> +	return !*d3cold_ok;
>+}

How about the pme_poll?
IMHO, if the pme_poll is set for some device, the PCIe port couldn't go to sleep as well.

> +void pci_bridge_pm_update(struct pci_dev *pdev, bool remove) {
> +	struct pci_dev *bridge;
> +	bool d3cold_ok = true;
> +
> +	bridge = pci_upstream_bridge(pdev);
> +	if (!bridge || !pci_bridge_d3_possible(bridge))
> +		return;
> +
> +	pci_dev_get(bridge);
> +	if (!remove)
> +		pci_dev_check_d3cold(pdev, &d3cold_ok);
> +
> +	if (d3cold_ok) {
> +		/*
> +		 * We need to go through all children to find out if all of
> +		 * them can still go to D3cold.
> +		 */
> +		pci_walk_bus(bridge->subordinate, pci_dev_check_d3cold,
> +			     &d3cold_ok);
> +	}
> +	bridge->bridge_d3 = d3cold_ok;
> +	pci_dev_put(bridge);
> +}

IMHO, the PCIe port can go to sleep if all the devices behind it are already in D3, not they have the capability to enter D3.
Besides, why the devices should in D3cold? Why D3hot can't?
Thanks.
