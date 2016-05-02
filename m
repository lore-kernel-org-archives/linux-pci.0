Return-Path: <ravikanth.nalla@hpe.com>
Return-Path: <ravikanth.nalla@hpe.com>
From: "Nalla, Ravikanth" <ravikanth.nalla@hpe.com>
To: Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"timur@codeaurora.org" <timur@codeaurora.org>, "cov@codeaurora.org"
	<cov@codeaurora.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "K, Harish
 (MCOU/UPEL)" <harish.k@hpe.com>, "Reghunandanan, Ashwin (STSD)"
	<ashwin.reghunandanan@hpe.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements
Date: Mon, 2 May 2016 17:44:11 +0000
Message-ID: <49D617FA63152941907AADE32CF072F12FF09187@G4W3290.americas.hpqcorp.net>
References: <1460914617-8259-1-git-send-email-okaya@codeaurora.org>
 <20160426183611.GC27803@localhost> <571FBACB.1020606@codeaurora.org>
In-Reply-To: <571FBACB.1020606@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>


-----Original Message-----
From: Sinan Kaya [mailto:okaya@codeaurora.org]=20
Sent: Wednesday, April 27, 2016 12:30 AM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-acpi@vger.kernel.org; timur@codeaurora.org; cov@codeaurora.org; l=
inux-pci@vger.kernel.org; Nalla, Ravikanth <ravikanth.nalla@hpe.com>; lenb@=
kernel.org; K, Harish (MCOU/UPEL) <harish.k@hpe.com>; Reghunandanan, Ashwin=
 (STSD) <ashwin.reghunandanan@hpe.com>; bhelgaas@google.com; rjw@rjwysocki.=
net; linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/4] acpi,pci,irq: reduce resource requirements

On 4/26/2016 2:36 PM, Bjorn Helgaas wrote:
> On Sun, Apr 17, 2016 at 01:36:53PM -0400, Sinan Kaya wrote:
>> Code has been redesigned to calculate penalty requirements on the=20
>> fly. This significantly simplifies the implementation and removes=20
>> some of the init calls from x86 architecture.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>=20
> For all four patches:
>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Thanks, can the HPE developers in CC test the series in order to avoid an=
other revert?=20

 I'm facing below errors while applying these patches on mainline kernel fo=
r verification. Please check and let me know what is the issue or if I'm=20
 missing  anything. I use outlook for mail and I copied your mail formatted=
 patches into each individual file manually and converted these files into
 unix format (using dos2unix cmd)  and when trying to apply with cmd "patch=
 -p1  patch1.patch" /  "git apply patch1.patch" i see
 below errors. I'm getting similar errors for remaining  patches too and al=
so "checkpatch.pl" looks to be throwing errors. Hence I'm not able to=20
 verify your changes.

 linux]# dos2unix patch1.patch
 dos2unix: converting file patch1.patch to Unix format ...
 linux]# patch -p1 < patch1.patch
 patching file drivers/acpi/pci_link.c
 patch: **** malformed patch at line 99: @@ -547,12 +601,12 @@ static int a=
cpi_pci_link_allocate(struct acpi_pci_link *link)
 linux]# git apply patch1.patch
 fatal: corrupt patch at line 99

 "checkpatch.pl" errors:
