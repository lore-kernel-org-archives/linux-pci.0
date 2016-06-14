Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1465920434.30123.87.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] x86/platform/intel-mid: Add Power Management
 Unit driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	David Cohen <david.a.cohen@linux.intel.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 14 Jun 2016 19:07:14 +0300
In-Reply-To: <20160614155835.GA29820@gmail.com>
References: <1465849087-54528-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1465919118.30123.73.camel@linux.intel.com>
	 <20160614155835.GA29820@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-06-14 at 17:58 +0200, Ingo Molnar wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Tue, 2016-06-14 at 17:29 +0200, Ingo Molnar wrote:
> > 
> > > * Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > On Tue, 2016-06-14 at 12:43 +0200, Ingo Molnar wrote:
> > > > In the TRM it's called Power Management Unit, though once or
> > > > twice
> > > > in some 
> > > > documents as Power Management Controller. I actually woudn't
> > > > like to
> > > > use PMC 
> > > > abbreviation to not be confused with pmc_atom.c and many other
> > > > variation of 
> > > > existing PMC drivers of other Intel platforms.
> > > > 
> > > > PM* as a prefix might be too short to conflict with Power
> > > > Management
> > > > framework 
> > > > in the kernel. P-Unit (punit*) is existing part in SoC which
> > > > will
> > > > have its own 
> > > > driver in the future, so, can't use it either.
> > > > 
> > > > pwr*, pwrmu*, scpmu* (as of South Complex Power Management Unit)
> > > > —
> > > > one of them?
> > > 
> > > 'pwr' certainly sounds good to me! PWMU perhaps?
> > 
> > Wouldn't be a bit confusing with pwm? I would stay at 'pwr'.
> 
> Yeah, indeed - so pwr it is?

Yes. Will rename in this way, re-test and re-send.

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
