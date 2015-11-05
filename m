Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC PATCHv3 3/4] x86/pci: Initial commit for new VMD device
 driver
To: Thomas Gleixner <tglx@linutronix.de>,
	Keith Busch <keith.busch@intel.com>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
 <1445967247-24310-4-git-send-email-keith.busch@intel.com>
 <alpine.DEB.2.11.1511021426020.4032@nanos>
 <20151103001552.GE13904@localhost.localdomain>
 <alpine.DEB.2.11.1511031001130.4032@nanos>
 <20151104144905.GI13904@localhost.localdomain>
 <alpine.DEB.2.11.1511041614070.4032@nanos>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Peter Zijlstra <peterz@infradead.org>
From: Jiang Liu <jiang.liu@linux.intel.com>
Message-ID: <563AF8B3.8030907@linux.intel.com>
Date: Thu, 5 Nov 2015 14:35:31 +0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1511041614070.4032@nanos>
Content-Type: multipart/mixed;
 boundary="------------090905010006000707020204"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090905010006000707020204
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



On 2015/11/4 23:14, Thomas Gleixner wrote:
> On Wed, 4 Nov 2015, Keith Busch wrote:
> 
>> On Tue, Nov 03, 2015 at 12:42:02PM +0100, Thomas Gleixner wrote:
>>> On Tue, 3 Nov 2015, Keith Busch wrote:
>>>>>> +	msi_irqdomain = pci_msi_create_irq_domain(NULL, &pci_chained_msi_domain_info,
>>>>>> +						  vmd_irqdomain);
>>>
>>> But that parent limitation does not matter simply because your
>>> msi_irqdomain does not follow down the hierarchy in the allocation
>>> path.
>>>
>>> So we can avoid the vmd_irqdomain creation completely. It's just
>>> wasting memory and has no value at all. Creating the msi domain with a
>>> NULL parent is possible.
>>
>> I'm having trouble following the hierarchy and didn't understand the
>> connection between the parent and msi comain. It's still new to me,
>> but I don't think a NULL parent is allowable with msi domains:
>>
>>  pci_msi_setup_msi_irqs()
>>   pci_msi_domain_alloc_irqs()
>>    msi_domain_alloc_irqs()
>>     __irq_domain_alloc_irqs()
>>      irq_domain_alloc_irqs_recursive()
>>       msi_domain_alloc()
>>        irq_domain_alloc_irqs_parent()
>>
>> The last call returns -ENOSYS since there parent is NULL. Was the
>> intension to allow no parent, or do I still need to allocate one to
>> achieve the desired chaining?
> 
> Hmm, seems I missed that part. But that's a fixable problem. Jiang?
Hi Keith,
	Could you please try the attached patch?
Thanks!
Gerry

> 
> Thanks,
> 
> 	tglx
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--------------090905010006000707020204
Content-Type: text/x-patch;
 name="0001-msi-Relax-msi_domain_alloc-to-support-parentless-MSI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-msi-Relax-msi_domain_alloc-to-support-parentless-MSI.pa";
 filename*1="tch"

>From 6db1568564f8edee626d1c168b22ed5502abc6eb Mon Sep 17 00:00:00 2001
From: Liu Jiang <jiang.liu@linux.intel.com>
Date: Thu, 5 Nov 2015 11:25:07 +0800
Subject: [PATCH] msi: Relax msi_domain_alloc() to support parentless MSI
 irqdomains

Previously msi_domain_alloc() assumes MSI irqdomains always have parent
irqdomains, but that's not true for the new Intel VMD devices. So relax
msi_domain_alloc() to support parentless MSI irqdomains.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
---
 kernel/irq/msi.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7e6512b9dc1f..e4d3d707efff 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -109,9 +109,11 @@ static int msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (irq_find_mapping(domain, hwirq) > 0)
 		return -EEXIST;
 
-	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
-	if (ret < 0)
-		return ret;
+	if (domain->parent) {
+		ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
+		if (ret < 0)
+			return ret;
+	}
 
 	for (i = 0; i < nr_irqs; i++) {
 		ret = ops->msi_init(domain, info, virq + i, hwirq + i, arg);
-- 
1.7.10.4


--------------090905010006000707020204--
