Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795486061;
	b=DL763mOLGRGKnVRY8JTlfDKT1n2HIhww8oDZZlCtXrr/pAGDnsgXaCM1fuZT8Wg9TmvH
	 6OhrAkJid5LWRcAV+tNJGQKpMPOuHBccU4KbjM/Os4Ix8pfbPHwFOeEIW4oKv8s3t/WWZ
	 e66UrDRiPUs6TfkiwkaZ5gXZQ+TyEvextoAvsS51kWl0YiXCtg52BNNQHqjDRkVGN0nDP
	 YjmfLT2sksTtUwEhyu6YgGyye0uMDx6w6r2q+slEVovGouZ9Fj1/AOzuuXnva2K1K/qyI
	 P162RW+nF7WlssLo+KN8Mh3LEav3/ZYYWvtvbVL+9PPxEGqt/+kJrvdUdhKHxWy2eSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DFHy6Q4RHLBxApjxLT8S/8XA8Y9LAIt9WqgfD30lJuE=;
	b=XDJ9+TZuzY0FzGSP5Jb5MvBZWaZE31Y6eHM/POg5Ma0+nUIV87n6IpKtNrg7NkHG+E2k
	 vyWR4RCq6IUm9chPv4EscA/5Mc8+SxEWIJa0pP2zmvEmRKTm+0ypW81mmlL+ZMpX/3ChI
	 Ef4ZLBNXajhwXCHpO7OguxUkUh7iLrQ7j/egjQjI+36t6QP4OGiMx5fbaR1Em2GPWMIiF
	 P6BD06KOvbxqovGOnjzxmMOCoIT2dEsVvO4ucxKHXY2JUw4/ZQQUb0G/6pzsYyEII+E/j
	 yk0bdXFJOQWukn8AYysxdVAFi/4abRf3JkUfFamIUx3QdXG61aX4nQriTjFp9dMEbMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi938ATn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1380606A31E
	for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 02:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1380606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi938ATn
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b4f4095a7aso33406157b3.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 18:07:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795486060; cv=none;
        d=google.com; s=arc-20260327;
        b=H4e04CI0HkIH1Rcyo15nFeiEQsaCGRL1ZvgPucDIL8e59O792I2kEr049HwO7lJosy
         fsgj2FXcDZ2IcmNpKQgslTVpT0NMFbabrqibALWY04SbNcaoOfmY4a4Da/nYR6ZInlh2
         4koCpNmdHPYTafrYt3C8DbkBRUHjMSneE3sr8MhUG+SlFm6XogdOwhwV1v/K5DXNAfME
         PEzhan4VbklW8CSmaZqf9HPeTRTkhsg/h3Sde7jcDv5mKLogd0/+RkkGr5GJt40gAPRi
         Bmi20Y7JVv1QejbCxDBnVJfJ6ZBYXi6l/hXCCErMirV+oXgstzrh3f9e7VdKa4rTZL2c
         zj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFHy6Q4RHLBxApjxLT8S/8XA8Y9LAIt9WqgfD30lJuE=;
        fh=nh4k0lA0OXnIS855XA0C+oGb+gjJgnCKPWX2HgX15IU=;
        b=rMnaJxMTSfGV6vW54Ft8b0zZQvT/ZExam140lxXrfEaaQYvmUvZpGAD5emS/SupbQ3
         cTVQ08dCHrsgSBT0xX1SHB7OEHu9UC48LFR/X0bOyt9frkvTceINwp+ktHFsGEsB8Bet
         VvxiWwgEuu+2mG6YYgGnpeqzU2RJQbum0R4ktRFLFMvTRTZHE+1t2MrEsHDYpQoZzz8a
         6s3A8knvEewlqiPUv4goJnfoJOG5OhX3E5PpxVwrWZavTm7OwLtg7g21uWaFY76ThGWf
         RC/iXrzhF0q7xdWw1YTWkWc3GFUYKVMC4mIgqcz4O0MIG/GO+gauNFzzHjbLipS4INVy
         SPZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795486060; x=1796090860; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFHy6Q4RHLBxApjxLT8S/8XA8Y9LAIt9WqgfD30lJuE=;
        b=wi938ATnhuxuzXEKwgqtjJB8Z2+898Aq77WCBtWeBKZy2/LJvoIpus18jeOt3P7k8D
         Crmvj3P2XsnVh5OCEXhgt5r73nkuLKaDx6kWoJb3+sqpxGRdFQsIjwSFjVwWks39cXx3
         kuw/ui9ZjK+QA0u+0ZCbskHbReMO0E2YF+/ziQVM/ox4bI0TmUtahECSZff+kRaarP07
         zoNMeVZ1wpzrJmj4gGDnZaTezfKdtQLnApS9fkFmWiUnCDm41XJp3gRHfHTT/9HicIX8
         PIOO5EI/BDB5kV1i4coUTpkc4xLn2c8jFwZxh1lNJSynuDJyAZku6ByN8YMOcuIO26YV
         XYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486060; x=1796090860;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFHy6Q4RHLBxApjxLT8S/8XA8Y9LAIt9WqgfD30lJuE=;
        b=KkhcIRHrooJjSSE2sns3vLBT/UC4i/SSuOsSLMKOpnFCcLj2KYOcZhSiK7sFzOyL/i
         OeRMmdmtQ3vrpYnnr3x6DWOaJ0l4xNfmVd5hnVk7fZlHI+nDbzEBOtC6vPD5U7m70dDb
         ybaTpnJmHz+r3C5u1Zz5HgUzqmJcl3gd5n4XM3b5gRxSah1TnCP6BX3DTuFugoHhr6Hn
         b/ePsPuuvgFM/F7caQpNiLOF+7WIXpLJuKHNM0af1z2rJD1qSGv69xx3JmsGhLhPXWmJ
         DbO+NOXq1ZGjeBPq34BMYsMs0Xbz8up0lZ10jMazo296rCDntQ77ojB18I4YycZ6hzu3
         mtoA==
