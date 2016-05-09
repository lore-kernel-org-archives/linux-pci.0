Return-Path: <jonathan.yong@intel.com>
Return-Path: <jonathan.yong@intel.com>
Message-ID: <572FFFD8.30709@intel.com>
Date: Mon, 09 May 2016 11:11:20 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
References: <1461047358-4736-1-git-send-email-jonathan.yong@intel.com> <1461047358-4736-2-git-send-email-jonathan.yong@intel.com> <20160508023821.GA13531@localhost>
In-Reply-To: <20160508023821.GA13531@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 05/08/2016 10:38, Bjorn Helgaas wrote:
> On Tue, Apr 19, 2016 at 06:29:18AM +0000, Yong, Jonathan wrote:
>> Simplified Precision Time Measurement driver, activates PTM feature
>> if a PCIe PTM requester (as per PCI Express 3.1 Base Specification
>> section 7.32)is found, but not before checking if the rest of the
>> PCI hierarchy can support it.
>>
>> The driver does not take part in facilitating PTM conversations,
>> neither does it provide any useful services, it is only responsible
>> for setting up the required configuration space bits.
>>
>> As of writing, there aren't any PTM capable devices on the market
>> yet, but it is supported by the Intel Apollo Lake platform.
>
> Can you also add lspci support for the PTM capability?  That will help
> debugging.
>
> Bjorn
>

Do I also send it to this list? Or directly to Martin?

As for the kernel code side, still cleaning things up.
