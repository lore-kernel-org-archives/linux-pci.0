Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:5895 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750952AbdFANjz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jun 2017 09:39:55 -0400
From: <Narendra.K@dell.com>
Cc: <Jordan.Hargrave@dell.com>, <Shyam.Iyer@dell.com>,
        <bhelgaas@google.com>, <Narendra.K@dell.com>
To: <jdelvare@suse.de>, <x86@kernel.org>, <linux-pci@vger.kernel.org>
Subject: RE: dmi type 0xB1 record - unknown flag
Date: Thu, 1 Jun 2017 13:28:31 +0000
Message-ID: <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
References: <20170601143826.5f980444@endymion>
In-Reply-To: <20170601143826.5f980444@endymion>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Jean Delvare [mailto:jdelvare@suse.de]
> Sent: Thursday, June 1, 2017 6:08 PM
> To: x86@kernel.org; linux-pci@vger.kernel.org
> Cc: K, Narendra <Narendra_K@Dell.com>; Hargrave, Jordan
> <Jordan_Hargrave@Dell.com>; Iyer, Shyam <Shyam_Iyer@Dell.com>; Bjorn
> Helgaas <bhelgaas@google.com>
> Subject: dmi type 0xB1 record - unknown flag
>=20
> Hi all,
>=20

Hi Jean,

> I see the following message in my kernel log:
>=20
> dmi type 0xB1 record - unknown flag
>=20
> This is on a Dell Optiplex 9020 workstation. I see the message comes
> from:
>=20
> static void __init read_dmi_type_b1(const struct dmi_header *dm,
>                                     void *private_data) {
> 	(...)
>         switch (((*(u32 *)d) >> 9) & 0x03) {
>         case 0x00:
>                 printk(KERN_INFO "dmi type 0xB1 record - unknown flag\n")=
;
>                 break;
>=20
> What is the value of this message? Is there anything which needs to be do=
ne
> to properly support such systems?

This function was added to avoid adding systems to the 'pciprobe_dmi_table'=
 and set breadth first sorting in a generic way.

This flag is a hint to indicate the sort method to be used. The value 0x01 =
indicates that PCI breadth first sort be used.
' find_sort_method' function checks if smbios_type_b1_flag is set to 1 and =
if yes, calls 'set_bf_sort '. This function sets ' pci_bf_sort' to 'pci_dmi=
_bf'.

The value 0x00 is not a valid value. When the flag is 0x00, the sort method=
 will be the default that is decided by the kernel.

There is no additional handling required for such a system.

With regards,
Narendra K
