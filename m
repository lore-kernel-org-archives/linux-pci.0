Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from [216.32.180.13] ([216.32.180.13]:11400 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752011Ab3LOX1O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 15 Dec 2013 18:27:14 -0500
From: Rajat Jain <rajatjain@juniper.net>
To: Guenter Roeck <linux@roeck-us.net>, Yinghai Lu <yinghai@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Paul Bolle <pebolle@tiscali.nl>,
	Rajat Jain <rajatxjain@gmail.com>,
	Guenter Roeck <groeck@juniper.net>
Subject: RE: [PATCH v2 2/4] pciehp: Use link change notifications for
 hot-plug and removal
Date: Sun, 15 Dec 2013 23:24:50 +0000
Message-ID: <241775f7fb71476aa84bbb19fde4602f@DM2PR05MB671.namprd05.prod.outlook.com>
References: <529E5C0E.80903@gmail.com> <20131212224407.GL4699@google.com>
 <CAE9FiQX8XXkwbhhuNhCF-pHdc_3or_dMEH-VN5NBSEV_eXE-Pg@mail.gmail.com>
 <CAErSpo5BsaLNrny3T1sYknz3wo4hN0SKJk0_u6eNyEd6qq5o=g@mail.gmail.com>
 <428d664592c2466c9e5e6b393df9d690@DM2PR05MB671.namprd05.prod.outlook.com>
 <CAErSpo5NjOCqkao03Ea=98gunVEaUUitq8mGLarpKW_DQoDF8g@mail.gmail.com>
 <CAE9FiQX-ZP0R-weuPoOJ6GkPxOLp5jk9thnjfPQ+Q5tCHugD4w@mail.gmail.com>
 <20131214033911.GA25115@roeck-us.net>
In-Reply-To: <20131214033911.GA25115@roeck-us.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > >
> > >> Once again: the way I interpret this is:
> > >> * Always enable Link events.
> > >> * Disable presence events if attention button is present.
> > >
> > > That sounds like a good plan to me.
> >
> > How about Diag_Reset from MPT2SAS and others?
> > link could up and down
> >

I am assuming you are referring to 

static int
_base_diag_reset(struct MPT2SAS_ADAPTER *ioc, int sleep_flag)

Which as far as I could understand would cause link to go down and come up
 again without the kernel knowing anything about it?

Please see below since I think point made by Guenter includes this. 

> 
> Good question. Another question is how this would play together with AER
> functions, specifically link_reset and slot_reset.
> 
> In this context ... is it possible that the link_reset function from
> struct pci_error_handlers is never called, or am I missing something ?
>

Very good catch. That seems to be the case, at least as far as I can see.
In fact I think this may be uncovering a more serious problem 
with current code (with no link state events used for hotplug). 

A fatal error is discovered by AER
=> Calls do_recovery()
   => reset_link()
      => Which will  reset the link at downstream / root port.

[PS: There is a clear problem the link_reset() is never broadcasted to all
The drivers, but skimming over that for now] 

In general, I guess the question is when a link goes down and back up, whether
or not we want to treat it as a hot unplug followed by a hotplug. I think there
may be cases such as AER (or the one Yinghai mentions) where we don't want to
treat it as a hotplug (see note below). And there may be cases that we
definitely want to treat it as hotplug (need link events!). Situation gets more
complex since there may be pciehp slots downstream of a link getting reset. 

It seems to me that we are saying that a mechanism is needed so that a voluntary
Link flap is NOT treated like a hotplug temporarily?

I found these:

/**
 * pcie_port_device_suspend - suspend port services associated with a PCIe port
 * @dev: PCI Express port to handle
 */
int pcie_port_device_suspend(struct device *dev)
{
        return device_for_each_child(dev, NULL, suspend_iter);
}

/**
 * pcie_port_device_suspend - resume port services associated with a PCIe port
 * @dev: PCI Express port to handle
 */
int pcie_port_device_suspend(struct device *dev)
{
        return device_for_each_child(dev, NULL, suspend_iter);
}

May be either these can be used or enhancements can be provided to disable a specific
Service on a particular port. 

Thanks,

Rajat


Notes: 
* it may not OK, if the kernel thinks the device is accessible when it is really not.
  What if during this downtime, someone tries to access the device (say userspace)?
* How do we know after the link up, that the device is really the same. 
  If during this reset, the device changed its "character", say a different class?
  I think a rescan should be mandated after every such event.
 * Do we need to unload and reload the driver after the link reset, since it can be a different device?





