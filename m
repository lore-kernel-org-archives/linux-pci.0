Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33689 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422730Ab2JDQ2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Oct 2012 12:28:06 -0400
Message-ID: <1349368080.2759.52.camel@ul30vt.home>
Subject: Re: vfio: missing patch in linux 3.6
From: Alex Williamson <alex.williamson@redhat.com>
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
	kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Thu, 04 Oct 2012 10:28:00 -0600
In-Reply-To: <20121004161421.GV4009@amd.com>
References: <506DA799.5090603@01019freenet.de>
	 <1349364399.2759.42.camel@ul30vt.home> <20121004161421.GV4009@amd.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-10-04 at 18:14 +0200, Roedel, Joerg wrote:
> On Thu, Oct 04, 2012 at 09:26:39AM -0600, Alex Williamson wrote:
> > On Thu, 2012-10-04 at 17:13 +0200, Andreas Hartmann wrote:
> > > Hello Alex,
> > > 
> > > I just tested vfio as part of linux 3.6 and detected, that it doesn't
> > > work because of the following missing patch:
> > > 
> > > http://news.gmane.org/find-root.php?group=gmane.linux.kernel.pci&article=16422
> > > 
> > > Could you please get it applied for the next stable release?
> > 
> > Hi Andreas,
> > 
> > This patch needs to go through Bjorn's PCI tree, but as noted in the
> > comments I have some outstanding questions that need to be answered,
> > probably by Joerg.  Thanks,
> 
> What are the open questions? I have confirmation from the hardware
> people that the south bridges are peer-2-peer safe. Other questions?

Hi Joerg,

There are a couple questions in the link above.  Since the devices don't
expose a PCIe capability, we probably need to add a check to look at the
upstream device and verify we're not on a legacy bus where ACS can't be
enforced.  Then there's the general question of whether the confirmation
of no peer-to-peer applies to every case where we might see this device
(some of them seem to have history that pre-dates this specific package
implementation) or do we need to try to identify specific package
properties in addition to just a device ID?  Thanks,

Alex

