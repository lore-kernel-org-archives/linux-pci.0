Return-Path: <SRS0=6zic=LD=oracle.com=thomas.tai@kernel.org>
Return-Path: <SRS0=6zic=LD=oracle.com=thomas.tai@kernel.org>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, poza@codeaurora.org,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@kernel.org>, bhelgaas@google.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-pci-owner@vger.kernel.org,
        Sam Bobroff <sam.bobroff@au1.ibm.com>
References: <b0104a716319d76e734c307cb4bedd9d@codeaurora.org>
 <903394c04d6ad468ed06dc0a779200e7555345a7.camel@kernel.crashing.org>
 <6cb069038530757f31f3dd60328c7e30@codeaurora.org>
 <e931bc7a7e468e8bb2ee3766b3fcf96f1800f552.camel@kernel.crashing.org>
 <bf7ceabb6fe51398e0f4eebd9c4fe4ac1ec2b8a4.camel@kernel.crashing.org>
 <42bd39aef30fe24bfc48d378e1f5d35d@codeaurora.org>
 <54d19e0e3d44bedf247853144c6bbfed5561a125.camel@kernel.crashing.org>
 <f022581a9ecb88e5501a09bdcdc62954@codeaurora.org>
 <1d5b1157-2f78-5fab-78f0-5828892fc739@kernel.org>
 <c7b996e0856cbea16cbb94287225bf2083158f02.camel@kernel.crashing.org>
 <20180819022402.GF128050@bhelgaas-glaptop.roam.corp.google.com>
 <6f0b939604aa10e9de2a6bd7fed76ce5@codeaurora.org>
 <6435dd654f4e98f311a0544e1ff7b608aa2a4f4c.camel@kernel.crashing.org>
From: Thomas Tai <thomas.tai@oracle.com>
Message-ID: <b3a3d1a2-567e-8d48-8628-f58e88dd78f6@oracle.com>
Date: Mon, 20 Aug 2018 09:02:43 -0400
MIME-Version: 1.0
In-Reply-To: <6435dd654f4e98f311a0544e1ff7b608aa2a4f4c.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>



On 08/20/2018 01:15 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2018-08-20 at 10:39 +0530, poza@codeaurora.org wrote:
>> On 2018-08-19 07:54, Bjorn Helgaas wrote:
>>> On Fri, Aug 17, 2018 at 09:27:03AM +1000, Benjamin Herrenschmidt wrote:
>>>> On Thu, 2018-08-16 at 09:46 -0400, Sinan Kaya wrote:
>>>>> On 8/16/2018 4:22 AM, poza@codeaurora.org wrote:
>>>>>> we can catch up on webex, (Sinan is going to be there in Plumber's
>>>>>> conference, I might not be able to join there, as we have bring-up coming)
>>>>>
>>>>> My plumbers conference attendance is not confirmed yet. I'm trying to
>>>>> combine it with a business trip. I did not get an ACK yet from my boss.
>>>>
>>>> Ok, I'll collect the names and will propose a time/date early next
>>>> week, I'm a bit caught up until monday.
>>>>
>>>> Bjorn, are you available as well ?
>>>
>>> I'm in CDT (UTC-5).  Possible times for me are 6am-10pm CDT.
>>
>> I am in India timezone.
> 
> Hrm ... this is going to be difficult to reconcile. Let's first see
> what we can do by email this week shall we ?

OK, I will catch up on email to see the details. I suppose I should hold 
off the original patch to fix the "prevent pcie_do_fatal_recovery from 
using device after it is removed" patch, right?

Thank you,
Thomas

> 
> Cheers,
> Ben.
> 
> 
