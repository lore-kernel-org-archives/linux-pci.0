Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
 <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
Date: Tue, 27 Dec 2016 09:51:01 +0530
Message-ID: <CAGcde9EsO39B4CsPH2KrC=tJM4+SFaO4+P8frHTGB_13eBujqQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: exynos: refactor exynos pcie driver
To: Jaehoon Chung <jh80.chung@samsung.com>
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
 bhelgaas@google.com, sanath@samsung.com,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jaehoon,

On 26 December 2016 at 14:32, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Pankaj,
>
> On 12/23/2016 07:56 PM, Pankaj Dubey wrote:
>> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
>>
>> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
>> This patch does refactoring of Exynos PCIe driver to extend support
>> for other Exynos SoC.
>>
>> Following are the main changes done via this patch:
>> 1) It adds separate structs for memory, clock resources.
>> 2) It add exynos_pcie_ops struct which will allow us to support the
>> differences in resources in different Exynos SoC.
>
> It's nice to me for reusing this file.
> but after considering too many times, i decided not to use this file.
>

It would be better if we redesign/modify existing driver to support new single
driver for all Exynos SoC.

For this we can have internal discussion and design it so that it
becomes suitable
for other Exynos SoC PCIe controllers.

> I'm not sure what block base is..actually this pci-exynos.c is really black-box.

I saw Jingoo already explained about block base, so it may or may not be used in
other exynos. If it is used they can reuse this variable and related
code, if not the
implementation of exynos_pcie_ops hooks should be written in such a way that
ignores (do not initializes/uses) block_base.

> (No one maintains this file, even Samsung didn't care.)
> Who is using this?

I feel now we we (you and me) will care for it, at least we have use
case for this now :)

> If Someone can share the information about exynos5440, i can refactor everything.
> Otherwise, there are two solution..
>

We also do not have access to exynos5440 hardware, but we do have access
to exynos5440 UM, so we can see some details of these SFRs. Based on
our understanding
we refactored this code for making it more suitable for other SoC.

Regarding phy_base and block_base as they are phy related it need to
be replaced with phy driver, so for this we can reuse your RFC patch
of pcie-phy. Even phy driver design should be
such that it can support multiple Exynos SoC PCIe-Phy.

> One is "adding the new pci-exynos.c" likes pci-exynos5433.c

I know exynos5433 and exynos7 SoC have similar PCIe controller, although they
may share comparatively less similarity with exynos5440. If start
adding new file for
each SoC we may end of lot of code duplication.

> Other is "refactor this file" under assuming the each register's usage.
>

IMHO, this would be good design decision.

We have separate various resources of exynos_pcie struct such as iomem
and clks for
the timebeing, and these resources can be managed via exynos_pcie_ops
which can have different implementation for different SoCs, we have
freedom to handle these resources per SoC. If some SoCs share similar
PCIe controller h/w design, code will be reused.

> I want to use the PHY generic Framework for EXYNOS PCIe.
>
> If you or other guys really want to use the pci-exynos.c for other exynos,
> I will rework with PHY generic framework. Then i will resend the my patches as V2.
>
> One more thing..Does anyone know what the usage of block base is?
> Can i use that register as "syscon"?
>

I think this is not exactly syscon, as it only be used in pcie-phy,
so we can use this as child device of phy-device.

> Best Regards,
> Jaehoon Chung
>

Thanks,
Pankaj Dubey

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
