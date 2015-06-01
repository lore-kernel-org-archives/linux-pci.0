Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35629 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbFAWMU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2015 18:12:20 -0400
Received: by iesa3 with SMTP id a3so120040186ies.2
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2015 15:12:19 -0700 (PDT)
Date: Mon, 1 Jun 2015 17:12:16 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Rajat Jain <rajatxjain@gmail.com>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>
Subject: Re: [PATCH RFC 2/4] PCI: pciehp: Wait for hotplug command completion
 lazily
Message-ID: <20150601221216.GB3631@google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20140614212126.15202.66060.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <1432939534.5794.56.camel@redhat.com>
 <20150601214322.GA3631@google.com>
 <1433196179.5794.159.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433196179.5794.159.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 01, 2015 at 04:02:59PM -0600, Alex Williamson wrote:
> On Mon, 2015-06-01 at 16:43 -0500, Bjorn Helgaas wrote:
> > If we added calls to pcie_wait_cmd() in these places:
> > 
> >   pciehp_power_on_slot
> >   pciehp_power_off_slot
> >   pcie_disable_notification
> >   pciehp_reset_slot
> > 
> > do you think that would be enough?
> 
> I think that would solve the problem, but the API becomes very difficult
> to use correctly if the programmer just needs to know that a
> pcie_wait_cmd() is necessary following a pcie_write_cmd() if you really
> want to be sure it's synchronous.  pcie_write_cmd() should probably
> incorporate the "safe" behavior and some new _nowait version should
> handle the special cases where we don't need to wait

I don't think of pcie_write_cmd() as an API, since it's static to
pciehp_hpc.c, but I do like your idea.

Bjorn
