Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794710376;
	b=3MN7muQq+NuHQsrKA1g8STTv9NpnzExs713ZGTmivuIdqMoJvgVF5Rv5yqlKGoeAuuHA
	 qvaDs9eG9MH5dBG8d0Wc8hgCZYh0yq63X8/3Ihb2ycYT5yS+T3vFijO/2YuT2evknx9dc
	 aWyZDDIt9T9bED1327fLcmPlm3mS79pVyrQmUfL5l61n9iLFAibYDqHhnJpliSDUpbviC
	 eirq3VPmb3fKfNYU5VU8tjXAs37RaB6hmGAeW2enQJdq5KxWAIT3bRhq+RqtKynjwiO04
	 +r7zdnDPPYLzVDuyvTjwkvzIeEja3aNXh04s4sG0Q9JudD0h8YlX84/nbcn+G5yjlqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794710376;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+cJpKZaKJYIoa7D/gp2rh2l3AKqTggTbPHMS342yxYM=;
	b=135Bgkj258+FLDq+wnzKzAkV3WgscTTw0DHr5XjJozWJ5jhvBjT2piA08h4DRlTVdUfB
	 njXuRoaMM3KpmDXFDpeomtoeO+DBZ4Se3BT+xDjrI3SLd97eNrHrTN0qUOJY2mt3g+g8S
	 rxxO4rfWgyoRKla0x0YA/AtbvbgE+yAeIFkcQyFpH6+eooMjJcWvq9WPj2/KC04xEmUJO
	 3YDgH4Vntj/u1NVvX1lyWRyMvPLp+AOSBCgfLAPTIRONpFcSTzNgoG9TWLZg6XQEgg82l
	 FwHUQv+zvAUL2dJN/kqjcyR8j6BUKo4e3mQ5Bawb75+w9MTouUke8bzYcvf116BgvcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYdy6oX6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4F606A327
	for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2026 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYdy6oX6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6261F000C4;
	Sun, 15 Nov 2026 02:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794710376;
	bh=+cJpKZaKJYIoa7D/gp2rh2l3AKqTggTbPHMS342yxYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYdy6oX6PqWVbxhttTC5rzGo4UWHvFLSglLMSaiKB4sQ/W9huyKDY+BVnn7Q81R11
	 Ns6Y6YzFsZIIcS695GBdK5U1L/F9caFM3o8U+qLxEf41GckiKy0ugjg0ZiNv8I4PyU
	 g2q3SmxlO47rIBSJ74UCfVl6QYWDW5eBwMDCIEQG91j+sWHZI4US+jBVeItPPB+Q9H
	 wUyeEScIwEsiMR0L/Yg5lwC68OdinGQBjjdQEJ8O6qchMA5nO7XiIlqyu1X0aV4+P5
	 qnw93lJ7wm8Y6up+r2I7cEpYQMjz44MkoMqCQHWUSWR3IotjlcrV+lQ1BAtBPz/PSN
	 gWeAPGtvIsXVA==
Message-ID: <sashiko-outbox-215190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [bug report] nvme-pci: NVMe lost after S3 resume, CSTS reads
 all-ones for a few 100 ms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Moritz Hiller" <m.hiller@pc-heini.de>
Cc: linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 02:39:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] nvme-pci: missing Signed-off-by trailer and RFC email commit
  message
--

commit ba0016eb2b4fe54e7c1345a47b1af60d7461f91e
Author: Moritz Hiller <m.hiller@pc-heini.de>

> nvme-pci: NVMe lost after S3 resume, CSTS reads all-ones for a few 100 ms
>
> Hi,
>
> on my desktop the root NVMe drive sporadically does not come back after
> S3 resume (roughly 5-10% of resumes in automated runs):
>
>   nvme nvme0: Disabling device after reset failure: -19
>
> The single readl(CSTS) in nvme_pci_enable() returns all-ones about
> 200 ms after resume. The controller is not dead, it just needs a few
> hundred ms more. A small wait loop (diff below) fixes it here, tested
> on CachyOS kernels and on vanilla v7.4-rc2. I am not asking for the
> diff to be merged as is, I would like to know where this should be
> fixed properly.
>
> System:
> - ASUS ROG STRIX X570-F GAMING (BIOS 5044), Ryzen 7 5800X, S3 (deep)
> - Samsung 9100 PRO 2TB [144d:a810], FW 0B2QNXH7, at 0000:01:00.0,
>   directly behind root port 0000:00:01.1 [1022:1483]
>
> Observations:
> - pci_pm_resume_noirq takes ~0.3 ms for the SSD, config space answers.
> - At the failing CSTS read config space is intact, the link is up
>   (16 GT/s x4), the device is in D0, no AER errors:
>
>   vendor=3D144d cmd=3D0006 (saved 0002) bar0=3Dfcf00004 (saved fcf00004)
>   pmcsr=3D0008 lnksta=3D1044 rp_lnksta=3D3044
>
> - sysfs remove + rescan brings the drive back after ~3 s.
> - ASPM is off on this link, pcie_aspm=3Doff and
>   nvme_core.default_ps_max_latency_us=3D0 make no difference.
> - Unpatched, 2 of 15 and 2 of 24 cycles failed in automated runs
>   (90 s sleep, RTC wake). With the wait, no cycle failed (30/30 on
>   CachyOS, 15/15 on v7.4-rc2); the controller answered after
>   200-400 ms whenever the wait triggered.
>
> My reading: pci_power_up() finds PMCSR already in D0 and does not
> wait, and pci_bridge_wait_for_secondary_bus() only runs after D3cold
> and only checks config space. So nothing waits for MMIO to come back,
> and nvme_pci_enable() gives up on the first all-ones read.
>
> The diff polls CSTS every 100 ms for up to 10 s, only if
> NVME_CC_SHN_NORMAL is still set (the was_suspend test in
> nvme_reset_work()) and while pci_device_is_present(). Probe and
> runtime resets are unchanged. Known downsides:
> - The 10 s bound is arbitrary.
> - It also triggers on thaw/restore after hibernation (same bit set).
> - The wait sleeps with shutdown_lock held, as nvme_wait_ready() already
>   does in the same call chain.
> - A controller that answers config space but is really dead after
>   resume is declared dead 10 s later than today.
> - A wait that times out is not logged.
>
> Should this go into nvme-pci, the PCI core, or a quirk for this board
> or drive? I can provide lspci -vvv, full dmesg or test patches.
>
> The problem has existed on this machine for about a year, possibly
> also with the previous SSD in this slot. It was hard to pin down: when
> it happens the root filesystem is gone, so nothing gets written to
> disk. I only got the first log of a failure in August 2026 via
> netconsole, and every failure captured since then looks the same.
>
> Disclosure: I am not a kernel developer. Log analysis, code reading
> and the diff were done with an LLM assistant (Claude); I ran all tests
> on my hardware. I can send patch with Signed-off-by if useful.
>
> Thanks,
> Moritz Hiller
>
> ---8<--- proof of concept, against v7.3.4 ---8<---

[Severity: High]
This commit is missing a Signed-off-by trailer certifying the Developer
Certificate of Origin.  The commit message is also formatted as a mailing
list bug report and inquiry rather than a standard kernel commit changelog,
with conversational notes that should be moved below the "---" separator if
submitted as a patch.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/598ee2b4-32aa-4ad3-=
99c7-db7f9a7e7736@pc-heini.de?part=3D1
