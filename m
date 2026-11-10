Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794352505;
	b=nI5fqrCVPPBWJKWyVWYWFUz0A0vcWp+S/1qdRJJiH0LtrkcurrMX8ixz4xnYZHhhE2yA
	 7Y6wlyVkSVImJF7PRmLJVUSs2d+z0PryFagf5Rp/Z4WX1xMLFlqyUcFzZranS4WXp8pEO
	 rRYZONSyAr8iIn5Tl/PU98udCiKsExIxsK0ETeN0fDZqGF/Z/IRHjaF9WNuZT0cY/musQ
	 f48MBE0p3SBATVp9oHnleeR1t1Hiyq4R77B+9mumDmOvlK9WMkoYcNgPigSltX1jpZCsD
	 6BdLwgkBGToDXnK4elo7BuDePC+EFWaBW+254Zj6G9yUTAz3xaaNMNGtXL6J9jsxrhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=UHoJSqCLvyJwBQ65tIMfan/ByALnrwkzVh6tGfih3LY=;
	b=gFLnFNcMZ84EkeJgswDs5n7az+IuKSYvS+AX28ZfyJmG5quZmxD2d4O1qLPpfpelP06t
	 CSTCtzNPnMVqONKcmJ/wSnVq5d750hgRLPNeIqtgye9un+gWyJQJx7vawcNgdKnltKgwE
	 iJn26/h77hvW+kOWcTytgyv7jTmVh+BDtzU4EX89ad7Paih/W1KtVusYl0iK+KI/m6cv8
	 XEwkcag4k/MZl3Mva/9AstFZxNTGDlzk4gj1f/TjcurrdUPFma9Tezvp+YQ/yguIDuUcD
	 3UzYjHkkU3ohUrPaaNuOMzPbblgFwiyedMCiESncj6L2EoZHCW/JJI372UnjidO0CXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cz1zEhQG;
	arc=fail smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C59606A327
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 23:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C59606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cz1zEhQG
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso2433778e87.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 15:15:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794352503; cv=none;
        d=google.com; s=arc-20260327;
        b=SQSlW+yltm0fw+m65kLn5axRSrMe4OwAWWcwPwcXPhEAuVhz70gsKO2DWlIFxNo8Pq
         9xXGg3hyOig+iMwGDnFlFzOU66CNB1lJ1zIs5Nvo2w+9S1Hjpk/mavBX/mutKKm/MWJo
         DvTdulykEeci7cRJl7of151eWgtu8js9ZeLzyhix4Cgf3CdwgeJ5gEx9xWcDQGbF4w/s
         CU/8M9KU2obR8T6XA+KUBzv4lmq+zRV8Hhsefw919smL8WDyvZ/Jk9xwT39ECQJKA8sy
         4mrldg7/p/d3B93pARBnAXV+Nk0zqbnVKJnT1WH2kC3nPpwW5eQ27cVu1fG4XkT6dPbe
         idZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=UHoJSqCLvyJwBQ65tIMfan/ByALnrwkzVh6tGfih3LY=;
        fh=NWfGKhQbTvurZyGgN/mPM22EZsxIEG6blHM6YRY54RI=;
        b=KQcylrMpucfEqi7MK09WPWKNx9aiPm+M9lToUHMwRNLqM/9anQkGXsjzH+qOrF8jCm
         37SAw54Rn6IJq73BqfaLKIe4utLwf/+4z+Rm6fH3Gktfij/+T7lV3yH8zl247pmsnBMm
         fNghclHPS5Mu4bRg8XcZhMQC6HYPGDR0Vtoe/oF143UR9U5LAdUUdfOLXda9mhrtl6A/
         EZfcuGhxJMzHZ8hXGqn+1x1Mns6N/tVFGzqMlSEFm2f/tL0y8uCOyNlnLPMXbs5viFat
         abcyyyW99TH3GZoqI+tcQMOTAfeN+BxHsQTnDOfhSW7ihY+xkyq8WK8teJMZMxelTc52
         F8bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794352503; x=1794957303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UHoJSqCLvyJwBQ65tIMfan/ByALnrwkzVh6tGfih3LY=;
        b=cz1zEhQGrl9LDJW5JfrRxRmet3Ck5QjhbXmPEKd4MvFHowpEthLuJUr7tqbryE6jkq
         PcNex8qKV7JhaqmrXFygRKsMFphd8JVSqkhtD4vP3MJr1BUMDiEqA2iqbx7/N278QNdJ
         aV9ZMKAXTpkA6a2QxnKdMcoVuI1Qbu8U/JKD9G0bdYlg8gA3+sce5wAgRZS3Elp2kvud
         DILeX7hdxBQ8f1vCY4FhYl0dKXF3VhH3RK/0ywBzEgi5we1xb8fWpdSHHwwxMyLaTSQ4
         Dyf0UPJcoafpYeS/VF31DWBJYhJbV8RtZGEaN+TJNTFcKNMcT1Tuj/AWkAno5dVXfAUr
         20fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794352503; x=1794957303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHoJSqCLvyJwBQ65tIMfan/ByALnrwkzVh6tGfih3LY=;
        b=umXraMvZC1XRV5zA1AagaIdQrwDyxmsbHIVk7ne6Am6HSCLeQRXafakH/vMyr76wIS
         YzdCAIwCQ4jT6z3YMrpZP661yp27tLqygrU/Kv33gZ7v0xnSD2rZRxZHPDxHkG/Y8JOI
         kgnKwAWRSuxyf0fnj5OjmvI0dvXXYGG/0uz4EloBD+iRe/DVOyK880YQmPFPFqpMTi9L
         qCPvZtRkw2pXTtlrm5ZxM0t8y4TsbmSZeEyAPk8a7C28qClEEED3t/WtyKS3r/q5PLhK
         zLELUHcZ6Ux+sfkJjW/UrxaQYur39gYup6ZXALSGUjsNuXZ6BgYGZ79U4oT41IA8Ynij
         jCAw==
