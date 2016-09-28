Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609281902.31500.linux@rainbow-software.org>
 <76303bb8-7ae2-9a6b-8e5d-a144ae7c6009@codeaurora.org>
 <201609282123.48506.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, wim@djo.tudelft.nl,
        ravikanth.nalla@hpe.com
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <946fcb62-272b-61b3-9afa-7c27a1ce7419@codeaurora.org>
Date: Wed, 28 Sep 2016 19:38:41 -0400
MIME-Version: 1.0
In-Reply-To: <201609282123.48506.linux@rainbow-software.org>
Content-Type: multipart/mixed;
 boundary="------------97707A6EB943ECEA41FEED52"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------97707A6EB943ECEA41FEED52
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

On 9/28/2016 3:23 PM, Ondrej Zary wrote:
> On Wednesday 28 September 2016 20:22:40 Sinan Kaya wrote:
>> On 9/28/2016 1:02 PM, Ondrej Zary wrote:
>>>> Thanks, It sounds like you have more than one machine with similar
>>>>
>>>>> problems. Can you collect the log from the other machines with
>>>>> 4.8-rc8?
>>>>>
>>>>> and also a boot log with 4.6 kernel where things are working?
>>>
>>> The attached logs are from another machine:
>>>
>>> dmesg-bad-debug.txt: 4.8-rc8 with your debug patch - bad
>>>
>>> dmesg-reverted.txt: 4.8-rc8 with patches (as per Rafael's suggestion)
>>> reverted - good
>>>
>>> dmesg-3.6.txt: 4.6 (Debian kernel) - good
>>
>> I think I see a race condition for the SCI interrupt. I need another dump
>> from 4.8-rc8 with the attached patch to confirm. Let's remove the previous
>> one and apply this one.
> 
> dmesg-reverted.txt: 4.8-rc8 w/patches reverted (good)
> $ head /proc/interrupts
>            CPU0
>   0:       8531    XT-PIC  timer
>   1:          9    XT-PIC  i8042
>   2:          0    XT-PIC  cascade
>   8:          1    XT-PIC  rtc0
>  11:        713    XT-PIC  acpi, uhci_hcd:usb1, uhci_hcd:usb2, nvkm, eth0
>  12:        161    XT-PIC  i8042
>  14:       4042    XT-PIC  pata_via
>  15:          0    XT-PIC  pata_via
> NMI:          0   Non-maskable interrupts
> 
> dmesg-bad-debug.txt: 4.8-rc8 (bad)
> $ head /proc/interrupts
>            CPU0
>   0:       8027    XT-PIC  timer
>   1:        286    XT-PIC  i8042
>   2:          0    XT-PIC  cascade
>   8:          1    XT-PIC  rtc0
>  10:          0    XT-PIC  uhci_hcd:usb1, uhci_hcd:usb2
>  11:          0    XT-PIC  acpi, nvkm, eth0
>  12:        161    XT-PIC  i8042
>  14:       4069    XT-PIC  pata_via
>  15:          0    XT-PIC  pata_via
> 
> (I'm moving between different machines through the day - these logs are from 
> different machine than the last ones).
> 

Can you try these patches on your machines please?


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------97707A6EB943ECEA41FEED52
Content-Type: text/plain; charset=UTF-8;
 name="0002-ACPI-PCI-IRQ-remove-double-penalty-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-ACPI-PCI-IRQ-remove-double-penalty-calculation.patch"

>From fe125e9ed5226a8976f5510c5a0d34280d693952 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 28 Sep 2016 19:08:34 -0400
Subject: [PATCH 2/4] ACPI, PCI, IRQ: remove double penalty calculation

acpi_irq_get_penalty returns the penalty for both PCI and ISA penalties.
Now that we don't have any storage place for PCI IRQs, we run into some
math problem such as follows:

The original code was as simple as this:
acpi_isa_irq_penalty += penalty

In order to hide PCI IRQ calculation difference vs. ISA IRQ difference, we
created the acpi_irq_get_penalty function and replaced the above statement
as

acpi_isa_irq_penalty = acpi_irq_get_penalty() + penalty

This is what acpi_irq_get_penalty returns.

acpi_irq_get_penalty()= acpi_isa_irq_penalty + SCI penalty

When you call acpi_penalize_isa_irq twice, you end up with:

acpi_isa_irq_penalty = 2 * SCI penalty + acpi_isa_irq_penalty

Fixing this by directly modifying acpi_isa_irq_penalty for the new penalty
added.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 1edda48..df58153 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -871,9 +871,10 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
+	int penalty = active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
+
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
-		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
+		acpi_isa_irq_penalty[irq] += penalty;
 }
 
 bool acpi_isa_irq_available(int irq)
