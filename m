Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58856 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755316AbcECOzK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 3 May 2016 10:55:10 -0400
Date: Tue, 3 May 2016 09:55:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Yong, Jonathan" <jonathan.yong@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RFC v4] PCI: PTM Driver
Message-ID: <20160503145506.GA30040@localhost>
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com>
 <20160429141750.GB949@localhost>
 <57286935.3090409@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57286935.3090409@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 03, 2016 at 05:02:45PM +0800, Yong, Jonathan wrote:
> On 04/29/2016 22:17, Bjorn Helgaas wrote:
> >On Tue, Apr 19, 2016 at 06:29:17AM +0000, Yong, Jonathan wrote:
> >>Hello LKML,
> >>
> >>This is a preliminary implementation of the PTM[1] support driver. This driver
> >>has only been tested against a virtual PCI bus since there are no known
> >>endpoints utilizing it yet.
> >
> >What sort of testing is this, exactly?  Is this using a software model
> >of devices that support PTM?
> >
> 
> We wrote another driver to fake the PCI config space with
> pci_scan_bus, with fake switches and fake devices. Convenient since
> the driver only deals with the config space.
> 
> >When will hardware that supports PTM be available to you for testing?
> >When will it be available on the market?
> >
> 
> I don't have any dates for when consumer endpoints will hit the
> market. PTM aware FPGA device models might come around Q3/Q4 this
> year, with exercisers around 2017.
> 
> >I'm trying to figure out whether there's any benefit to merging
> >something before it is useful to anybody.
> >
> 
> True it won't be useful to anybody until such a device is available.
> What is the general policy for future hardware standards?

I don't know if there is a real consensus about that.  In this case,
the feature is relatively simple (at least compared to, say ASPM), and
it's defined by a spec that's already been published, so I don't think
there's really much reason to wait.

I think the most expedient thing is to get it merged now so it'll be
easier to test and deploy it.

Bjorn