X-Gm-Message-State: APuU4Z/utzTehFYaWEW43PLjbieUMLQcmLpzydbawwNGVN/OJreSqkoD
	9yeAQ7j7XFokcQvNO151YzHaJJ+VnlDOML6C9ds7uAjRZrugmf3/Cpoeoj/+s3+XUpKEaXxT3z8
	e+TMJ7Lb1DH/O8vBzyDc5vbX627POcPyZUHYR
X-Gm-Gg: AZFdTZeRRzBRGSS6jRYncLkw90WeYNFifQuWBmq+4hENS88sDvI76TPGlwstjdVMa9L
	wbyeX9dZUJ5EUD5/QjcMhD5kFP/H9ZSW9E9NkAMPx4teIpScO0hZ8gI91SvtAVCT77v0yL+B/0i
	7QZgBD14rXE7R3/gun1kxIlKtzKmqWadcquJbNI5SxTHlCBB8VTVAFLVzXF9z/YZ3UphVnuJ9Ko
	hEOibV+yWEpfRA3dvX4uI3goDOzjffxsh3JBlEgo541TDyDrCvoTHJQ6eQKul6afUhTVcKNK/1P
	Ul9ZFbjGVhOWK01Kc3hJqaKjYQWRZO8V7RaIGiKPdR5WR87RARZuHiVcWg+M/EDoMC/wjfzdkcV
	E/rYfmGQbuyodvgIiQ+pgX/P7xX0RVDRvGuxY1Ild//bfVrodbdleDDAmm1L6nFMdvzyZP1itl2
	mVS4uZ36TCxkVXFw==
X-Received: by 2002:a05:690c:9c11:b0:8b4:d9cf:4582 with SMTP id
 00721157ae682-8b52032406amr62328397b3.5.1795486059818; Mon, 23 Nov 2026
 18:07:39 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bug-222253-41252@https.bugzilla.kernel.org/> <CABhMZUVJjeNUwp_yT3kkyk1U+0MNw0_qF=RU39keKnypd9T2YQ@mail.gmail.com>
 <CACpBZmVWnoRCRmvLBTQ2T94NG5Vbyw6wkg5g3crbg1MgpSS6dA@mail.gmail.com>
In-Reply-To: <CACpBZmVWnoRCRmvLBTQ2T94NG5Vbyw6wkg5g3crbg1MgpSS6dA@mail.gmail.com>
From: Kameron Markham <kameron.markham@gmail.com>
Date: Mon, 23 Nov 2026 18:07:27 -0800
X-Gm-Features: Aa3M54rM0d9fL2QcPnPFCaCiShZVH8LMYMKxaxqrnMLrUhk9qcw32j61sbZkn9o
Message-ID: <CACpBZmXnw1ie3uvnNBHCbu2fDOAyegXOu4yPG7Yio_YqPUk_FQ@mail.gmail.com>
Subject: Re: [Bug 222253] New: Dell PowerEdge R730 resets at boot since v6.15:
 failed disabled ROM BARs trigger PCI realloc, I350 moved
To: bjorn@helgaas.com
Cc: Linux PCI <linux-pci@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	regressions@lists.linux.dev, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo and Mika,

Following up on the Dell R730 boot regression in Bug 222253.
Reserving the conflicting 4 KiB range let stock 6.17 boot on my
R730. The address changes with the firmware layout, so a quirk
would need to discover it rather than hard-code it.

