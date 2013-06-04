Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63278 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751474Ab3FDXmE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 19:42:04 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jiang Liu <liuj97@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH 2/3] PCI, ACPI: Don't glue ACPI dev with pci VFs
Date: Wed, 05 Jun 2013 01:51:06 +0200
Message-ID: <1565177.fVUsxhqHvk@vostro.rjw.lan>
In-Reply-To: <CAE9FiQW4UynXesgv58YajV73VZHQLzFiD3M6Dq=7bXmCXDbCiQ@mail.gmail.com>
References: <1369974092-11450-1-git-send-email-jiang.liu@huawei.com> <2947055.dGtK2eC6Fm@vostro.rjw.lan> <CAE9FiQW4UynXesgv58YajV73VZHQLzFiD3M6Dq=7bXmCXDbCiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, June 04, 2013 03:57:28 PM Yinghai Lu wrote:
> On Tue, Jun 4, 2013 at 3:49 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, June 05, 2013 12:44:27 AM Rafael J. Wysocki wrote:
> >> On Friday, May 31, 2013 12:21:30 PM Jiang Liu wrote:
> >> > From: Yinghai Lu <yinghai@kernel.org>
> >> >
> >> > When sriov is enabled, VF could just start after PF in pci tree.
> >> > like c1:00.0 will be PF, and c1:00.1 and after will be VF.
> >> >
> >> > acpi do have dev with same ADR. that will make them get glued
> >> > wrongly.
> >>
> >> How exactly are they glued in that case?
> >>
> >> > Skip that if it is virtfn.
> >>
> >> That should be a bit more specific as far as I can say.  I don't see why a VF
> >> would not have a valid ACPI device object corresponding to it.  Is there any
> >> particular reason?
> >
> > To be precise, I don't quite see why it is impossible or invalid for a VF to
> > have a corresponding ACPI device object.  It may not be the case on this
> > particular system, but why not in general?
> 
> at least for ioapic routing GSI, we should not mix VF to use other PF's
> setting.

I can agree with that, but your patch is far more general than this.  It won't
allow any VF on any system to be "glued" to any ACPI device object and I'm
thinking that that may just go too far.

May that be addressed in a more specific way?

Also, I don't quite understand what the problem *exactly* is, because you
haven't given any details so far.  Can you possibly attach the specific piece
of AML causing the problem to happen on your system?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
