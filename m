Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37072 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbcFNRh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 14 Jun 2016 13:37:56 -0400
Date: Tue, 14 Jun 2016 10:37:43 -0700
From: David Cohen <david.a.cohen@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v1 1/1] x86/platform/intel-mid: Add Power Management Unit
 driver
Message-ID: <20160614173743.GB16566@psi-dev26.jf.intel.com>
References: <1465849087-54528-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1465919118.30123.73.camel@linux.intel.com>
 <20160614155835.GA29820@gmail.com>
 <1465920434.30123.87.camel@linux.intel.com>
 <20160614172621.GA16566@psi-dev26.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160614172621.GA16566@psi-dev26.jf.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 14, 2016 at 10:26:21AM -0700, David Cohen wrote:
> Hi,
> 
> On Tue, Jun 14, 2016 at 07:07:14PM +0300, Andy Shevchenko wrote:
> > On Tue, 2016-06-14 at 17:58 +0200, Ingo Molnar wrote:
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > On Tue, 2016-06-14 at 17:29 +0200, Ingo Molnar wrote:
> > > > 
> > > > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > > > 
> > > > > > On Tue, 2016-06-14 at 12:43 +0200, Ingo Molnar wrote:
> > > > > > In the TRM it's called Power Management Unit, though once or
> > > > > > twice
> > > > > > in some 
> > > > > > documents as Power Management Controller. I actually woudn't
> > > > > > like to
> > > > > > use PMC 
> > > > > > abbreviation to not be confused with pmc_atom.c and many other
> > > > > > variation of 
> > > > > > existing PMC drivers of other Intel platforms.
> > > > > > 
> > > > > > PM* as a prefix might be too short to conflict with Power
> > > > > > Management
> > > > > > framework 
> > > > > > in the kernel. P-Unit (punit*) is existing part in SoC which
> > > > > > will
> > > > > > have its own 
> > > > > > driver in the future, so, can't use it either.
> > > > > > 
> > > > > > pwr*, pwrmu*, scpmu* (as of South Complex Power Management Unit)
> > > > > > —
> > > > > > one of them?
> > > > > 
> > > > > 'pwr' certainly sounds good to me! PWMU perhaps?
> > > > 
> > > > Wouldn't be a bit confusing with pwm? I would stay at 'pwr'.
> > > 
> > > Yeah, indeed - so pwr it is?
> > 
> > Yes. Will rename in this way, re-test and re-send.
> 
> I'm curious about that. What pmu prefix would stand for?

Nevermind :)
I'd vote for pwmu, as it would make more sense WRT the hw
documentation.

Br, David

> 
> Br, David
