Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60060 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab3JDCn7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Oct 2013 22:43:59 -0400
Date: Thu, 3 Oct 2013 19:36:39 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatjain@juniper.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	"kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>,
	"linux-newbie@vger.kernel.org" <linux-newbie@vger.kernel.org>
Subject: Re: [PCIe spec question] How to get PCI express link up / link down
 notifications?
Message-ID: <20131004023639.GA3417@kroah.com>
References: <1fa2fecbcbe147cc83a3011ff23e3d1a@BN1PR05MB123.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1fa2fecbcbe147cc83a3011ff23e3d1a@BN1PR05MB123.namprd05.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 04, 2013 at 01:40:49AM +0000, Rajat Jain wrote:
> Hello,
> 
> I have a HW which is not compliant with the PCI Express hot-plug (as
> described in the PCI express spec) because the HP signals from the
> downstream port are simply not connected. And I have a PCI express
> endpoint, that in the course of its life, will routinely undergo
> power-off and power-on on cycles. Hence the PCIe link to this device
> is expected to come down, and come up as part of regular operation.

What hardware is this?  Why not ask the manufacturer of it as they are
the ones in control of this type of thing.

> I'm reading the PCI express spec trying to understand if it is
> possible to get notification interrupts, whenever the PCIe link to
> this device goes down or goes up. Can someone please help me
> understand if it is possible?

Notification where?

thanks,

greg k-h
