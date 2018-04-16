Return-Path: <SRS0=UnEt=HF=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=UnEt=HF=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 16 Apr 2018 22:45:19 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Wei
 Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: Re: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled
 system
In-Reply-To: <c236b732-ed65-9f94-7ae5-b1203dff2eb0@codeaurora.org>
References: <20180410210349.GG54986@bhelgaas-glaptop.roam.corp.google.com>
 <13efe2e8-74c8-acb4-ec58-f79b14a1f182@codeaurora.org>
 <20180412140648.GD145698@bhelgaas-glaptop.roam.corp.google.com>
 <ca7e5285-2e88-e130-6402-a271bb92a81e@codeaurora.org>
 <20180412143954.GB4810@localhost.localdomain>
 <20180412150231.GD4810@localhost.localdomain>
 <ea977780-6f90-af5a-442f-575536038307@codeaurora.org>
 <20180412170911.GA6424@localhost.localdomain>
 <fa167b21-f70d-a220-5671-5ad66a0f72c0@codeaurora.org>
 <cced24b5-c0bd-138a-0304-c87cac2ec226@codeaurora.org>
 <20180416031726.GB158153@bhelgaas-glaptop.roam.corp.google.com>
 <c236b732-ed65-9f94-7ae5-b1203dff2eb0@codeaurora.org>
Message-ID: <0bed6fb09478349a95d9f6ad4449f31f@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-04-16 20:16, Sinan Kaya wrote:
> On 4/15/2018 11:17 PM, Bjorn Helgaas wrote:
>> It doesn't seem right to me that we handle both ERR_NONFATAL and
>> ERR_FATAL events differently if we happen to have DPC support in a
>> switch.
>> 
>> Maybe we should consider triggering DPC only on ERR_FATAL?  That would
>> keep DPC out of the ERR_NONFATAL cases.
>> 
> From reliability perspective, it makes sense. DPC handles NONFATAL 
> errors
> by bringing down the link. If error happened behind a switch and root 
> port
> is handling DPC, we are impacting a lot of devices operation because of 
> one
> faulty device.
> 
> Keith, do you have any preference on this direction?
> 
>> For ERR_FATAL, maybe we should bite the bullet and use
>> remove/re-enumerate for AER as well as for DPC.  That would be painful
>> for higher-level software, but if we're willing to accept that pain
>> for new systems that support DPC, maybe life would be better overall
>> if it worked the same way on systems without DPC?
> 
> Sure, we can go to this route as well.


ok so finally this is what is being proposed and so far Bjorn, Sinan and 
myself agreed on following:

I need to move the stop and re-enumerate code into the AER path instead 
of patch #6 for both DPC_FATAL and AER_FATAL error types.
Also, I should turn off DPC NON_FATAL error detection.

Keith, please confirm if you are okay with above proposal.

Regards,
Oza.
