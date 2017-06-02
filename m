Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750813AbdFBONO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jun 2017 10:13:14 -0400
Date: Fri, 2 Jun 2017 16:13:11 +0200
From: Jean Delvare <jdelvare@suse.de>
To: <Narendra.K@dell.com>
Cc: <x86@kernel.org>, <linux-pci@vger.kernel.org>,
        <Jordan.Hargrave@dell.com>, <Shyam.Iyer@dell.com>,
        <bhelgaas@google.com>
Subject: Re: dmi type 0xB1 record - unknown flag
Message-ID: <20170602161311.27eab72d@endymion>
In-Reply-To: <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
References: <20170601143826.5f980444@endymion>
 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Narendra,

Thanks for your answer.

On Thu, 1 Jun 2017 13:28:31 +0000, Narendra.K@dell.com wrote:
> > -----Original Message-----
> > From: Jean Delvare [mailto:jdelvare@suse.de]
> > I see the following message in my kernel log:
> > 
> > dmi type 0xB1 record - unknown flag
> > 
> > This is on a Dell Optiplex 9020 workstation. I see the message comes
> > from:
> > 
> > static void __init read_dmi_type_b1(const struct dmi_header *dm,
> >                                     void *private_data) {
> > 	(...)
> >         switch (((*(u32 *)d) >> 9) & 0x03) {
> >         case 0x00:
> >                 printk(KERN_INFO "dmi type 0xB1 record - unknown flag\n");
> >                 break;
> > 
> > What is the value of this message? Is there anything which needs to be done
> > to properly support such systems?  
> 
> This function was added to avoid adding systems to the 'pciprobe_dmi_table' and set breadth first sorting in a generic way.
> 
> This flag is a hint to indicate the sort method to be used. The value 0x01 indicates that PCI breadth first sort be used.
> ' find_sort_method' function checks if smbios_type_b1_flag is set to 1 and if yes, calls 'set_bf_sort '. This function sets ' pci_bf_sort' to 'pci_dmi_bf'.

I can read the code, thank you ;-)

> The value 0x00 is not a valid value. When the flag is 0x00, the sort method will be the default that is decided by the kernel.

How can it be invalid? I have DMI dumps of several Dell systems with a
type 0xB1 DMI structure, with value 0x00 for these bits. If Dell ships
such systems, then this is valid by definition.

> There is no additional handling required for such a system.

I don't understand the complexity of the code. There are 4 possible
values for these bits, the code treats all of them differently:
* 0x01, you set smbios_type_b1_flag to 1 and this later triggers a call
  to set_bf_sort().
* 0x02, you set smbios_type_b1_flag to 2 but this has no effect.
* 0x00, you print a rather cryptic info message which serves no purpose.
* 0x03, you do nothing.

On top of that, I can't see the value of the intermediate variable
smbios_type_b1_flag. The only situations where it would make a
difference is if multiple type 0xB1 structures with conflicting
information were present; but I don't think this is supposed to happen
in the first place.

Lastly I'm not sure why you continue processing the list of DMI
matches, when smbios_type_b1_flag == 1, and stop processing it if not.
This seems needlessly inconsistent.

I think the whole thing can be simplified like this:

From: Jean Delvare <jdelvare@suse.de>
Subject: x86/PCI: Simplify Dell DMI B1 quirk

No need for such convoluted code, when all we need is to call one
function in one specific case.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 arch/x86/pci/common.c |   27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

--- linux-4.11.orig/arch/x86/pci/common.c	2017-05-01 04:47:48.000000000 +0200
+++ linux-4.11/arch/x86/pci/common.c	2017-06-02 16:04:05.737889598 +0200
@@ -24,7 +24,6 @@ unsigned int pci_probe = PCI_PROBE_BIOS
 
 unsigned int pci_early_dump_regs;
 static int pci_bf_sort;
-static int smbios_type_b1_flag;
 int pci_routeirq;
 int noioapicquirk;
 #ifdef CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS
@@ -197,34 +196,18 @@ static int __init set_bf_sort(const stru
 static void __init read_dmi_type_b1(const struct dmi_header *dm,
 				    void *private_data)
 {
-	u8 *d = (u8 *)dm + 4;
+	u8 *data = (u8 *)dm + 4;
 
 	if (dm->type != 0xB1)
 		return;
-	switch (((*(u32 *)d) >> 9) & 0x03) {
-	case 0x00:
-		printk(KERN_INFO "dmi type 0xB1 record - unknown flag\n");
-		break;
-	case 0x01: /* set pci=bfsort */
-		smbios_type_b1_flag = 1;
-		break;
-	case 0x02: /* do not set pci=bfsort */
-		smbios_type_b1_flag = 2;
-		break;
-	default:
-		break;
-	}
+	if ((((*(u32 *)data) >> 9) & 0x03) == 0x01)
+		set_bf_sort((const struct dmi_system_id *)private_data);
 }
 
 static int __init find_sort_method(const struct dmi_system_id *d)
 {
-	dmi_walk(read_dmi_type_b1, NULL);
-
-	if (smbios_type_b1_flag == 1) {
-		set_bf_sort(d);
-		return 0;
-	}
-	return -1;
+	dmi_walk(read_dmi_type_b1, (void *)d);
+	return 0;
 }
 
 /*

What do you think?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
