Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: exynos: remove redundant code in
 exynos_pcie_establish_link
To: Jingoo Han <jingoohan1@gmail.com>, 'Krzysztof Kozlowski' <krzk@kernel.org>
From: Pankaj Dubey <pankaj.dubey@samsung.com>
Message-ID: <b81a09be-1873-ab81-dcb2-c3b29ff7e430@samsung.com>
Date: Tue, 10 Oct 2017 19:16:23 +0530
MIME-Version: 1.0
In-Reply-To: <000a01d3411a$82eea770$88cbf650$@gmail.com>
References: <CGME20171009141438epcas2p4ead7e2f2d1af7e0950f2c026e3a9943b@epcas2p4.samsung.com>
 <1507558478-3218-1-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPeC=cS2cvAXHrKuK5F4tEqH6PppwYkxC+Z8+5D--48CAg@mail.gmail.com>
 <000a01d3411a$82eea770$88cbf650$@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>,
 'linux-pci' <linux-pci@vger.kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 'Anvesh Salveru' <anvesh.s@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo,


On 10/09/2017 09:50 PM, Jingoo Han wrote:
> On Monday, October 9, 2017 10:44 AM, Krzysztof Kozlowski wrote:
>> On Mon, Oct 9, 2017 at 4:14 PM, Pankaj Dubey <pankaj.dubey@samsung.com>
>> wrote:
>>> From: Anvesh Salveru <anvesh.s@samsung.com>
>>>
>>> In exynos_pcie_establish_link if driver is not using generic phy,
>>> we are resetting PHY twice, which is redundant, so this patch removes
>> Hi Pankaj,
>>
>> This lacks the information why it is redundant.
> (I resend this mail, because email address of pci list was corrupted.)
Thanks, somehow I typed wrong email id.
> I think so, too.
>
> Did you test this code on some boards with Exynos PCIe?
> Or did hardware engineers confirm this?
> Please add more information on this patch.
I have replied reason behind this patch in reply to Krzysztof, hope I am 
able to
explain logic behind this change.

I do not have access to Exynos5440 PCIe, and this PHY_COMMON_RESET is not
applicable to other Exynos SoC which I have with me, so I can't test 
this change,
but if you see the change it is an obvious change, before introducing 
generic phy
support to this driver PHY_COMMON_RESET was programmed only once, then
in case platform is not using PHY it suppose to be done only once during 
linkup.
I am not sure when Jaehoon introduced this patch, he verified this on 
Exynos5440 or
not. We are just trying to make the logic as it was before without 
affecting anything.

Thanks,
Pankaj Dubey
> Best regards,
> Jingoo Han
>
>>> repeated lines of code for PHY reset.
>>>
>>> Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
>> Your Signed-off-by is needed here.
>>
>> Best regards,
>> Krzysztof
>>
>>> ---
>>>   drivers/pci/dwc/pci-exynos.c | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/dwc/pci-exynos.c b/drivers/pci/dwc/pci-exynos.c
>>> index 5596fde..85d2f4b 100644
>>> --- a/drivers/pci/dwc/pci-exynos.c
>>> +++ b/drivers/pci/dwc/pci-exynos.c
>>> @@ -423,13 +423,6 @@ static int exynos_pcie_establish_link(struct
>> exynos_pcie *ep)
>>>                  exynos_pcie_deassert_phy_reset(ep);
>>>                  exynos_pcie_power_on_phy(ep);
>>>                  exynos_pcie_init_phy(ep);
>>> -
>>> -               /* pulse for common reset */
>>> -               exynos_pcie_writel(ep->mem_res->block_base, 1,
>>> -                                       PCIE_PHY_COMMON_RESET);
>>> -               udelay(500);
>>> -               exynos_pcie_writel(ep->mem_res->block_base, 0,
>>> -                                       PCIE_PHY_COMMON_RESET);
>>>          }
>>>
>>>          /* pulse for common reset */
>>> --
>>> 2.7.4
>>>
>
>
>
>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
