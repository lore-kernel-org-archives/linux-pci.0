Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14217 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab2GQOPG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 17 Jul 2012 10:15:06 -0400
Date: Tue, 17 Jul 2012 10:14:59 -0400
From: Jason Baron <jbaron@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/5] PCI, acpiphp: add is_hotplug_bridge detection
Message-ID: <20120717141459.GD2463@redhat.com>
References: <1340437325-29282-1-git-send-email-yinghai@kernel.org>
 <1340437325-29282-5-git-send-email-yinghai@kernel.org>
 <CAErSpo7SS1N+h+VyGoCBq5HCMezvFAonRZR-pqsYezVHX2-_2w@mail.gmail.com>
 <20120711171458.GA14610@redhat.com>
 <CAErSpo6Xdc-rDvvipJFzXbbF3V75zSBq4skMtZ2PDVsz1kxtdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo6Xdc-rDvvipJFzXbbF3V75zSBq4skMtZ2PDVsz1kxtdw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2012 at 01:42:15PM -0600, Bjorn Helgaas wrote:
> On Wed, Jul 11, 2012 at 11:14 AM, Jason Baron <jbaron@redhat.com> wrote:
> > On Wed, Jul 11, 2012 at 09:50:19AM -0600, Bjorn Helgaas wrote:
> >> On Sat, Jun 23, 2012 at 1:42 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> >> > When system support hotplug bridge with children hotplug slots, we need to make sure
> >> > that parent bridge get preallocated resource so later when device is plugged into
> >> > children slot, those children devices will get resource allocated.
> >> >
> >> > We do not meet this problem, because for pcie hotplug card, when acpiphp is used,
> >> > pci_scan_bridge will set that for us when detect hotplug bit in slot cap.
> >> >
> >> > Reported-and-tested-by: Jason Baron <jbaron@redhat.com>
> >> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> >> > Acked-by: Jason Baron <jbaron@redhat.com>
> >> > ---
> >> >  drivers/pci/hotplug/acpiphp_glue.c |   27 ++++++++++++++++++++++++++-
> >> >  1 files changed, 26 insertions(+), 1 deletions(-)
> >> >
> >> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> >> > index ad6fd66..0f2b72d 100644
> >> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> >> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> >> > @@ -783,6 +783,29 @@ static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
> >> >         }
> >> >  }
> >> >
> >> > +static void check_hotplug_bridge(struct acpiphp_slot *slot, struct pci_dev *dev)
> >> > +{
> >> > +       struct acpiphp_func *func;
> >> > +
> >> > +       if (!dev->subordinate)
> >> > +               return;
> >> > +
> >> > +       /* quirk, or pcie could set it already */
> >> > +       if (dev->is_hotplug_bridge)
> >> > +               return;
> >> > +
> >> > +       if (PCI_SLOT(dev->devfn) != slot->device)
> >> > +               return;
> >> > +
> >> > +       list_for_each_entry(func, &slot->funcs, sibling) {
> >> > +               if (PCI_FUNC(dev->devfn) == func->function) {
> >> > +                       /* check if this bridge has ejectable slots */
> >> > +                       if ((detect_ejectable_slots(func->handle) > 0))
> >> > +                               dev->is_hotplug_bridge = 1;
> >> > +                       break;
> >> > +               }
> >> > +       }
> >> > +}
> >> >  /**
> >> >   * enable_device - enable, configure a slot
> >> >   * @slot: slot to be enabled
> >> > @@ -817,8 +840,10 @@ static int __ref enable_device(struct acpiphp_slot *slot)
> >> >                         if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
> >> >                             dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
> >> >                                 max = pci_scan_bridge(bus, dev, max, pass);
> >> > -                               if (pass && dev->subordinate)
> >> > +                               if (pass && dev->subordinate) {
> >> > +                                       check_hotplug_bridge(slot, dev);
> >>
> >> I don't like this patch because it increases the differences between
> >> the hotplug drivers, rather than decreasing them.
> >>
> >> For PCI Express devices, we set dev->is_hotplug_bridge in the
> >> pci_setup_device() path (in set_pcie_hotplug_bridge()).  I think it
> >> would make sense to try to expand that path to also handle SHPC and
> >> ACPI hotplug as well.  ACPI is harder because it's not PCI-specified,
> >> so we'd need some sort of pcibios or other optional hook.
> >>
> >> I don't have a clear picture of how this works -- if I understand
> >> correctly, the situation is that we have a bridge managed by acpiphp.
> >> That part makes sense because the bridge is on the motherboard and can
> >> have a DSDT device.  Now we plug something into the slot below the
> >> bridge.  I *think* this patch handles the case where this new
> >> hot-added thing is also a bridge managed by acpiphp.  But where does
> >> the ACPI device for this hot-added bridge come from?  It's an
> >> arbitrary device the BIOS knows nothing about, so it can't be in the
> >> DSDT.
> >>
> >
> > So this came up while I was developing pci bridge hotplug for qemu.
> > Currently, there is a top level host bus (with ACPI device definitions), where
> > devices can be hot-plugged. What I've done is added a second level
> > of hotplug pci busses (again with ACPI device definitions). Thus, we can
> > now hotplug a bridge into the top-level bus and then devices behind it.
> > Effectively increasing the hot-plug space from n -> n^2.
> >
> > Before the above pci patch, the devices behind the bridge would not
> > configure their PCI BARs properly, since there were no i/o, mem resources
> > assigned to the bridge. However, with the above patch in place things
> > work as expected.
> >
> > Using the same code base I was able to do acpi hotplug on Windows 7,
> > which correctly configured the both the bridge window and devices behind
> > it on hot-plug. So currently, the above usage pattern works on Windows
> > 7, but not on Linux.
> 
> Thanks, Jason.  Do you have "lspci -v" output and the DSDT AML handy?
> I'd like to look in more detail at what we're missing.

Hi,

Sorry for the delay...was on vacation.

Anyways, below is the patch I have to the seabios acpi table. However,
there are other pieces for seabios and qemu required. I still need to
clean them up and send them out. But this pci patch (or something
similar) is a required dependency.

What 'lspci -v' output are you looking for?

Let me know what else I can provide.

Thanks,

-Jason


--- a/src/ssdt-pcihp.dsl
+++ b/src/ssdt-pcihp.dsl
@@ -17,82 +17,162 @@ DefinitionBlock ("ssdt-pcihp.aml", "SSDT", 0x01, "BXPC", "BXSSDTPCIHP", 0x1)
         // at runtime, if the slot is detected to not support hotplug.
         // Extract the offset of the address dword and the
         // _EJ0 name to allow this patching.
-#define hotplug_slot(slot)                              \
-        Device (S##slot) {                              \
-           ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword  \
-           Name (_ADR, 0x##slot##0000)                  \
-           ACPI_EXTRACT_METHOD_STRING aml_ej0_name      \
-           Method (_EJ0, 1) { Return(PCEJ(0x##slot)) }  \
-           Name (_SUN, 0x##slot)                        \
-        }
+#define hotplug_level2_slot(slot1, slot2)                   \
+        Device (S##slot2) {                                 \
+           Name (_ADR, 0x##slot2##0000)                     \
+           Method (_EJ0, 1) { Return(PCEJ(0x##slot1, 0x##slot2)) } \
+           Name (_SUN, 0x##slot2)                           \
+        }                                                   \
+
+#define hotplug_top_level_slot(slot)                          \
+        Device (S##slot) {                                    \
+            ACPI_EXTRACT_NAME_DWORD_CONST aml_adr_dword       \
+            Name (_ADR,0x##slot##0000)                        \
+            ACPI_EXTRACT_METHOD_STRING aml_ej0_name           \
+            Method (_EJ0, 1) { Return(PCEJ(0x##slot, 0x00)) } \
+            Name (_SUN, 0x##slot)                             \
+            hotplug_level2_slot(slot, 01)                     \
+            hotplug_level2_slot(slot, 02)                     \
+            hotplug_level2_slot(slot, 03)                     \
+            hotplug_level2_slot(slot, 04)                     \
+            hotplug_level2_slot(slot, 05)                     \
+            hotplug_level2_slot(slot, 06)                     \
+            hotplug_level2_slot(slot, 07)                     \
+            hotplug_level2_slot(slot, 08)                     \
+            hotplug_level2_slot(slot, 09)                     \
+            hotplug_level2_slot(slot, 0a)                     \
+            hotplug_level2_slot(slot, 0b)                     \
+            hotplug_level2_slot(slot, 0c)                     \
+            hotplug_level2_slot(slot, 0d)                     \
+            hotplug_level2_slot(slot, 0e)                     \
+            hotplug_level2_slot(slot, 0f)                     \
+            hotplug_level2_slot(slot, 10)                     \
+            hotplug_level2_slot(slot, 11)                     \
+            hotplug_level2_slot(slot, 12)                     \
+            hotplug_level2_slot(slot, 13)                     \
+            hotplug_level2_slot(slot, 14)                     \
+            hotplug_level2_slot(slot, 15)                     \
+            hotplug_level2_slot(slot, 16)                     \
+            hotplug_level2_slot(slot, 17)                     \
+            hotplug_level2_slot(slot, 18)                     \
+            hotplug_level2_slot(slot, 19)                     \
+            hotplug_level2_slot(slot, 1a)                     \
+            hotplug_level2_slot(slot, 1b)                     \
+            hotplug_level2_slot(slot, 1c)                     \
+            hotplug_level2_slot(slot, 1d)                     \
+            hotplug_level2_slot(slot, 1e)                     \
+            hotplug_level2_slot(slot, 1f)                     \
+        }                                                     \
+
+        hotplug_top_level_slot(01)
+        hotplug_top_level_slot(02)
+        hotplug_top_level_slot(03)
+        hotplug_top_level_slot(04)
+        hotplug_top_level_slot(05)
+        hotplug_top_level_slot(06)
+        hotplug_top_level_slot(07)
+        hotplug_top_level_slot(08)
+        hotplug_top_level_slot(09)
+        hotplug_top_level_slot(0a)
+        hotplug_top_level_slot(0b)
+        hotplug_top_level_slot(0c)
+        hotplug_top_level_slot(0d)
+        hotplug_top_level_slot(0e)
+        hotplug_top_level_slot(0f)
+        hotplug_top_level_slot(10)
+        hotplug_top_level_slot(11)
+        hotplug_top_level_slot(12)
+        hotplug_top_level_slot(13)
+        hotplug_top_level_slot(14)
+        hotplug_top_level_slot(15)
+        hotplug_top_level_slot(16)
+        hotplug_top_level_slot(17)
+        hotplug_top_level_slot(18)
+        hotplug_top_level_slot(19)
+        hotplug_top_level_slot(1a)
+        hotplug_top_level_slot(1b)
+        hotplug_top_level_slot(1c)
+        hotplug_top_level_slot(1d)
+        hotplug_top_level_slot(1e)
+        hotplug_top_level_slot(1f)
 
-        hotplug_slot(01)
-        hotplug_slot(02)
-        hotplug_slot(03)
-        hotplug_slot(04)
-        hotplug_slot(05)
-        hotplug_slot(06)
-        hotplug_slot(07)
-        hotplug_slot(08)
-        hotplug_slot(09)
-        hotplug_slot(0a)
-        hotplug_slot(0b)
-        hotplug_slot(0c)
-        hotplug_slot(0d)
-        hotplug_slot(0e)
-        hotplug_slot(0f)
-        hotplug_slot(10)
-        hotplug_slot(11)
-        hotplug_slot(12)
-        hotplug_slot(13)
-        hotplug_slot(14)
-        hotplug_slot(15)
-        hotplug_slot(16)
-        hotplug_slot(17)
-        hotplug_slot(18)
-        hotplug_slot(19)
-        hotplug_slot(1a)
-        hotplug_slot(1b)
-        hotplug_slot(1c)
-        hotplug_slot(1d)
-        hotplug_slot(1e)
-        hotplug_slot(1f)
+#define gen_pci_level2_hotplug(slot1, slot2) \
+            If (LEqual(Arg0, 0x##slot1)) { \
+                If (LEqual(Arg1, 0x##slot2)) { \
+                    Notify(\_SB.PCI0.S##slot1.S##slot2, Arg2) \
+                } \
+            } \
 
-#define gen_pci_hotplug(slot)   \
-            If (LEqual(Arg0, 0x##slot)) { Notify(S##slot, Arg1) }
+#define gen_pci_top_level_hotplug(slot)   \
+            If (LEqual(Arg1, Zero)) { \
+                If (LEqual(Arg0, 0x##slot)) { \
+                    Notify(S##slot, Arg2) \
+                } \
+            } \
+            gen_pci_level2_hotplug(slot, 01) \
+            gen_pci_level2_hotplug(slot, 02) \
+            gen_pci_level2_hotplug(slot, 03) \
+            gen_pci_level2_hotplug(slot, 04) \
+            gen_pci_level2_hotplug(slot, 05) \
+            gen_pci_level2_hotplug(slot, 06) \
+            gen_pci_level2_hotplug(slot, 07) \
+            gen_pci_level2_hotplug(slot, 08) \
+            gen_pci_level2_hotplug(slot, 09) \
+            gen_pci_level2_hotplug(slot, 0a) \
+            gen_pci_level2_hotplug(slot, 0b) \
+            gen_pci_level2_hotplug(slot, 0c) \
+            gen_pci_level2_hotplug(slot, 0d) \
+            gen_pci_level2_hotplug(slot, 0e) \
+            gen_pci_level2_hotplug(slot, 0f) \
+            gen_pci_level2_hotplug(slot, 10) \
+            gen_pci_level2_hotplug(slot, 11) \
+            gen_pci_level2_hotplug(slot, 12) \
+            gen_pci_level2_hotplug(slot, 13) \
+            gen_pci_level2_hotplug(slot, 14) \
+            gen_pci_level2_hotplug(slot, 15) \
+            gen_pci_level2_hotplug(slot, 16) \
+            gen_pci_level2_hotplug(slot, 17) \
+            gen_pci_level2_hotplug(slot, 18) \
+            gen_pci_level2_hotplug(slot, 19) \
+            gen_pci_level2_hotplug(slot, 1a) \
+            gen_pci_level2_hotplug(slot, 1b) \
+            gen_pci_level2_hotplug(slot, 1c) \
+            gen_pci_level2_hotplug(slot, 1d) \
+            gen_pci_level2_hotplug(slot, 1e) \
+            gen_pci_level2_hotplug(slot, 1f) \
 
-        Method(PCNT, 2) {
-            gen_pci_hotplug(01)
-            gen_pci_hotplug(02)
-            gen_pci_hotplug(03)
-            gen_pci_hotplug(04)
-            gen_pci_hotplug(05)
-            gen_pci_hotplug(06)
-            gen_pci_hotplug(07)
-            gen_pci_hotplug(08)
-            gen_pci_hotplug(09)
-            gen_pci_hotplug(0a)
-            gen_pci_hotplug(0b)
-            gen_pci_hotplug(0c)
-            gen_pci_hotplug(0d)
-            gen_pci_hotplug(0e)
-            gen_pci_hotplug(0f)
-            gen_pci_hotplug(10)
-            gen_pci_hotplug(11)
-            gen_pci_hotplug(12)
-            gen_pci_hotplug(13)
-            gen_pci_hotplug(14)
-            gen_pci_hotplug(15)
-            gen_pci_hotplug(16)
-            gen_pci_hotplug(17)
-            gen_pci_hotplug(18)
-            gen_pci_hotplug(19)
-            gen_pci_hotplug(1a)
-            gen_pci_hotplug(1b)
-            gen_pci_hotplug(1c)
-            gen_pci_hotplug(1d)
-            gen_pci_hotplug(1e)
-            gen_pci_hotplug(1f)
+        Method(PCNT, 3) {
+            gen_pci_top_level_hotplug(01)
+            gen_pci_top_level_hotplug(02)
+            gen_pci_top_level_hotplug(03)
+            gen_pci_top_level_hotplug(04)
+            gen_pci_top_level_hotplug(05)
+            gen_pci_top_level_hotplug(06)
+            gen_pci_top_level_hotplug(07)
+            gen_pci_top_level_hotplug(08)
+            gen_pci_top_level_hotplug(09)
+            gen_pci_top_level_hotplug(0a)
+            gen_pci_top_level_hotplug(0b)
+            gen_pci_top_level_hotplug(0c)
+            gen_pci_top_level_hotplug(0d)
+            gen_pci_top_level_hotplug(0e)
+            gen_pci_top_level_hotplug(0f)
+            gen_pci_top_level_hotplug(10)
+            gen_pci_top_level_hotplug(11)
+            gen_pci_top_level_hotplug(12)
+            gen_pci_top_level_hotplug(13)
+            gen_pci_top_level_hotplug(14)
+            gen_pci_top_level_hotplug(15)
+            gen_pci_top_level_hotplug(16)
+            gen_pci_top_level_hotplug(17)
+            gen_pci_top_level_hotplug(18)
+            gen_pci_top_level_hotplug(19)
+            gen_pci_top_level_hotplug(1a)
+            gen_pci_top_level_hotplug(1b)
+            gen_pci_top_level_hotplug(1c)
+            gen_pci_top_level_hotplug(1d)
+            gen_pci_top_level_hotplug(1e)
+            gen_pci_top_level_hotplug(1f)
         }
     }
 
