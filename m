Return-Path: <SRS0=Gq9p=HF=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=Gq9p=HF=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v13 0/6] Address error and recovery for AER and DPC
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
 Timur Tabi <timur@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
 <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5b4e667f-bead-a007-78dd-e42d3194f232@codeaurora.org>
Date: Sun, 15 Apr 2018 23:53:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180416031600.GB80087@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 4/15/2018 11:16 PM, Bjorn Helgaas wrote:
> On Mon, Apr 09, 2018 at 10:41:48AM -0400, Oza Pawandeep wrote:
>> This patch set brings in error handling support for DPC
>>
>> The current implementation of AER and error message broadcasting to the
>> EP driver is tightly coupled and limited to AER service driver.
>> It is important to factor out broadcasting and other link handling
>> callbacks. So that not only when AER gets triggered, but also when DPC get
>> triggered (for e.g. ERR_FATAL), callbacks are handled appropriately.
>>
>> DPC should behave identical to AER as far as error handling is concerned.
>> DPC should remove the devices and not to do recovery for hotplug enabled system.
> 
> Is there a specific bug that's fixed by these patches?  I didn't see
> one mentioned in the changelogs.
> 

There is no actual bug. 

We realized that DPC and hotplug is heavily integrated today. We have use
cases for systems without hotplug support but still support DPC. That's the
problem we are trying to solve with this patchset.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
