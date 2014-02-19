Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17502 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbaBSTJN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Feb 2014 14:09:13 -0500
Message-ID: <1392836949.15608.536.camel@ul30vt.home>
Subject: Re: pci_reset_bus() usage in rc drivers
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jagan Teki <jagannadh.teki@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Wed, 19 Feb 2014 12:09:09 -0700
In-Reply-To: <CAErSpo6_kXR_GWbK8SjOTVXYTZWEtMoH3FBww2Vn4He6TcuYEA@mail.gmail.com>
References: <CAD6G_RRUjWLYkzR_=EFwO_tx1aJOqqn-jqixhj4tnnqpamv92g@mail.gmail.com>
	 <CAErSpo6_kXR_GWbK8SjOTVXYTZWEtMoH3FBww2Vn4He6TcuYEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-02-19 at 07:57 -0700, Bjorn Helgaas wrote:
> On Wed, Feb 19, 2014 at 5:52 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> > Hi Bjorn,
> >
> > One of the functionality of pci_reset_bus could reset the secondary bus
> > as described in the configuration space - pci_reset_bridge_secondary_bus()
> >
> > Does this reset require in the part of enumeration, what is usage of
> > this in root complex
> > driver perspective.
> 
> Sorry, I don't understand this last sentence.

I don't fully understand either, but pci_reset_bus() will error if you
attempt to use it for the root complex bus.  It only knows how to reset
a bus when there's a parent bridge.  Thanks,

Alex

