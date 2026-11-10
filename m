Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794354024;
	b=XTt0QEHGQQlg9mh18jkppbsXeMqMalx1GmlN7nGxcs0c+jPhbzqgjUwLAX0x2bhdnFDx
	 +WHIn8kGuXYamfA1EPcfwtMztOvSAlHwEYOyGJC1etCOka5PwLj0ukYFa5DCik05q/PxJ
	 29FGiYaJzsvg7kLxrRIZ/oQqf0xKe4mTQCoaNpxHbQZvAqBzrYVGbU8H7eKwvSj6rgaKr
	 K/FPgqSGVqnPiFnFcROYp4pU0U5Zmr4uKW/wWWdcGA7k87VRUc44+Kd/ciw6XoU42YPkC
	 FkLvCTDvuhw686nztBFTX2b8z/u6CxJ2VoqgeQ8diHVGFccje9SuJ6pBMNeLKwVnBuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QnGd7FYqd1uBq9LqoPDkEcxLfOLIFQl/QxjaadD0DI0=;
	b=eiISZit9T40bE9MxVzQDu2DLDePPSe4SU08YBGy4G+1+xCvz3wqxb2xe7dH4oVfwALKV
	 mSZAGk93m+89V+6SSjBzMRDy+cs8NMF0nX43J5XboeGZeD4tjVwCaOP5fwqLUJ8CpgGOw
	 YhHjwMvSFXVSUKbO23pIiNNHiJ5sySW8UzLhMmChCseWzwht2+Jz914n9tjCz4dfyWKRr
	 3FMD23l/bz+xEgSohBu5rO7QBhougTvcCwai6QJD0C6A4bM4LV41PhBFselHkt4u+uIBc
	 cC/ssDDjViXU1zS/JQVHgRstn6wiOp3hvXQXHM3vxp4Z0qiGqwVuXIevzytQXCkruuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htOhRCt7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF5606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 23:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BCF5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=htOhRCt7
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-677bc4704cbso3066331d50.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:40:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794354023; cv=none;
        d=google.com; s=arc-20260327;
        b=GWTh697YVaQQhhCRlyOrFcXJMDTFJ6Kk/BvXXzi18XILcrdoSa49bSvdn720w0+6Ct
         NKN7/a/nnqh0EiAM0qm/vhUqBVoxzxmEuBkJR6uryjYnYmlY8fKNyBnkMyT9WLPoysj5
         MwZlW1Km7qCCglr2aGWlRGU9KROz6n6iW7JiM3VzNilrIewFyQLPaQFACFb2n4T6G/Og
         bp1VmofL3wVbYt1st0CQGV9KjLBKtgqAxupHdpIBtr82n0t0vH4ukif+VAeRJ1P2pFHb
         oH6MtA7OrQPJi9Ap52YU+Niy2Lqv2aQ7h3qp0LJ8v8L/tdGxhp723BQTsvJfEuErW1EC
         Sb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QnGd7FYqd1uBq9LqoPDkEcxLfOLIFQl/QxjaadD0DI0=;
        fh=nh4k0lA0OXnIS855XA0C+oGb+gjJgnCKPWX2HgX15IU=;
        b=kTeaWfhK1TpGBtwdg9N6BBCoGUzJcst3/SGG3PdOWAHWgO0fpbTTreph9la/5sNb9o
         qH/hGu3ee1XnmXJSwzv0jBApgWl2vbgFudVwapyECaCGgWkc28+ETmxnYxxhF80BE9xV
         dNDlIcZJx/0gk4XHfo85mz7LAqHyG0zKkjhcY8+6m/aYAwPXvWQHzv+TjZdixlbs+PI+
         DW6TIxeNKwF3YW+meftzAD8k2tnDtShJCAOQHMSTq/hIoL+FA9xRwtyJTw9eJrEDJ7MU
         WA52jqwnJ32IAPUqBrfgrNrodNe4leKbxTQw6rkLIZxICkvf7bzepBTo9QXaVm5gxOC5
         6z0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354023; x=1794958823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QnGd7FYqd1uBq9LqoPDkEcxLfOLIFQl/QxjaadD0DI0=;
        b=htOhRCt7hrghoPIC2Byy1KcFNjfPgXV7/CETkLRh/qvl5cm84x6e/v1TJaLuS2+k6H
         YzXzqfPwq8fHOkivRagndAkoqlpMlhfRMk6bWhA8mnQyjkNG6S7dbFWIwZFm0eJeiKTd
         phGNgwZqC5yeZ7MiVcpzV2u2AtFN+dyPIcrbKXwrfwJ0OkdWC5XQLvHRhJ1ZwVUgUMNR
         Ntvp5XCT2hz/H45cCzIQp8zw7o51rz2O537Hh7/nMVwgeQ/pCg5FylBYzGc58hfy+t5n
         IoOtpJmu20pGCqAXB5HNzWedzYOADzsnlrRatXytbmhjzLm61eKGZdpUX0pCS3nH+6y/
         ZAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354023; x=1794958823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QnGd7FYqd1uBq9LqoPDkEcxLfOLIFQl/QxjaadD0DI0=;
        b=fnnmTmz/MyEPI6pJPmcrmQmTv7/tL/T6A9ebhWdkhilZFMlmUfu3L7ukN9WsgWJUvZ
         lPr6kGzMeYBboMHWayw9rPywR3RNZi1Y2OkEx+p/L/xjWL3Z3FfFXeh+ie4LamvHgk1n
         Dszmn7SNGyLwDoYuRzGZCkSuCFCp8xBjat0Ihhu+Hz44rPxzWzb9yTlmGFwpTN2QsNog
         Yj7A55jt55Bl3xFcIKnE5kw0tn80fq7YDI+NgYRgfd73BqZFYIaxSq/cYKpw/CLjad0l
         HB83Wf1AwKyFpRdeHpRlAmgGqCTIf8BpcouSJ8NZQi+0QSKDSKh7RYUBXSF4hxPrP0ET
         RzDQ==
