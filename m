Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51751 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390AbbBCRGr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 3 Feb 2015 12:06:47 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo4SKP=nKdn43rE37JFNW5SSb4uRyRyO6vAO5tqa2TOpQg@mail.gmail.com>
References: <8761boas78.fsf@spindle.srvr.nix>
	<1422847799.2491.13.camel@zim.stowe>
	<87h9v42p22.fsf@spindle.srvr.nix>
	<CAErSpo4SKP=nKdn43rE37JFNW5SSb4uRyRyO6vAO5tqa2TOpQg@mail.gmail.com>
Date: Tue, 3 Feb 2015 10:06:46 -0700
Message-ID: <CAL-B5D1ytTtQ6JnzWW3VTL2PnM67nj8karxSf5u0e-pmSdZNMg@mail.gmail.com>
Subject: Re: [3.18.3 BISECTED REGRESSION] scx200_acb / cs5535-smb / geodewdt /
 cs5535-clockevt torpedoed
From: Myron Stowe <myron.stowe@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nix <nix@esperi.org.uk>, Myron Stowe <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Bill Unruh <unruh@physics.ubc.ca>, martin@lucina.net,
	Matthew Wilcox <willy@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 3, 2015 at 9:50 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Feb 2, 2015 at 11:36 AM, Nix <nix@esperi.org.uk> wrote:
>> On 2 Feb 2015, Myron Stowe verbalised:
>>
>>> Nix:
>>>
>>> Thanks for the work you've already done with the bisection.  Let's see
>>> if we can get to the bottom of this.  Would you capture two couple sets
>>> of logs, one without the issue and another set with the commit at issue
>>> included for comparison.
>
>>  pci 0000:00:14.0: [1022:2090] type 00 class 0x060100
>> -pci 0000:00:14.0: reg 0x10: [io  0x6000-0x7fff]
>> -pci 0000:00:14.0: reg 0x14: [io  0x6100-0x61ff]
>> -pci 0000:00:14.0: reg 0x18: [io  0x6200-0x63ff]
>>  pci 0000:00:14.0: CS5536 ISA bridge bug detected (incorrect header); workaround applied
>
>> +scx200_acb: can't allocate io 0x0-0x7
>
> I think the problem is that these three BARs are read-only.  Prior to
> 36e8164882ca, we didn't detect that, and we computed the size based on
> the lowest order bit that was set in the address.  This gave us
> incorrect sizes, but it did work in the sense that the driver could
> operate the device.
>
> After 36e8164882ca, we detect that the BARs are read-only and ignore
> them completely, which breaks this case because we don't mark the
> resource as I/O and we don't fill in the starting address, so even
> though the quirk runs, it just sets the first resource to [???
> 0x0000-0x0007], which doesn't work.
>
> I think this is the right behavior for the PCI core because we can't
> tell how big these BARs are.  The only alternative is to assume they
> are as big as possible given their current addresses.  But that would
> mean a 4KB read-only BAR that happened to be aligned on a 2GB boundary
> would have to consume 2GB of address space, and *that* doesn't seem
> reasonable.
>
> We already have a quirk for this device, so I think the best fix is to
> change the quirk so it reads these three BARs directly and restores
> the resources based on its hard-coded knowledge of how big they are.
>

I see Bjorn beat me to the punch.  Anyway here is what I was just
writing up in response ...

Nix:

Thanks very much for provinding the logs asked for earlier.  I've studied
the logs, code, and commit 3fdb9b9 and believe I now understand what is
occurring.

As you too pointed out, the issue concerns the device at 00:14.0.  From the
'dmesg' logs we see that on a good boot we get:
  pci 0000:00:14.0: reg 0x10: [io  0x6000-0x7fff]       // Bad: see below
  pci 0000:00:14.0: reg 0x14: [io  0x6100-0x61ff]
  pci 0000:00:14.0: reg 0x18: [io  0x6200-0x63ff]
  pci 0000:00:14.0: CS5536 ISA bridge bug detected (incorrect header);
  workaround applied
whereas with commit 3fdb9b9 applied we longer get the lines corresponding to
the device's BARs.

I believe this is due to this specific device's BARs as being non-conformant
with respect to PCI device BAR sizing.  Based on my analysis, all three BARs
always return fixed, read-only, values and thus commit 3fdb9b9 is detecting
such as it was designed to.

