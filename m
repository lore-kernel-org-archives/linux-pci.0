Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI/DPC/AER: Address Concurrency between AER and
 DPC
To: Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Wei Zhang <wzhang@fb.com>, Timur Tabi <timur@codeaurora.org>
References: <1514532259-19383-1-git-send-email-poza@codeaurora.org>
 <1514532259-19383-3-git-send-email-poza@codeaurora.org>
 <20171229172324.GF16407@localhost.localdomain>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5e9ffecf-2da7-0014-9a62-e2ae10323ce3@codeaurora.org>
Date: Tue, 2 Jan 2018 08:25:08 -0500
MIME-Version: 1.0
In-Reply-To: <20171229172324.GF16407@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On 12/29/2017 12:23 PM, Keith Busch wrote:
> On Fri, Dec 29, 2017 at 12:54:17PM +0530, Oza Pawandeep wrote:
>> This patch addresses the race condition between AER and DPC for recovery.
>>
>> Current DPC driver does not do recovery, e.g. calling end-point's driver's
>> callbacks, which sanitize the device.
>> DPC driver implements link_reset callback, and calls pci_do_recovery.
> 
> I'm not sure I see why any of this is necessary for two reasons:
> 
> 1. A downstream port containment event disables the link. How can a driver
> sanitize an end device when all the end devices below the containment are
> physically inaccessible? Any attempt to access such devices will just
> end with either CA or UR (depending on DPC control settings). Since we
> already know the failed outcome from attempting to access such devices,
> why do you want the drivers to do anything?

The reset callback to the endpoint driver has a status field indicating
whether the IO is frozen or not. If IO is not frozen, an endpoint driver
can potentially recover from the error by reissuing the failed request. 

If IO is frozen, then the endpoint driver needs to clean up outstanding
resources. It is not safe to just shutdown the driver while there are
transactions in flight. This is the reason for the status field and a
chance for driver to clean up any state machines and resources. 

Also note that the error callback has a result return value. An endpoint
driver indicates whether it was successful on recovering or not.


> 
> 2. A DPC event suppresses the error message required for the Linux
> AER driver to run. How can AER and DPC run concurrently?
> 

As we briefly discussed in previous email exchanges, I think you are
looking at a use case with a switch that supports DPC functionality. 

Oza and I are looking at a root port functionality with DPC feature. 

As you already know, AER errors are logged to AER capability register
independent of the DPC driver presence.

A root port is also allowed to share the MSI interrupts across DPC and
AER. 

Therefore, when a DPC interrupt fires; both AER driver and DPC driver
starts recovery work. This is the issue we are trying to deal with. 

In the end, the driver needs to work for both root port and switches.
I think you verified it against a switch. We are doing the same for a
root port and submitting the plumbing code. 

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