X-Gm-Message-State: APuU4Z8FeADOT1+dsV8mYlo3umO4rcYfkvDQbFBxoKhpzgmSk+DC0YsY
	KBm/ud6fcBvUmoA0h/VDZzSIsxuiiNEocDaeRR5GdVihbaB7jmp5S0udwGfR3Kt/npL5UPpvqW8
	Ctco6LSSrfIq02JdOmKuXl/btZdZF44g=
X-Gm-Gg: AYBFou2smykKRhqJIZ18mcQIMSK+ddIp1jmoEbNi2HmtfijS1GQReW3s50FGrvFU+fU
	7x3ZXRKEvoLl0hVQpyJb06EUIzJB3ZI+7zjou2KYtH29FvAltn/vN+e6SP1nrNWz+P6mZWMrIhK
	Ys2h/epjo1OFrDVRFkszPiU5d/qVGu2pQRQo2cnTGhoA4jMtOCLnmUopWGLVQf8aoLhkLUt1uyr
	V8i/gXpG0E0Zf/sJ2U2L2jIpP15PMHfAQAo1CWkaXuEVvB10rX4AbTy42yFuSivEZ2J90BvXpRF
	m0yp3wVAyl2qVrTtLcrGnJ/kxAw1V3xw6RGhJzQSFWdyiRTqvrZMcUnj7VmRWOeqKyxekgNO73B
	SHFSPWGFS9Dr5/hvofUacfTZT5DKFR4oSGu+22zbN5PFAKtXeWKvtd3YDpObxbDUF1snb
X-Received: by 2002:a05:690e:4501:10b0:679:af57:d199 with SMTP id
 956f58d0204a3-67c6801bbd6mr317767d50.57.1794354022902; Tue, 10 Nov 2026
 15:40:22 -0800 (PST)
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
In-Reply-To: <CABhMZUVJjeNUwp_yT3kkyk1U+0MNw0_qF=RU39keKnypd9T2YQ@mail.gmail.com>
From: Kameron Markham <kameron.markham@gmail.com>
Date: Tue, 10 Nov 2026 15:40:11 -0800
X-Gm-Features: AclHuK90teGEf5LZoG2KcdkEV1p-gF2vEXTEnnkC3ST9EnQP_eIi2yy4vSgiv0w
Message-ID: <CACpBZmVWnoRCRmvLBTQ2T94NG5Vbyw6wkg5g3crbg1MgpSS6dA@mail.gmail.com>
Subject: Re: [Bug 222253] New: Dell PowerEdge R730 resets at boot since v6.15:
 failed disabled ROM BARs trigger PCI realloc, I350 moved
