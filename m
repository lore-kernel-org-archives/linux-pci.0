Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ebdb57b1-9a24-f83e-ac26-887f7a2263d3@samsung.com>
References: <CGME20161226052030epcas5p4ea673fc4ee5c0b2664e80f53d4758553@epcas5p4.samsung.com>
 <20161226052029.10552-1-jh80.chung@samsung.com> <20161226052029.10552-2-jh80.chung@samsung.com>
 <CAFp+6iH0q9TNvPgv3_Nexm-vE6TBB_eQHXCwniO-Yn=fq+WWMg@mail.gmail.com>
 <21de9ca7-e586-e5c8-ecda-d30c18bb6e40@samsung.com> <CAFp+6iEOvdaRdvmz45ZVpqPrdSmeKk9je0bHg9FtNg8hE8YUxg@mail.gmail.com>
 <ebdb57b1-9a24-f83e-ac26-887f7a2263d3@samsung.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Date: Wed, 28 Dec 2016 15:42:15 +0530
Message-ID: <CAFp+6iFSfC97g2NsW9NZtxgxxbXW5vwbtk=6kMUiQZcY4J0-1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] phy: exynos-pcie: Add support for Exynos PCIe phy
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-pci@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "robh+dt" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, krzk@kernel.org,
        javier@osg.samsung.com, kishon <kishon@ti.com>,
        Will Deacon <will.deacon@arm.com>, catalin.marinas@arm.com,
        CPGS <cpgs@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 28, 2016 at 3:05 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Vivek,
>
> On 12/28/2016 05:58 PM, Vivek Gautam wrote:
>> Hi Jaehoon,
>>
>> On Wed, Dec 28, 2016 at 8:19 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> Hi Vivek,
>>>
>>> On 12/27/2016 02:53 PM, Vivek Gautam wrote:
>>>> Hi Jaehoon,
>>>>
>>>>
>>>> On Mon, Dec 26, 2016 at 10:50 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>> This patch supports to use Generic Phy framework for Exynos PCIe phy.
>>>>> When Exynos that supported the pcie want to use the PCIe,
>>>>> it needs to control the phy resgister.
>>>>> But it should be more complex to control in their own PCIe device drivers.
>>>>>
>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> ---
>>>>>  drivers/phy/Kconfig           |   9 ++
>>>>>  drivers/phy/Makefile          |   1 +
>>>>>  drivers/phy/phy-exynos-pcie.c | 227 ++++++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 237 insertions(+)
>>>>>  create mode 100644 drivers/phy/phy-exynos-pcie.c
>>>>>
>>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>>>> index fe00f91..94b0433 100644
>>>>> --- a/drivers/phy/Kconfig
>>>>> +++ b/drivers/phy/Kconfig
>>>>> @@ -341,6 +341,15 @@ config PHY_EXYNOS5_USBDRD
>>>>>           This driver provides PHY interface for USB 3.0 DRD controller
>>>>>           present on Exynos5 SoC series.
>>>>>
>>>>> +config PHY_EXYNOS_PCIE
>>>>> +       bool "Exynos PCIe PHY driver"
>>>>
>>>> Is there a reason for this not being 'tristate' ?
>>>
>>> Will change.
>>
>> I notice that PCI_EXYNOS5433 is bool as well.
>> If the host has to be 'bool' then it makes sense to have phy
>> also bool as well. But if PCI_EXYNOS5433 can be made
>> tristate, then this also changes to tristate.
>
> Right. I understood what you said.
>
>>
>>>
>>>>
>>>>> +       depends on ARCH_EXYNOS && OF
>>>>> +       depends on PCI_EXYNOS5433
>>>>> +       select GENERIC_PHY
>>>>> +       help
>>>>> +         Enable PCIe PHY support for Exynos SoC series.
>>>>
>>>> If this driver is for Exynos5433, then same should come in this help
>>>> text as well.
>>>
>>> will support the other exynos series.
>>> I'm working on refactoring exynos5440 with PHY generic Framework.
>>> Then this drive is not for only Exnyos5433. how about?
>>
>> Ok, it's good then. My only concern is 'depends on PCI_EXYNOS5433'
>> makes it look like it is for EXYNOS5433. I am fine if that changes as well.
>
> I will not put PCI_EXYNOS5433, just will use the PCI_EXYNOS.
> Because it will be supported only one file as pci-exynos.c

cool then.

[...]

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
