Return-Path: <SRS0=ycIr=ZH=redhat.com=prarit@kernel.org>
Return-Path: <SRS0=ycIr=ZH=redhat.com=prarit@kernel.org>
Message-ID: <5888A6C9.6010708@redhat.com>
Date: Wed, 25 Jan 2017 08:23:21 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, alex.williamson@redhat.com, darcari@redhat.com,
        mstowe@redhat.com, bhelgaas@google.com, lukas@wunner.de,
        keith.busch@intel.com, mika.westerberg@linux.intel.com
Subject: Re: [PATCH] pci: Only disable MSI/X and enable INTx if shutdown function
 has been called
References: <1478627867-28795-1-git-send-email-prarit@redhat.com> <20161109170529.GJ14322@bhelgaas-glaptop.roam.corp.google.com> <58541AC6.90900@redhat.com> <20170119143804.GB12124@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170119143804.GB12124@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>



On 01/19/2017 09:38 AM, Bjorn Helgaas wrote:
> On Fri, Dec 16, 2016 at 11:48:06AM -0500, Prarit Bhargava wrote:
>> On 11/09/2016 12:05 PM, Bjorn Helgaas wrote:
>>> Hi Prarit,
>>>
>>> Is there a bugzilla or other archive of configuration/dmesg/other info
>>> related to this problem?  I'd really like to connect this fix to a
>>> problem report, and it would help me review the patch as well.
>>
>> Bjorn, have you had a chance to look at this?
>>
>> I had opened
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=187351
> 
> Hi Prarit,
> 
> Sorry, I've not had a chance to dig into this yet.  What I'd *like* to do
> is figure out what the kexec/kdump/shutdown strategy really is and make
> sure this is all coherent.  It seems like we've gone back and forth on this
> a couple times because this or that is broken, but I don't really
> understand why.
> 

Bjorn,

Let me start from the beginning with a new patch and explanation.  I think
that as time went on, some of the details and explanation were lost ...

I'll post a v2 shortly.

P.
