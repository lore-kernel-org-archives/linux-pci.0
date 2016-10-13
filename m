Return-Path: <afd@ti.com>
Return-Path: <afd@ti.com>
Subject: Re: [PATCH v2 3/7] PCI: dra7xx: Set drvdata at end of probe function
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20161012133112.27714.93244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161012133258.27714.51056.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <84f6a4b4-d900-844d-545f-cae1aed299e2@ti.com>
 <20161012222142.GA24545@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I
	<kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <a5fdab8f-77a6-35e9-49ce-11d17c218dd9@ti.com>
Date: Thu, 13 Oct 2016 10:24:39 -0500
MIME-Version: 1.0
In-Reply-To: <20161012222142.GA24545@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 10/12/2016 05:21 PM, Bjorn Helgaas wrote:
> On Wed, Oct 12, 2016 at 02:48:02PM -0500, Andrew F. Davis wrote:
>> On 10/12/2016 08:32 AM, Bjorn Helgaas wrote:
>>> Set the drvdata pointer at the end of probe function for consistency with
>>> other drivers. 
>>
>> I've seen it done the current way many places.
>>
>>> We don't need the drvdata until after the probe completes,
>>> and we don't need it at all if the probe fails. 
>>
>> Are you sure this will always be true? Why not set it as soon as we have
>> the ability to, what do we gain by waiting till the end, something like
>> one less instruction in the failure case?
> 
> I don't think it's likely anybody will need it before .probe()
> completes, because the purpose of drvdata is for an external driver
> entry point to locate its device data, and none of those entry points
> will be called until after .probe() completes successfully.
> 
> But I don't care at all if we do it earlier, as long as all the
> drivers do it the same way.
> 

Agree, then the standard needs to be one that will work for everyone, so
setting it early is my preference as some drivers may need to call into
their external entry points during probe to prime them for later calls
or initialization (like a device reset call you want to manually call
the first time during probe).

Andrew
