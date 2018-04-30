Return-Path: <SRS0=e93+=HT=gmail.com=mr.nuke.me@kernel.org>
Return-Path: <SRS0=e93+=HT=gmail.com=mr.nuke.me@kernel.org>
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, fred@fredlawl.com, linux-kernel@vger.kernel.org,
 alex_gagniuc@dellteam.com, austin_bolen@dell.com, keith.busch@intel.com
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
 <20180427224337.GC73256@bhelgaas-glaptop.roam.corp.google.com>
 <12343e44-2d8a-51e1-a0be-e6804e9bd8a3@gmail.com>
 <220bb125-b933-abf3-7b30-63446634e8d6@gmail.com>
 <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <8e8a8de1-a90c-ab88-c8ac-bbe8bcc7d49c@gmail.com>
Date: Mon, 30 Apr 2018 12:41:26 -0500
MIME-Version: 1.0
In-Reply-To: <20180430171531.GB95643@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>



On 04/30/2018 12:15 PM, Bjorn Helgaas wrote:
> On Sat, Apr 28, 2018 at 12:07:48PM -0500, Alex G. wrote:

(snip)
>> I could update the offending line to say:
>>  +	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> 
> That's what I would have expected.  So I'd say either do this, or add
> a comment about why it's not the right thing to do.

Okay.

>> Though I still have the concerns with validating CPER data:
>>
>>> I can see a way to use even more common printk code, but that requires
>>> validating the PCI regs we get from firmware. That means we need to make
>>> a guarantee about CPER that is beyond the scope of this patch.
> 
> Sounds like this is material for another patch, but if/when you do
> that, I'd like to understand your concern about validating the
> registers we get from firmware.  Are you worried about getting
> incorrect register contents, then printing the wrong info, making
> the wrong decision about how to recover, something else?

I don't trust firmware, and I have daymares about firmware leaving these
fields uninitialized. In jargon, I'd like to treat it as external
untrusted serialized data.

Alex
