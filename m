Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 30 Apr 2018 12:15:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        gregkh@linuxfoundation.org, fred@fredlawl.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, keith.busch@intel.com
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
Message-ID: <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
 <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
 <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 28, 2018 at 12:07:48PM -0500, Alex G. wrote:
> On 04/28/2018 11:46 AM, Alex G. wrote:
> > On 04/27/2018 05:43 PM, Bjorn Helgaas wrote:
> > > On Tue, Apr 17, 2018 at 12:09:43PM -0500, Alexandru Gagniuc wrote:
> (snip)
> > > > +    memset(&info, 0, sizeof(info));
> > > > +    info.severity = aer_severity;
> > > > +    info.status = status;
> > > > +    info.mask = mask;
> > > > +    info.first_error = 0x1f;
> > > 
> > > I like this patch a lot, but where does this "first_error = 0x1f" come
> > > from?
> > 
> > aer_(un)correctable_error_string don't go to [0x1f], so this guarantees
> > us we don't print "(First)".
> > 
> > > I assume this is supposed to be the "First Error Pointer" in the
> > > Advanced Error Capabilities and Control register (PCIe r4.0, sec
> > > 7.8.4.7).  There is a "cap_control" field in struct
> > > aer_capability_regs; should we be using that here?
> > 
> > There is a way to extract it from the PCI regs, and it's quite simple.
> > IIRC, it should be all f's when the capability is not implemented. I
> > wanted to avoid any further parsing of PCI regs in this patch.
> 
> I could update the offending line to say:
>  +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);

That's what I would have expected.  So I'd say either do this, or add
a comment about why it's not the right thing to do.

> Though I still have the concerns with validating CPER data:
> 
> > I can see a way to use even more common printk code, but that requires
> > validating the PCI regs we get from firmware. That means we need to make
> > a guarantee about CPER that is beyond the scope of this patch.

Sounds like this is material for another patch, but if/when you do
that, I'd like to understand your concern about validating the
registers we get from firmware.  Are you worried about getting
incorrect register contents, then printing the wrong info, making
the wrong decision about how to recover, something else?

Bjorn
