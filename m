Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE04A92E7;
	Wed,  2 Sep 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364493; cv=none; b=E9mZmaZI53O+DFLZWslbgKEVGOq/MRUD92yKX6WoQptFRHknHruK+s+5G2gPyzarspKDuQW6tohsRZ0Jz+Adb4VS4xVhQgDveeuJvojHG6owt6WShQYKQv2YryUDbp+TW2GqoQwjSmGW2+qbo7yF/G5zO/chc2xvIQ/pnEMws+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364493; c=relaxed/simple;
	bh=za4rczAllHUREQ0tAylA6HDsitJ8j6tAktTQRE8VX1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rP+BWSd8uCj4/2qkiz0zuV4GqFpCgPv9x8V1895B8DTM86uVGnqKAeqnKFu8Rk1u4zB3AzC70+0RnycwzELqJ9RuXHlGZ2xD/6F/1YsPg8OMyGXNi+WMT/2YebzboWqCY98kstFKP4/Tl/ZClV3c2wl1vbhUXVsiTwTEnd3w4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WS0cmN1S; arc=none smtp.client-ip=188.68.63.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WS0cmN1S"
Received: from mors-relay8204.netcup.net (localhost [127.0.0.1])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4hZnF90tl0z8pMQ;
	Wed,  2 Sep 2026 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1788364093;
	bh=za4rczAllHUREQ0tAylA6HDsitJ8j6tAktTQRE8VX1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WS0cmN1Sa/GNnBqQxnb+h/+asEZx3QM7WDRCmO9yQ9BTjV49L6uxVBytkjclVaQPV
	 2a9IstVrlJ4GjpUDXxuF5VFO3yfJXTSEhVLbiIe11nb/FwH0qIKELMqcK7zW+HkDw7
	 Tsa+PM45dT4Uckzz+nnYIcgKYbTkfmZwLG+ViCok4rUsdJv1289rELGmNkg/MUTdkA
	 zBjNvBGGoZ5D5SJGqZZ6IWYZLI28Svo34WaeDTY/GD/U+wY/as0jweDaDQvb5rwqPu
	 nW6eO9xKx3uU/jhJkW8fnSXQGvtWkAEq7jQF3KMxZ0Tf027ihRF//yP2V/B1zvzSlU
	 Axf6E2hZvIH8g==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8204.netcup.net (Postfix) with ESMTPS id 4hZnF907xrz8pK0;
	Wed,  2 Sep 2026 15:48:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hZnF74DK2z8td0;
	Wed,  2 Sep 2026 17:48:11 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 6DA105F9C6;
	Wed,  2 Sep 2026 17:48:02 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <fdbe2872-6fe3-4746-9d10-1ccef3a3e88d@leemhuis.info>
Date: Wed, 2 Sep 2026 17:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with no
 link
To: "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Aoxtj <aoxiangtianji@axtjblog.cc>, linux-pci@vger.kernel.org,
 Andreas Wild <andiwild@gmail.com>, linux-kernel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 restafvalendergelijke@outlook.com
References: <20260801201244.4421-1-andiwild@gmail.com>
 <331e97c7-e422-420d-9f3e-5d9f734464b3@axtjblog.cc>
 <20260808063103.10940-1-andiwild@gmail.com>
 <ae819bec-9c2b-47b5-be5e-3c65fea12da1@axtjblog.cc>
 <20260811064233.11315-1-andiwild@gmail.com>
 <7742d556-e878-4893-8b6d-d6039ddba544@leemhuis.info>
 <20260825070527.8481-1-andiwild@gmail.com>
 <alpine.DEB.2.21.2608251117260.44766@angie.orcam.me.uk>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <alpine.DEB.2.21.2608251117260.44766@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178836408287.729812.4990630246513450404@mxe9fb.netcup.net>
X-NC-CID: 1fB+P0nNO1B554jxB8L2WLOOkFyn5hxpGVOn+yBsb5qt2N8X0LQ=

