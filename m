Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:55248 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbcCOLdd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2016 07:33:33 -0400
Subject: Re: Request for Info: Designware PCIe Root Complex support in ARM64
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <helgaas@kernel.org>
References: <56E2ACF8.6030503@synopsys.com> <20160311194600.GA16257@localhost>
 <20160314121538.GB6629@red-moon>
CC: Joao Pinto <Joao.Pinto@synopsys.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>, <catalin.marinas@arm.com>,
	<linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56E7F308.2020907@synopsys.com>
Date: Tue, 15 Mar 2016 11:33:28 +0000
MIME-Version: 1.0
In-Reply-To: <20160314121538.GB6629@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi!
Just built the linux-next for ARM64 and built beautifully so there is no issue.
I was having an issue using 3.18, but with this new kernel no issues were found.
Thanks for all your inputs!

Joao


On 3/14/2016 12:15 PM, Lorenzo Pieralisi wrote:
> On Fri, Mar 11, 2016 at 01:46:00PM -0600, Bjorn Helgaas wrote:
>> [+cc Lorenzo]
>>
>> On Fri, Mar 11, 2016 at 11:33:12AM +0000, Joao Pinto wrote:
>>> Hi Liviu, Catalin and Bjorn,
>>>
>>> I am currently working on the PCIe Root Complex based on the Designware Core
>>> (/pci/host/pcie-desigware.c). I have noticed that currently building a solution
>>> based on the previous for an ARM64 CPU is problematic and demands some tweaking
>>> in the ARM64 arch (like adding some functions in the pcibios, etc.).
>>
>> If I understand you correctly, you're saying that pcie-designware.c
>> doesn't build on arm64.  It would be helpful to know exactly what
>> problem you're seeing (what kernel version, what config, what the
>> error are, etc.)
> 
> Yes, I am not sure I understand what Joao is referring to so I would
> be grateful if he can provide us with additional details.
> 
> Thanks,
> Lorenzo
> 

