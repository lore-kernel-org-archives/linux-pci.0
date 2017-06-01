Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdFARAH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jun 2017 13:00:07 -0400
Date: Thu, 1 Jun 2017 11:59:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Narendra.K@dell.com
Cc: jdelvare@suse.de, x86@kernel.org, linux-pci@vger.kernel.org,
        Jordan.Hargrave@dell.com, Shyam.Iyer@dell.com, bhelgaas@google.com
Subject: Re: dmi type 0xB1 record - unknown flag
Message-ID: <20170601165959.GB12257@bhelgaas-glaptop.roam.corp.google.com>
References: <20170601143826.5f980444@endymion>
 <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <68181b62786540ed8ca6ab877151a98b@BLRX13MDC105.AMER.DELL.COM>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 01, 2017 at 01:28:31PM +0000, Narendra.K@dell.com wrote:
> > -----Original Message-----
> > From: Jean Delvare [mailto:jdelvare@suse.de]
> > Sent: Thursday, June 1, 2017 6:08 PM
> > To: x86@kernel.org; linux-pci@vger.kernel.org
> > Cc: K, Narendra <Narendra_K@Dell.com>; Hargrave, Jordan
> > <Jordan_Hargrave@Dell.com>; Iyer, Shyam <Shyam_Iyer@Dell.com>; Bjorn
> > Helgaas <bhelgaas@google.com>
> > Subject: dmi type 0xB1 record - unknown flag
> > 
> > Hi all,
> > 
> 
> Hi Jean,
> 
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
> > What is the value of this message? Is there anything which needs
> > to be done to properly support such systems?
> 
> This function was added to avoid adding systems to the
> 'pciprobe_dmi_table' and set breadth first sorting in a generic way.
> 
> This flag is a hint to indicate the sort method to be used. The
> value 0x01 indicates that PCI breadth first sort be used.  '
> find_sort_method' function checks if smbios_type_b1_flag is set to 1
> and if yes, calls 'set_bf_sort '. This function sets ' pci_bf_sort'
> to 'pci_dmi_bf'.
> 
> The value 0x00 is not a valid value. When the flag is 0x00, the sort
> method will be the default that is decided by the kernel.
> 
> There is no additional handling required for such a system.

That was added by 6e8af08dfa40 ("PCI: enable pci=bfsort by default on
future Dell systems").

The fact that BIOS supplied a B1 record with an unknown value (0)
looks like a Dell BIOS defect, which is ironic, considering that Dell
added this thing in the first place.

I think we should remove the message, since it is alarming to users
and they can't do anything about it anyway.

Bjorn
