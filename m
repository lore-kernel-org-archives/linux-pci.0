Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:52232 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab2BGW1f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 7 Feb 2012 17:27:35 -0500
From: Paul Zimmerman <Paul.Zimmerman@synopsys.com>
To: "balbi@ti.com" <balbi@ti.com>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Date: Tue, 7 Feb 2012 14:19:49 -0800
Subject: RE: [PATCH 4/4] usb: dwc3: second part of hibernation support
Message-ID: <F6C4814A9B336243ABC3D1FB44E08AE801D5677FC6@US01WXMBX1.internal.synopsys.com>
References: <cover.1328582753.git.paulz@synopsys.com>
 <9c4ee1f156d28640bc43dee647e3470b9e1b9f37.1328582753.git.paulz@synopsys.com>
 <20120207070322.GB3707@legolas.emea.dhcp.ti.com>
 <F6C4814A9B336243ABC3D1FB44E08AE801D5677E3A@US01WXMBX1.internal.synopsys.com>
 <20120207201742.GA10970@legolas.emea.dhcp.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Paul Zimmerman
> Sent: Tuesday, February 07, 2012 1:16 PM
> 
> OK, I will poke around and see if I can find an existing driver to use as
> an example.

Hi Felipe,

Can you explain a little about how the runtime_pm stuff will work in
the DWC3 driver, disregarding the HAPS platform for now.

For example, if the device is a PCI device, won't the PM ops need to
be part of the struct pci_driver in the dwc3-pci module?

If so, how will they be able to communicate with the routines in the
dwc3 module? Or if not, how will that work exactly?

Thanks.

-- 
Paul

