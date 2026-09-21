Received: from intranet.stegbauer.info (intranet.stegbauer.info [80.153.120.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866584AA56F
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.153.120.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790002332; cv=none; b=u6cyddsJZ6Ko98uGkeqpERORkcJ2Fp8UeIjMfoAYQpJR97LY4cDeTKkb9eTKVHlmj1TQ/bGgb2FnCptupE55yQBnGdhpvQ5+lWy/EzrBVgbECRWNd2VyXgReYxDfEAXhvUUGcg5it3Az1HUepX7kQoCn7+SoplYog1Po/zJ6wY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790002332; c=relaxed/simple;
	bh=lLkv+jMmZGe/gBXa297FIVQvjgB+rkxSEhGSCTfQps4=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=UIWQmtogC551Y3tCt4OnPdqYD4Fa3aDu8y+u4/MnOCxehB0rSmNZnRw33uAJUwDMW/iJzHDkqeyToTXr9BgiYjlf6fSOT4f4wbR4Kx5VOiPp03IRxVASVFLE8LXz4M9PjerJKPfy8FCfEKiGO3OcjgLs3X+Nm+n6R9Koe1PFNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stegbauer.info; spf=pass smtp.mailfrom=stegbauer.info; dkim=pass (2048-bit key) header.d=stegbauer.info header.i=@stegbauer.info header.b=hBotiaSB; arc=none smtp.client-ip=80.153.120.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stegbauer.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stegbauer.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stegbauer.info header.i=@stegbauer.info header.b="hBotiaSB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=stegbauer.info;
	s=201607; t=1790001905;
	bh=lLkv+jMmZGe/gBXa297FIVQvjgB+rkxSEhGSCTfQps4=;
	h=Date:From:To:Cc:Subject:From;
	b=hBotiaSBi7drfKQI3DTUYstB6jSgdzVQ711Vue5KS/EEokp3sCDqEk4PzhaEk7S+y
	 VXPuzGQX2WE4HydOl4UvnS3qnJtmInwBBeu6EIS0+vbFNPjvX8OGhbHbXJtLrXXZh5
	 MP9Dujra+rFmonz3pqaiXXyuiNsvmJagazFJfg4hyLf6K+TAdDQRHggVMOwc1Nf2iF
	 JKixoBOqNRiLd82u7diFJynAJUbUNb1fmiMlzcvkfnsInvkIxRUXRpreLEmCibt583
	 VmS0ohCniGrqPlkK4oQW2yrmknoEWr6MoUNMaJ9y1VsWCdp0kzgeVZUvum7UwO7asq
	 e35sU4djGr2yQ==
Received: from zimbra-soscomp.soscomp.de (zimbra-soscomp.soscomp.de [192.168.23.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by intranet.stegbauer.info (Postfix) with ESMTPS id 2BF179F793;
	Mon, 21 Sep 2026 16:45:05 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-soscomp.soscomp.de (Postfix) with ESMTP id 09E983468B1;
	Mon, 21 Sep 2026 16:45:05 +0200 (CEST)
Received: from zimbra-soscomp.soscomp.de ([127.0.0.1])
 by localhost (zimbra-soscomp.soscomp.de [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 09zaqutbCEJo; Mon, 21 Sep 2026 16:45:04 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-soscomp.soscomp.de (Postfix) with ESMTP id 026483468C5;
	Mon, 21 Sep 2026 16:45:04 +0200 (CEST)
X-Virus-Scanned: amavis at zimbra-soscomp.soscomp.de
Received: from zimbra-soscomp.soscomp.de ([127.0.0.1])
 by localhost (zimbra-soscomp.soscomp.de [127.0.0.1]) (amavis, port 10026)
 with ESMTP id E8K-a0RdNPFA; Mon, 21 Sep 2026 16:45:03 +0200 (CEST)
Received: from zimbra-soscomp.soscomp.de (zimbra-soscomp.soscomp.de [192.168.23.3])
	by zimbra-soscomp.soscomp.de (Postfix) with ESMTP id 9800F3468B1;
	Mon, 21 Sep 2026 16:45:03 +0200 (CEST)
Date: Mon, 21 Sep 2026 16:45:03 +0200 (CEST)
From: Thomas Stegbauer <thomas.stegbauer@stegbauer.info>
To: Andreas Wild <andiwild@gmail.com>
Cc: macro@orcam.me.uk, helgaas@kernel.org, linux@leemhuis.info, 
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Message-ID: <752770208.319.1790001903323.JavaMail.zimbra@stegbauer.info>
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 10.1.20_GA_4200001 (ZimbraWebClient - GC153 (Linux)/10.1.20_GA_4200001)
Thread-Index: u4aSUst814tCowhW4rO/jDxdk3UN8A==
Thread-Topic: Skip Target Speed quirk on clamped ports with no link

In-Reply-To: <20260801201244.4421-1-andiwild@gmail.com>
References: <20260801201244.4421-1-andiwild@gmail.com>

Hi,

another data point for the regression from 72780f796468 ("PCI: Always
lift 2.5GT/s restriction in PCIe failed link retraining"), for the case
with a device present, which v3 does not appear to cover.

Hardware: Raspberry Pi 5 (BCM2712, pcie-brcmstb), ASMedia ASM1182e
[1b21:1182] Gen2 packet switch on a dual M.2 carrier, one NVMe SSD
behind each downstream port.

Downstream port 7 (0001:02:07.0) does not train at 5GT/s on this board.
Without the backport (v6.12.75) the quirk clamps it and the link comes
up at Gen1, in use for over a year:

  pci 0001:02:07.0: broken device, retraining non-functional downstream link at 2.5GT/s
  LnkSta:  Speed 2.5GT/s, Width x1, DLActive+
  LnkCtl2: Target Link Speed: 2.5GT/s

With the backport (v6.18.50, also v6.18.39; Raspberry Pi downstream
kernels, pcie-brcmstb identical between both 6.18 versions) the device
is lost:

  [0.518303] pci 0001:02:07.0: broken device, retraining non-functional downstream link at 2.5GT/s
  [0.538795] pci 0001:02:07.0: removing 2.5GT/s downstream link speed restriction
  [1.537936] pci 0001:02:07.0: retraining failed
  LnkSta:  Speed 5GT/s, Width x1, DLActive-, BWMgmt+
  LnkCtl2: Target Link Speed: 5GT/s

Same hardware, firmware and DT; only the kernel differs. Swapping the
SSDs moves the failure with the port, not with the drive.

To be fair, the Gen1 link is marginal: AER on the port shows RxErr
right after clearing, and BadTLP/BadDLLP under load. The replays are
absorbed, though: 8 GiB O_DIRECT read at 222 MB/s, no data errors.

So: the port is not clamped on entry, hence v3's new early return does
not trigger; the first block clamps and the link trains at 2.5GT/s; the
second block then lifts the clamp because LnkCap is 5GT/s; the 5GT/s
retrain fails as the initial training did, and the error path restores
the old 5GT/s target, leaving the link down (and adding ~2 s to boot).

Before 72780f796468 the lift was limited to the ASM2824 with the link
up, which is why this worked. Would it make sense to fall back to the
2.5GT/s clamp when lifting fails, rather than to the original target
speed, at least when the clamp had produced a working link?

Happy to test patches (v6.18.y based on the Raspberry Pi tree is
easiest for me). Downstream report with full logs:
https://github.com/raspberrypi/linux/issues/7635

Thanks,
Thomas S.

p.s. hopefully the mail get properly added, as I hade to add the in-reply and reference to the txt-body of the mail.
