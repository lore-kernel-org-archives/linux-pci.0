Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 14 May 2012 23:53:58 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Bjorn Helgaas <bhelgaas@google.com>
cc: Myron Stowe <mstowe@redhat.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org
Subject: Re: x86: runtime waring in pcibios_fwaddrmap_lookup
In-Reply-To: <20120514202147.GA20652@google.com>
Message-ID: <alpine.SOC.1.00.1205142353430.20118@math.ut.ee>
References: <alpine.SOC.1.00.1204122238400.16365@math.ut.ee> <CAErSpo6YnzywdjTTVdVEHj_E-B0ARBpZ+fiy29Rv==fO6m9-FA@mail.gmail.com> <1335557685.2386.62.camel@zim.stowe> <alpine.SOC.1.00.1204280819270.14507@math.ut.ee> <1335905694.2386.138.camel@zim.stowe>
 <1336430699.2427.117.camel@zim.stowe> <alpine.SOC.1.00.1205131811590.7097@math.ut.ee> <20120514202147.GA20652@google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > > > Thanks for the quick response Meelis (unlike myself; I've been consumed
> > > > with a hard deadline task recently - sorry).
> > 
> > Not so quick this time - I had to replace the HDD and then recreate the 
> > failing config. Took 2.4-rc7 as a base. This gives us another data point 
> > - it does not warn on SMP but warns only on UP.
> 
> I think that's the critical point; thanks for mentioning it :)
> 
> The following patch should fix it.  Can you confirm?

Yes, that fixes it, thanks!

-- 
Meelis Roos (mroos@linux.ee)
