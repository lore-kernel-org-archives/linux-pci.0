Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 6 Nov 2016 18:12:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_state hook
Message-ID: <20161106171217.GA5922@wunner.de>
References: <7c1567d4c49303a4aada94ba16275cbf56b8976b.1477221514.git.lukas@wunner.de>
 <1477226275.2932.54.camel@nexus-software.ie>
 <20161023145757.GA4909@wunner.de>
 <1477300505.6423.41.camel@linux.intel.com>
 <20161024100940.GB5144@wunner.de>
 <1477307145.6423.48.camel@linux.intel.com>
 <20161025061934.GB5630@wunner.de>
 <1477490807.25812.20.camel@nexus-software.ie>
 <1477494063.5295.12.camel@linux.intel.com>
 <92ac10c1-84e4-0e73-a12d-69e66aac9c45@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92ac10c1-84e4-0e73-a12d-69e66aac9c45@leemhuis.info>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Nov 06, 2016 at 02:43:33PM +0100, Thorsten Leemhuis wrote:
> On 26.10.2016 17:01, Andy Shevchenko wrote:
> > On Wed, 2016-10-26 at 15:06 +0100, Bryan O'Donoghue wrote:
> >> So the conclusion is to apply this patch now and go and look further @
> >> locking in a separate series right ? There's not much point in leaving
> >> Edison not booting as is the case with tip-of-tree right now.
> >
> > That's what I think is a summary of the discussion.
> 
> Did anything happen after that conclusion? Just wondering, because this
> bug is on the list of regressions for 4.9 and I think the proposed fix
> hasn't reached mainline yet (or did I miss it?)

The patch still awaits merging through tip.  I assume the x86 maintainers
were traveling (KS, LPC) or generally busy.

Thanks,

Lukas
