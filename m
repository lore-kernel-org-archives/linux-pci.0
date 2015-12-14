Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19292 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121AbbLNTKv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Dec 2015 14:10:51 -0500
Date: Mon, 14 Dec 2015 11:07:21 -0800
From: "Sean O. Stalley" <sean.stalley@intel.com>
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>, Martin Mares <mj@ucw.cz>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] Add lspci support for Enhanced Allocation Capability.
Message-ID: <20151214190720.GA2944@sean.stalley.intel.com>
References: <1449872845-3596-1-git-send-email-ddaney.cavm@gmail.com>
 <20151212011315.GA3924@sean.stalley.intel.com>
 <566B78B6.4070109@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <566B78B6.4070109@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 11, 2015 at 05:30:30PM -0800, David Daney wrote:
> On 12/11/2015 05:13 PM, Sean O. Stalley wrote:
> >Thanks for doing this. I tried it out & everything worked well for me.
> >Only a couple things:
> >
> >The memory regions described by EA also show up before the EA Capability
> >and appear as virtual, ex:
> >	Region 0: [virtual] Memory at 80000000 ...
> 
> We are just dumping out the config space.  lspci doesn't really know
> where the kernel gets the reported BAR values.
> 
> I don't think we want to suppress the dumping of the BARs, or the
> kernel's interpretation thereof.

That's a good point. I guess we should keep dumping the BARs.
I still think we should change the [virtual] flag though.

lspci assumes that if the OS reports a region and configspace doesn't,
that the region came from an SR-IOV entry.

Before EA, this was a safe assumption. Now regions can come from EA entries,
we can't assume that a region with no BAR is always virtual.


Also, I just noticed that show_size() assumes power-of-2 sizes for regions.
It doesn't look like it will display some EA-supported sizes correctly
(Ex: 1110 bytes would get truncated and show up as " [size=1K]").

> >I don't think we want these regions to be flagged as virtual.
> >I think this happens because lspci can't read/write to the BAR region,
> >and so it assumes it's looking at a VF.
> >
> >The rest of my gripes are minor syntax stuff. see inline.
> >
> >Thanks again,
> >Sean
> >
> >On Fri, Dec 11, 2015 at 02:27:25PM -0800, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> [...]
> >>--- a/ls-caps.c
> >>+++ b/ls-caps.c
> >>@@ -1254,6 +1254,145 @@ cap_sata_hba(struct device *d, int where, int cap)
> >>      printf(" BAR??%d\n", bar);
> >>  }
> >>
> [...]
> >>+static void cap_ea(struct device *d, int where, int cap)
> >>+{
> >>+  unsigned int entry;
> >>+  int entry_base = where + 4;
> >>+  unsigned int num_entries = BITS((unsigned int)cap, 0, 6);
> >>+  u8 htype = get_conf_byte(d, PCI_HEADER_TYPE) & 0x7f;
> >>+
> >>+  printf("Enhanced Allocation: Num Entries=%u", num_entries);
> >CamelCase.
> 
> Those are the names from the specification, I would like to keep
> them in some form.  As noted below, it may be desirable to squash it
> to "NumEntries"

Agreed. see below.

> >>+  if (htype == PCI_HEADER_TYPE_BRIDGE) {
> >>+    byte fixed_sub, fixed_sec;
> >>+
> >>+    entry_base += 4;
> >>+    if (!config_fetch(d, where + 4, 2)) {
> >>+      printf("\n");
> >>+      return;
> >>+    }
> >>+    fixed_sec = get_conf_byte(d, where + 4);
> >>+    fixed_sub = get_conf_byte(d, where + 4);
> >>+    printf(", secondary=%d, subordinate=%d", fixed_sec, fixed_sub);
> >>+  }
> >>+  printf("\n");
> >>+  if (verbose < 2)
> >>+    return;
> >>+
> >>+  for (entry = 0; entry < num_entries; entry++) {
> >>+    int max_offset_high_pos, has_base_high, has_max_offset_high;
> >>+    u32 entry_header;
> >>+    u32 base, max_offset;
> >>+    unsigned int es, bei, pp, sp, e, w;
> >>+
> >>+    if (!config_fetch(d, entry_base, 4))
> >>+      return;
> >>+    entry_header = get_conf_long(d, entry_base);
> >>+    es = BITS(entry_header, 0, 3);
> >>+    bei = BITS(entry_header, 4, 4);
> >>+    pp = BITS(entry_header, 8, 8);
> >>+    sp = BITS(entry_header, 16, 8);
> >>+    w = BITS(entry_header, 30, 1);
> >>+    e = BITS(entry_header, 31, 1);
> >>+    if (!config_fetch(d, entry_base + 4, es * 4))
> >>+      return;
> >>+    printf("\t\tEntry-%u: Enable%c Writable%c, Entry Size=%u\n", entry,
> >I would change this line to:
> >	printf("\t\tEntry %u: Enable%c Writable%c, EntrySize=%u\n", ...);
> 
> We could do that.  I would let others decide if squashing "Entry
> Size" to "EntrySize" is desirable.

Sounds good. Lets see what others want.
I don't care too much either way,
I just thought CamelCase would make EA stuff slightly easier to grep.

> >	Changes:         ^                              ^
> >	"-" after Entry to a " " (to match the "Region %i" used for BARs)
> >	make EntrySize CamelCase (to match the other fields in lspci)
> [...]
> >>+    printf("\n");
> >>+    printf("\t\t\t Primary Properties (PP): %s\n", cap_ea_property(pp));
> >>+    printf("\t\t\t Secondary Properties (SP): %s\n", cap_ea_property(sp));
> >"PP" & "SP" are probably sufficient, I don't think we need to write the whole thing out.
> >
> >Also, for the case where the Primary property is valid, can we hide the Secondary property if it is 0xFF?
> >My concern is that people may read the "entry unavailable for use" line as a warning and think something is wrong.
> >Maybe it would be better to make it say "Secondary Properties (SP): Not Present", or something similar.
> >
> 
> That is a good point.  I will try something like that.
> 
> >>+
> >>+    base = get_conf_long(d, entry_base + 4);
> >>+    has_base_high = ((base & 2) != 0);
> >>+    base &= ~3;
> >>+
> >>+    max_offset = get_conf_long(d, entry_base + 8);
> >>+    has_max_offset_high = ((max_offset & 2) != 0);
> >>+    max_offset |= 3;
> >>+    max_offset_high_pos = entry_base + 12;
> >>+
> >>+    printf("\t\t\t Base: ");
> >>+    if (has_base_high) {
> >>+      u32 base_high = get_conf_long(d, entry_base + 12);
> >>+
> >>+      printf("%x", base_high);
> >>+      max_offset_high_pos += 4;
> >>+    }
> >>+    printf("%08x\n", base);
> >>+
> >>+    printf("\t\t\t Max Offset: ");
> >CamelCase.
> 
> Again, I am trying to match the wording of the specification.
> Although in this case I think I got it wrong.  It should probably be
> squashed to "MaxOffset'
> 
> [...]
> 
> Thanks for reviewing it.
> 
> David Daney
> 
