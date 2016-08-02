Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v2 1/2] pcie-designware: add iATU Unroll feature
To: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1469193895.git.jpinto@synopsys.com>
 <0ce5678ac78d082afa3df7ad284111afcc03b2a1.1469193895.git.jpinto@synopsys.com>
 <20160725204443.GB15939@localhost>
 <e00f4953-eb9f-8b6c-0c16-f6fd1abcb717@synopsys.com>
 <20160802125335.GA31847@localhost>
CC: <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jszhang@marvell.com>,
	<CARLOS.PALMINHA@synopsys.com>, <MiguelFalcao.Sousa@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <bc8cd064-9397-7772-72d1-a782b3769cd4@synopsys.com>
Date: Tue, 2 Aug 2016 15:27:56 +0100
MIME-Version: 1.0
In-Reply-To: <20160802125335.GA31847@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

On 8/2/2016 1:53 PM, Bjorn Helgaas wrote:
> On Tue, Aug 02, 2016 at 11:27:45AM +0100, Joao Pinto wrote:
>> On 7/25/2016 9:44 PM, Bjorn Helgaas wrote:
>>> On Fri, Jul 22, 2016 at 02:29:38PM +0100, Joao Pinto wrote:
>>>> This patch adds the support to the new iATU mechanism that will be used
>>>> from Core version 4.80, which is called iATU Unroll.
>>>> The new Cores can support the iATU Unroll or support the "old" iATU 
>>>> method now called Legacy Mode. The driver is perfectly capable of
>>>> performing well for both.
>>>>
>>>> In order to make sure that the iATU is really enabled a for loop was
>>>> introduced in dw_pcie_prog_outbound_atu() to improve reliability.
>>>>

(snip...)

>> ...
>>>> +static inline void dw_pcie_readl_unroll(struct pcie_port *pp, u32 type,
>>>> +						u32 index, u32 reg, u32 *val)
>>>> +{
>>>> +	u32 reg_addr = 0;
>>>> +
>>>> +	if (type == PCIE_TRANSL_OUTB)
>>>> +		reg_addr = PCIE_GET_ATU_OUTB_UNR_REG_ADDR(index, reg);
>>>> +	else if  (type == PCIE_TRANSL_INB)
>>>> +		reg_addr = PCIE_GET_ATU_INB_UNR_REG_ADDR(index, reg);
>>>
>>> PCIE_TRANSL_INB is never used.  In fact, dw_pcie_readl_unroll() is
>>> *always* called with PCIE_TRANSL_OUTB, so it's not clear what the
>>> value of passing it as an argument is.
>>
>> I included The Inbound translation mechanism because you can have Inbound or
>> Outbound translation in the iATU. The old mechanism also had Inbound properties
>> that are not used in the code. I suggest we keep the Inbound mechanism to avoid
>> future rework. Agree?
> 
> Again, not a huge deal, but since PCIE_TRANSL_INB is not used, it
> makes life harder for the reader, and the related code is not tested.
> So personally, I would remove it and add it back if/when it is needed.
> 
> Bjorn
> 

Ok, I will do that and send a new version soon. Thanks!

Joao
