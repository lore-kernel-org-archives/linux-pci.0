Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2277E339847
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410076; cv=pass; b=fDiTCYK7z6tjG3WrHjDFSim+xV8agXfIr7SoSKuSkMsH9e7TElM4eEgwMUqw5mTQEcPfWYKumNKTTjodnXyHHoz/4G813oqG7G+Tv7ZiJjjisKrhpGlvAL1n86G2jT5luap6bP1j58H+wAnWmmRlkDgdFJfDsWoZVwF13rW/m5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410076; c=relaxed/simple;
	bh=ikrzNW38DkKxIYMT7Nc6jYhcaAg6y6pu4BvBD+PGUTM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=D4Mk9R22mIyKUhhPIxRXsQa+VlMpX/SJ/HBdpbK3CQ25vOvRwkTrMViEPqZSMUjhVrguoaiKys/GNHuO7BtM7b/b+fkxCm26WL/T5pMVqHUneJzNUxVcNxSPBGZxvSTUYyj/ZLxKRD5g5XAkKe1P34BBkwJpAAxmCxyJ2hCQ+Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmZSvNyx; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmZSvNyx"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso365828a12.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 18:01:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786410071; cv=none;
        d=google.com; s=arc-20260327;
        b=Uok9EGKnfvDkdpTfjT4k6f586wZNXWVon+ahjdF/z4QKNc70r6N85CcS3ubF9U5dB2
         +owluqWprJ9FDCDr3OUA1OJpMjF+DA7H3Q2CpzIsTsNImNTAf+hZl2Elk9X1072JEsTQ
         JpZkYA05uXdVAlzP63jt6GovlrLA00F9gE5pDoGJSws1Xoi1dyCiU+IMKE2XQarkrl9n
         dw32epj4I+s2UX15KZogsQUUc9ltfPV5PNFWozOoT++cpfkEHSTI8s6QuuqD4If5C8xx
         ywNJa7qKrRpEdg+TsSRSqzlwqihOrYex3wfVfdmJ5Um4vZEVjvUVzlbvUZo4K2WcSsMm
         uE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ikrzNW38DkKxIYMT7Nc6jYhcaAg6y6pu4BvBD+PGUTM=;
        fh=6EVG1Z/8txoDoOMvXzm0+bUit4wXeynaV+KTBpDHG9c=;
        b=FaDZLQIDsNxdQvHf1TD77rISdJOMGlaMBdtiWP3N2mWNq945BEJSy2n4mDjKDN4iEF
         OpcmoPtYU0CymyurlHiKsQtl7sz8E9qKle24fhKiBYvoH9+XA1Ki5SHm/XnueJ8nNExo
         UIaU4LqBneqKvkCORap4sw+MpxXIifczpbwsj+Xb3YVzvJ53pKfWIlJA6KXHHtgvULxj
         io2H6+82sDhYtYIOTxj59GGHueA4BEdsqIQJcOjzvt8nfehVlAfDz6rjMlpspq46pQ3b
         jSmo/DxBAT/MeZuPJBavhIMQRNVzx0TXdBPbRag78szSvWwWk7IpnxBFqxVMDJis4oYt
         X8Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786410071; x=1787014871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ikrzNW38DkKxIYMT7Nc6jYhcaAg6y6pu4BvBD+PGUTM=;
        b=mmZSvNyxP2sE6G/+zr/OjA9jUFVxuG1rmfsK/031T2mJDEb64U+RRdXS1VINrlQJvR
         fwUutK7lnb7nq3lxwfpOKnmznJisZbWddu5pK2U4Y8WZrQCa+pnkIKxU7LGU8l8pbza5
         K2HoTiURMp6hACBoEZRJ3G50CN29U31p7CL72tlmWAuQEkzBGlHvXUy8oPOQYLWiLrvG
         gj2WOMX84k+JmYnOHIuUFBaNc+0OHqV8BTGT1H+bC8Y1PmX2YmbIWwnP5vf+LJcMRuLH
         07iBqu5J4K+fgVHEkLkObqTtwg/QyOgMEvPikg2rySq3YxE1vCjoIzeQ2xJGgGfzQnXH
         8hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786410071; x=1787014871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ikrzNW38DkKxIYMT7Nc6jYhcaAg6y6pu4BvBD+PGUTM=;
        b=ACp1NfVPe1bXnD6XFVTwvnE4UUQiH+t9yIVZA2Iu2ceMb3HDaKfPwpn9h+oo6F7gvI
         9N+i7ny0t1DLmiAWDePKHk64bwmXfn9Fmxujcj4lL/K86LtXBSyqmMKfaJpiM/Udno+a
         WkqQDI+/rO8RgjQrTdZ/totdvCCdsUq3cjbhrhu5sXbI8i0BYac65j58ngykpKybeGu1
         spnyRh0ANo0dkVvcEhOBAeEEiWIYmR7Ey4SG9yl6Q32MLsDtTb32zHBtDYQdCYlxZC7s
         espq+jKKyHK+pLSpi4Exlp2AdoCqEFwpHOfpLPT2XZLFTYH4XBkbKhmHcQxMMcv73DHU
         09pA==
X-Gm-Message-State: AOJu0Yz5AsThSoE6q4mZ9TJ9wMU0fTSQbkAHMPCsyDkpAsxrdl5aSUHh
	BVkfDJis8e4m+9AY/xGLL8hfy+lg4sfphHGtaIzNNEvoJoPB69K3UJL6SVyC+r8uH3WKD/MJquv
	mHiKAJYkqPXBUTXwj2GwdiOonGqX/K5mtu89H