The difference in this case is we need these BARs.  In all the prior cases
where we detected read-only BARs we could ignore them with no consequenses
(see the patch series summary at: https://lkml.org/lkml/2014/10/30/637).

Note also that in the series I submitted upstream to detect non-conformant
BARs there were three patches and the latter added a message letting us know
such a BAR was encountered (https://lkml.org/lkml/2014/10/30/636).  It looks
like you are running a "stable" kernel, 3.18.5, and the warning message is
not present as the "stable" kernel updates only took in patch 1/3 and not
the subsequent two.

With commit 3fdb9b9 applied, no resource information was obtained for the
device.  Thus later, when the kernel's driver probed and tried to attach it
ended up failing since it could not acquire the needed resources:
  cs5535-gpio cs5535-gpio: can't request region
  cs5535-gpio: probe of cs5535-gpio failed with error -5
  cs5535-mfgpt cs5535-mfgpt: can't request region
  cs5535-mfgpt: probe of cs5535-mfgpt failed with error -5
  ...
  cs5535-smb: probe of cs5535-smb failed with error -5
  ...
  cs5535-clockevt: Could not allocate MFGPT timer


Focusing on the root issue, here is my analysis -
During PCI device discovery the kernel walks the bus and collects resource
information (see: drivers/pci/probe.c::__pci_read_base()).  Flowing the
pertinant parts based on specific values obtained from the 'dmesg' logs I
come up with this with respect to device 00:14.0 BAR 0 (prior to commit
3fdb9b9 being applied):

  #define PCI_BASE_ADDRESS_IO_MASK (~0x03UL)
  #define IO_SPACE_LIMIT ~(0UL)

  mask = 0xffffffff
  l = 0x00006001
  sz = 0x00006001       // See footnote [1] below; this is the key
  l &= PCI_BASE_ADDRESS_IO_MASK
  l = 0x00006000
  [ sz &= PCI_BASE_ADDRESS_IO_MASK ]    // commit 3fdb9b9
  [ sz = 0x00006000 ]                   // commit 3fdb9b9
  mask = PCI_BASE_ADDRESS_IO_MASK & (u32) IO_SPACE_LIMIT
  mask = 0xfffffffc

  sz = pci_size(l, sz, mask)
  sz = pci_size(base, maxbase, mask)
  sz = pci_size(0x00000000.00006000, 0x00000000.00006001, 0x00000000.fffffffc)
      u64 size = mask & maxbase
      size = 0x00000000.00006000
      size = (size & ~(size-1)) - 1
      size = (0x00000000.00006000 & ~(0x00000000.00005fff)) - 1
      size = (0x00000000.00006000 & 0xffffffff.ffffa000) - 1
      size = 0x00000000.00002000 - 1
      size = 0x00000000.00001fff
      if (base == maxbase && ((base | size) & mask) != mask)
          return 0      // base != maxbase so test is False
      return  0x00000000.00001fff
  sz = 0x1fff

  region.start = l
  region.start = 0x6000
  region.end = l + sz
  region.end = 0x7fff

The kernel ends up with an 8k IO Port region with start and end sizes of
0x6000 and 0x7fff respectively for BAR 0 as is confirmed in the "good boot"
'dmesg':
  pci 0000:00:14.0: reg 0x10: [io  0x6000-0x7fff]

[1] There are two issues here.  The largest range that an IO decoder can
request is 256 bytes.  This is rectified later by
drivers/pci/quirks.c::quirk_cs5536_vsa(), which truncates the range to 8
bytes (see: support.amd.com/TechDocs/31506_cs5535_databoot.pdf, sec 6.11, p
370 and sec 5.6.1, p 105).

The other issue is that the BARs of this device are non-conformant.  They
are not returning proper sizing infomation when sized.  Instead, they seem
to be returning hard-coded, read-only, values and this is the root cause at
play.

With commit 3fdb9b9 applied, the read-only BARs are detected and ignored:

  mask = 0xffffffff
  l = 0x00006001
  sz = 0x00006001       // For 8k, device should have returned 0xffffe001
  l &= PCI_BASE_ADDRESS_IO_MASK
  l = 0x00006000
  sz &= PCI_BASE_ADDRESS_IO_MASK        // commit 3fdb9b9
  sz = 0x00006000                       // commit 3fdb9b9
  mask = PCI_BASE_ADDRESS_IO_MASK & (u32) IO_SPACE_LIMIT
  mask = 0xfffffffc

  sz = pci_size(l, sz, mask)
  sz = pci_size(base, maxbase, mask)
  sz = pci_size(0x00000000.00006000, 0x00000000.00006000, 0x00000000.fffffffc)
      u64 size = mask & maxbase
      size = 0x00000000.00006000
      size = (size & ~(size-1)) - 1
      size = (0x00000000.00006000 & ~(0x00000000.00005fff)) - 1
      size = (0x00000000.00006000 & 0xffffffff.ffffa000) - 1
      size = 0x00000000.00002000 - 1
      size = 0x00000000.00001fff
      if (base == maxbase && ((base | size) & mask) != mask)
          // base == maxbase - this part of test is True
          // ((base | size) & mask) != mask - while this part is for
          // detecting another aspect, it is also True
          return 0
  sz = 0

  if (!sz)
    goto fail


As expressed above, I believe this device is non-conformant.  This could be
validated by instrumenting the kernel's sizing code in '__pci_read_base()';
specifically the initial 'pci_read_config_dword()'s of 'l' and 'sz'.

Whereas we have been able to ignore read-only BARs in past occurrances, this
time they are needed.  As such, I think we can solve this issue by expanding
the existing quirk for this device.  I'll work that up and post.  If you
would, please apply and test what is posted and report back.  In the mean
time, I would be interested in obtaining confirmation as to my belief that
this device's BARs are read-only (i.e. the instrumentation mentioned).  If
you have time and are willing I would appreaciate that.  If not, I'm
confident that is what is occurring and you can just stick with applying and
testing the expanded quirk patch I intend to post.

Thanks so much for your efforts,
 Myron


> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
