Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46759 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbbGOHWB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 15 Jul 2015 03:22:01 -0400
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
In-Reply-To: <775bb7e5ecc09c3f042ca8e949b35e5f@mail.gmail.com>
References: <robbat2-20140712T111727-002806026Z@orbis-terrarum.net>
	 <CAErSpo5+=33byGqCjFCSfTpfKFtSAHRqYLzGF7yf5d18gEmWsQ@mail.gmail.com>
	 <robbat2-20140712T215640-831385120Z@orbis-terrarum.net>
	 <20150429172832.GB7888@google.com> <20150528122443.GI10210@google.com>
	 <9e8b957da24d7b1f532ed83ffb86ca37@mail.gmail.com>
	 <20150707104426.3d7e8697@endymion.delvare>
	 <a2dbe3edaba57bb78f0c3e22d6068178@mail.gmail.com>
	 <1436537115.4540.31.camel@chaos.site>
	 <775bb7e5ecc09c3f042ca8e949b35e5f@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 15 Jul 2015 09:21:55 +0200
Message-ID: <1436944915.4661.5.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Le Friday 10 July 2015 à 19:46 +0530, Kashyap Desai a écrit :
> >
> > I am about to commit the patch that was successfully tested by the
> > customer on
> > SLES 12, but I'm a bit confused. The upstream patch you referred to is:
> >
> > https://git.kernel.org/cgit/linux/kernel/git/jejb/scsi.git/commit/?h=for-
> > next&id=6431f5d7c6025f8b007af06ea090de308f7e6881
> > [SCSI] megaraid_sas: megaraid_sas driver init fails in kdump kernel
> >
> > But the patch I used is the one you sent by e-mail on May 28th. It is
> > completely
> > different!
> >
> > So what am I supposed to do? Use the patch you sent (and that was tested
> > by the customer) for SLES 11 SP3 and SLES 12? Or was it just for testing
> > and the proper way of fixing the problem would be to backport the
>>upstream commit?
> 
> You can use that patch as valid candidate for upstream submission. Some of
> the MR maintainer (Sumit Saxena) will send that patch. We are just
> organizing other patch series.
> Since SLES already ported patch without commit id, we are fine. I am just
> giving reference that patch which send via email will be send to upstream
> very soon along with other patch set.

OK, thanks for the clarification. The patched SLES 11 SP3 kernel is
currently under testing by the customer, apparently it doesn't work but
I don't have all the details yet. Maybe some more patches need to be
backported because that kernel is older.

-- 
Jean Delvare
SUSE L3 Support

