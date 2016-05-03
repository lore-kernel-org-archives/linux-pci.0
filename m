Return-Path: <jonathan.yong@intel.com>
Return-Path: <jonathan.yong@intel.com>
Message-ID: <57286935.3090409@intel.com>
Date: Tue, 03 May 2016 17:02:45 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RFC v4] PCI: PTM Driver
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com> <20160429141750.GB949@localhost>
In-Reply-To: <20160429141750.GB949@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 04/29/2016 22:17, Bjorn Helgaas wrote:
> On Tue, Apr 19, 2016 at 06:29:17AM +0000, Yong, Jonathan wrote:
>> Hello LKML,
>>
>> This is a preliminary implementation of the PTM[1] support driver. This driver
>> has only been tested against a virtual PCI bus since there are no known
>> endpoints utilizing it yet.
>
> What sort of testing is this, exactly?  Is this using a software model
> of devices that support PTM?
>

We wrote another driver to fake the PCI config space with pci_scan_bus, 
with fake switches and fake devices. Convenient since the driver only 
deals with the config space.

> When will hardware that supports PTM be available to you for testing?
> When will it be available on the market?
>

I don't have any dates for when consumer endpoints will hit the market. 
PTM aware FPGA device models might come around Q3/Q4 this year, with 
exercisers around 2017.

> I'm trying to figure out whether there's any benefit to merging
> something before it is useful to anybody.
>

True it won't be useful to anybody until such a device is available. 
What is the general policy for future hardware standards?
