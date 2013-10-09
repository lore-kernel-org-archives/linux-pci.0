Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:13302
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756086Ab3JIRmh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Oct 2013 13:42:37 -0400
From: Rajat Jain <rajatjain@juniper.net>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hotplug@vger.kernel.org" <linux-hotplug@vger.kernel.org>
Subject: RE: Difference between hot-plug on PCIe rootport vs downstream port
Date: Wed, 9 Oct 2013 17:42:31 +0000
Message-ID: <5519286ef69743e39c17efe621de300d@BLUPR05MB118.namprd05.prod.outlook.com>
References: <43e5eb8dd8c04af197a01dc974f52924@BLUPR05MB118.namprd05.prod.outlook.com>
 <CAErSpo5W9=oFo5kEzWQPCj_OePuCtYU8w7RhVRfz9jH-O=XupQ@mail.gmail.com>
In-Reply-To: <CAErSpo5W9=oFo5kEzWQPCj_OePuCtYU8w7RhVRfz9jH-O=XupQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> >
> > 1) Does the pciehp support hotplug on both rootport and downstream
> port?
> 
> Yes.  To be precise, pciehp supports hotplug of PCIe devices below Root
> Ports and Downstream Ports.
> 
> > 2) What is so different about these that downstream port hotplug was
> part of the kernel since very long, but root port hotplug was included
> releatively recently? Are there any added complexities? I couldn't find
> anything on the net on this. From my understanding it should be exactly
> similar?
> 
> Hotplugging of PCIe devices below Root Ports and Downstream Ports
> should be identical.

Thanks a lot, I think you are right. I got confused between hot-plug of a device on root port, and hot-plug of the root port itself. 

No I'm not bothered about the hot-plug of the host bridge itself. I was talking abouthot-plug of a device directly under the root port.

So I' assuming I should be good with pciehp then.

Thanks,

Rajat


