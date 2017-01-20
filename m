Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2] PCI: exynos: refactor exynos pcie driver
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, jingoohan1@gmail.com, bhelgaas@google.com
From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Message-id: <d63bfff9-4ea8-a670-581b-38b224ca1676@samsung.com>
Date: Fri, 20 Jan 2017 09:59:19 +0530
MIME-version: 1.0
In-reply-to: <339cc068-567e-09b0-3578-08fd7a5df109@samsung.com>
References: <CGME20170105035104epcas1p2de6c52e577dd78a4f3539fb32d1f0dfe@epcas1p2.samsung.com>
 <1483588418-2551-1-git-send-email-pankaj.dubey@samsung.com>
 <339cc068-567e-09b0-3578-08fd7a5df109@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: CPGS <cpgs@samsung.com>, Niyas Ahmed S T <niyas.ahmed@samsung.com>,
 krzk@kernel.org, kgene@kernel.org, alim.akhtar@samsung.com, sanath@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hello Jingoo, Bjorn,

On Thursday 05 January 2017 09:47 AM, Jaehoon Chung wrote:
> On 01/05/2017 12:53 PM, Pankaj Dubey wrote:
>> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
>>
>> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
>> This patch does refactoring of Exynos PCIe driver to extend support
>> for other Exynos SoC.
>>
>> Following are the main changes done via this patch:
>>
>> 1) It adds separate structs for memory, clock resources.
>>
>> Reason behind this change is, moving ahead various Exynos SoC will
>> have different hardware resources such as iomem, clocks, regmap handles
>> etc. for PCIe controller, so keeping these resources in separate struct
>> will help us in intiailizing them via per SoC ops, and will avoid too
>> many of_machine_is_compatible in code, and help us simplifying
>> exynos_pcie struct.
>>
>> 2) It add exynos_pcie_ops struct which will allow us to support the
>> differences in resources in different Exynos SoC.
>>
>> No functional change intended.
>>
>> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Best Regards,
> Jaehoon Chung
> 
>> ---
>> This patch set is prepared on top of Krzysztof's for-next and
>> PCIe driver cleanup patch [1] by Jaehoon Chung.
>>
>> [1]: https://lkml.org/lkml/2016/12/19/44
>>

Any update on this patch and dependent series [1] from Jaehoon Chung.


Thanks,
Pankaj Dubey

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
