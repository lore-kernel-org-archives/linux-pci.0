Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gg0-f170.google.com ([209.85.161.170]:48416 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3JDXBX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 19:01:23 -0400
Received: by mail-gg0-f170.google.com with SMTP id f4so672909ggn.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Oct 2013 16:01:23 -0700 (PDT)
Date: Fri, 4 Oct 2013 17:01:18 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Rajat Jain <rajatjain.linux@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
	linux-hotplug@vger.kernel.org, tom.l.nguyen@intel.com,
	yanmin.zhang@intel.com
Subject: Re: pciehp & other hot-plug drivers (shpc etc..)
Message-ID: <20131004230118.GB26108@google.com>
References: <CADTPrLTuzvj3iSMdNVs2BjDFHsWqjRPM4qDkkpmv+P11LMP0JQ@mail.gmail.com>
 <20130930020500.GB28774@kroah.com>
 <CADTPrLSpfnY6Z1MgpR=C4SRH7yXJ2BKi3w5ChLpTuWL3zZWx_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADTPrLSpfnY6Z1MgpR=C4SRH7yXJ2BKi3w5ChLpTuWL3zZWx_Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 03, 2013 at 06:08:15PM -0700, Rajat Jain wrote:
>  Hello,
> 
> On Sun, Sep 29, 2013 at 7:05 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Sun, Sep 29, 2013 at 11:27:23AM -0700, Rajat Jain wrote:
> >> Hello List,
> >>
> >> Today all the PCI Hot-plug drivers (shpc, acpihp, cpqhp, ibmhp etc
> >> except pciedhp) directly claim the downstream port bridge device.
> >> Where as in case of pciehp, the PCIe port bus driver claims the bridge
> >> device, and service drivers (aer, pm, pciehp) simply register for the
> >> service with it.
> >>
> >> 1) Does that mean that in a system where I am using a driver other
> >> than pciehp for hot-plug (eg. shpc), I cannot use service drivers like
> >> AER or PM on the same port (since the device would be claimed by
> >> shpc, it would not be available to port bus driver)?
> >
> > It depends on your system, and you BIOS, which sets up all of this
> > stuff.  It's up to the kernel to bind to the proper things it exposes.
> 
> Actually, I just wanted to understand that on a machine where
> shpchp.ko is to be used for hot-plug, can I still use the AER port bus
> service driver? My understanding is NO, because shpc will claim the
> downstream port bridge, and hence port bus driver will not be able to
> claim it?

I think you are correct, at least in principle.  Both pcie_portdriver
and shpc_driver try to claim all PCI bridge devices.  pcie_portdrv_probe()
succeeds only for PCIe Root Ports, Upstream Ports, and Downstream Ports.
shpc_probe() succeeds only for bridges with the SHPC capability.  If
one of them does claim the bridge, the driver core should not call the
other probe method.

So if you have a PCIe Root Port or switch port that has the SHPC
capability, either pcie_portdrv_probe() or shpc_probe() will fail,
depending on which was called first.

I've never seen such a device, so I don't know whether this is a
problem in practice.

Bjorn
