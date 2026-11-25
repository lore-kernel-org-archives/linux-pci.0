Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795642870;
	b=HWetxd5+EaIqXXD/X7Bc+zhpxl73leG56Te9pPn/lyjxxW2QaAKlC8K86mTNvtSgxsyY
	 W/IkWDtPO2eKdqdJbwarFoQGgR0SM2wpjdt20s2LpUHZRzXSEfZJ+e2rlKtSx3PauzVu7
	 G+quXPD1ZzhUGhDtF5AbzTYH+cCoHoGc23g4sAYO9prShd/ETfKYM85IU1tIgDMGqPn8j
	 4j8UXDe2qyp3rSEd786py3ywhJSSXTiYyTJ9Jmjd+5lNSWTlVkhcOsm9sOQfn9Egsj+Tf
	 jmF/9YMLrjCjIR40won8b8E3nEQ9hkfTZQH9g3XehSWKVzXqpM2TAT5p0YZOdisejqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
	b=3a6VgCPD+TluY2nOTB6qgUtRe0CZc4G1RVHH6VP1pxVtFKVhzhXbzUkG+eFJjicttQ3e
	 7sufpuHGY/j02DT1VtuLaKXY+IZ/E7NR2eczTd/J5zF0HyZcakx8izL5u8kx13SfoIIee
	 Pj4q3ptmp3LnO2eRT3NAhB2W5MaIqwkq3A6sQ99ABd/Mt+hSY+nJ0LWzUvOeqmz9vvESH
	 tPn138dnOvvmNii2JpQCIf5i09PtvXmwrDHTc45xKC1Yd315T3169+eD8KARA0nNcHXDJ
	 JX5BxQBZ5gMuM1eAYEKfMEjOSBC/9p183hf1gHp9ynZ+GosqEO3gycukKY6yGuqfxvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aC3740uV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEA8606A327
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEA8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aC3740uV
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6ba12b00c76so6666657a12.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 13:41:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795642869; cv=none;
        d=google.com; s=arc-20260327;
        b=Kcivp3ImD+paBVc+QTpb02yxBJfxbYfaUtIQVNR7UI/YiSlGy1gC9TG5/bjxH8xFQ0
         QvsQ/f+42emPlUJmWinG2rwNkDf+a07tIYECaRT4/UwD7B8OAyHNo+w03RX6ktZu4LqP
         /u+IoHi9VeWThpzHr5Ldd/k7BhfwTsJ2T49lcZnWQk7QuIv2h+Sgnfuw2ULiis42s5ue
         PZvAk5em2gXvaqI+2WrHTDKhM7mc3lbSongTyfV1Who+VI0YNojTOC3iNAG3pfcZ9swI
         s9TBWbSxIBTo17nB15wSmccYOLr8LFWGHZ+gPPfuZWQ+6OIuOl3MULI0kFMsyv7hrGa8
         jFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
        fh=rI6xhYyqA2joEfgVy/Ce8kz06AeUKbewXe/QCOE5QCo=;
        b=TyP0kFl80m3CwB/pfiLx7chYHHjkDr5Iz7NHvCIURiintz3FnRSBMDjSY6oNTU1bQD
         iunPffwWwefmG+uVWncKuneBLEz3ECnbjmZ+/SPD4/HL38i+20F6Qo/XaQvqowzAfpuA
         x9ioNQQE1K3nFjV1w2UqMVx8A7zgbkP0dzSH5RBlaX6z5EBiXwg8AmokAc3EA3h2KHhZ
         EyoUwb1740u6BtLvzCqoZuRmtU5Plwbd3wFwwA1A6+HCyNZVt41j1nei+G2eZvyc9tbP
         fv/KSUfZ/ZMfH46Umy3pNhumtRkL20ag1MGBmb93438I8se6Tp+y7nC6DnSqELBahgHp
         dcxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795642869; x=1796247669; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
        b=aC3740uVgVcyHCk3CmmlKf829ag95gDggE1ypjdPOMt1t6KoSJzC9w+nj2Y7G/65yW
         VP8q9jwLQFzGYlwqygAFGiaNbGigY7UvHmBVFXiSTeOe3Yf0Wz0Q4m0eYWc5abftDy7+
         qOmck9n391Bqr968mTrDMAQy+FYjLFqXA9P7bcK1iIJvX73AQpI6CgMqRjo17Oc3fCH7
         dsXYnUyo62OZ4A/csv3h5hIU1vZoY4n6SCOs63e0XhDnJ6MXdIa9Q7QFo3seUIL3Q9iP
         cINpwH8wNJTAIy//DGMq4/s2l9GgDxzIbi8hdElRxqlnhPK1Dtyln6NCJTMm5BurWXyw
         SEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795642869; x=1796247669;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hs7Z4dSlPzZIU83bg2ZGfkYDjyGJ7+bM1OgNG/+I3Js=;
        b=uy0Ns/FPdvqow1tAwgKqM1OJx0c2KUEjH8UCcXeV1MDBDudDrRlg/nud2Gl03j0Hgt
         7OHQJ/MyZsk0nw719Pue37wR//zO4Ww6AcGiG6t37ou3hnkLxbycLsb7eaaIeOg3Ung0
         vSdi5gfEpdZ/OuRBiZe7mYUvoqRgLch1OdR4YxxP31RlbpY2/1Wn+nHyMxJkTzwr6vV4
         rlPMKP6vPNdMcBme8TwN1VyHkptGcBa7l0zon7XDmy0eRRyl40Sk8P3Aw0CZyIrIMHXz
         v07FkYCK/SR38SsaCMZBnRLFPD5VYz7ZgolUwq007HzyxpK3ZQTeMkH4UOVk97/x92z9
         /0nw==
