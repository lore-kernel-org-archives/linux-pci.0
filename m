Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: "Sricharan" <sricharan@codeaurora.org>
To: "'Robin Murphy'" <robin.murphy@arm.com>,
 "'Tomasz Nowicki'" <tn@semihalf.com>, <will.deacon@arm.com>,
 <joro@8bytes.org>, <lorenzo.pieralisi@arm.com>,
 <iommu@lists.linux-foundation.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-2-git-send-email-sricharan@codeaurora.org>
 <4388779a-0e83-fadc-83f4-98c46c88d42e@semihalf.com>
 <c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com>
In-Reply-To: <c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com>
Subject: RE: [PATCH V7 01/11] iommu/of: Refactor of_iommu_configure() for
 error handling
Date: Fri, 27 Jan 2017 23:30:05 +0530
Message-ID: <009901d278c7$34fee230$9efca690$@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,

[..]

>>> +const struct iommu_ops *of_iommu_configure(struct device *dev,
>>> +                       struct device_node *master_np)
>>> +{
>>> +    const struct iommu_ops *ops;
>>> +
>>> +    if (!master_np)
>>> +        return NULL;
>>> +
>>> +    if (dev_is_pci(dev))
>>> +        ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
>>
>> I gave the whole patch set a try on ThunderX. really_probe() is failing
>> on dma_configure()->of_pci_iommu_init() for each PCI device.
>
>When you say "failing", do you mean cleanly, or with a crash? I've
>managed to hit __of_match_node() dereferencing NULL from
>of_iommu_xlate() in a horribly complicated chain of events, which I'm
>trying to figure out now, and I wonder if the two might be related.

Sorry that there is crash still. __of_match_node seems to checking
for NULL arguments , feels like some invalid pointer was passed in.
Is there any particular sequence to try for this ?

Regards,
 Sricharan





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
