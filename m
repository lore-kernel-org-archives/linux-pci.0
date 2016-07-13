Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:39537 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbcGMXyZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2016 19:54:25 -0400
Subject: Re: [PATCH] bindings: PCI: artpec: correct pci binding example
To: Arnd Bergmann <arnd@arndb.de>
References: <1467934090-12834-1-git-send-email-niklass@axis.com>
 <1838529.X3K6mcn6MA@wuerfel>
CC: <bhelgaas@google.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
From: Niklas Cassel <niklas.cassel@axis.com>
Message-ID: <1336f919-e145-7875-9204-c1fc124fb9fe@axis.com>
Date: Thu, 14 Jul 2016 01:54:20 +0200
MIME-Version: 1.0
In-Reply-To: <1838529.X3K6mcn6MA@wuerfel>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/08/2016 11:39 AM, Arnd Bergmann wrote:
> On Friday, July 8, 2016 1:28:10 AM CEST Niklas Cassel wrote:
>> From: Niklas Cassel <niklas.cassel@axis.com>
>>
>>  - Increase config size. When using a PCIe switch,
>>    the previous config size only had room for one device.
>>  - Add bus range. Inherited optional property.
>>  - Map downstream I/O to PCI address 0. We can map it to any
>>    address, but let's be consistent with other drivers.
>>
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>> ---
>>  Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>> index 330a45b..5ecaea1 100644
>> --- a/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt
>> @@ -24,16 +24,17 @@ Example:
>>  		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
>>  		reg = <0xf8050000 0x2000
>>  		       0xf8040000 0x1000
>> -		       0xc0000000 0x1000>;
>> +		       0xc0000000 0x2000>;
> If this is your config space size
>
>>  		num-lanes = <2>;
>> +		bus-range = <0x00 0xff>;
> then the bus range looks too large. These two are typically connected.
> I couldn't immediately see which config space access function is
> used, but if you have 0x1000 bytes per bus, then the bus range matching
> a 0x2000 byte config space would be either <0x00 0x01> or <0x00 0x02>
> depending whether the root bus is part of that range.

I see your point, a config space size of 0x2000 is only enough to
hold two configuration space headers.

However, all other PCIe controllers based on Synopsys DesignWare IP
with a config space size of 0x2000, uses a bus-range of 0x0-0xff.
(Except hisilicon which for some reason uses 0x0-0xf).
Isn't it better to be consistent with the other DesignWare based controllers?

Also, isn't is possible to have a device behind bus 1, then nothing behind
bus 2, and then a device behind bus 3?
Not sure if this could actually happen though, since Linux appears to assign
the bus numbers, unless already defined by BIOS.
