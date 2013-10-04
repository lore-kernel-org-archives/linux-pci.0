Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:2920
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750728Ab3JDGs5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Oct 2013 02:48:57 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Rajat Jain <rajatjain@juniper.net>,
	Greg KH <gregkh@linuxfoundation.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>,
	Guenter Roeck <groeck@juniper.net>,
	"kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>,
	"linux-newbie@vger.kernel.org" <linux-newbie@vger.kernel.org>
Subject: RE: [PCIe spec question] How to get PCI express link up / link down
 notifications?
Date: Fri, 4 Oct 2013 06:48:50 +0000
Message-ID: <a092b6a8fd0e4c32a79458b13386b9e8@BN1PR05MB123.namprd05.prod.outlook.com>
References: <1fa2fecbcbe147cc83a3011ff23e3d1a@BN1PR05MB123.namprd05.prod.outlook.com>
 <20131004023639.GA3417@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

I found the answer to my original question. I found the "Data Link Layer State Changed Enable" bit in the Slot Control register which seems to provide interrupt on link state changes.

6.7.3.3. Data Link Layer State Changed Events 
==============================================
The Data Link Layer State Changed event provides an indication that the state of the Data Link Layer Link Active bit in the Link Status register has changed. Support for Data Link Layer State Changed events and software notification of these events are required for hot-plug capable Downstream Ports. If this event is supported, the Port sets the status field associated with the event
5 when the value in the Data Link Layer Link Active bit changes.

Thanks a bunch!

Rajat

