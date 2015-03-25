Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:44803 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751874AbbCYGNl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2015 02:13:41 -0400
Message-ID: <5512520C.9030407@renesas.com>
Date: Wed, 25 Mar 2015 15:13:32 +0900
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <phil.edworthy@renesas.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: rcar: Add PCIE_CONF_REGNO macro for PCIECAR register
References: <1426047830-26410-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com> <20150320224446.GO26935@google.com>
In-Reply-To: <20150320224446.GO26935@google.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thanks for your review.

(2015/03/21 7:44), Bjorn Helgaas wrote:
> On Wed, Mar 11, 2015 at 01:23:50PM +0900, Nobuhiro Iwamatsu wrote:
>> The reg variable used when setting PCIECAR register need to be masked by 0xFC
>> by restriction of the corresponding register.
>> This adds PCIE_CONF_REGNO are macros for masking changes that PCIE_CONF_REGNO
>> is used when setting PCIECAR register.
>>
>> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>>   drivers/pci/host/pcie-rcar.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
>> index c57bd0a..1f493ef 100644
>> --- a/drivers/pci/host/pcie-rcar.c
>> +++ b/drivers/pci/host/pcie-rcar.c
>> @@ -104,6 +104,7 @@
>>   #define  PCIE_CONF_BUS(b)	(((b)&  0xff)<<  24)
>>   #define  PCIE_CONF_DEV(d)	(((d)&  0x1f)<<  19)
>>   #define  PCIE_CONF_FUNC(f)	(((f)&  0x7)<<  16)
>> +#define  PCIE_CONF_REGNO(r)	(r&  0xfc)
>>
>>   #define RCAR_PCI_MAX_RESOURCES 4
>>   #define MAX_NR_INBOUND_MAPS 6
>> @@ -227,7 +228,8 @@ static int rcar_pcie_config_access(struct rcar_pcie *pcie,
>>
>>   	/* Set the PIO address */
>>   	rcar_pci_write_reg(pcie, PCIE_CONF_BUS(bus->number) |
>> -		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) | reg, PCIECAR);
>> +		PCIE_CONF_DEV(dev) | PCIE_CONF_FUNC(func) |
>> +		PCIE_CONF_REGNO(reg), PCIECAR);
>
> What about the other rcar_pci_read_reg()/rcar_pci_write_reg() calls (the
> ones for "if (pci_is_root_bus())"?  Do those need to be limited to the
> first 256 bytes also?
>
> It seems a little strange to mask "reg = where&  ~3" at the top (making it
> 4-byte aligned), then mask "r&  0xfc" here (limiting to first 256 bytes and
> also making it 4-byte aligned).
>
> Seems like those two operations should either be combined or completely
> split.

This depends on the PCIECAR register of Rcar PCIE.
2bit from 7bit is REGNO, and 8bit from 11bit is EREGNO (Extended Register No) field.
If we do not want to mask, you might unnecessary data is written to the EREGNO.
This depends on 'where' value, but more safely value is written by the mask.


>
>>   	/* Enable the configuration access */
>>   	if (bus->parent->number == pcie->root_bus_nr)
>> --
>> 2.1.3
>>

Best regards,
   Nobuhiro
