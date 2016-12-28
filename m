Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
To: Pankaj Dubey <pankaj.dubey@samsung.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <f6106086-3f96-f55c-2f7b-dbd7992bc6ec@samsung.com>
Date: Wed, 28 Dec 2016 14:25:29 +0900
MIME-version: 1.0
In-reply-to: <CAGcde9HTd7Gxc89ZaYW8z-pc91ps3kwHx3KsEpNRLcoHO9S-zw@mail.gmail.com>
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
 <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
 <5860E6F7.2090703@samsung.com>
 <79b89c49-a9de-3daa-9afa-b8f36304a226@samsung.com>
 <5861CE23.9060202@samsung.com>
 <6de4bc5b-05fb-793f-d3ab-b1c6ee19cfeb@samsung.com>
 <58620B5A.1060900@samsung.com>
 <a4200793-19dd-3727-505c-5840a8ec72bb@samsung.com>
 <CAGcde9HTd7Gxc89ZaYW8z-pc91ps3kwHx3KsEpNRLcoHO9S-zw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 CPGS <cpgs@samsung.com>, linux-pci@vger.kernel.org,
 Niyas Ahmed S T <niyas.ahmed@samsung.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, sanath@samsung.com,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Pankaj,

On 12/28/2016 12:10 PM, Pankaj Dubey wrote:
> Hi Jaehoon,
> 
> On 27 December 2016 at 15:48, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Dear Alim,
>>
>> On 12/27/2016 03:34 PM, Alim Akhtar wrote:
>>> Hi Jaehoon,
>>>
>> [snip]
>>>>
>>>> Ah. Right..And i'm doing the refactoring to reuse the current pci-exynos.c.
>>> There is a nice refactoring patch posted by Pankaj recently @
>>> https://lkml.org/lkml/2016/12/23/73
>>> I would suggest you to rebase your work on this top.
>>
>> Well, i don't think so. Pankaj's patch might be good way..but i can't agree about a few point.
>> If based on Pankaj's patch, it's more complex..
>>
>> why put the ops callback for getting clock and mem resource?
>>
> 
> I think I replied reason behind this in reply to Jingoo. Well I will
> explain with some example here. Current exynos_pcie struct contains
> all mem, phy, gpio and clock resources in one place and this driver is
> supported only for Exynos5440. Until this it was fine. As Jingoo
> mentioned when he up streamed this driver, generic phy framework was
> not ready so he used phy_base along with some additional phy related
> sfr base in pcie driver itself.
> 
> Moving ahead for adding support for PCIe module on Exynos7, Exynos5433
> or other existing Exynos (non-mainlined) and some of upcoming SoC
> seeing the differences in these resources (mem, clk, regmap handles,
> gpio etc.) we will endup adding following kind of code in probe to get
> these resources from DT
> 
> if (of_machine_is_compatible(exynos7420)) {
>     /* get certain mem resources */
>     /* get certain clock resources */
>     /* get certain regmap handle resources if required */
> } else if (of_machine_is_compatble(exynos5433)) {
>     /* get certain but may be different mem resources */
>     /* get certain clock resources */
>     /* get certain regmap handle resources if required */
> } else if (of_machine_is_compatible(exynosMMMM)) {
>   //may be something else
> }
> 
> for giving real example, exynos7420 does not uses only two clocks
> "bus", "pcie_bus" there are other clocks required to be taken care in
> driver. It also need to take care of pmu regmap handle and sysreg
> regmap handle.
> 
> So if we keep exynos_pcie as only struct then we will keep adding all
> these resources in only one struct making it more complex. Also
> resource initialization part will become complex. For the same reason
> I decided to separate these rather keeping them in single struct. This
> is very obvious design used in many drivers (samsung or other
> vendors). Just to give one more example see pcie-qcom.c where they
> also have different clocks and it is managed in same fashion.
> 
>> If PHY generic framework is used, it's unnecessary. because it needs to get elbi and dbi resources.
> 
> Surely elbi and dbi are fixed, but as we already have one example of
> exynos5440 which used block_base (additional SFR base other than phy
> base), I can see some of existing and upcoming SoC will need more SFR
> base than these two, it all depends on how h/w engineers design these
> modules and distribute SFR access.
> 
>> clock resources("pcie" and "pcie_bus") are general things.
>>
> 
> With current Exynos SoCs which have PCIe hardware modules I can see
> this will not remain uniform across various SoCs, some of them require
> more clocks to be handled by PCIe driver.
> 
>> If Pankaj's patch is applied, also need to make the exynos5433_pcie_* callback functions?
>> It doesn't make sense.
>>
> 
> Adding exynos5433_pcie_ops struct and hooks specific to the exynos5433
> is a small overhead compared to the flexibility it provides. This will
> make current driver flexibility with less
> of_machine_is_compatible(...) kind of conditional statement, less
> complex exynos_pcie struct.
> For the hooks of exynos_pcie_ops also if two different Exynos SoC
> shares same mem, clock and other resources the actual hooks will point
> to same functions so no overhead of implementing these for each SoC.
> Only separate implementation will be required if they differ in these
> resources. This approach also very common across various drivers
> nothing special here.
> 
> I hope I am clear in explaining the intention and pros and cons of
> both approaches.

Yep, clear..Well, My opinion is also my preference.
(Maybe i think that you also know a little what my meaning is. )
There is no objection that we want to support the other Exynos variants. :)

This discussion is for how to support better than now.
So I will send the patch based on your patch...then we can discuss more. how about?

I think we can maintain more better than now.
As you already know, current exynos-pcie has to modify for supporting other.

> 
>> I want to know maintainer's opinion..we can just touch a little for supporting All Exynos SoCs.
>>
> 
> I also have same intention but design should be flexible to adopt
> future SoC at least some of them which we are seeing will be supported
> soon and we can see the differences.

Sure, I will wait for your patch.
And You can also check my patches.. :)

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Pankaj Dubey
> 
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>>> Maybe..Today or Tomorrow..I will send the patches..At that time, could you also check them?
>>>> Any comments might be helpful to me! :)
>>>>
>>> Will wait for you patches :-)
>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>> [snip]
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
