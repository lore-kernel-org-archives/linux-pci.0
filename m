Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57565 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbbESDI3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 May 2015 23:08:29 -0400
Message-ID: <555AA8CD.3010706@redhat.com>
Date: Mon, 18 May 2015 23:06:53 -0400
From: Jarod Wilson <jarod@redhat.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci/hotplug: work-around for missing _RMV on HP ZBook
 G2
References: <1431632038-39917-1-git-send-email-jarod@redhat.com> <555A1093.40303@redhat.com> <555A4F68.1020208@redhat.com> <1948383.UKjRPomMUp@vostro.rjw.lan>
In-Reply-To: <1948383.UKjRPomMUp@vostro.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/18/2015 7:06 PM, Rafael J. Wysocki wrote:
> On Monday, May 18, 2015 04:45:28 PM Jarod Wilson wrote:
...
>>>>>>> On Thu, May 14, 2015 at 03:33:58PM -0400, Jarod Wilson wrote:
>>>>>>>> The HP ZBook 15 and 17 Mobile Workstations, generation 2, up to and
>>>>>>>> including at least BIOS revision 01.07, do not have an ACPI _RMV
>>>>>>>> object
>>>>>>>> associated with their expresscard slots, so acpi-based
>>>>>>>> hotplug-capable
>>>>>>>> slot detection fails. If we fall back to pcie-based detection, the
>>>>>>>> systems
>>>>>>>> work just fine
...
>> Ah, I forgot some additional details. pciehp_probe() in
>> drivers/pci/hotplug/pciehp_core.c fails on the
>> pciehp_acpi_slot_detection_check() call for the expresscard slot, which
>> is why the base pciehp doesn't bind. DEVICE_ACPI_HANDLE(&dev->dev) in
>> the slot detection check is winding up with a NULL acpi device.
>
> So IMO the bug is that select_detection_mode() assumes that ACPI should be
> used as the PCIe hotplug detection method if it has found at least one
> device that looks like an "ACPI hotplug slot" (Thuderbolt breaks that "logic").
>
> To be honest, I'm not sure why we need the pciehp_acpi_slot_detection_check()
> in pciehp_probe() at all.  It doesn't add any value as far as I can say.
>
> If pciehp_probe() is called at all, we have registered a PCIe port service
> and if this is a "hotplug" service, we wouldn't have registered it if the
> _OSC handshake had not given us contol over native hotplug.
>
> So I wonder if the patch below makes any difference.

Yeah, that also works, for the most part. You still get spew from 
pciehp_acpi_slot_detection_init() saying "Using ACPI for slot 
detection.", but in re-reading pciehp_acpi.c in its entirety... I can't 
see anything productive that it actually does. I'm of the mind that the 
entire file should just be nuked, the path from pciehp_core.c that your 
patch alters was the only one that called 
pciehp_acpi_slot_detection_check(), and everything else is basically the 
dummy probe and fluff, nothing meaningful actually happens. I can whip 
up a follow-up patch that neuters that file entirely in the morning. At 
the very least, the "Using ACPI" bit needs to be beaten into submission, 
since its not going to be accurate.

-- 
Jarod Wilson
jarod@redhat.com