-- 
1.9.1


--------------97707A6EB943ECEA41FEED52
Content-Type: text/plain; charset=UTF-8;
 name="0003-ACPI-PCI-IRQ-add-PCI-possible-only-for-PCI-interrupt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-ACPI-PCI-IRQ-add-PCI-possible-only-for-PCI-interrupt.pa";
 filename*1="tch"

>From 0a75506dc5d7aeba0a7ca8cd3fdcfaca55bbaf18 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 28 Sep 2016 18:56:48 -0400
Subject: [PATCH 3/4] ACPI,PCI,IRQ: add PCI possible only for PCI interrupts

acpi_irq_penalty_init is pre-calculating PCI_POSSIBLE penalty for
ISA interrupts at power up. Remove this from PCI dynamic penalty
path.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index df58153..a7068a4 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -481,13 +481,15 @@ static int acpi_irq_pci_sharing_penalty(int irq)
 			(link->irq.initialized == 1))
 			penalty += PIRQ_PENALTY_PCI_USING;
 
-		/*
-		 * penalize the IRQs PCI might use, but not as severely.
-		 */
-		for (i = 0; i < link->irq.possible_count; i++)
-			if (link->irq.possible[i] == irq)
-				penalty += PIRQ_PENALTY_PCI_POSSIBLE /
-					link->irq.possible_count;
+		if (link->irq.possible[i] >= ACPI_MAX_ISA_IRQS) {
+			/*
+			 * penalize the IRQs PCI might use, but not as severely.
+			 */
+			for (i = 0; i < link->irq.possible_count; i++)
+				if (link->irq.possible[i] == irq)
+					penalty += PIRQ_PENALTY_PCI_POSSIBLE /
+						link->irq.possible_count;
+		}
 	}
 
 	return penalty;
-- 
1.9.1


--------------97707A6EB943ECEA41FEED52
Content-Type: text/plain; charset=UTF-8;
 name="0004-ACPI-PCI-IRQ-add-PCI_USING-for-ISA-interrupts-too.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-ACPI-PCI-IRQ-add-PCI_USING-for-ISA-interrupts-too.patch"

>From 0214f2910443832bc2c97959ad8710dab82144d4 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 28 Sep 2016 19:27:41 -0400
Subject: [PATCH 4/4] ACPI, PCI, IRQ: add PCI_USING for ISA interrupts too

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed PCI_USING penalty from
acpi_pci_link_allocate function as there is no longer a fixed size penalty
array for both PCI and IRQ interrupts.

We need to add the PCI_USING penalty for ISA interrupts too if the link is
in use and matches our ISA IRQ number.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index a7068a4..984a972 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -514,7 +514,7 @@ static int acpi_irq_get_penalty(int irq)
 	}
 
 	if (irq < ACPI_MAX_ISA_IRQS)
-		return penalty + acpi_isa_irq_penalty[irq];
+		penalty += acpi_isa_irq_penalty[irq];
 
 	penalty += acpi_irq_pci_sharing_penalty(irq);
 	return penalty;
-- 
1.9.1


--------------97707A6EB943ECEA41FEED52
Content-Type: text/plain; charset=UTF-8;
 name="0001-ACPI-PCI-IRQ-add-PCI_USING-penalty-only-if-the-link-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ACPI-PCI-IRQ-add-PCI_USING-penalty-only-if-the-link-.pa";
 filename*1="tch"

>From 7650ce30a023fc85e8484e5c58f6d1ac4dc30744 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Wed, 28 Sep 2016 18:54:10 -0400
Subject: [PATCH 1/4] ACPI,PCI,IRQ: add PCI_USING penalty only if the link is
 initialized

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed PCI_USING penalty from
acpi_pci_link_allocate function as there is no longer a fixed size penalty
array for both PCI and IRQ interrupts. Instead PCI_USING is determined by
scanning all link objects' active value against the IRQ value we are
interested.

The original code would add the PCI_USING penalty only if the link
initialization is successful. The current code is blindly adding this
regardless of the link object initialization state.

Fixing this by adding an additional check.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..1edda48 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -477,7 +477,8 @@ static int acpi_irq_pci_sharing_penalty(int irq)
 		 * If a link is active, penalize its IRQ heavily
 		 * so we try to choose a different IRQ.
 		 */
-		if (link->irq.active && link->irq.active == irq)
+		if (link->irq.active && (link->irq.active == irq) &&
+			(link->irq.initialized == 1))
 			penalty += PIRQ_PENALTY_PCI_USING;
 
 		/*
-- 
1.9.1


--------------97707A6EB943ECEA41FEED52--
