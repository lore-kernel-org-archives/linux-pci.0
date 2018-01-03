Return-Path: <SRS0=L9eR=D6=codeaurora.org=poza@kernel.org>
Return-Path: <SRS0=L9eR=D6=codeaurora.org=poza@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 03 Jan 2018 11:44:31 +0530
From: poza@codeaurora.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart
 <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>, Keith Busch
 <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>, Sinan Kaya
 <okaya@codeaurora.org>, Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2 0/4] Address error and recovery for AER and DPC
In-Reply-To: <20180102190215.GC6211@bhelgaas-glaptop.roam.corp.google.com>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <20180102190215.GC6211@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <a3b2db25519d3e189cda47e232321ca3@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-03 00:32, Bjorn Helgaas wrote:
> On Fri, Dec 29, 2017 at 12:54:15PM +0530, Oza Pawandeep wrote:
>> This patch set brings in support for DPC and AER to co-exist and not 
>> to
>> race for recovery.
>> 
>> The current implementation of AER and error message broadcasting to 
>> the
>> EP driver is tightly coupled and limited to AER service driver.
>> It is important to factor out broadcasting and other link handling
>> callbacks. So that not only when AER gets triggered, but also when DPC 
>> get
>> triggered, or both get triggered simultaneously (for e.g. ERR_FATAL),
>> callbacks are handled appropriately.
>> having modularized the code, the race between AER and DPC is handled
>> gracefully.
>> for e.g. when DPC is active and kicked in, AER should not attempt to 
>> do
>> recovery, because DPC takes care of it.
> 
> High-level question:
> 
> We have some convoluted code in negotiate_os_control() and
> aer_service_init() that (I think) essentially disables AER unless the
> platform firmware grants us permission to use it.
> 
> The last implementation note in PCIe r3.1, sec 6.2.10 says
> 
>   DPC may be controlled in some configurations by platform firmware
>   and in other configurations by the operating system. DPC
>   functionality is strongly linked with the functionality in Advanced
>   Error Reporting. To avoid conflicts over whether platform firmware
>   or the operating system have control of DPC, it is recommended that
>   platform firmware and operating systems always link the control of
>   DPC to the control of Advanced Error Reporting.
> 
> I read that as suggesting that we should enable DPC support in Linux
> if and only if we also enable AER.  But I don't see anything in DPC
> that looks like that.  Should there be something there?  Should DPC be
> restructured so it's enabled and handled inside the AER driver instead
> of being a separate driver?
> 
> Bjorn

The whole idea of factoring out error handing and plug it back to DPC is 
to
enable DPC is participate synchronously in pcie_port_service_driver 
hooks.

AER and DPC both being port service driver, it makes more sense, for DPC 
to be able
to do with those callbacks as much as AER is able to do with those 
callbacks currently.
but those callbacks are tightly coupled with AER driver.

that way DPC and AER can act independently in their own space, by 
gaining more control.
and if needed, both can synchronize the callbacks.

Regards,
Oza.
