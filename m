Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55619 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbbGAJUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Jul 2015 05:20:12 -0400
Subject: RE: megaraid_sas: "FW in FAULT state!!", how to get more debug
 output? [BKO63661]
From: Jean Delvare <jdelvare@suse.de>
To: Kashyap Desai <kashyap.desai@avagotech.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Adam Radford <aradford@gmail.com>,
	Neela Syam Kolli <megaraidlinux@lsi.com>,
	linux-scsi@vger.kernel.org, arkadiusz.bubala@open-e.com,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Sumit Saxena <sumit.saxena@avagotech.com>,
	Uday Lingala <uday.lingala@avagotech.com>,
	"PDL,MEGARAIDLINUX" <megaraidlinux.pdl@avagotech.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>
In-Reply-To: <12176d8f15f49359898726ccede592bd@mail.gmail.com>
References: <robbat2-20140712T111727-002806026Z@orbis-terrarum.net>
	 <CAErSpo5+=33byGqCjFCSfTpfKFtSAHRqYLzGF7yf5d18gEmWsQ@mail.gmail.com>
	 <robbat2-20140712T215640-831385120Z@orbis-terrarum.net>
	 <20150429172832.GB7888@google.com> <20150528122443.GI10210@google.com>
	 <9e8b957da24d7b1f532ed83ffb86ca37@mail.gmail.com>
	 <1435584320.4646.53.camel@chaos.site>
	 <12176d8f15f49359898726ccede592bd@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Jul 2015 11:20:07 +0200
Message-ID: <1435742407.22803.34.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kashyap,

I finally managed to backport your patch to the SLES 12 kernel :-) I'll
build a test kernel for the customer and have them test it. I'll let you
know if I need your help later for the SLES 11 SP3 kernel backport -
thanks for the offer!

Jean

Le Tuesday 30 June 2015 à 16:03 +0530, Kashyap Desai a écrit :
> Jean,
> 
> Patch is available at below repo -
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git - b for-next
> 
> Commit id -
> 6431f5d7c6025f8b007af06ea090de308f7e6881
> 
> If you share megaraid_sas driver code of your tree, I can provide patch for
> you.
> 
> ` Kashyap
> 
> > -----Original Message-----
> > From: Jean Delvare [mailto:jdelvare@suse.de]
> > Sent: Monday, June 29, 2015 6:55 PM
> > To: Kashyap Desai
> > Cc: Bjorn Helgaas; Robin H. Johnson; Adam Radford; Neela Syam Kolli;
> > linux-
> > scsi@vger.kernel.org; arkadiusz.bubala@open-e.com; Matthew Garrett; Sumit
> > Saxena; Uday Lingala; PDL,MEGARAIDLINUX; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Myron Stowe
> > Subject: RE: megaraid_sas: "FW in FAULT state!!", how to get more debug
> > output? [BKO63661]
> >
> > Hi Kashyap,
> >
> > Thanks for the patch. May I ask what tree it was based on? Linus'
> > latest? I am trying to apply it to the SLES 11 SP3 and SLES 12 kernel
> > trees (based
> > on kernel v3.0 + a bunch of backports and v3.12
> > respectively) but your patch fails to apply in both cases. I'll try harder
> > but I don't
> > know anything about the megaraid_sas code so I really don't know where I'm
> > going.
> >
> > Does your patch depend on any other that may not be present in the SLES
> > 11 SP3 and SLES 12 kernels?
> >
> > Thanks,
> > Jean
> >
> > Le Thursday 28 May 2015 à 19:05 +0530, Kashyap Desai a écrit :
> > > Bjorn/Robin,
> > >
> > > Apologies for delay. Here is one quick suggestion as we have seen
> > > similar issue (not exactly similar, but high probably to have same
> > > issue) while controller is configured on VM as pass-through and VM
> > > reboot
> > abruptly.
> > > In that particular issue, driver interact with FW which may  require
> > > chip reset to bring controller to operation state.
> > >
> > > Relevant patch was submitted for only Older controller as it was only
> > > seen for few MegaRaid controller. Below patch already try to do chip
> > > reset, but only for limited controllers...I have attached one more
> > > patch which does chip reset from driver load time for
> > > Thunderbolt/Invader/Fury etc. (In your case you have Thunderbolt
> > > controller, so attached patch is required.)
> > >
> > > http://www.spinics.net/lists/linux-scsi/msg67288.html
> > >
> > > Please post the result with attached patch.
> > >
> > > Thanks, Kashyap


