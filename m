Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0057.outbound.protection.outlook.com ([157.56.111.57]:63776
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751904AbbIOSDI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Sep 2015 14:03:08 -0400
Message-ID: <55F85D4E.9020604@caviumnetworks.com>
Date: Tue, 15 Sep 2015 11:02:54 -0700
From: David Daney <ddaney@caviumnetworks.com>
MIME-Version: 1.0
To: Will Deacon <will.deacon@arm.com>
CC: David Daney <ddaney.cavm@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Daney <david.daney@cavium.com>,
	<lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 4/6] PCI: generic: Correct, and avoid overflow, in bus_max
 calculation.
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com> <1442013719-5001-5-git-send-email-ddaney.cavm@gmail.com> <20150915174934.GL31157@arm.com>
In-Reply-To: <20150915174934.GL31157@arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/15/2015 10:49 AM, Will Deacon wrote:
> On Sat, Sep 12, 2015 at 12:21:57AM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> There are two problems with the bus_max calculation:
>>
>> 1) The u8 data type can overflow for large config space windows.
>>
>> 2) The calculation is incorrect for a bus range that doesn't start at
>>     zero.
>>
>> Since the configuration space is relative to bus zero, make bus_max
>> just be the size of the config window scaled by bus_shift.  Then clamp
>> it to a maximum of 255, per PCI.  Use a data type of int to avoid
>> overflow problems.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> ---
>>   drivers/pci/host/pci-host-generic.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
>> index cd6f898..fce5bf7 100644
>> --- a/drivers/pci/host/pci-host-generic.c
>> +++ b/drivers/pci/host/pci-host-generic.c
>> @@ -164,7 +164,7 @@ out_release_res:
>>   static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>>   {
>>   	int err;
>> -	u8 bus_max;
>> +	int bus_max;
>>   	resource_size_t busn;
>>   	struct resource *bus_range;
>>   	struct device *dev = pci->host.dev.parent;
>> @@ -177,8 +177,9 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>>   	}
>>
>>   	/* Limit the bus-range to fit within reg */
>> -	bus_max = pci->cfg.bus_range->start +
>> -		  (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
>> +	bus_max = (resource_size(&pci->cfg.res) >> pci->cfg.ops.bus_shift) - 1;
>> +	if (bus_max > 255)
>> +		bus_max = 255;
>>   	pci->cfg.bus_range->end = min_t(resource_size_t,
>>   					pci->cfg.bus_range->end, bus_max);
>
> Hmm, this is changing the meaning of the bus-range property in the
> device-tree, which really needs to match what IEEE Std 1275-1994 requires.

I doesn't change the bus-range.

>
> My understanding was that the bus-range could be used to offset the config
> space, which is why it's subtracted from the bus number in
> gen_pci_map_cfg_bus_[e]cam.

There is an inconsistency in the current code.  The calculation of the 
cfg.win[?] pointers is done such that the beginning of the config space 
specified in the "reg" property corresponds to bus 0.

The calculation that I am changing, was done such that the beginning of 
the config space specified in the "reg" property corresponds to the 
first bus of the "bus-range"

Which is correct?  I assumed that the config space specified in the 
"reg" property corresponds to bus 0.  Based on this assumption, I made 
the bus_max calculation match.

Due to hardware peculiarities, our bus-range starts at a non-zero bus 
number.  So, something has to be done to make all the code agree on a 
single interpretation of the meaning "reg" property.

> Also, why is your config space so large that
> we end up overflowing bus_max?

It isn't.  The part of the patch that changes the type from u8 to int 
was just to add some sanity.  The  code was easily susceptible to 
overflow failures, it seemed best to change to int.


David Daney

