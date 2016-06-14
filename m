Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1465926480.30123.92.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] x86/platform/intel-mid: Add Power Management
 Unit driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 14 Jun 2016 20:48:00 +0300
In-Reply-To: <20160614173743.GB16566@psi-dev26.jf.intel.com>
References: <1465849087-54528-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1465919118.30123.73.camel@linux.intel.com>
 <20160614155835.GA29820@gmail.com>
 <1465920434.30123.87.camel@linux.intel.com>
 <20160614172621.GA16566@psi-dev26.jf.intel.com>
	 <20160614173743.GB16566@psi-dev26.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-06-14 at 10:37 -0700, David Cohen wrote:
> On Tue, Jun 14, 2016 at 10:26:21AM -0700, David Cohen wrote:
> > Hi,
> > 
> > 
> > > > > > > pwr*, pwrmu*, scpmu* (as of South Complex Power Management
> > > > > > > Unit)
> > > > > > > —
> > > > > > > one of them?
> > > > > > 
> > > > > > 'pwr' certainly sounds good to me! PWMU perhaps?
> > > > > 


> > > > > Wouldn't be a bit confusing with pwm? I would stay at 'pwr'.

^^^ (1)

> > > > 
> > > > Yeah, indeed - so pwr it is?
> > > 
> > > Yes. Will rename in this way, re-test and re-send.
> > 
> > I'm curious about that. What pmu prefix would stand for?
> 
> Nevermind :)
> I'd vote for pwmu, as it would make more sense WRT the hw
> documentation.

What about (1)?
Currently I renamed everything to pwr and it looks good.

-- 

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
