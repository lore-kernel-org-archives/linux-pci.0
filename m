Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
To: wim@djo.tudelft.nl
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan> <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org> <20160621124715.GB3528@djo.tudelft.nl>
 <576943BA.1000001@codeaurora.org> <20160621221347.GA28603@djo.tudelft.nl>
 <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl> <576BF86E.8060302@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <576C042B.20507@codeaurora.org>
Date: Thu, 23 Jun 2016 11:45:47 -0400
MIME-Version: 1.0
In-Reply-To: <576BF86E.8060302@codeaurora.org>
Content-Type: multipart/mixed;
 boundary="------------020602060702010907000403"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020602060702010907000403
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 6/23/2016 10:55 AM, Sinan Kaya wrote:
> On 6/23/2016 10:12 AM, Wim Osterholt wrote:
>> On Wed, Jun 22, 2016 at 11:54:39PM -0400, okaya@codeaurora.org wrote:
>>> On 2016-06-21 18:13, Wim Osterholt wrote:
>>>>>
>>>>> 	pr_info("%s:%d irq = %d penalty = %d\n", __func__, __LINE__, irq,
>>>>> 		penalty);
>>>>>
>>>>
>>>> This produced some 60 lines extra....
>>>
>>> Thanks, let's go back to 4.6 and add a very similar printf to every 
>>> single place where the array is modified and also right before the 
>>> enabled message.
>>>
>>
>> I don't get this right.
>> Assuming that you're still talking about the same file, I find a few
>> instances of 'enabled', most of them in if-statements and one where it might
>> be set, so it looks. However, that's already in a printk statement.
>> I don't know about arrays and even less where these are set. Even worse, I
>> don't know what to put in a 'similar' line if you don't mean 'exactly the
>> same'.
>> So please state file and line numbers and the line to be inserted.
>>
> 
> Sure, let me get a patch for you. I was hoping to do it yesterday. 
> I ran out of time. I typed the message from my phone. 
> 

Here it is



-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

--------------020602060702010907000403
Content-Type: text/plain; charset=UTF-8;
 name="irq_link.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="irq_link.patch"

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index ededa90..228b61f 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -487,15 +487,18 @@ int __init acpi_irq_penalty_init(void)
 			    link->irq.possible_count;
 
 			for (i = 0; i < link->irq.possible_count; i++) {
-				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
+				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ) {
 					acpi_irq_penalty[link->irq.
 							 possible[i]] +=
 					    penalty;
+					pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, link->irq.possible[i], acpi_irq_penalty[link->irq.possible[i]]);
+				}
 			}
 
 		} else if (link->irq.active) {
 			acpi_irq_penalty[link->irq.active] +=
 			    PIRQ_PENALTY_PCI_POSSIBLE;
+			pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, link->irq.active, acpi_irq_penalty[link->irq.active]);
 		}
 	}
 
@@ -548,8 +551,11 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		 */
 		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
 			if (acpi_irq_penalty[irq] >
-			    acpi_irq_penalty[link->irq.possible[i]])
+			    acpi_irq_penalty[link->irq.possible[i]]) {
+				    pr_info("%s:%d acpi_irq_penalty[irq=%d](0x%x) vs. acpi_irq_penalty[%d](0x%x)\n",
+					    __func__, __LINE__, irq, acpi_irq_penalty[irq], link->irq.possible[i], acpi_irq_penalty[link->irq.possible[i]]);
 				irq = link->irq.possible[i];
+			    }
 		}
 	}
 	if (acpi_irq_penalty[irq] >= PIRQ_PENALTY_ISA_ALWAYS) {
@@ -569,6 +575,7 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		return -ENODEV;
 	} else {
 		acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;
+		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, link->irq.active, acpi_irq_penalty[link->irq.active]);
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
@@ -804,6 +811,8 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 		else
 			acpi_irq_penalty[irq] = PIRQ_PENALTY_PCI_AVAILABLE;
 
+		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
+
 		if (retval != 2)	/* no next number */
 			break;
 	}
@@ -824,11 +833,16 @@ void acpi_penalize_isa_irq(int irq, int active)
 			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_USED;
 		else
 			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
+
+		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
 	}
 }
 
 bool acpi_isa_irq_available(int irq)
 {
+	if (irq >= 0 && (irq < ARRAY_SIZE(acpi_irq_penalty)))
+		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
+
 	return irq >= 0 && (irq >= ARRAY_SIZE(acpi_irq_penalty) ||
 			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
 }
@@ -846,6 +860,8 @@ void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
 			acpi_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
 		else
 			acpi_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
+
+		pr_info("%s:%d acpi_irq_penalty[%d] = 0x%x\n", __func__, __LINE__, irq, acpi_irq_penalty[irq]);
 	}
 }
 

--------------020602060702010907000403--