Is there a supported way to read the BIOS-hidden D31:F6 thermal
BAR on C610/Wellsburg before PCI resource assignment?

The serial logs are attached here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D222253

Thanks,
Kameron


On Tue, Nov 10, 2026 at 3:40=E2=80=AFPM Kameron Markham
<kameron.markham@gmail.com> wrote:
>
> Thanks, Bjorn.
>
> For the new Cc's: the mechanism in this report is out of date. The ROM
> BAR change was intentional, and I've dropped my patch. After Ilpo's
> review I captured the end state. The assignment itself is valid, but
> the second pass puts 00:1c.4's window, and the I350's BAR 0, at
> 0x92200000. That 4K is still decoded by the PCH thermal function
> (D31:F6), which the BIOS hides on this C610/Wellsburg platform. The
> first MMIO read of the I350 there resets the machine. Reserving the
> range with memmap=3D4K$0x92200000 makes stock v6.17 boot normally.
>
> Details:
> https://lore.kernel.org/all/CACpBZmUoSU8Emvego8sEce5AbB4+48yMLbs=3DE-5HKM=
h=3D65Zq=3DA@mail.gmail.com/
>
> The new serial logs are attached to the bugzilla entry.
>
> So this looks like quirk territory: reserve the hidden thermal BAR
> before resources are assigned. Its address follows the firmware layout
> (0x92600000 with SR-IOV Global enabled), so the quirk has to find it
> rather than use a fixed range. Ilpo, Mika: is there a supported way to
> read the BAR of the hidden D31:F6 on C610/X99, similar to what p2sb.c
> does for P2SB?
>
> --
> Kameron
>
> The investigation and these tests were done with the help of an AI
> coding assistant (Claude, by Anthropic); I ran them on the hardware and
> checked the results.
>
> On Tue, Nov 10, 2026 at 3:15=E2=80=AFPM Bjorn Helgaas <bjorn.helgaas@gmai=
l.com> wrote:
> >
> > [+cc Ilpo, Mika, Mario, reporter in bcc]
> >
> > ---------- Forwarded message ---------
> > From: <bugzilla-daemon@kernel.org>
> > Date: Mon, Nov 9, 2026 at 6:12=E2=80=AFPM
> > Subject: [Bug 222253] New: Dell PowerEdge R730 resets at boot since
> > v6.15: failed disabled ROM BARs trigger PCI realloc, I350 moved
> > To: <bjorn@helgaas.com>
> >
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D222253
> >
> >             Bug ID: 222253
> >            Summary: Dell PowerEdge R730 resets at boot since v6.15: fai=
led
> >                     disabled ROM BARs trigger PCI realloc, I350 moved
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 6.15 - 7.4-rc2
> >           Hardware: Intel
> >                 OS: Linux
> >             Status: NEW
> >           Severity: normal
> >           Priority: P3
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: kameron.markham@gmail.com
> >         Regression: Yes
> >            Bisected 96336ec70264
> >          commit-id:
> >
> >
> > Since v6.15, a Dell PowerEdge R730 with "SR-IOV Global Enable" disabled=
 in
> > the BIOS setup hard-resets during boot when igb probes the on-board Int=
el
> > I350 (8086:1521, behind PCH root port 00:1c.4). v6.14 boots fine.
> >
> > iDRAC Lifecycle log for a failed boot:
> >   PWR2262  The Intel Management Engine has reported an internal system =
error.
> >   CPU0000  Internal error has occurred check for additional logs.
> >   RAC0703  Requested system hardreset.
> >   CPU0704  CPU 1 machine check error detected.
> > Normally the platform then power-cycles itself and boots the next OS; i=
n 2
> > of the ~17 crashes during testing the BIOS halted in POST instead (PST0=
208
> > "System BIOS has halted") and needed a power cycle.
> >
> > The same signature (PWR2262 / IERR on kernels >=3D 6.17, on R630/R730/X=
C730xd
> > with I350) is reported by Proxmox users:
> >   https://forum.proxmox.com/threads/186063/
> >   https://forum.proxmox.com/threads/177201/
> > There, enabling X2APIC Mode, I/OAT DMA and SR-IOV Global in the BIOS is=
 the