X-Forwarded-Encrypted: i=1; AL+hErFSzrD3We0O3h0j10uPY6TVL5G+X1okqu8aY7MSj1kd51UuipRnzuc8MZLcgLPse239wmXnAjit2oU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SDubTUd2UUYOZO5+6bROa2MejSz54XOKT2jl2CWi4ET2RXB77
	gWl7hzudb2LeDc1TODo6XFifU8xpwcdWg4LSJYayQ55+tUsXrtOr/GkE91uHpvrj4JpIgs96Ed+
	lJgE1OJD6+B1/5IXsqORQ/rhUuFh3HXI=
X-Gm-Gg: AZFdTZem3AHWvZu8swZTymQG/vbud0OlVNA+buwDnL+SJEA5I0aHBElUHzP/MlcbU3G
	DYNdcGD7nSjWJkT24omAaCL5NN7d/0iWnChDFDQYXmCHTJ+AF9TerTQ/tmhc3CHIQjr+o7r9YXl
	UuJ/kLVp1tM7MP3CBumA//Wbl6Fa1dN7D5M/fkuZk4Gtd9eHJ21rS8UcvtncWDoAQk/OqPS6qDu
	IORm1eD/51dSRERMZydeRVHvtVY/16iioFTvGWFM5b86cj54PgAaY9C1cNYaM+9abbJc1twYuKP
	ewE8JSsYSBgTw9NfT6bVXmSWX7+5TJJQyrxSzV3vlZF5sVOqClvf+WsZ1grdzDNOJz5PrgOFeel
	KTSZSZFicuvYQUaKnV7u+qlYpcTH3VZ4WTFgmqkafE/e1pkRFE+NSc1fNyBfTpjFT9tXqfD4=
X-Received: by 2002:a05:6402:13d6:b0:6ba:857e:ae83 with SMTP id
 4fb4d7f45d1cf-6ba857eb664mr9860990a12.13.1795642868334; Wed, 25 Nov 2026
 13:41:08 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Marco Sousa <marcomsousa@gmail.com>
Date: Wed, 25 Nov 2026 22:40:56 +0100
X-Gm-Features: Aa3M54qfJGFxhgD70-BdRQ7MJG0bE-l0ZUccxFIG7pX-78XZybuqjHc_9rgjpGU
Message-ID: <CAHRsBfbYF3wocif+a0FRyBBkhcL+FtKF2qm=ne0jgLCzL8cH9w@mail.gmail.com>
Subject: [BUG] AMD Strix Point USB4 (1022:150a): mid-s2idle pciehp hot-add
 causes D3cold->D0 failure and hard hang
