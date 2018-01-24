Return-Path: <SRS0=08Wt=ET=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=08Wt=ET=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1516778261.7000.1213.camel@linux.intel.com>
Subject: Re: [GIT PULL] PCI fixes for v4.15
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Bjorn Helgaas
	 <helgaas@kernel.org>, Peter Grayson <jpgrayson@gmail.com>, Catalin Marinas
	 <catalin.marinas@gmail.com>
Cc: linux-pci@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>
Date: Wed, 24 Jan 2018 09:17:41 +0200
In-Reply-To: <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
References: <20180123195644.GA92112@bhelgaas-glaptop.roam.corp.google.com>
	 <CA+55aFxFp_rjSviLUEH-uZ1U=x_g-xiAFKoEQqOOxZQs4xV11A@mail.gmail.com>
	 <20180124004603.GH5317@bhelgaas-glaptop.roam.corp.google.com>
	 <CA+55aFwpmqZUnD=3U23c-r89XmyncoXQzK7+b8AyuQ9+soC19g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-01-23 at 17:04 -0800, Linus Torvalds wrote:
> On Tue, Jan 23, 2018 at 4:46 PM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:

> > Applying the identical patch with "stg import -M" results in
> > 
> >   Author: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken
> > @gmail.com>

> Oddly, stgit seems to even have a *testcase* for this:
> 
>  - t/t1800-import/email-qp:
> 
>         From: Inge =?utf-8?q?Str=C3=B6m?= <inge@power.com>
> 
> and that test-case harkens back to 2006. I wonder why it doesn't seem
> to work for you and Christian.

I see two subtle differences:
- test case starts with letters followed by quoted-printable encoding
- test case has utf-8 while in example we have UTF-8 (should it matter?)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