X-Gm-Gg: AR+sD12z2T9c+UdI1OQyRy99X8qeZL/MaVri+aNkJaC/S4cCPMXr32HFOgjULHaTaS7
	AZZovsipY/JvPIjQfemOIYPfP5/UxpecZca5twY6c1oYY1yqW+VzJwA0pZSb5o1PciAXLfAdCah
	L2VJY8dmMowuI4INLO4fIoCjiq7Vx0Yqzq+Osrxm8niVAikOgiP0xNiF9Fkhaex4Q3sFUFy2vrL
	TIa/HPN0Ebn0i143wz39NbPl/fh++aNte1hhIhJ7t6mhDiBI4HbZ9aoMM5B/AEhLeFFNRJ8MHtE
	Ttt8vfG5pKXivhDFyFPKvsdijIQ7ineeu2BVUo+oC0Pz
X-Received: by 2002:a05:6a20:6f04:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3cc22f3a917mr2527771637.14.1786410071036; Mon, 10 Aug 2026
 18:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Stevens <thinker.healer@gmail.com>
Date: Mon, 10 Aug 2026 20:00:59 -0500
X-Gm-Features: AUfX_myCFEgdwEKjmTFvdmSjhpfg_YFpKnd-DekweJSD1mBc-ikP--wRPue04JM
Message-ID: <CADoo8uyrmw_GkNgNf+bV_pieYN_gn5i49rOF8jUvSsfPOcqCJA@mail.gmail.com>
Subject: =?UTF-8?Q?Pericom_PI7C9X2G608_=2812d8=3A2608=29_missing_from_ACS_qui?=
	=?UTF-8?Q?rk_=E2=80=94_breaks_Renesas_uPD720202_USB3_cards_when_IOMMU_is_on?=
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, nathan@nathanrossi.com, 
	nicolas.cavallari@green-communications.fr, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I'd like to report that the Pericom PI7C9X2G ACS erratum handled by
pci_fixup_pericom_acs_store_forward() also affects the 6-port variant
of the switch, PI7C9X2G608GP (12d8:2608), which is not covered by the
existing quirk (2404/2304/2303, and b404 recently proposed by Nicolas
Cavallari). On this switch the erratum is severe enough to make an
entire class of consumer USB 3.0 cards completely non-functional on
any system with the IOMMU enabled.

Hardware

StarTech PEXUSB3S44V-style 4-port USB 3.0 card ("one dedicated channel
per port", widely sold ~2016 for Oculus Rift sensors). Topology:

00:1d.0 Intel Z690 PCH root port 07:00.0 Pericom PI7C9X2G608GP switch
upstream [12d8:2608] (x4 gen2) 08:01.0 - 08:04.0 switch downstream
ports [12d8:2608] 09:00.0 - 0c:00.0 4x Renesas uPD720202 xHCI
[1912:0015] (rev 02)

System: Alder Lake / Z690, kernel 6.18.43 (Void Linux), VT-d enabled,
booted with iommu=3Dpt (default domain: passthrough). Firmware for the
uPD720202s is the correct v2.0.2.6 image (sha256 177560c2...) and
uploads successfully on every probe.

Symptom

With the IOMMU on, the kernel enables ACS on the switch's downstream
ports (ACSCtl: SrcValid+ ReqRedir+ CmpltRedir+ UpstreamFwd+). The four
xHCI controllers then probe cleanly, register their buses, upload
firmware, and report port connect status normally =E2=80=94 but any device
plugged into any port fails enumeration with:

xhci-pci-renesas 0000:09:00.0: Error while assigning device slot ID:
Command Aborted xhci-pci-renesas 0000:09:00.0: Max number of devices
this xHCI host supports is 32. usb usb3-port1: couldn't allocate
usb_device

All four controllers fail identically. xhci debugfs portsc shows the
port stuck at "Connected ... Link:Polling" while the Enable Slot
command times out. Posted writes from the endpoints still work (MSI-X
interrupts for port change events are delivered), but the controllers
appear unable to complete DMA reads (command ring fetch) =E2=80=94 consiste=
nt
with the known PI7C9X2G packet-buffering erratum when P2P Request
Redirect is enabled. No AER/DMAR errors are logged for the failed
requests.

Confirmation

Clearing ACS control on the downstream ports at runtime and rebinding
the drivers immediately and fully fixes the card:

for p in 08:01.0 08:02.0 08:03.0 08:04.0; do setpci -s $p
ECAP_ACS+6.w=3D0x0000 done

+ unbind/rebind xhci-pci-renesas for each 0x:00.0

After this, all four controllers enumerate devices normally and the
card works (tested with HID devices, hubs, and mass storage).
"pci=3Ddisable_acs_redir=3Dpci:12d8:2608" is my current persistent
workaround.

Given that the 2G404/2G304/2G303 (and b404) already have the
store-and-forward fixup, could 12d8:2608 be added as well? I'm happy
to test a patch, and can provide full lspci -vv dumps, dmesg, or
register reads from the switch on request. I can't say whether the
store-and-forward vendor register of the smaller switches exists at
the same offset on the 2G608, but I'm glad to poke it under
instruction.

These cards were sold in large numbers and every Linux report I can
find about them (Arch, FreeBSD, Proxmox, Unraid forums) describes
unexplained failures or dropped input events with no root cause
identified =E2=80=94 this quirk gap likely explains most of them.

Thanks, Maximo Paulino
