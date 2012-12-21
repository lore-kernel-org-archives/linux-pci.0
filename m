Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Yinghai Lu <yinghai@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Toshi Kani <toshi.kani@hp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Myron Stowe <myron.stowe@redhat.com>,
	Yijing Wang <wangyijing0307@gmail.com>,
	Jiang Liu <liuj97@gmail.com>
Subject: Re: [PATCH 0/16] ACPI: Rework ACPI namespace scanning for devices
Date: Fri, 21 Dec 2012 23:23:31 +0100
Message-ID: <3550843.LLuPaOBdqu@vostro.rjw.lan>
In-Reply-To: <CAE9FiQUO16M+_HG7=adYN1B8GpMgL3_rEzCtp5MjGcw2enMw_Q@mail.gmail.com>
References: <8498184.VilrUmatxI@vostro.rjw.lan> <12351296.YKgNhoGAuR@vostro.rjw.lan> <CAE9FiQUO16M+_HG7=adYN1B8GpMgL3_rEzCtp5MjGcw2enMw_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 20, 2012 07:59:15 PM Yinghai Lu wrote:
> On Thu, Dec 20, 2012 at 4:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday, December 19, 2012 06:06:57 PM Yinghai Lu wrote:
> >> On Wed, Dec 19, 2012 at 5:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>
> >> great!, the .bind and .unbind go away.
> >>
> >> >
> >> > The patches are on top of my master branch and I'm going to rebase them when
> >> > v3.8-rc1 is out.
> >>
> >> >
> >> > There is a git tree you can pull them from at:
> >> >
> >> > http://git.kernel.org/?p=linux/kernel/git/rafael/linux-pm.git;a=summary acpi-scan-temp-new
> >> >
> >> > It's v3.7 with my master branch merged and the new patches on top.
> >>
> >>
> >> can you make it base to today's Linus tree ?
> >
> > Sure.  Rebased and pushed out:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-scan-next
> >
> 
> Thanks.
> 
> I rebased pci-root-bus-hotplug patchset on top it, and it works well.

Great, thanks for testing!

> So
> Acked-by: Yinghai Lu <yinghai@kernel.org>
> for the four new ones in your acpi_scan_next branch.

Thanks!

I'll rebase the whole series on top of v3.8-rc1 when it's out.

> i put the updated patches in
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-root-bus-3.9

OK, thanks.

I'll have a look at that series next week.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