X-Gm-Message-State: APuU4Z+VA1y18MP1Nu57dKYT8tzjhAxg5NaBB3KknnufLjmBVXHMItYu
	1JrQzYFVjH/oObhgssED9eoOGpHuOskSmRLIgNdeaNgZVOn8pVPX/a97RNynKE8BlKYZL3AFCSJ
	DEY9OxRF3HXpeA9jH3IDOhsVUkDene5m4WVDn
X-Gm-Gg: AYBFou2TMiIJAKVT7oNk0IJtVpjfQDaumkPpahifNwuAZ3R+fYSaj7LdhfY/nYvDoMt
	k2KrAFRsNgRmmVhzo7bbiI+c1lkYYFaN98x6e5zkVk7cqceIWFeiTZEoBH1I2V8uSSu0dKFYvaO
	OadDQCZqdyY3AwvoVYJYjKfHP0xj3/F63Q32WfqOFmilkcJeKGKf9n6kdVdeGaeRUPOKxhpcu7z
	9aC7Lnnw0nnaiwrOs9Necq6EQQMMV0C5xiJs9e2mFlD1EnRSNOL49xwQ0JjftE+uXuHvbB9iUWr
	qYRTjO8KCZhz7rQTmTAyzacoZMaLM2tMebDwbID6AgqUrD4jlE9BX+0xMt/jcR3d3w+1EdCK/wd
	VSUK6iKcfnyg02yiVhqsDFrw4IUaKpBpNe9wePWvR46WePo6imjGaBvyv7A13aur0bcAssz1bu+
	N9BWJ9IG8FlzdSW1SXvAMuWInK86NWVzCeiLAwuVDMQxglbfB7rlQOCOnrgoHERqgcWltoLQ==
X-Received: by 2002:a05:6512:2213:b0:5c1:5c9a:fd9d with SMTP id
 2adb3069b0e04-5c15d7680a2mr136511e87.64.1794352502776; Tue, 10 Nov 2026
 15:15:02 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bug-222253-41252@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222253-41252@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date: Tue, 10 Nov 2026 17:14:50 -0600
X-Gm-Features: AclHuK9vazuIlBsthx05azqG-Zropzp86ELvNih1H0eih_bznMLlD679bmaqlbQ
Message-ID: <CABhMZUVJjeNUwp_yT3kkyk1U+0MNw0_qF=RU39keKnypd9T2YQ@mail.gmail.com>
Subject: Fwd: [Bug 222253] New: Dell PowerEdge R730 resets at boot since
 v6.15: failed disabled ROM BARs trigger PCI realloc, I350 moved
To: Linux PCI <linux-pci@vger.kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	regressions@lists.linux.dev, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[+cc Ilpo, Mika, Mario, reporter in bcc]

---------- Forwarded message ---------
From: <bugzilla-daemon@kernel.org>
Date: Mon, Nov 9, 2026 at 6:12=E2=80=AFPM
Subject: [Bug 222253] New: Dell PowerEdge R730 resets at boot since
v6.15: failed disabled ROM BARs trigger PCI realloc, I350 moved
To: <bjorn@helgaas.com>


https://bugzilla.kernel.org/show_bug.cgi?id=3D222253

            Bug ID: 222253
           Summary: Dell PowerEdge R730 resets at boot since v6.15: failed
                    disabled ROM BARs trigger PCI realloc, I350 moved
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.15 - 7.4-rc2
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: kameron.markham@gmail.com
        Regression: Yes
           Bisected 96336ec70264
         commit-id:


