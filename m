Return-Path: <SRS0=843H=47=arm.com=marc.zyngier@kernel.org>
Return-Path: <SRS0=843H=47=arm.com=marc.zyngier@kernel.org>
Subject: Re: [PATCH v4 2/2] PCI: Add tango PCIe host bridge support
To: Mason <slash.tmp@free.fr>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
 <4a354b33-d59c-4ebb-4b31-0388ac8090d4@sigmadesigns.com>
 <62bb805a-abd6-9aca-3641-8037f42a3b95@arm.com>
 <57673076-4fbd-92ab-453c-3d77fd65407f@free.fr>
 <1b0ec9c9-1036-619e-19c7-16818ca728e3@arm.com>
 <a7d4752f-001d-ba7e-07ff-435643a7e661@free.fr>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <276e40e8-6539-2765-7ce7-9a942b56d54d@arm.com>
Date: Thu, 25 May 2017 14:20:16 +0100
MIME-Version: 1.0
In-Reply-To: <a7d4752f-001d-ba7e-07ff-435643a7e661@free.fr>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 25/05/17 13:41, Mason wrote:
> On 25/05/2017 14:23, Marc Zyngier wrote:
>> On 25/05/17 13:00, Mason wrote:
>>> On 25/05/2017 10:48, Marc Zyngier wrote:
>>>> Please have some defines for these magic values.
>>>
>>> Typical driver do
>>> #define MUX_OFFSET 0x48
>>> and then access the register's value through
>>> readl_relaxed(pcie->base + MUX_OFFSET);
>>>
>>> I can't do that because the registers were shuffled around
>>> between revision 1 and revision 2. Thus, instead of an
>>> explicitly-named macro (MUX_OFFSET), I used an explicitly-
>>> named field (pcie->mux) and access the register's value
>>> through readl_relaxed(pcie->mux);
>>
>> That doesn't prevent you from having a TANGO_V1_MUX_OFFSET define, which
>> you can supplement with a V2 at some point.
>>
>>> This is equivalent to providing the offset definitions in the
>>> init functions, instead of at the top of the file.
>>
>> Sorry, my brain parses text far better than hex number.
> 
> Well, the hex numbers do need to show up somewhere :-)
> 
> IIUC, you're saying that
> #define MUX_OFFSET 0x48
> is clearer than
> pcie->mux = base + 0x48;

yes.

> 
> OK, I can accept that. Maybe our brains have been trained
> to easily recognize and ingest the macro, or maybe it's
> the caps, or maybe the fact that the statement does
> several things (addition and assignment and hex).
> 
> Out of curiosity, how would you feel about
> pcie->MUX_OFFSET = 0x48;
> and then using
> readl_relaxed(pcie->base + pcie->MUX_OFFSET);
> 
> It feels weird to me, I think mostly because it is
> an unusual pattern.

Exactly. Use existing practices help the reviewers quite a lot.

> 
> Anyway, I'll add the macros, if that improves review and
> maintenance.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
