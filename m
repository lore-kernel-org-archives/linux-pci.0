Return-Path: <SRS0=Cik3=HJ=intel.com=dennis.dalessandro@kernel.org>
Return-Path: <SRS0=Cik3=HJ=intel.com=dennis.dalessandro@kernel.org>
Subject: Re: [PATCH v3 0/2] IB/hfi1: Cleanup PCIe link configuration
To: Bjorn Helgaas <helgaas@kernel.org>,
 "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Frederick Lawler <fred@fredlawl.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dledford@redhat.com" <dledford@redhat.com>,
 "jgg@mellanox.com" <jgg@mellanox.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180417002825.2737-1-fred@fredlawl.com>
 <20180417065343.GA29193@infradead.org>
 <32E1700B9017364D9B60AED9960492BC627FF54C@fmsmsx120.amr.corp.intel.com>
 <20180417171956.GJ28657@bhelgaas-glaptop.roam.corp.google.com>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <7dfe3365-8a88-fb4f-4f67-a15a4560694c@intel.com>
Date: Fri, 20 Apr 2018 13:03:42 -0400
MIME-Version: 1.0
In-Reply-To: <20180417171956.GJ28657@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 4/17/2018 1:19 PM, Bjorn Helgaas wrote:
> On Tue, Apr 17, 2018 at 03:56:13PM +0000, Marciniszyn, Mike wrote:
>>>
>>> Btw, why is the driver configuring the PCIe link speed?  Isn't this
>>> something we should be handling in the PCI core?
>>
>> The device comes out of reset at the 5GT/s speed. The driver
>> downloads device firmware, programs PCIe registers, and co-ordinates
>> the transition to 8GT/s.
>>
>> This recipe is device specific and is therefore implemented in the
>> hfi1 driver built on top of PCI core functions and macros.
> 
> Do you think this behavior conforms to the spec, or is this a
> workaround for a hardware erratum?

Can't speculate as to why, but this is just the way this hardware works.

> I don't think it's feasible to have every driver deal with this level
> of PCIe detail.  Do you have to do something similar in the Windows
> driver?

No Windows driver.

> Is there something we can do in the PCI core to do the
> reconfiguration?  If you can't go to 8GT/s before doing some
> device-specific initialization, could the driver do that setup and
> then use a generic PCI core interface to reconfigure the link?
> 
> Or maybe if the driver finds the device at 5GT/s, it could download
> the firmware and reset the device.  Would the device then negotiate at
> 8GT/s?

Yes. In fact this is what we should be doing. We use the SBR to trigger 
renegotiation of the link to 8GT/s.

-Denny