Since v6.15, a Dell PowerEdge R730 with "SR-IOV Global Enable" disabled in
the BIOS setup hard-resets during boot when igb probes the on-board Intel
I350 (8086:1521, behind PCH root port 00:1c.4). v6.14 boots fine.

iDRAC Lifecycle log for a failed boot:
  PWR2262  The Intel Management Engine has reported an internal system erro=
r.
  CPU0000  Internal error has occurred check for additional logs.
  RAC0703  Requested system hardreset.
  CPU0704  CPU 1 machine check error detected.
Normally the platform then power-cycles itself and boots the next OS; in 2
of the ~17 crashes during testing the BIOS halted in POST instead (PST0208
"System BIOS has halted") and needed a power cycle.

The same signature (PWR2262 / IERR on kernels >=3D 6.17, on R630/R730/XC730=
xd
with I350) is reported by Proxmox users:
  https://forum.proxmox.com/threads/186063/
  https://forum.proxmox.com/threads/177201/
There, enabling X2APIC Mode, I/OAT DMA and SR-IOV Global in the BIOS is the
usual workaround. On this machine only SR-IOV Global Enable matters (see
below).

Hardware / firmware:
  Dell PowerEdge R730, 2 sockets, BIOS 2.19.0 (also reproduced on 2.11.0),
  iDRAC8 2.75. On-board: 82599 (8086:10fb) on CPU root port 00:03.0,
  PERC H730P Mini (1000:005d) on 00:01.0, I350 (8086:1521) on PCH root port
  00:1c.4. BIOS: X2APIC, I/OAT and SR-IOV Global disabled unless stated.

Bisection (v6.14 good, v6.17 bad; test kernels booted from RAM via PXE, a
BAD boot detected through the BMC's SEL):
  first bad commit: 96336ec70264 ("PCI: Perform reset_resource() and build
  fail list in sync")
  96336ec70264 does not build on its own (pci_resource_is_disabled_rom() is
  not defined anywhere); it was tested with a one-line definition matching
  the check it replaced. Its parent e89df6d2beae boots.

Mechanism (from serial console logs with PCI dynamic debug):
  - The firmware leaves the 82599 VF BARs unassigned, so pci_realloc_detect=
()
    enables reallocation.
  - On the first pass the disabled ROM BARs of 02:00.0, 01:00.1 and 07:00.1
    fail ("can't assign; no space").
  - Before 96336ec70264 a failed disabled ROM BAR was not added to fail_hea=
d.
    96336ec70264 tests that with an idx that is not set for the resource
    being checked, and 2499f5348431 ("PCI: Rework optional resource
    handling") removed the test, so the ROM BARs land on fail_head.
  - "PCI: No. 2 try to assign unassigned res" follows: the windows of
    00:1c.4, 00:03.0 and 00:01.0 are released and reassigned; the I350 move=
s
    from 0x91a80000 (firmware) to 0x92200000.
  - The last console line before the reset is igb saving the config space
    of 07:00.0 with BAR0 =3D 0x92200000.
  The new address range is free in /proc/iomem; why the platform resets is
  not known.

BIOS switch matrix with stock v6.17:
  all three disabled                     -> resets
  SR-IOV Global only                     -> boots (no realloc, no 2nd round=
)
  X2APIC + I/OAT, SR-IOV Global disabled -> resets
  any switches, pci=3Drealloc=3Doff          -> boots (tested with all disa=
bled)

Current mainline v7.4-rc2 still resets. A patch restoring the old behavior
(do not put a failed disabled ROM BAR on fail_head) makes both v6.17 and
v7.4-rc2 boot; it follows on linux-pci.

Attachments:
  sol_v6.17-realloc-off.log       serial console, GOOD (pci=3Drealloc=3Doff=
), with
/proc/iomem
  sol_96336-bad-dbg.log           serial console, BAD, first bad commit, PC=
I
dyndbg
  sol_v7.4-rc2-dbg.log            serial console, BAD, mainline
  sol_v7.4-rc2+fix1.log           serial console, GOOD, mainline + patch
  sol_v6.17+fix1.log              serial console, GOOD, v6.17 + patch
  sol_v6.17-stock-sriov-only.log  serial console, GOOD, SR-IOV Global only
  git_bisect_log.txt              git bisect log
  lclog-excerpts.txt              iDRAC Lifecycle log entries for a failed =
boot
  harness.tar.gz                  test scripts (addresses replaced by
placeholders), kernel .config, initramfs
  lspci-vvv.txt                   from the working v6.8 kernel (BIOS switch=
es
enabled; with
                                  SR-IOV Global enabled the BIOS renumbers
buses, so the
                                  PERC is 03:00.0 and the I350 08:00.x ther=
e)

Notes: The analysis and patch were prepared with help from an AI coding
assistant (Claude, by Anthropic); all results above come from test boots on
the machine described.

--

#regzbot introduced: 96336ec70264
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222253
