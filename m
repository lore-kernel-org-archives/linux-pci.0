Return-Path: <SRS0=CQSM=EM=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=CQSM=EM=intel.com=keith.busch@kernel.org>
Date: Tue, 16 Jan 2018 18:34:34 -0700
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maik Broemme <mbroemme@libmpq.org>,
	Pawandeep Oza <poza@codeaurora.org>
Subject: Re: [PATCH 4/4] PCI/DPC: Print AER status in DPC event handling
Message-ID: <20180117013434.GC6259@localhost.localdomain>
References: <20171219210643.24615-1-keith.busch@intel.com>
 <20171219210643.24615-4-keith.busch@intel.com>
 <35445e86-e7b6-3fed-f26a-954a0f8d5e8a@codeaurora.org>
 <20171221051256.GA15276@localhost.localdomain>
 <ea609f8a-1d79-c2fe-e9e5-5993e418f9cc@codeaurora.org>
 <20180116024740.GA32639@localhost.localdomain>
 <20180117005559.GF10860@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117005559.GF10860@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 16, 2018 at 06:56:00PM -0600, Bjorn Helgaas wrote:
> On Mon, Jan 15, 2018 at 07:47:41PM -0700, Keith Busch wrote:
> > On Wed, Jan 10, 2018 at 10:52:23AM -0500, Sinan Kaya wrote:
> > > Since the AER status is set when we observe DPC event and nobody
> > > is clearing these we won't observe another DPC event until
> > > somebody clears these. We can say that we are resetting the
> > > endpoints as part of the DPC but we are not touching the switch
> > > downstream port or the root port registers.
> > > 
> > > Somebody still needs to clear these in addition to printing
> > > whatever information is available in the AER registers.
> > 
> > We should clear the downstream port's AER uncorrectable status
> > register if the trigger reason is of that type, but DPC definitely
> > does not require we clear it in order to observe a new event.
> 
> I don't quite understand this.  We don't need to clear the AER status
> in order to observe a new DPC event, but I think we *do* need to clear
> the AER status in order to log future AER events.  Don't we?

Absolutely, I totally agree on this. I have a v2 ready to send that calls
pci_cleanup_aer_uncorrect_error_status after printing the error. And
I've also made sure to do this only for the appropriate trigger reason
that you mentioned on the other thread.

> I think Sinan is saying that if a DPC Port observes its own unmasked
> uncorrectable error (i.e., not something it learned about by receiving
> an ERR_* message), it will set a bit in an AER status register.
> 
> Since we do not set DPC ERR_COR Enable, the DPC Port does not generate
> an ERR_COR Message, so the AER driver never learns about the error and
> never clears the AER status register.  So we'll decode the AER status
> (with your current patch), but we don't clear it, so if another error
> occurs, the AER logging won't work correctly.
> 
> Maybe we should be setting DPC ERR_COR Enable and letting the AER
> driver decode and clear the AER info?

Yes, enabling ERR_COR should be no problem and will provide those
platform notification benefits.

That alone will not clear the uncorrectable status, though. The AER
driver will only check correctable status registers on that message. The
spec doesn't appear to define what we should find in the downstream
port's correctable status, so I can't tell if that will actually log
new information or if it's simply to assist platform notification that
something happened.

I'll post the v2 for consideration, and inlcude the ERR_COR enabling. This
does clash a bit with Oza's approach, but it should lower churn for the
near term.