> > usual workaround. On this machine only SR-IOV Global Enable matters (se=
e
> > below).
> >
> > Hardware / firmware:
> >   Dell PowerEdge R730, 2 sockets, BIOS 2.19.0 (also reproduced on 2.11.=
0),
> >   iDRAC8 2.75. On-board: 82599 (8086:10fb) on CPU root port 00:03.0,
> >   PERC H730P Mini (1000:005d) on 00:01.0, I350 (8086:1521) on PCH root =
port
> >   00:1c.4. BIOS: X2APIC, I/OAT and SR-IOV Global disabled unless stated=
.
> >
> > Bisection (v6.14 good, v6.17 bad; test kernels booted from RAM via PXE,=
 a
> > BAD boot detected through the BMC's SEL):
> >   first bad commit: 96336ec70264 ("PCI: Perform reset_resource() and bu=
ild
> >   fail list in sync")
> >   96336ec70264 does not build on its own (pci_resource_is_disabled_rom(=
) is
> >   not defined anywhere); it was tested with a one-line definition match=
ing
> >   the check it replaced. Its parent e89df6d2beae boots.
> >
> > Mechanism (from serial console logs with PCI dynamic debug):
> >   - The firmware leaves the 82599 VF BARs unassigned, so pci_realloc_de=
tect()
> >     enables reallocation.
> >   - On the first pass the disabled ROM BARs of 02:00.0, 01:00.1 and 07:=
00.1
> >     fail ("can't assign; no space").
> >   - Before 96336ec70264 a failed disabled ROM BAR was not added to fail=
_head.
> >     96336ec70264 tests that with an idx that is not set for the resourc=
e
> >     being checked, and 2499f5348431 ("PCI: Rework optional resource
> >     handling") removed the test, so the ROM BARs land on fail_head.
> >   - "PCI: No. 2 try to assign unassigned res" follows: the windows of
> >     00:1c.4, 00:03.0 and 00:01.0 are released and reassigned; the I350 =
moves
> >     from 0x91a80000 (firmware) to 0x92200000.
> >   - The last console line before the reset is igb saving the config spa=
ce
> >     of 07:00.0 with BAR0 =3D 0x92200000.
> >   The new address range is free in /proc/iomem; why the platform resets=
 is
> >   not known.
> >
> > BIOS switch matrix with stock v6.17:
> >   all three disabled                     -> resets
> >   SR-IOV Global only                     -> boots (no realloc, no 2nd r=
ound)
> >   X2APIC + I/OAT, SR-IOV Global disabled -> resets
> >   any switches, pci=3Drealloc=3Doff          -> boots (tested with all =
disabled)
> >
> > Current mainline v7.4-rc2 still resets. A patch restoring the old behav=
ior
> > (do not put a failed disabled ROM BAR on fail_head) makes both v6.17 an=
d
> > v7.4-rc2 boot; it follows on linux-pci.
> >
> > Attachments:
> >   sol_v6.17-realloc-off.log       serial console, GOOD (pci=3Drealloc=
=3Doff), with
> > /proc/iomem
> >   sol_96336-bad-dbg.log           serial console, BAD, first bad commit=
, PCI
> > dyndbg
> >   sol_v7.4-rc2-dbg.log            serial console, BAD, mainline
> >   sol_v7.4-rc2+fix1.log           serial console, GOOD, mainline + patc=
h
> >   sol_v6.17+fix1.log              serial console, GOOD, v6.17 + patch
> >   sol_v6.17-stock-sriov-only.log  serial console, GOOD, SR-IOV Global o=
nly
> >   git_bisect_log.txt              git bisect log
> >   lclog-excerpts.txt              iDRAC Lifecycle log entries for a fai=
led boot
> >   harness.tar.gz                  test scripts (addresses replaced by
> > placeholders), kernel .config, initramfs
> >   lspci-vvv.txt                   from the working v6.8 kernel (BIOS sw=
itches
> > enabled; with
> >                                   SR-IOV Global enabled the BIOS renumb=
ers
> > buses, so the
> >                                   PERC is 03:00.0 and the I350 08:00.x =
there)
> >
> > Notes: The analysis and patch were prepared with help from an AI coding
> > assistant (Claude, by Anthropic); all results above come from test boot=
s on
> > the machine described.
> >
> > --
> >
> > #regzbot introduced: 96336ec70264
> > #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222253
>
>
>
> --
> Kameron Markham
> Mechanical Engineer
> (253)347-3004
>
> "The most difficult subjects can be explained to the most slow-witted
> man if he has not formed any idea of them already; but the simplest
> thing cannot be made clear to the most intelligent man if he is firmly
> persuaded that he knows already, without a shadow of doubt, what is
> laid before him" -Leo Tolstoy



--
Kameron Markham
Mechanical Engineer

"The most difficult subjects can be explained to the most slow-witted
man if he has not formed any idea of them already; but the simplest
thing cannot be made clear to the most intelligent man if he is firmly
persuaded that he knows already, without a shadow of doubt, what is
laid before him" -Leo Tolstoy