On 8/25/26 12:18, Maciej W. Rozycki wrote:
> On Tue, 25 Aug 2026, Andreas Wild wrote:
> 
>>> Are we waiting for a reply from Aoxtj before moving on with the fix at
>>> the start of the thread? And whatever the answer is: would it make sense
>>> to move on with that independently to get the other regression (boot
>>> time delay) resolved?
>>
>> Not on my side.  Aoxtj tested v3 early on and it does not help them, which
>> is expected: their link is up at 2.5GT/s and v3 only skips ports with no
>> link at all.  The two are separate failure modes needing separate fixes,
>> so I see no reason to hold v3 back.

Thx for the clarification. Would afaics be really good to get that fix
in to solve that problem. Bjorn, is this somewhere on your todo list?
>  I'd be happy to hear any results of your posted HASD check though.
There is another report from Mich (now CCed). Mich, can you maybe test
that if you haven't yet (your report is really verbose, which makes
things somewhat hard to follow)?

FWIW, Mich's report can be found here:
https://bugzilla.kernel.org/show_bug.cgi?id=221919

Quoting from there:
"""
>  Mich 2026-08-25 09:56:05 UTC
> 
> Created attachment 310724 [details]
> Various collection of log files.
> 
> Overview
> ========
> After the Vendor:Device ID matching was removed from the
> pcie_failed_link_retrain() quirk, the kernel now lifts 2.5GT/s link speed
> clamps that platform firmware has deliberately applied. On a Dell PowerEdge
> R610 this causes the affected links to fail to come back up, the device
> behind them to disappear from the PCI bus, and a fatal PCIe error resulting
> in a kernel panic.
> 
> Kernel version
> ==============
> Failing : 7.0.14-12-pve (Proxmox, based on Ubuntu-7.0.0-31.31)
> Working : 7.0.14-5-pve  (Proxmox, based on an earlier Ubuntu base)
> 
> The Proxmox changelog shows 7.0.14-7 as the release that pulled in the large
> upstream update (Ubuntu-7.0.0-28.28i3); all later releases in that series are
> CVE cherry-picks only. Forum reports independently confirm -6 works and -7
> onwards do not.
> 
> Hardware
> ========
> Dell PowerEdge R610 (11G)
>   Chipset : Intel 5520/5500 I/O Hub
>   BIOS    : 6.4.0 (2013-07-23) on one machine, 6.6.0 (latest) on the other
>   NIC     : Intel 82571EB quad-port PCIe (the device that disappears)
>   RAID    : LSI MegaRAID SAS 2108 (PERC H700)
> 
> Reproduced on two separate R610 machines with different BIOS versions, so
> this is not a firmware revision issue.
> 
> What happens
> ============
> [    1.666183] pci 0000:00:07.0: removing 2.5GT/s downstream link speed restriction
>                <- exactly 1 second gap (link training timeout)
> [    2.666510] pci 0000:00:09.0: removing 2.5GT/s downstream link speed restriction
> [    2.673748] Uhhuh. NMI received for unknown reason 21 on CPU 0.
> 
> Resulting link state (captured while booted with ghes.disable=y):
>   00:07.0  LnkCap: Speed 5GT/s, Width x8  /  LnkSta: Speed 2.5GT/s, Width x0
>   00:09.0  LnkCap: Speed 5GT/s, Width x8  /  LnkSta: Speed 2.5GT/s, Width x0
> 
> Width x0 means the link is down. The Intel 82571EB installed behind one of
> these ports is not enumerated at all - it is completely absent from lspci.
> Only the onboard BCM5709 ports remain visible.
> 
> Without ghes.disable=y the machine panics before reaching userspace:
>   Kernel panic - not syncing: GHES: Fatal hardware error
> The call trace shows this happens during acpi_ghes_init:
>   acpi_ghes_init+0xd3/0x160
>   acpi_init+0x401/0x490
>   do_one_initcall+0x5f/0x350
>   kernel_init_freeable+0x243/0x2f0
> 
> The front panel LCD and iDRAC SEL both report "E171F PCIe fatal".
> 
> The ACPI BERT table is empty (48 bytes, header only), confirming this is a
> live error raised during PCI enumeration rather than a stale firmware record.
> 
> Suspected cause
> ===============
> Commit a89c82249c37 ("PCI: Work around PCIe link training failures")
> introduced pcie_failed_link_retrain(), originally limited to the ASMedia
> ASM2824 by Vendor:Device ID.
> 
> A later change - "PCI: Always lift 2.5GT/s restriction in PCIe failed link
> retraining" (Maciej W. Rozycki, Dec 2025) - removed that ID matching, so the
> quirk now lifts 2.5GT/s clamps on any downstream port, explicitly including
> clamps "the firmware may have already arranged".
> 
> On this platform the firmware sets that clamp intentionally and the hardware
> cannot negotiate a higher speed, so lifting it takes the link down entirely.
> 
> During review of that patch, concerns were raised on linux-pci that lifting
> firmware-set clamps on arbitrary hardware would cause regressions on real
> systems. This appears to be exactly such a case.
> 
> Workarounds tried
> =================
> ghes.disable=y : machine boots, but the NIC is still missing, so the node is
>                  unusable. Only suppresses the reporting.
> pci=noaer      : no effect (the link is already down before AER is involved).
> Pinning kernel 7.0.14-5-pve : works, and is what we are currently using.
> 
> Question
> ========
> Would it be possible to restrict this quirk back to the original ASMedia
> device IDs, or to skip lifting clamps that were set by firmware rather than
> by the quirk itself? On platforms where firmware deliberately limits a link,
> overriding that appears to be unsafe.
> 
> Attachments
> ===========
> Full dmesg, lspci -nnvvv, dmidecode, ACPI tables (BERT/HEST) attached.
> 
> Comment 1 The Linux kernel's regression tracker (Thorsten Leemhuis) 2026-08-26 04:07:17 UTC
> 
> Please use latest upstream kernels when reporting problem upstream, those downstream kernels are patched in various ways and thus might have issues that never even happened upstream or were fixed long ago. Nevertheless:
> 
> There is some discussion about an issue that might be the same here here: https://lore.kernel.org/all/20260801201244.4421-1-andiwild@gmail.com/
> 
> Would be best if you could try if the fix or one of the test-patches in that thread helps and report back there; alternatively, report back here please, ideally while allowing me to CC you on a mail about this (which would expose your email to the world)
> 
> Comment 2 Mich 2026-08-26 04:59:18 UTC
> 
> (In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from comment #1)
>> Please use latest upstream kernels when reporting problem upstream, those
>> downstream kernels are patched in various ways and thus might have issues
>> that never even happened upstream or were fixed long ago. Nevertheless:
>> 
>> There is some discussion about an issue that might be the same here here:
>> https://lore.kernel.org/all/20260801201244.4421-1-andiwild@gmail.com/
>> 
>> Would be best if you could try if the fix or one of the test-patches in that
>> thread helps and report back there; alternatively, report back here please,
>> ideally while allowing me to CC you on a mail about this (which would expose
>> your email to the world)
> 
> Thank you for the response, I will take a look at it!
> I tried adding my "spam" collection mailbox, but I am not allowed unfortunately. If you want to add this to CC "
> restafvalendergelijke@outlook.com" it's no problem. Thank you once again.
> 
> Comment 3 Mich 2026-09-01 09:46:23 UTC
> 
> Created attachment 310765 [details]
> Full diagnostics attached (dmesg, lspci -nnvvv, dmidecode, ACPI tables).
> 
> == Second platform, and a case the proposed v3 fix would NOT cover ==
> 
> Reproduced on a second machine from a different vendor:
> 
>   HP ProLiant DL360 G7, BIOS P68 (2015-08-16)
>   Intel 5520 I/O Hub (same chipset generation as the Dell R610)
>   Intel 82571EB quad-port NIC [8086:10bc] - same card as the R610s
>   Kernel 7.0.14-14-pve (Proxmox, Ubuntu-based). 7.0.14-5-pve works.
> 
> This rules out a Dell-specific firmware quirk: two vendors, different BIOS
> versions, same Intel 5520 chipset, identical failure mode.
> 
> == The important difference from my earlier R610 report ==
> 
> On the R610 the affected ports were EMPTY: LnkSta Width x0, DLActive- , no
> device behind them. That case is covered by the v3 approach (bail out when
> Target Link Speed is already 2.5GT/s and no link has been established).
> 
> On this HP machine one of the affected ports had an ACTIVE link with a
> device behind it before the quirk ran:
> 
>   00:08.0  before: LnkCap 5GT/s x4, LnkSta 2.5GT/s Width x4, DLActive+
>                    (Intel 82571EB, bus 04, working normally on 7.0.14-5)
>            after : LnkCap 5GT/s x4, LnkSta 2.5GT/s Width x0
>                    (bus 04 now empty, NIC absent from lspci)
> 
> Since DLLLA was set, pcie_failed_link_retrain() would take the first branch
> of the v3 patch and fall through to the clamp-removal block regardless. The
> clamp is then lifted on a port with a working device attached, the link
> fails to retrain, and the device is lost.
> 
> If that reading is correct, v3 fixes the empty-port case but not this one.
> I'm happy to be corrected - I'm reporting observed behaviour, not reading
> the patch as an expert.
> 
> == Full quirk trace on the HP ==
> 
> The quirk walks every root port, each with a one-second retrain timeout:
> 
>   [ 1.883010] pci 0000:00:02.0: removing 2.5GT/s downstream link speed restriction
>   [ 2.882097] pci 0000:00:02.0: retraining failed
>   [ 2.882422] pci 0000:00:03.0: removing 2.5GT/s downstream link speed restriction
>   [ 3.882097] pci 0000:00:03.0: retraining failed
>   [ 3.882441] pci 0000:00:04.0: removing 2.5GT/s downstream link speed restriction
>   [ 4.882097] pci 0000:00:04.0: retraining failed
>   [ 4.882417] pci 0000:00:05.0: removing 2.5GT/s downstream link speed restriction
>   [ 5.882097] pci 0000:00:05.0: retraining failed
>   [ 5.882409] pci 0000:00:06.0: removing 2.5GT/s downstream link speed restriction
>   [ 6.882097] pci 0000:00:06.0: retraining failed
>   [ 6.882425] pci 0000:00:07.0: removing 2.5GT/s downstream link speed restriction
>   [ 6.882746] pci 0000:00:08.0: removing 2.5GT/s downstream link speed restriction
>   [ 7.882097] pci 0000:00:08.0: retraining failed
>   [ 7.882415] pci 0000:00:09.0: removing 2.5GT/s downstream link speed restriction
>   [ 7.882742] pci 0000:00:0a.0: removing 2.5GT/s downstream link speed restriction
>   [ 7.906501] NMI: IOCK error (debug interrupt?) for reason 61 on CPU 0.
>   [ 8.882097] pci 0000:00:0a.0: retraining failed
> 
> Note 00:07.0 gets the same treatment but is NOT reported as failed - the
> onboard BCM5709 behind it survives at Width x4. So on the same machine, in
> the same boot, one device survives the retrain and another does not.
> 
> Also of note: roughly 7 seconds of boot time are spent on these one-second
> timeouts, on a machine where nothing needed retraining in the first place.
> 
> == Firmware clamps every port on both platforms ==
> 
> Dell R610 (working kernel, quirk not triggered):
>   00:01.0  LnkCap 5GT/s x4  /  LnkSta 2.5GT/s, Width x4   BCM5709, link up
>   00:03.0  LnkCap 5GT/s x4  /  LnkSta 2.5GT/s, Width x4   BCM5709, link up
>   00:07.0  LnkCap 5GT/s x8  /  LnkSta 2.5GT/s, Width x0   empty
>   00:09.0  LnkCap 5GT/s x8  /  LnkSta 2.5GT/s, Width x0   empty (Intel NIC on the failing node)
> 
> HP DL360 G7: same pattern across nine root ports.
> 
> Both platforms clamp every 5GT/s-capable port to 2.5GT/s, occupied or not.
> Moving the card to another slot is therefore not a workaround.
> 
> Full diagnostics attached (dmesg, lspci -nnvvv, dmidecode, ACPI tables).
> 
"""
