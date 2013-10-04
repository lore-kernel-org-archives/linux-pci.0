Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:59530
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab3JDDdM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Oct 2013 23:33:12 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	"kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>,
	"linux-newbie@vger.kernel.org" <linux-newbie@vger.kernel.org>
Subject: RE: [PCIe spec question] How to get PCI express link up / link down
 notifications?
Date: Fri, 4 Oct 2013 03:31:58 +0000
Message-ID: <e0827cdb950044ba8931a544a10e0ebb@BN1PR05MB123.namprd05.prod.outlook.com>
References: <1fa2fecbcbe147cc83a3011ff23e3d1a@BN1PR05MB123.namprd05.prod.outlook.com>
 <20131004023639.GA3417@kroah.com>
In-Reply-To: <20131004023639.GA3417@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Greg,

> 
> On Fri, Oct 04, 2013 at 01:40:49AM +0000, Rajat Jain wrote:
> > Hello,
> >
> > I have a HW which is not compliant with the PCI Express hot-plug (as
> > described in the PCI express spec) because the HP signals from the
> > downstream port are simply not connected. And I have a PCI express
> > endpoint, that in the course of its life, will routinely undergo
> > power-off and power-on on cycles. Hence the PCIe link to this device
> > is expected to come down, and come up as part of regular operation.
> 
> What hardware is this?  Why not ask the manufacturer of it as they are
> the ones in control of this type of thing.

OK, Understood :-).

Actually my question was generic. For e.g. say I have a topology where root port connects to a PCIe switch-1 that in turn connects to a PCIe switch-2. My question is if the PCIe link between the switch-1 and switch-2 goes down or up for some reason (say a power fault, or due to RESET pin assertion on the switch etc), is there a way to get notification interrupt at the root port or CPU? Essentially I am looking for a notification from downstream port of switch-1, that it saw a change in the link status.

> 
> > I'm reading the PCI express spec trying to understand if it is
> > possible to get notification interrupts, whenever the PCIe link to
> > this device goes down or goes up. Can someone please help me
> > understand if it is possible?
> 
> Notification where?

Notification to the CPU via the root port.

Thanks a bunch,

Rajat

> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
> 