To: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org
Cc: westeri@kernel.org, bhelgaas@google.com, lukas@wunner.de, 
	rafael@kernel.org, superm1@kernel.org, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"

Hi all,
I filed a bug report with full sanitized dmesg logs, lspci topology,
controlled A/B test results, and a thunderbolt.dyndbg=+p boot log here:

  https://bugzilla.kernel.org/show_bug.cgi?id=222327

Short summary:
On an ASUS Zenbook S 16 UM5606WA (AMD Ryzen AI 9 HX 370 / Strix Point,
BIOS UM5606WA.321, s2idle-only) docked to an HP Thunderbolt Dock G4
(Intel Goshen Ridge 8086:0b26 + igc 8086:5502), reproduced on vanilla
6.18.65-lts and 7.2.4..7.3.6-arch1-1:

1. At boot, tb_acpi_add_link() creates the device link from 0000:00:01.1
   [1022:150a] (consumer) to 0000:c6:00.5 [1022:151c] (supplier):
     [ 5.005536] thunderbolt 0000:c6:00.5: created link from 0000:00:01.1
2. Host router reset tears down the firmware PCIe tunnel:
     [ 5.008763] thunderbolt 0000:c6:00.5: 0: resetting
     [ 5.008813] pcieport 0000:00:01.1: pciehp: Slot(0): Link Down
     [ 5.008895] pcieport 0000:00:01.1: pciehp: Slot(0): Card not present
   0000:00:01.1 then runtime-suspends into D3cold (power resource
   \_SB_.PCI0.GPP0.PWRS).
3. After dock authorization, tb_tunnel_pci() activates the PCIe tunnel
   cleanly:
     [ 9.429077] thunderbolt 0000:c6:00.5: 0:5 <-> 2:9 (PCI): activating
     [ 9.430721] thunderbolt 0000:c6:00.5: PCIe Down path activation complete
     [ 9.432080] thunderbolt 0000:c6:00.5: PCIe Up path activation complete
   Yet 0000:00:01.1 remains asleep in D3cold and never wakes to enumerate
   0000:01:00.0 / 0000:60:00.0 (igc).
4. On the first s2idle entry, pci_pm_suspend() runtime-resumes
   0000:00:01.1 mid-suspend, invoking pciehp_runtime_resume() ->
   pciehp_check_presence() concurrently with device_suspend:
     pci 0000:01:00.0: PM: parent 0000:00:01.1 should not be sleeping
     pcieport 0000:02:0x.0: Unable to change power state from D3cold
to D0, device inaccessible
     pcieport 0000:02:0x.0: pciehp: Slot #8191 ... /
pcie_do_write_cmd: no response from device
     igc 0000:60:00.0: PCIe link lost, device now detached
   Entering s2idle in this unenumerated/wedged state causes a complete
   hard hang requiring a ~30 s power-button EC reset.
5. Controlled A/B proof on 7.3.6: waking 0000:00:01.1 from D3cold once
   before suspend (power/control=on + lspci, then restoring auto) makes
   pciehp immediately see Slot(0): Card present / Link Up, enumerates
   0000:01:00.0 + igc, and makes s2idle 100% reliable with full hardware
   S0i3 residency (11-27 s, Last S0i3 Status: Success).

Also attached on Bug 222327 is a secondary drivers/thunderbolt/nhi.c:143
(ring_interrupt_active) WARNING + Call Trace seen on dock hot-unplug.

I have the hardware on my desk and am happy to write and test a patch.
Could you advise where the proper fix belongs?
- Should tb_tunnel_pci() runtime-resume the linked host PCIe root port
  when activating a PCIe tunnel?
- Should pciehp_runtime_resume() avoid hot-adding devices while system
  suspend is in progress?
- Or is 1022:150a expected to receive a hardware/ACPI wake from D3cold
  on tunnel activation?

Happy to collect any extra dumps (sudo lspci -vvnn, acpidump, amd-s2idle)
or test debug patches.

Thanks,
Marco
