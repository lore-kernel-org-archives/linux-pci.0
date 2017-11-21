Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:24974 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdKUHzG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Nov 2017 02:55:06 -0500
Subject: Re: [PATCH v2 1/2] PCI: designware-ep: Fix find_first_zero_bit()
 usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
References: <20171117150041.30509-1-niklas.cassel@axis.com>
 <20171117150041.30509-2-niklas.cassel@axis.com>
 <20171117184337.GA26321@red-moon>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4376af2c-7e90-f9b4-7f53-65c00de55e90@ti.com>
Date: Tue, 21 Nov 2017 13:24:53 +0530
MIME-Version: 1.0
In-Reply-To: <20171117184337.GA26321@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On Saturday 18 November 2017 12:13 AM, Lorenzo Pieralisi wrote:
> [+Kishon - please CC him next time]
> 
> On Fri, Nov 17, 2017 at 04:00:40PM +0100, Niklas Cassel wrote:
>> find_first_zero_bit()'s parameter 'size' is defined in bits,
>> not in bytes.
>>
>> find_first_zero_bit() was called with size in bytes rather than bits,
>> which thus defined a too low upper limit, causing
>> dw_pcie_ep_inbound_atu() to assign iatu index #4 to both bar 4
>> and bar 5, which made bar 5 overwrite the settings set by bar 4.
>>
>> Fix this by using replacing find_first_zero_bit() with ffz(),
>> since ffz() only works on a single 'unsigned long' and therefore
>> does not need a size argument.
>>
>> Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
>> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
>> ---
>>  drivers/pci/dwc/pcie-designware-ep.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
>> index d53d5f168363..ab9a9e160daf 100644
>> --- a/drivers/pci/dwc/pcie-designware-ep.c
>> +++ b/drivers/pci/dwc/pcie-designware-ep.c
>> @@ -70,8 +70,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
>>  	u32 free_win;
>>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>>  
>> -	free_win = find_first_zero_bit(&ep->ib_window_map,
>> -				       sizeof(ep->ib_window_map));
>> +	free_win = ffz(ep->ib_window_map);
> 
> You fix the bug at hand but code suffers from the same issue since we
> should be checking the value against ~0UL first ie if size in bits <
> num_ib_windows (that I think it is unlikely anyway but while at it let's
> think if we can improve this).
> 
> @Kishon: maybe we should add a static upper size and declare a
> static bitmap accordingly (and still use find_first_zero_bit()) ?
> 
> I think the check against ~0UL should be added anyway, let's get
> Kishon's opinion before a v3 (if any).

Yeah, for both ffz and find_first_zero_bit, the results are undefined if no
zero exists.

I'm thinking if we should just use
find_first_zero_bit(&ep->ib_window_map, ep->num_ib_windows) after checking if
there are some '0' bits left.

Thanks
Kishon