To: bjorn@helgaas.com
Cc: Linux PCI <linux-pci@vger.kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	regressions@lists.linux.dev, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Bjorn.

For the new Cc's: the mechanism in this report is out of date. The ROM
BAR change was intentional, and I've dropped my patch. After Ilpo's
review I captured the end state. The assignment itself is valid, but
the second pass puts 00:1c.4's window, and the I350's BAR 0, at
0x92200000. That 4K is still decoded by the PCH thermal function
(D31:F6), which the BIOS hides on this C610/Wellsburg platform. The
first MMIO read of the I350 there resets the machine. Reserving the
range with memmap=3D4K$0x92200000 makes stock v6.17 boot normally.

Details:
https://lore.kernel.org/all/CACpBZmUoSU8Emvego8sEce5AbB4+48yMLbs=3DE-5HKMh=
=3D65Zq=3DA@mail.gmail.com/

The new serial logs are attached to the bugzilla entry.

So this looks like quirk territory: reserve the hidden thermal BAR
before resources are assigned. Its address follows the firmware layout
(0x92600000 with SR-IOV Global enabled), so the quirk has to find it
rather than use a fixed range. Ilpo, Mika: is there a supported way to
read the BAR of the hidden D31:F6 on C610/X99, similar to what p2sb.c
does for P2SB?

--=20
Kameron

The investigation and these tests were done with the help of an AI
coding assistant (Claude, by Anthropic); I ran them on the hardware and
checked the results.

