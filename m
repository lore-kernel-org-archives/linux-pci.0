Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0069.outbound.protection.outlook.com ([104.47.41.69]:43916
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754947AbeAIKiP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 05:38:15 -0500
Subject: Re: [BISECTED] v4.15-rc: Boot regression on x86_64/AMD
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20180105220412.fzpwqe4zljdawr36@darkstar.musicnaut.iki.fi>
 <CA+55aFxCSWCG7ZvHW3AkLPzMPMAuG1BhL8fNgC0-JPYU4LZVow@mail.gmail.com>
 <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <628e2b58-b16b-5792-b4ef-88bec15ab779@amd.com>
Date: Tue, 9 Jan 2018 11:37:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAErSpo7dOfabXk9rpZr=B87wK4_Ao9_moK89Ze0cyi6Mqb0Z+Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------292CEB6B2E472794B49E0431"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------292CEB6B2E472794B49E0431
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 09.01.2018 um 00:23 schrieb Bjorn Helgaas:
> [+cc Boris, Juergen, linux-pci]
>
> On Fri, Jan 5, 2018 at 6:00 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Fri, Jan 5, 2018 at 2:04 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>>> After v4.14, I've been unable to boot my AMD compilation box with the
>>> v4.15-rc mainline Linux. It just ends up in a silent reboot loop.
>>>
>>> I bisected this to:
>>>
>>> commit fa564ad9636651fd11ec2c79c48dee844066f73a
>>> Author: Christian König <christian.koenig@amd.com>
>>> Date:   Tue Oct 24 14:40:29 2017 -0500
>>>
>>>      x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)
>> Hmm. That was reported to break boot earlier already.
>>
>> The breakage was supposedly fixed by three patches from Christian:
>>
>>    a19e2696135e: "x86/PCI: Only enable a 64bit BAR on single-socket AMD
>> Family 15h"
>>
>>    470195f82e4e:  "x86/PCI: Fix infinite loop in search for 64bit BAR placement"
>>
>> and a third one that was apparently never applied.
>>
>> I'm not sure why that third patch was never applied, I'm including it here.
>>
>> Does the system work for you if you apply that patch (instead of
>> reverting all of them)?
>>
>> I wonder why that patch wasn't applied, but if it doesn't fix things,
>> I think we do need to revert it all.
>>
>> Christian? Bjorn?
> I didn't apply the third patch ("x86/PCI: limit the size of the 64bit
> BAR to 256GB") because (a) we thought it was optional ("just a
> precaution against eventual problems"), (b) we didn't have a good
> explanation of why 256GB was the correct number, and (c)  it seemed to
> be a workaround for a Xen issue that we hoped to fix in a better way.

Just for the record completely agree on that.

> It does apparently make Aaro's system work, but I still hesitate to
> apply it because it's magical -- avoiding the address space from
> 0x1_00000000 to 0xbd_00000000 makes things work, but we don't know
> why.  I assume there's some unreported device in that area, but I
> don't think we have any real assurance that the
> 0xbd_00000000-0xfd_00000000 area we now use is any safer.

Well, I knew why it's not working. The BIOS is not telling us the truth 
about how much memory is installed.

A device above 4GB would actually be handled correctly by the code (see 
the check when we walk over all the existing IO regions).

I tested a bit with Aaro and came up with the attached patch, it adds a 
16GB guard between the end of memory and the new window for the PCIe 
root hub. But I agree with you that this is just a hack and not a real 
solution.

> I would feel better about this if we made it opt-in via a kernel
> parameter and/or some kind of whitelist.  I still don't really *like*
> it, since ACPI does provide a mechanism (_PRS/_SRS) for doing this
> safely, and we could just say "if you want to use big BARs, the BIOS
> should enable big windows or at least make them available via ACPI
> resources."  The only problem is that BIOSes don't do that and we
> don't yet have Linux support for _PRS/_SRS for host bridges.

Well that is the point I disagree on. When the memory map we get from 
the BIOS is not correct it makes no difference if we enable the window 
with the BIOS or by direct programming the hardware.

I will work with Aaron some more to come up with a solution which reads 
the memory map directly from the hardware as well and checks if that is 
valid before doing anything else.

> I'll prepare a revert as a back-up plan in case we don't come up with
> a better solution.

Either that or only enable it when pci=add-root-window is given on the 
kernel commandline.

Just let me know what you prefer and I will hack a patch for this 
together today.

Christian.

> Bjorn


--------------292CEB6B2E472794B49E0431
Content-Type: text/x-patch;
 name="0001-x86-PCI-add-16GB-guard-between-end-of-memory-and-new.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-x86-PCI-add-16GB-guard-between-end-of-memory-and-new.pa";
 filename*1="tch"

>From 101e157babcef10b91edf91e7e6f03826c2f8ade Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Date: Tue, 28 Nov 2017 10:02:35 +0100
Subject: [PATCH] x86/PCI: add 16GB guard between end of memory and new PCI
 window
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a workaround for buggy BIOS implementations who steal memory for
iGPUs from the OS without reporting it as reserved.

Signed-off-by: Christian König <christian.koenig@amd.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/x86/pci/fixup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index e663d6bf1328..e1bdae2cebb6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -713,6 +713,10 @@ static void pci_amd_enable_64bit_bar(struct pci_dev *dev)
 		}
 		res->start = conflict->end + 1;
 	}
+	/* Add 16GB guard between end of memory and new PCI window to work
+	 * around buggy BIOS implementations.
+	 */
+	res->start += 0x400000000ull;
 
 	dev_info(&dev->dev, "adding root bus resource %pR\n", res);
 
-- 
2.11.0


--------------292CEB6B2E472794B49E0431--
