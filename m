Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:40802 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbaLDAvt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Dec 2014 19:51:49 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so12178881qcx.12
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2014 16:51:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Dec 2014 17:51:28 -0700
Message-ID: <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	zermond@gmail.com, David Airlie <airlied@linux.ie>,
	Yinghai Lu <yinghai@kernel.org>, saifi.khan@datasynergy.org,
	Alex Deucher <alexdeucher@gmail.com>, kordikmarek@gmail.com
Cc: Guo Chao <yan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Guo, Ben]

On Wed, Dec 3, 2014 at 3:15 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> There's a bugzilla for this, so this email is to make the bugzilla
> more discoverable and to have a more public discussion about it.
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=85491
>
> I think this regression is caused by 5b28541552ef ("PCI: Restrict
> 64-bit prefetchable bridge windows to 64-bit resources").
> ...

> In v3.16 (which does contain 5b28541552ef), when pbus_size_mem() sizes
> the 64-bit prefetchable window, it only looks for downstream 64-bit
> resources.  Since the radeon at 01:00.0 has none, we size the window
> to 0 + 0x200000 (the 0x200000 part is pci_hotplug_mem_size, to
> accommodate future hot-added devices).
> ...

> I don't know what the best fix is, but I think it's probably too
> aggressive to *never* use a 64-bit prefetchable window for downstream
> 32-bit prefetchable resources.  This configuration from BIOS should
> just work without us changing anything (although we probably should
> trim the window to start at 0xc0000000, which would still work).
>
> In this case, I think we certainly want the radeon BAR 0 in the
> prefetchable window.  In general, it seems wrong that a device with
> 32-bit BARs will work fine below a bridge with a 32-bit prefetchable
> window, but it won't work (or will work slower) below a bridge with a
> 64-bit prefetchable window.  A more capable bridge should make things
> work *better*, not worse.

5b28541552ef was added to fix https://bugzilla.kernel.org/show_bug.cgi?id=74151

In that case, there was a bridge with a 64-bit prefetchable window,
and downstream devices had 64-bit prefetchable BARs as well as
prefetchable 32-bit ROMs:

    pci 0006:00:00.0: PCI bridge to [bus 01]
    pci 0006:00:00.0:   bridge window [mem 0x3d24800000000-0x3d248007fffff]
    pci 0006:00:00.0:   bridge window [mem
0x3d24008000000-0x3d2400fffffff 64bit pref]

    pci 0006:01:00.0: reg 0x10: [mem 0x3d2400e000000-0x3d2400e007fff 64bit pref]
    pci 0006:01:00.0: reg 0x20: [mem 0x3d2400e030000-0x3d2400e030fff 64bit pref]
    pci 0006:01:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]

The problem was that we used to put all the prefetchable BARs in the
prefetchable window, which meant we had to put the window below 4GB
because the ROM BAR is only 32 bits.  But there wasn't enough space
below 4GB for all the other 64-bit BARs.

I think another way to fix the bug 74151 problem would have been to
put the ROMs in the non-prefetchable window and the 64-bit BARs in the
64-bit prefetchable window.

Bjorn
