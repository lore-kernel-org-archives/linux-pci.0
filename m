Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40420 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab3C0P0n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Mar 2013 11:26:43 -0400
Message-ID: <1364397928.11644.41.camel@pasglop>
Subject: Re: [PATCHv2 1/3] pci: added pcie_get_speed_cap_mask function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	David Airlie <airlied@linux.ie>,
	Brian King <brking@linux.vnet.ibm.com>,
	Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>
Date: Wed, 27 Mar 2013 16:25:28 +0100
In-Reply-To: <CAErSpo4rc=8mYgwuTO6693QCQJ9nsPsxmh7YAwxMygiVrPQR0A@mail.gmail.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
	 <1363757079-23550-2-git-send-email-lucaskt@linux.vnet.ibm.com>
	 <CAErSpo4rc=8mYgwuTO6693QCQJ9nsPsxmh7YAwxMygiVrPQR0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-03-26 at 12:39 -0600, Bjorn Helgaas wrote:
> But we also know pdev is a PCIe device, and I think a PCIe device on a
> root bus must be a "Root Complex Integrated Endpoint" (PCIe spec sec
> 1.3.2.3).  Such a device does not have a link at all, so there's no
> point in fiddling with its link speed.

This is where our IBM hypervisor makes things murky. It doesn't expose
the PCIe parents (basically somewhat makes PCIe look like PCI except we
still have the PCIe caps on the child devices, just no access to the
parent device).

It's garbage but can't be fixed (would break AIX :-)

However we might be able to populate the bus->max_bus_speed from some
architecture specific quirk and have radeon use that.

Cheers,
Ben.