-----------------------------
 linux]# ./scripts/checkpatch.pl patch1.patch
 ERROR: open brace '{' following function declarations go on the next line
 #44: FILE: drivers/acpi/pci_link.c:470:
 +static int acpi_irq_pci_sharing_penalty(int irq) {

 ERROR: open brace '{' following function declarations go on the next line
 #72: FILE: drivers/acpi/pci_link.c:498:
+static int acpi_irq_get_penalty(int irq) {

ERROR: patch seems to be corrupt (line wrapped?)
#173: FILE: drivers/acpi/pci_link.c:889:
1.8.2.1

total: 3 errors, 0 warnings, 144 lines checked

patch1.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
>=20
>> ---
>>  drivers/acpi/pci_link.c | 97=20
>> ++++++++++++++++++++++++++++++++++---------------
>>  1 file changed, 68 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c index=20
>> ededa90..cc0ba16 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/mutex.h>
>>  #include <linux/slab.h>
>>  #include <linux/acpi.h>
>> +#include <linux/irq.h>
>> =20
>>  #include "internal.h"
>> =20
>> @@ -440,7 +441,6 @@ static int acpi_pci_link_set(struct acpi_pci_link *l=
ink, int irq)
>>  #define ACPI_MAX_IRQS		256
>>  #define ACPI_MAX_ISA_IRQ	16
>> =20
>> -#define PIRQ_PENALTY_PCI_AVAILABLE	(0)
>>  #define PIRQ_PENALTY_PCI_POSSIBLE	(16*16)
>>  #define PIRQ_PENALTY_PCI_USING		(16*16*16)
>>  #define PIRQ_PENALTY_ISA_TYPICAL	(16*16*16*16)
>> @@ -457,9 +457,9 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] =3D {
>>  	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ6 */
>>  	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ7 parallel, spurious */
>>  	PIRQ_PENALTY_ISA_TYPICAL,	/* IRQ8 rtc, sometimes */
>> -	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ9  PCI, often acpi */
>> -	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ10 PCI */
>> -	PIRQ_PENALTY_PCI_AVAILABLE,	/* IRQ11 PCI */
>> +	0,				/* IRQ9  PCI, often acpi */
>> +	0,				/* IRQ10 PCI */
>> +	0,				/* IRQ11 PCI */
>>  	PIRQ_PENALTY_ISA_USED,		/* IRQ12 mouse */
>>  	PIRQ_PENALTY_ISA_USED,		/* IRQ13 fpe, sometimes */
>>  	PIRQ_PENALTY_ISA_USED,		/* IRQ14 ide0 */
>> @@ -467,6 +467,60 @@ static int acpi_irq_penalty[ACPI_MAX_IRQS] =3D {
>>  	/* >IRQ15 */
>>  };
>> =20
>> +static int acpi_irq_pci_sharing_penalty(int irq) {
>> +	struct acpi_pci_link *link;
>> +	int penalty =3D 0;
>> +
>> +	list_for_each_entry(link, &acpi_link_list, list) {
>> +		/*
>> +		 * If a link is active, penalize its IRQ heavily
>> +		 * so we try to choose a different IRQ.
>> +		 */
>> +		if (link->irq.active && link->irq.active =3D=3D irq)
>> +			penalty +=3D PIRQ_PENALTY_PCI_USING;
>> +		else {
>> +			int i;
>> +
>> +			/*
>> +			 * If a link is inactive, penalize the IRQs it
>> +			 * might use, but not as severely.
>> +			 */
>> +			for (i =3D 0; i < link->irq.possible_count; i++)
>> +				if (link->irq.possible[i] =3D=3D irq)
>> +					penalty +=3D PIRQ_PENALTY_PCI_POSSIBLE /
>> +						link->irq.possible_count;
>> +		}
>> +	}
>> +
>> +	return penalty;
>> +}
>> +
>> +static int acpi_irq_get_penalty(int irq) {
>> +	int penalty =3D 0;
>> +
>> +	if (irq < ACPI_MAX_ISA_IRQ)
>> +		penalty +=3D acpi_irq_penalty[irq];
>> +
>> +	/*
>> +	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
>> +	* with PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be
>> +	* use for PCI IRQs.
>> +	*/
>> +	if (irq =3D=3D acpi_gbl_FADT.sci_interrupt) {
>> +		u32 type =3D irq_get_trigger_type(irq) & IRQ_TYPE_SENSE_MASK;
>> +
>> +		if (type !=3D IRQ_TYPE_LEVEL_LOW)
>> +			penalty +=3D PIRQ_PENALTY_ISA_ALWAYS;
>> +		else
>> +			penalty +=3D PIRQ_PENALTY_PCI_USING;
>> +	}
>> +
>> +	penalty +=3D acpi_irq_pci_sharing_penalty(irq);
>> +	return penalty;
>> +}
>> +
>>  int __init acpi_irq_penalty_init(void)  {
>>  	struct acpi_pci_link *link;
>> @@ -547,12 +601,12 @@ static int acpi_pci_link_allocate(struct acpi_pci_=
link *link)
>>  		 * the use of IRQs 9, 10, 11, and >15.
>>  		 */
>>  		for (i =3D (link->irq.possible_count - 1); i >=3D 0; i--) {
>> -			if (acpi_irq_penalty[irq] >
>> -			    acpi_irq_penalty[link->irq.possible[i]])
>> +			if (acpi_irq_get_penalty(irq) >
>> +			    acpi_irq_get_penalty(link->irq.possible[i]))
>>  				irq =3D link->irq.possible[i];
>>  		}
>>  	}
>> -	if (acpi_irq_penalty[irq] >=3D PIRQ_PENALTY_ISA_ALWAYS) {
>> +	if (acpi_irq_get_penalty(irq) >=3D PIRQ_PENALTY_ISA_ALWAYS) {
>>  		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
>>  			    "Try pci=3Dnoacpi or acpi=3Doff\n",
>>  			    acpi_device_name(link->device), @@ -568,7 +622,6 @@ static=20
>> int acpi_pci_link_allocate(struct acpi_pci_link *link)
>>  			    acpi_device_bid(link->device));
>>  		return -ENODEV;
>>  	} else {
>> -		acpi_irq_penalty[link->irq.active] +=3D PIRQ_PENALTY_PCI_USING;
>>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>>  		       acpi_device_name(link->device),
>>  		       acpi_device_bid(link->device), link->irq.active); @@ -800,9=20
>> +853,10 @@ static int __init acpi_irq_penalty_update(char *str, int used=
)
>>  			continue;
>> =20
>>  		if (used)
>> -			acpi_irq_penalty[irq] +=3D PIRQ_PENALTY_ISA_USED;
>> +			acpi_irq_penalty[irq] =3D acpi_irq_get_penalty(irq) +
>> +				PIRQ_PENALTY_ISA_USED;
>>  		else
>> -			acpi_irq_penalty[irq] =3D PIRQ_PENALTY_PCI_AVAILABLE;
>> +			acpi_irq_penalty[irq] =3D 0;
>> =20
>>  		if (retval !=3D 2)	/* no next number */
>>  			break;
>> @@ -819,34 +873,19 @@ static int __init acpi_irq_penalty_update(char *st=
r, int used)
>>   */
>>  void acpi_penalize_isa_irq(int irq, int active)  {
>> -	if (irq >=3D 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
>> -		if (active)
>> -			acpi_irq_penalty[irq] +=3D PIRQ_PENALTY_ISA_USED;
>> -		else
>> -			acpi_irq_penalty[irq] +=3D PIRQ_PENALTY_PCI_USING;
>> -	}
>> +	if (irq >=3D 0 && irq < ARRAY_SIZE(acpi_irq_penalty))
>> +		acpi_irq_penalty[irq] =3D acpi_irq_get_penalty(irq) +
>> +			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
>>  }
>> =20
>>  bool acpi_isa_irq_available(int irq)  {
>>  	return irq >=3D 0 && (irq >=3D ARRAY_SIZE(acpi_irq_penalty) ||
>> -			    acpi_irq_penalty[irq] < PIRQ_PENALTY_ISA_ALWAYS);
>> +		    acpi_irq_get_penalty(irq) < PIRQ_PENALTY_ISA_ALWAYS);
>>  }
>> =20
>> -/*
>> - * Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes=20
>> conflict with
>> - * PCI IRQ attributes, mark ACPI SCI as ISA_ALWAYS so it won't be=20
>> use for
>> - * PCI IRQs.
>> - */
>>  void acpi_penalize_sci_irq(int irq, int trigger, int polarity)  {
>> -	if (irq >=3D 0 && irq < ARRAY_SIZE(acpi_irq_penalty)) {
>> -		if (trigger !=3D ACPI_MADT_TRIGGER_LEVEL ||
>> -		    polarity !=3D ACPI_MADT_POLARITY_ACTIVE_LOW)
>> -			acpi_irq_penalty[irq] +=3D PIRQ_PENALTY_ISA_ALWAYS;
>> -		else
>> -			acpi_irq_penalty[irq] +=3D PIRQ_PENALTY_PCI_USING;
>> -	}
>>  }
>> =20
>>  /*
>> --
>> 1.8.2.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html


--
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux =
Foundation Collaborative Project
