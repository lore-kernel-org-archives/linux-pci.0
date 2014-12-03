Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:39006 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaLCWPy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Dec 2014 17:15:54 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so11733698qcx.40
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2014 14:15:53 -0800 (PST)
MIME-Version: 1.0
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 3 Dec 2014 15:15:32 -0700
Message-ID: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
Subject: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during GPU init
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	zermond@gmail.com, David Airlie <airlied@linux.ie>,
	Yinghai Lu <yinghai@kernel.org>, saifi.khan@datasynergy.org,
	Alex Deucher <alexdeucher@gmail.com>, kordikmarek@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

There's a bugzilla for this, so this email is to make the bugzilla
more discoverable and to have a more public discussion about it.

  https://bugzilla.kernel.org/show_bug.cgi?id=85491

I think this regression is caused by 5b28541552ef ("PCI: Restrict
64-bit prefetchable bridge windows to 64-bit resources").  These dmesg
fragments are from v3.16, which doesn't work:

    pci_bus 0000:00: root bus resource [mem 0xc0000000-0xffffffff]

    pci 0000:00:01.0: PCI bridge to [bus 01]
    pci 0000:00:01.0:   bridge window [io  0x8000-0xafff]
    pci 0000:00:01.0:   bridge window [mem 0xfdf00000-0xfdffffff]
    pci 0000:00:01.0:   bridge window [mem 0xbdf00000-0xddefffff 64bit
pref]  <-- outside host bridge window

    pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
    pci 0000:01:00.0: reg 0x14: [io  0xa000-0xa0ff]
    pci 0000:01:00.0: reg 0x18: [mem 0xfdff0000-0xfdffffff]
    pci 0000:01:00.0: reg 0x30: [mem 0xfdfc0000-0xfdfdffff pref]

    pci 0000:00:01.0: can't claim BAR 15 [mem 0xbdf00000-0xddefffff
64bit pref]: no compatible bridge window
    pci 0000:01:00.0: can't claim BAR 0 [mem 0xc0000000-0xcfffffff
pref]: no compatible bridge window

    pci 0000:00:01.0: bridge window [mem 0x00100000-0x000fffff 64bit
pref] to [bus 01] add_size 200000
    pci 0000:00:01.0: res[15]=[mem 0x00100000-0x000fffff 64bit pref]
get_res_add_size add_size 200000  <-- size == 0
    pci 0000:00:01.0: BAR 15: assigned [mem 0xc0000000-0xc01fffff 64bit pref]
    pci 0000:00:01.0: PCI bridge to [bus 01]
    pci 0000:00:01.0:   bridge window [io  0x8000-0xafff]
    pci 0000:00:01.0:   bridge window [mem 0xfdf00000-0xfdffffff]
    pci 0000:00:01.0:   bridge window [mem 0xc0000000-0xc01fffff 64bit pref]

The initial 00:01.0 64bit pref window is interesting because it
doesn't fit in the host bridge window.  Probably a BIOS bug, but we
should be able to deal with it.  In v3.15 (which doesn't contain
5b28541552ef), we assign [mem 0xc0000000-0xcfffffff pref] to that
window and the radeon works.  (There are some error messages related
to this assignment, so the dmesg *looks* like it failed, but I think
it must have worked.)

In v3.16 (which does contain 5b28541552ef), when pbus_size_mem() sizes
the 64-bit prefetchable window, it only looks for downstream 64-bit
resources.  Since the radeon at 01:00.0 has none, we size the window
to 0 + 0x200000 (the 0x200000 part is pci_hotplug_mem_size, to
accommodate future hot-added devices).

But that's not big enough to hold the radeon BAR 0 [mem
0xc0000000-0xcfffffff pref], so BAR 0 remains unassigned, so
pci_enable_device() should fail, and radeon doesn't work.

I don't know what the best fix is, but I think it's probably too
aggressive to *never* use a 64-bit prefetchable window for downstream
32-bit prefetchable resources.  This configuration from BIOS should
just work without us changing anything (although we probably should
trim the window to start at 0xc0000000, which would still work).

In this case, I think we certainly want the radeon BAR 0 in the
prefetchable window.  In general, it seems wrong that a device with
32-bit BARs will work fine below a bridge with a 32-bit prefetchable
window, but it won't work (or will work slower) below a bridge with a
64-bit prefetchable window.  A more capable bridge should make things
work *better*, not worse.

Bjorn
