Return-Path: <SRS0=J3+B=LD=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=J3+B=LD=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 20 Aug 2018 10:49:46 +0530
From: poza@codeaurora.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Tai <thomas.tai@oracle.com>, bhelgaas@google.com,
 keith.busch@intel.com, linux-pci@vger.kernel.org,
 linux-pci-owner@vger.kernel.org, Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
In-Reply-To: <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
References: <1534179088-44219-1-git-send-email-thomas.tai@oracle.com>
 <1534179088-44219-2-git-send-email-thomas.tai@oracle.com>
 <51f4b387d9bd96a42d526a6a029fc43b@codeaurora.org>
 <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <20180819021922.GE128050@bhelgaas-glaptop.roam.corp.google.com>
 <fe891b63-12c7-61ab-a59a-ae24ad766754@kernel.org>
 <ab5cb5b277f1c1c1362ef597ca7b8c6a2cd32cdf.camel@kernel.crashing.org>
Message-ID: <908ff33ded8f31830f95a8889d8540f1@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-20 07:33, Benjamin Herrenschmidt wrote:
> On Sun, 2018-08-19 at 17:41 -0400, Sinan Kaya wrote:
>> On 8/18/2018 10:19 PM, Bjorn Helgaas wrote:
>> > > Bjorn, please revert all of those changes.
>> >
>> > Please send the appropriate patches and we'll go from there.
>> >
>> 
>> I'm also catching up on this thread.
>> 
>> I don't think revert is the way to go. There is certainly value in 
>> Oza's
>> code to make error handling common.
> 
> The revert of the Documentation change must happen though. It's
> completely wrong. The documentation documents what EEH implements so by
> making it match what I argue is a broken implementation in AER, you are
> in fact breaking us.
> 
>> We started by following the existing error handling scheme and then
>> moved onto the stop/remove behavior based on Bjorn's feedback.
> 
> Whish is utterly wrong.
> 
>> The right thing is for Oza to rework the code to go back to original
>> error handling callback mechanism. That should be a trivial change.
> 
> At this stage I'm only asking to revert the documentation updatgae.
> I'll send a patch to that effect.
> 
> As for figuring out where to go from there, I agree we should discuss
> this further, I would love to be able to make more of the code common
> with EEH as well.
> 
> Cheers,
> Ben.


Reverting spec/Documentation which is fine by me.

But the good thing has happened now is; we can have very clear 
definition for the framework to go forward.
e.g. how the errors have to be handled.

Because of those patches, the whole error framework is under common code 
base and now has become independent of service e.g. AER, DPC etc..
That enables us to define or extend policies in more clearly defined way 
irrespective of what services are running.

Now it is just that we have to change in err.c and walk away with the 
policies what we want to enforce.

let me know how this sounds Ben.

Regards,
Oza.
