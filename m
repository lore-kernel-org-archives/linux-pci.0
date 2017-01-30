Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH V7 01/11] iommu/of: Refactor of_iommu_configure() for
 error handling
To: Sricharan <sricharan@codeaurora.org>, 'Tomasz Nowicki' <tn@semihalf.com>,
 will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-2-git-send-email-sricharan@codeaurora.org>
 <4388779a-0e83-fadc-83f4-98c46c88d42e@semihalf.com>
 <c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com>
 <009901d278c7$34fee230$9efca690$@codeaurora.org>
 <d27f04da-7d34-9640-1639-790d0732ed93@arm.com>
 <003601d27ac6$84866840$8d9338c0$@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8387d057-15bd-500c-134e-0e731ff837d6@arm.com>
Date: Mon, 30 Jan 2017 18:42:31 +0000
MIME-Version: 1.0
In-Reply-To: <003601d27ac6$84866840$8d9338c0$@codeaurora.org>
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

On 30/01/17 07:00, Sricharan wrote:
> Hi Robin,
> 
>>> [..]
>>>
>>>>>> +const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>>>> +                       struct device_node *master_np)
>>>>>> +{
>>>>>> +    const struct iommu_ops *ops;
>>>>>> +
>>>>>> +    if (!master_np)
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    if (dev_is_pci(dev))
>>>>>> +        ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
>>>>>
>>>>> I gave the whole patch set a try on ThunderX. really_probe() is failing
>>>>> on dma_configure()->of_pci_iommu_init() for each PCI device.
>>>>
>>>> When you say "failing", do you mean cleanly, or with a crash? I've
>>>> managed to hit __of_match_node() dereferencing NULL from
>>>> of_iommu_xlate() in a horribly complicated chain of events, which I'm
>>>> trying to figure out now, and I wonder if the two might be related.
>>>
>>> Sorry that there is crash still. __of_match_node seems to checking
>>> for NULL arguments , feels like some invalid pointer was passed in.
>>> Is there any particular sequence to try for this ?
>>
>> Ah, I did figure it out - it wasn't actually a NULL dereference, but an
>> unmapped address. Turns out __iommu_of_table is in initdata, so any
>> driver probing after init, connected to an unprobed IOMMU (in this case
>> disabled in DT), trips over trying to match the now-freed table. I'm
>> working on the fix - technically the bug's in my patch (#2) anyway ;)
>>
> 
> Ok, thanks for bringing this out. There is also an issue that
> Sinan has mentioned while testing the ACPI hotplug path, probably
> its related to the above, not sure. I will try to check more on that
> in the meanwhile. Then, taking your fix and fixing the hotplug case
> i will do one more repost.

OK, I've finally settled on the below fixup for patch #2 - I have some
follow-on ideas for eventually getting of the magic table altogether,
but they can wait until we've got the baseline functionality sorted.
Updated full patch here:

http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=5616af885f7c5c24f7239d5c689583b2b583c407

Robin.

-----8<-----

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 349bd1d01612..1f92d98237d5 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -96,6 +96,19 @@ int of_get_dma_window(struct device_node *dn, const
char *prefix, int index,
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);

+static bool of_iommu_driver_present(struct device_node *np)
+{
+	/*
+	 * If the IOMMU still isn't ready by the time we reach init, assume
+	 * it never will be. We don't want to defer indefinitely, nor attempt
+	 * to dereference __iommu_of_table after it's been freed.
+	 */
+	if (system_state > SYSTEM_BOOTING)
+		return false;
+
+	return of_match_node(&__iommu_of_table, np);
+}
+
 static const struct iommu_ops
 *of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
 {
@@ -105,7 +118,7 @@ static const struct iommu_ops

 	ops = iommu_get_instance(fwnode);
 	if ((ops && !ops->of_xlate) ||
-	    (!ops && !of_match_node(&__iommu_of_table, iommu_spec->np)))
+	    (!ops && !of_iommu_driver_present(iommu_spec->np)))
 		return NULL;

 	err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
