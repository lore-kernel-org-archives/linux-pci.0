Return-Path: <SRS0=cWmm=HU=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=cWmm=HU=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 01 May 2018 15:30:57 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>, Keith
 Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v14 0/9] Address error and recovery for AER and DPC
In-Reply-To: <20180430224002.GI95643@bhelgaas-glaptop.roam.corp.google.com>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
 <f97676e307fe7a02f1f2059a140a5e32@codeaurora.org>
 <20180430224002.GI95643@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <42d49b12f1465d6d6c2fdfd182031881@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-01 04:10, Bjorn Helgaas wrote:
> On Thu, Apr 26, 2018 at 11:00:52AM +0530, poza@codeaurora.org wrote:
>> On 2018-04-23 20:53, Oza Pawandeep wrote:
>> > This patch set brings in error handling support for DPC
>> >
>> > The current implementation of AER and error message broadcasting to the
>> > EP driver is tightly coupled and limited to AER service driver.
>> > It is important to factor out broadcasting and other link handling
>> > callbacks. So that not only when AER gets triggered, but also when DPC
>> > get
>> > triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>> >
>> > The goal of the patch-set is:
>> > DPC should handle the error handling and recovery similar to AER,
>> > because
>> > finally both are attempting recovery in some or the other way,
>> > and for that error handling and recovery framework has to be loosely
>> > coupled.
>> > ...
> 
>> Hi Bjorn,
>> 
>> I know I need to rebase this whole patch-set to 4.17 now.
>> 
>> But before I do that, can you please help to comment.
> 
> My overall comment is that I think the series will be simpler and read
> better if you first change AER to do remove/re-enumerate, before doing
> anything with DPC.
> 
> This could be done by extracting just the AER part of "PCI/AER/DPC:
> Align FATAL error handling for AER and DPC" (i.e., adding
> pcie_do_fatal_recovery()) and moving that to be the very first patch.
> 
> It's a small change in terms of code size, but significant to drivers,
> and it's really the core of the series, so it would be good to clearly
> establish the policy of:
> 
>   ERR_NONFATAL => call driver recovery entry points
>   ERR_FATAL    => remove and re-enumerate
> 
> before bringing DPC into the picture.
> 
> Then the subsequent patches would all be more or less mechanical
> changes to make DPC follow the same model.

ok I have taken care of you comment, please follow v15, coming next.
I could not make that the first patch, because I needed to unify 
pci_wait_for_link function.
hence it is the second patch, but now the order looks quiet obvious and 
simplified.

Regards,
Oza.

> 
> Bjorn
