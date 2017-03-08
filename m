Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
To: Kishon Vijay Abraham I <kishon@ti.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han
 <jingoohan1@gmail.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com> <58BFEC7D.3090608@ti.com>
 <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com> <58C00798.1030302@ti.com>
 <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <32adcffc-4d63-5953-9e61-3f48773a5e14@synopsys.com>
Date: Wed, 8 Mar 2017 15:33:36 +0000
MIME-Version: 1.0
In-Reply-To: <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 3:32 PM de 3/8/2017, Joao Pinto escreveu:
> =C0s 1:31 PM de 3/8/2017, Kishon Vijay Abraham I escreveu:
>> Hi,
>>
>> On Wednesday 08 March 2017 05:07 PM, Joao Pinto wrote:
>>> =C0s 11:35 AM de 3/8/2017, Kishon Vijay Abraham I escreveu:
>>>> Hi,
>>>>
>>>> On Wednesday 08 March 2017 05:02 PM, Joao Pinto wrote:
>>>>>
>>>>> Hi Kishon,
>>>>>
>>>>>>> Can you provide PCIE_GET_ATU_INB_UNR_REG_OFFSET (similar to
>>>>>>> PCIE_GET_ATU_OUTB_UNR_REG_OFFSET)?
>>>>>>
>>>>>> Yes of course, I will send you the definition soon.
>>>>>
>>>>> As promissed here is the definition for Inbound:
>>>>>
>>>>> +/* register address builder */
>>>>> +#define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
>>>>> +					((0x3 << 20) | (region << 9) |	\
>>>>> +					(0x1 << 8) | (register << 2))
>>>>
>>>> Cool, thanks!
>>>
>>> No problem! If you have doubts, please let me know.
>>
>> Okay, so this looks slightly different than the outbound macro since it =
takes
>> the register argument. In the case of outbound PCIE_GET_ATU_OUTB_UNR_REG=
_OFFSET
>> returns the offset which was used like
>> dw_pcie_write_dbi(pci, base, offset + reg, 0x4, val);
>>
>> How should the value from PCIE_GET_ATU_INB_UNR_REG_ADDR be used?
> =

> My original way was this one:
> =

> +/* Register address builder */
> +#define PCIE_GET_ATU_OUTB_UNR_REG_ADDR(region, register)		\
> +					((0x3 << 20) | (region << 9) |	\
> +					(register << 2))
> =

> Bjorn then converted to offset:
> =

> #define PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(region)  ((0x3 << 20) | (region =
<< 9))
> =

> and applied the <<2 shift to the ATU registers.
> =

> So you can use:
> =

> #define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
> 					((0x3 << 20) | (region << 9) |	\
> 					(0x1 << 8)
> =


This one has the right name :)

#define PCIE_GET_ATU_INB_UNR_REG_OFFSET(region, register)		\
					((0x3 << 20) | (region << 9) |	\
					(0x1 << 8)


> Thanks.
> =

>>
>> Thanks
>> Kishon
>>
> =



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
