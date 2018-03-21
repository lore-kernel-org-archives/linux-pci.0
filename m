Return-Path: <SRS0=oXy1=GL=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=oXy1=GL=intel.com=keith.busch@kernel.org>
Date: Wed, 21 Mar 2018 16:27:20 -0600
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maik Broemme <mbroemme@libmpq.org>
Subject: Re: [PATCH 1/4] PCI/AER: Return approrpiate value when AER is not
 supported
Message-ID: <20180321222720.GJ12909@localhost.localdomain>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20180320230201.GC137590@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320230201.GC137590@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 20, 2018 at 04:02:01PM -0700, Bjorn Helgaas wrote:
> On Tue, Dec 19, 2017 at 02:06:40PM -0700, Keith Busch wrote:
> > Getting the AER information is documented to return 0 when it failed to
> > get the information.
> > 
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> 
> Keith, I'm sorry, but I lost track of where we're at with this series.
> Can you repost a fresh version if it's still applicable?
> 
> Don't worry about rebasing it to anything other than v4.16-rc1 (my
> "master" branch).  I might have added some conflicting things, but
> I'll take care of resolving any conflicts.

No problem, I think this is still applicable, and can be done without
conflicting with what Oza and Sinan are working on (it took a few tries,
but it finally clicked for me on how that works).

I'll rebase a new series and should have it posted by end of week.

Thanks,
Keith