On Tue, Nov 10, 2026 at 3:15=E2=80=AFPM Bjorn Helgaas <bjorn.helgaas@gmail.=
com> wrote:
>
> [+cc Ilpo, Mika, Mario, reporter in bcc]
>
> ---------- Forwarded message ---------
> From: <bugzilla-daemon@kernel.org>
> Date: Mon, Nov 9, 2026 at 6:12=E2=80=AFPM
> Subject: [Bug 222253] New: Dell PowerEdge R730 resets at boot since
> v6.15: failed disabled ROM BARs trigger PCI realloc, I350 moved
> To: <bjorn@helgaas.com>
>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=3D222253
>
>             Bug ID: 222253
>            Summary: Dell PowerEdge R730 resets at boot since v6.15: faile=
d
>                     disabled ROM BARs trigger PCI realloc, I350 moved
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 6.15 - 7.4-rc2
>           Hardware: Intel
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: kameron.markham@gmail.com
>         Regression: Yes
>            Bisected 96336ec70264
>          commit-id:
>
>
> Since v6.15, a Dell PowerEdge R730 with "SR-IOV Global Enable" disabled i=
n
> the BIOS setup hard-resets during boot when igb probes the on-board Intel
> I350 (8086:1521, behind PCH root port 00:1c.4). v6.14 boots fine.
>
> iDRAC Lifecycle log for a failed boot:
>   PWR2262  The Intel Management Engine has reported an internal system er=
ror.
>   CPU0000  Internal error has occurred check for additional logs.
>   RAC0703  Requested system hardreset.
>   CPU0704  CPU 1 machine check error detected.
> Normally the platform then power-cycles itself and boots the next OS; in =
2
> of the ~17 crashes during testing the BIOS halted in POST instead (PST020=
8
> "System BIOS has halted") and needed a power cycle.
>
> The same signature (PWR2262 / IERR on kernels >=3D 6.17, on R630/R730/XC7=
30xd
> with I350) is reported by Proxmox users:
>   https://forum.proxmox.com/threads/186063/
>   https://forum.proxmox.com/threads/177201/
> There, enabling X2APIC Mode, I/OAT DMA and SR-IOV Global in the BIOS is t=
he
> usual workaround. On this machine only SR-IOV Global Enable matters (see
> below).
>
> Hardware / firmware:
>   Dell PowerEdge R730, 2 sockets, BIOS 2.19.0 (also reproduced on 2.11.0)=
,
>   iDRAC8 2.75. On-board: 82599 (8086:10fb) on CPU root port 00:03.0,
>   PERC H730P Mini (1000:005d) on 00:01.0, I350 (8086:1521) on PCH root po=
rt
>   00:1c.4. BIOS: X2APIC, I/OAT and SR-IOV Global disabled unless stated.
>
> Bisection (v6.14 good, v6.17 bad; test kernels booted from RAM via PXE, a
> BAD boot detected through the BMC's SEL):
>   first bad commit: 96336ec70264 ("PCI: Perform reset_resource() and buil=
d
>   fail list in sync")
>   96336ec70264 does not build on its own (pci_resource_is_disabled_rom() =
is
>   not defined anywhere); it was tested with a one-line definition matchin=
g
>   the check it replaced. Its parent e89df6d2beae boots.
>
> Mechanism (from serial console logs with PCI dynamic debug):
>   - The firmware leaves the 82599 VF BARs unassigned, so pci_realloc_dete=
ct()
>     enables reallocation.
>   - On the first pass the disabled ROM BARs of 02:00.0, 01:00.1 and 07:00=
.1
>     fail ("can't assign; no space").
>   - Before 96336ec70264 a failed disabled ROM BAR was not added to fail_h=
ead.
>     96336ec70264 tests that with an idx that is not set for the resource
>     being checked, and 2499f5348431 ("PCI: Rework optional resource
>     handling") removed the test, so the ROM BARs land on fail_head.
>   - "PCI: No. 2 try to assign unassigned res" follows: the windows of
>     00:1c.4, 00:03.0 and 00:01.0 are released and reassigned; the I350 mo=
ves
>     from 0x91a80000 (firmware) to 0x92200000.
>   - The last console line before the reset is igb saving the config space
>     of 07:00.0 with BAR0 =3D 0x92200000.
>   The new address range is free in /proc/iomem; why the platform resets i=
s
>   not known.
>
> BIOS switch matrix with stock v6.17:
>   all three disabled                     -> resets
>   SR-IOV Global only                     -> boots (no realloc, no 2nd rou=
nd)
>   X2APIC + I/OAT, SR-IOV Global disabled -> resets
>   any switches, pci=3Drealloc=3Doff          -> boots (tested with all di=
sabled)
>
> Current mainline v7.4-rc2 still resets. A patch restoring the old behavio=
r
> (do not put a failed disabled ROM BAR on fail_head) makes both v6.17 and
> v7.4-rc2 boot; it follows on linux-pci.
>
> Attachments:
>   sol_v6.17-realloc-off.log       serial console, GOOD (pci=3Drealloc=3Do=
ff), with
> /proc/iomem
>   sol_96336-bad-dbg.log           serial console, BAD, first bad commit, =
PCI
> dyndbg
>   sol_v7.4-rc2-dbg.log            serial console, BAD, mainline
>   sol_v7.4-rc2+fix1.log           serial console, GOOD, mainline + patch
>   sol_v6.17+fix1.log              serial console, GOOD, v6.17 + patch
>   sol_v6.17-stock-sriov-only.log  serial console, GOOD, SR-IOV Global onl=
y
>   git_bisect_log.txt              git bisect log
>   lclog-excerpts.txt              iDRAC Lifecycle log entries for a faile=
d boot
>   harness.tar.gz                  test scripts (addresses replaced by
> placeholders), kernel .config, initramfs
>   lspci-vvv.txt                   from the working v6.8 kernel (BIOS swit=
ches
> enabled; with
>                                   SR-IOV Global enabled the BIOS renumber=
s
> buses, so the
>                                   PERC is 03:00.0 and the I350 08:00.x th=
ere)
>
> Notes: The analysis and patch were prepared with help from an AI coding
> assistant (Claude, by Anthropic); all results above come from test boots =
on
> the machine described.
>
> --
>
> #regzbot introduced: 96336ec70264
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222253



--=20
Kameron Markham
Mechanical Engineer
(253)347-3004

"The most difficult subjects can be explained to the most slow-witted
man if he has not formed any idea of them already; but the simplest
thing cannot be made clear to the most intelligent man if he is firmly
persuaded that he knows already, without a shadow of doubt, what is
laid before him" -Leo Tolstoy
