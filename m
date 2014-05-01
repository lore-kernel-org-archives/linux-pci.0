Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:58739 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaEARbd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 May 2014 13:31:33 -0400
Received: by mail-ie0-f178.google.com with SMTP id lx4so3926456iec.37
        for <linux-pci@vger.kernel.org>; Thu, 01 May 2014 10:31:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9160c7a49304270b5070dcf49482723@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1396261856-22465-1-git-send-email-phil.edworthy@renesas.com>
 <1396261856-22465-2-git-send-email-phil.edworthy@renesas.com>
 <20140424191901.GE29593@google.com> <9b8bedae9d604383ac7ec22fd0f62fdb@HKXPR06MB168.apcprd06.prod.outlook.com>
 <CAErSpo6Autto4n4A4wHtXQNJzD3RKevkVcLZHUods-2-eiRDYQ@mail.gmail.com>
 <20140428203501.GA3016@obsidianresearch.com> <ac795ce3bb6349708e2e96686e19d24f@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140430154345.GA1705@obsidianresearch.com> <b9160c7a49304270b5070dcf49482723@HKXPR06MB168.apcprd06.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 1 May 2014 11:31:12 -0600
Message-ID: <CAErSpo4xJ36UabUcCDLsA_Q+r-C2ZV_q16y=Os8vVGFm-iMBxw@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] PCI: host: rcar: Add Renesas R-Car PCIe driver
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	Srikanth Thokala <sthokal@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Grant Likely <grant.likely@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Srikanth, Michal, Grant because we're having the same discussion
about root bus numbers in the Xilinx host bridge driver]

On Thu, May 1, 2014 at 3:50 AM, Phil Edworthy <phil.edworthy@renesas.com> wrote:

> When would the PCI core change the root bus number to something other than set in sys->busnr?

The PCI core never changes the root bus number of a host bridge, but
it's important for the core to know exactly what bus numbers are
behind each host bridge so we can correctly assign bus numbers, MMIO,
and I/O port resources.

The reason is that when we enumerate a PCI-to-PCI bridge, we have to
know whether bus numbers are available for the secondary bus.  For
example, assume two host bridges configured (or wired) as follows:

  A leads to [bus 00-1f], with aperture [mem 0x80000000-0x8fffffff]
  B leads to [bus 20-ff], with aperture [mem 0x90000000-0x9fffffff]

Further, assume a PCI-to-PCI bridge at 1f:00.0.  If the host bridge
driver doesn't tell us the [bus 00-1f] range for host bridge A, the
PCI core will assume [bus 00-ff].  When the core enumerates the
1f:00.0 bridge, it will assign bus number 20 to its secondary bus.
Now it enumerates devices on bus 20.  The core expects this to be done
via host bridge A, but enumeration uses ID-routed config transactions,
so they are claimed by host bridge B instead.  If we find a device
20:00.0, the core thinks it is below A, but it is really below B.

Now we assign resources to 20:00.0, and since we think it's below A,
we assign them from the [mem 0x80000000-0x8fffffff] aperture.  This
obviously doesn't work, because when the driver performs MMIO
accesses, which are address-routed, they are claimed by host bridge A,
not B, so the 20:00.0 device never sees them.

If your host bridge really claims ALL bus numbers (00-ff), that's
fine, and you can tell the PCI core that.  But if you have several
such bridges, they should be placed in separate domains.

This is probably more detail than you wanted, and maybe you don't ever
expect to have multiple host bridges or complicated hierarchies of
devices.  But the PCI core has to deal with these issues on other
systems, so it's important to get these details right.

Bjorn
