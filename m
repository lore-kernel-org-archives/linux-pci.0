Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51308 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581AbbLLBQ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Dec 2015 20:16:29 -0500
Date: Fri, 11 Dec 2015 17:13:15 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Martin Mares <mj@ucw.cz>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] Add lspci support for Enhanced Allocation Capability.
Message-ID: <20151212011315.GA3924@sean.stalley.intel.com>
References: <1449872845-3596-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449872845-3596-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for doing this. I tried it out & everything worked well for me.
Only a couple things:

The memory regions described by EA also show up before the EA Capability
and appear as virtual, ex:
	Region 0: [virtual] Memory at 80000000 ...
I don't think we want these regions to be flagged as virtual.
I think this happens because lspci can't read/write to the BAR region,
and so it assumes it's looking at a VF.

The rest of my gripes are minor syntax stuff. see inline.

Thanks again,
Sean

On Fri, Dec 11, 2015 at 02:27:25PM -0800, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The PCISIG recently added the Enhanced Allocation Capability.  Decode
> it in lspci.
> 
> ---
> The specification is currently located here:
> 
> https://pcisig.com/sites/default/files/specification_documents/ECN_Enhanced_Allocation_23_Oct_2014_Final.pdf
> 
> Bjorn Helgaas recently merged Linux kernel support for EA, and Cavium
> ThunderX processors have implemented it.  This patch gives us a pretty
> view of the capability structure.
> 
> Thanks,
> David Daney
> 
> 
>  lib/header.h |   1 +
>  ls-caps.c    | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 143 insertions(+)
> 
> diff --git a/lib/header.h b/lib/header.h
> index f7cdee7..8c80e45 100644
> --- a/lib/header.h
> +++ b/lib/header.h
> @@ -203,6 +203,7 @@
>  #define  PCI_CAP_ID_MSIX	0x11	/* MSI-X */
>  #define  PCI_CAP_ID_SATA	0x12	/* Serial-ATA HBA */
>  #define  PCI_CAP_ID_AF		0x13	/* Advanced features of PCI devices integrated in PCIe root cplx */
> +#define  PCI_CAP_ID_EA		0x14	/* Enhanced Allocation */
>  #define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
>  #define PCI_CAP_FLAGS		2	/* Capability defined flags (16 bits) */
>  #define PCI_CAP_SIZEOF		4
> diff --git a/ls-caps.c b/ls-caps.c
> index c145ed6..dec47f4 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -1254,6 +1254,145 @@ cap_sata_hba(struct device *d, int where, int cap)
>      printf(" BAR??%d\n", bar);
>  }
>  
> +static const char *cap_ea_property(unsigned p)
> +{
> +  switch (p) {
> +  case 0x00:
> +    return "memory space, non-prefetchable";
> +  case 0x01:
> +    return "memory space, prefetchable";
> +  case 0x02:
> +    return "I/O space";
> +  case 0x03:
> +    return "VF memory space, prefetchable";
> +  case 0x04:
> +    return "VF memory space, non-prefetchable";
> +  case 0x05:
> +    return "allocation behind bridge, non-prefetchable memory";
> +  case 0x06:
> +    return "allocation behind bridge, prefetchable memory";
> +  case 0x07:
> +    return "allocation behind bridge, I/O space";
> +  case 0xfd:
> +    return "memory space resource unavailable for use";
> +  case 0xfe:
> +    return "I/O space resource unavailable for use";
> +  case 0xff:
> +    return "entry unavailable for use";
> +  default:
> +    return "reserved";
> +  }
> +}
> +
> +static void cap_ea(struct device *d, int where, int cap)
> +{
> +  unsigned int entry;
> +  int entry_base = where + 4;
> +  unsigned int num_entries = BITS((unsigned int)cap, 0, 6);
> +  u8 htype = get_conf_byte(d, PCI_HEADER_TYPE) & 0x7f;
> +
> +  printf("Enhanced Allocation: Num Entries=%u", num_entries);
CamelCase.
> +  if (htype == PCI_HEADER_TYPE_BRIDGE) {
> +    byte fixed_sub, fixed_sec;
> +
> +    entry_base += 4;
> +    if (!config_fetch(d, where + 4, 2)) {
> +      printf("\n");
> +      return;
> +    }
> +    fixed_sec = get_conf_byte(d, where + 4);
> +    fixed_sub = get_conf_byte(d, where + 4);
> +    printf(", secondary=%d, subordinate=%d", fixed_sec, fixed_sub);
> +  }
> +  printf("\n");
> +  if (verbose < 2)
> +    return;
> +
> +  for (entry = 0; entry < num_entries; entry++) {
> +    int max_offset_high_pos, has_base_high, has_max_offset_high;
> +    u32 entry_header;
> +    u32 base, max_offset;
> +    unsigned int es, bei, pp, sp, e, w;
> +
> +    if (!config_fetch(d, entry_base, 4))
> +      return;
> +    entry_header = get_conf_long(d, entry_base);
> +    es = BITS(entry_header, 0, 3);
> +    bei = BITS(entry_header, 4, 4);
> +    pp = BITS(entry_header, 8, 8);
> +    sp = BITS(entry_header, 16, 8);
> +    w = BITS(entry_header, 30, 1);
> +    e = BITS(entry_header, 31, 1);
> +    if (!config_fetch(d, entry_base + 4, es * 4))
> +      return;
> +    printf("\t\tEntry-%u: Enable%c Writable%c, Entry Size=%u\n", entry,
I would change this line to:
	printf("\t\tEntry %u: Enable%c Writable%c, EntrySize=%u\n", ...);
	Changes:         ^                              ^ 
	"-" after Entry to a " " (to match the "Region %i" used for BARs)
	make EntrySize CamelCase (to match the other fields in lspci)
> +	   e ? '+': '-',
> +	   w ? '+': '-', es);
> +    printf("\t\t\t BAR Equivalent Indicator (BEI): ");
> +    switch (bei) {
> +    case 0:
> +    case 1:
> +    case 2:
> +    case 3:
> +    case 4:
> +    case 5:
> +      printf("BAR%u", bei);
> +      break;
> +    case 6:
> +      printf("Resource behind function");
> +      break;
> +    case 7:
> +      printf("Not Indicated");
> +      break;
> +    case 8:
> +      printf("Expansion ROM");
> +      break;
> +    case 9:
> +    case 10:
> +    case 11:
> +    case 12:
> +    case 13:
> +    case 14:
> +      printf("VF-BAR%u", bei - 9);
> +      break;
> +    default:
> +      printf("Reserved");
> +      break;
> +    }
> +    printf("\n");
> +    printf("\t\t\t Primary Properties (PP): %s\n", cap_ea_property(pp));
> +    printf("\t\t\t Secondary Properties (SP): %s\n", cap_ea_property(sp));
"PP" & "SP" are probably sufficient, I don't think we need to write the whole thing out.

Also, for the case where the Primary property is valid, can we hide the Secondary property if it is 0xFF?
My concern is that people may read the "entry unavailable for use" line as a warning and think something is wrong.
Maybe it would be better to make it say "Secondary Properties (SP): Not Present", or something similar.

> +
> +    base = get_conf_long(d, entry_base + 4);
> +    has_base_high = ((base & 2) != 0);
> +    base &= ~3;
> +
> +    max_offset = get_conf_long(d, entry_base + 8);
> +    has_max_offset_high = ((max_offset & 2) != 0);
> +    max_offset |= 3;
> +    max_offset_high_pos = entry_base + 12;
> +
> +    printf("\t\t\t Base: ");
> +    if (has_base_high) {
> +      u32 base_high = get_conf_long(d, entry_base + 12);
> +
> +      printf("%x", base_high);
> +      max_offset_high_pos += 4;
> +    }
> +    printf("%08x\n", base);
> +
> +    printf("\t\t\t Max Offset: ");
CamelCase.
> +    if (has_max_offset_high) {
> +      u32 max_offset_high = get_conf_long(d, max_offset_high_pos);
> +
> +      printf("%x", max_offset_high);
> +    }
> +    printf("%08x\n", max_offset);
> +
> +    entry_base += 4 + 4 * es;
> +  }
> +}
> +
>  void
>  show_caps(struct device *d, int where)
>  {
> @@ -1348,6 +1487,9 @@ show_caps(struct device *d, int where)
>  	    case PCI_CAP_ID_AF:
>  	      cap_af(d, where);
>  	      break;
> +	    case PCI_CAP_ID_EA:
> +	      cap_ea(d, where, cap);
> +	      break;
>  	    default:
>  	      printf("#%02x [%04x]\n", id, cap);
>  	    }
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
