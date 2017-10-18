Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Drake <drake@endlessm.com>
Date: Wed, 18 Oct 2017 16:36:49 +0800
Message-ID: <CAD8Lp47nOCt-93kBxmcJzUam=P7XRcm8vhwogoxXTJ_mwCH_Cg@mail.gmail.com>
Subject: PCIe legacy interrupts blocked on Intel Apollo Lake platforms
To: Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        x86@kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        AceLan Kao <acelan.kao@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[retitling and re-summarizing in hope of attention from Intel]

Andy / Rafael,

Thomas Gleixner suggested that you might be able to help with a nasty
issue related to Intel Apollo Lake platforms - or you can put us in
contact with another relevant person at Intel.

On Thu, Oct 5, 2017 at 6:13 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> We have tried taking the mini-PCIe wifi module out of one of the affected
>> Acer products and moved it to another computer, where it is working fine
>> with legacy interrupts. So this suggests that the wifi module itself is OK,
>> but we are facing a hardware limitation or BIOS limitation on the affected
>> products. In the Dell thread it says "Some platform(BIOS) blocks legacy
>> interrupts (INTx)".
>>
>> If you have any suggestions for how we might solve this without getting into
>> the MSI mess then that would be much appreciated. If the BIOS blocks the
>> interrupts, can Linux unblock them?
>
> I'm pretty sure we can. Cc'ed Rafael and Andy. They might know, if not they
> certainly know whom to ask @Intel.

To summarize the issue:

At least 8 new Acer consumer laptop products based on Intel Apollo
Lake are unable to deliver legacy interrupts from the ath9k miniPCIe
wifi card to the host. This results in wifi connectivity being
unusable on those systems.

This also seems to affect the 4 Dell systems included in this patch series:
  https://lkml.org/lkml/2017/9/26/55
at least 2 of which are also Apollo Lake (can't find specs for the other 2).

We know that the wifi module itself is OK, since we can take it to
another laptop and it delivers legacy interrupts just fine.

We know that this is not a fundamental limitation of Intel Apollo
Lake, since we have other Apollo Lake products in hand with ath9k wifi
modules and legacy interrupts work fine there.

We would like to switch to MSI interrupts instead, but unfortunately
ath9k seems to have a hardware bug in that it corrupts the MSI message
data, see:

  ath9k hardware corrupts MSI Message Data, raises wrong interrupt
  https://marc.info/?l=linux-pci&m=150238260826803&w=2

We have explored workarounds for this on the Linux side, but that has
turned out to be unattractive and impractical:

  [PATCH] PCI MSI: allow alignment restrictions on vector allocation
  https://marc.info/?t=150631283200001&r=1&w=2

Interrupt remapping could probably help us avoid this MSI problem, but
unfortunately that's not available on the affected platforms:

  DMAR table missing, Intel IOMMU not available
  https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023717.html

So now, digging for other options, I would like to explore the theory
mentioned on the Dell thread that the BIOS is blocking legacy
interrupts on these platforms. The question for Intel is: if the BIOS
is blocking legacy interrupts, can Linux unblock them? (and how)

I have Apollo Lake platforms here which exhibit the issue, and also
other Apollo Lake platforms that work fine, so let me know where I can
help look for differences (register dumps etc)

Thanks
Daniel
