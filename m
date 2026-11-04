Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793834574;
	b=SyJa5PW6xh0XoIcvWyt52d566MRoYW8qtfgbWDg6FLycDdyT0syuFPdhys6997e9SGtN
	 hgef7voAd/Q+Mfh9jJK5inNqly1EIQ5rM7qBrH2X59Opehw8/BBt6GySvXaL1FZIduLYD
	 58aaXhbhtcA74/VDAopcdfgbclLh3MDH/eygNas2T1MniU8nLLkAbhFvrlqnBRQlAxLCl
	 qBqMAFCmfrwNvL/IuXs21nluz/XJtxV1C6ni03EFe1xjEq4PnQK0EfSpsWZw1r/uDZ8T/
	 AYQTS+j23ax+sLqAxzLgTsernQq7ugOpJ003089Xpmdm9X4VBBchn8tObcumIx/waRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0Wso2HXvKCD3ero1AES96+hMFKDJJsjN+Pw78Jewgvg=;
	b=NsAtEym9/eUyuv/o901DI8cWyTDp7rdUwa4M2xyaRHVh/mJfJbaSH+RGmDu/ozP9RIC0
	 Dvjs3CePIhhXEwN4WZrQcof2ygBNpeBJWJx/FKzsXRKLUPAwwULxGiVCisAadxxbODjU9
	 yBVCYw07SkjQeMfApybN7xYU6SD5IyEyYDEOXtCH04XJPCOkrGHZMglPCqYKc7S5Wg6Cp
	 2eHGInRDLb6NnxVF/KetgBoZle3HZqp6ocMZCTrq9DNlRGTd5BZjwgj/Y0W5ApIlI9Q3D
	 rZ54qMr1cv8NPtfVEicPPgwvsqs5EflNAp2rUqmiR7j7PnRLMJequm520wTexWp8ICQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.oaklandcc.edu;
	spf=pass smtp.mailfrom=student.oaklandcc.edu;
	dkim=pass header.d=student.oaklandcc.edu header.i=@student.oaklandcc.edu header.a=rsa-sha256 header.s=google header.b=eQ8hWw0i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D2606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952D2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.oaklandcc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.oaklandcc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=student.oaklandcc.edu header.i=@student.oaklandcc.edu header.a=rsa-sha256 header.s=google header.b=eQ8hWw0i
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8ab3d3c5761so16203777b3.1
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 15:22:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793834572; cv=none;
        d=google.com; s=arc-20260327;
        b=ZIhPt+KnJqQUc1LqOiXI6/D7Obg+7DIGroFSTlk6LB1N95g7kxDqq0BbadxoKqtVxR
         RZGlA99m16gnkdAVc0Hian4Y2foP5ScQ9CRtRv0dWbm327fT8AV8uDsjalJ6UuicdcSI
         KoQXdkLsP2ASySnQj/+XjqbjIB9IObYXn739+1ZT5v6GGAqAZce+J2+5rNaCAMA3LBKH
         paAIPsz2CiGxfD+UPCHkIGv76OZepDSLuylQEIQtlGuXZLmaILtFUgLS8bTgqtiZb5OO
         N5smfJWGyGSARfSR1HCYirD2rDYDIS708uLVrAvZLBhpvghmwL3/gszZdpbwctSfieHB
         d17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0Wso2HXvKCD3ero1AES96+hMFKDJJsjN+Pw78Jewgvg=;
        fh=eW7iQdKcZ2ExO2FqD3RHdpEmehW+pWblwUM9dStdj1s=;
        b=QhpNWj3MH4o2vQqRnTFe99RuLKuYpGZPTfVF5zEZT+OlWMsEX4G4QkaDlcHYydx4nW
         hPuhJ/Bh1RqDyZ3mC8z3Pgz3yueJCdAAPNFcv0kTrgWmsGbvJl05vrtaUXLTrtqUzsuL
         +pR0GQwz5eVU6z5b8dC0+Y7m63fpF72z9fEcRezMO059n+nf5kg9QVj19IP6ZHbdpa71
         rNy7JQHhqkM3IsPVa1fuyJDldWaFSCHuYAtwPwc20VtSdcp7wvm05j72RAPgi6kExHY4
         mSSgjzyzP7RgC44zgclJEXTdFMMBVELquBsZKMmDElmrijPEE3SIrJ2MmuZOs2ALKNY9
         xT1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.oaklandcc.edu; s=google; t=1793834572; x=1794439372; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Wso2HXvKCD3ero1AES96+hMFKDJJsjN+Pw78Jewgvg=;
        b=eQ8hWw0iDcimpL7P0Ng4itgw9yIhrZhEIUluYwBR7UoJBQpXLUW97TOGdeH3rBg1UJ
         kJGMHvEUghKbJH8fUZ0sKVfi2dY2H+YKtFDNz386i4S9IeGdd5bBR+onP9xX8tIXZl4T
         UP1Dgz67H4zR66m5IkEkZHJJbXvtJDEOawRo4B+yY3Be/Ls0FaKdPQtQGgEjq9u/SIDt
         rh5gOAJZKcKAKtJQ/DnCshcCGZHJyo25yHwBQEzI5xZlsMTSG81dRPOYxqhNJVH9K8Oe
         xRYsJ1o3E6XzE6l+YuKfpbJuAotwBdLz0j9Vm4rv6K98/KYGacUsMpowNnavwpg9IhxD
         aIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793834572; x=1794439372;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0Wso2HXvKCD3ero1AES96+hMFKDJJsjN+Pw78Jewgvg=;
        b=qGB/lSYosiMAvhC3DmNxJREE6BG4EisWjKyv3cweosgCqZ6hErpz/byu02M5ILbZoq
         H9hBYwl669hQqjrCxihR0lo535WHlw3IaQnCKCKptj2t/QNQ8gehDXhsNtDFOR5gJtNE
         rqpzP6NdmU6unVomvnqpulZAzBB/Ls1DSitQfLOfmNqKpl1HJ+zoP+XTv6ZJ+ItLonbi
         iWhA+DHAOJh/Ycl/HkfMIfndBewramnA1OGV1dO8HYPhWHvpiAM6y21Uzzdv3h5/pMge
         EsNrc2OI8aBoqlvDJ1S4B85HFYym/9MtJWx5uyCITem/d+NwHE34lY56ga21ePfK9f4w
         YCSw==
X-Gm-Message-State: APuU4Z+iSvwcNZ1hd8rdwMMx7DjUrCqRW4TjZP2VLkt6Qne5Qgd4kmJu
	xQwk6vSs6+lpy1fwncz9h7jwCG/lgox+VFpwcftQFXnBGNpOrWuW/jCrlkMF89RE6Eel9JYtyB9
	/Y1IAoiWeubzrhFcQJywRVZxptPHM/zMI7J665tE/cVGcLLoINHg/
X-Gm-Gg: AYBFou1cKvTgou6g55I2yH2bUQVqd05seoGejFncojSOyXLx3PmsgYOxK4RUKyMRo0x
	EkEofkzIr4LpzjmOCRSuzeo44YBciKs4dekD9hb3jMNJBUr1U0vk+pZTwmwzb5PcBhlgjGXw4AR
	qHCu7An4BKIyiLSQKT68ZMJX593RU+ckPAgXA8Q5/0b31cWG+qAmZTiNiNMsaUFA9eCoPtI7vzv
	QdFqXE3XtRRz6mJ4Z/ZAB92rE17iL5SdJ1vk8SzeyXe4M63hsYf70JszWQIvB5NI7nQ/rNop76P
	FhonuniOr58uQmrOgCaMgNxDTLMobFSnmElQFfnlaqIEnzfMV8o3pJpGQIeAj++H8HN6GbJV6Io
	Odh25A3jw1HmWy67htyYqwgQeDeH+3UwBUP4=
X-Received: by 2002:a05:690c:e204:10b0:8b0:e479:6872 with SMTP id
 00721157ae682-8b2b66dd6e3mr101757167b3.17.1793834572476; Wed, 04 Nov 2026
 15:22:52 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 15:22:51 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 4 Nov 2026 15:22:51 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Poulin, Louis" <poulin.louis@student.oaklandcc.edu>
Date: Wed, 4 Nov 2026 15:22:51 -0800
X-Gm-Features: AclHuK9MElrCKDIxxzOM7vZJnl-oPjwpu5YaFUGdbmXIhKW1W8CYau04MUhUwZA
Message-ID: <CAGQButtv-1k9DzOLEBwjoKQP+=-u4obM5bBHZZs=Mw2vd1cBnQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Add missing NULL check for link in sysfs
 show/store callbacks
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, zhaojinming@uniontech.com
Content-Type: text/plain; charset="UTF-8"

Hi,

We observed a cold-boot crash in l0s_aspm_show() that appears to
contradict the assumption in this thread that the visibility check
always keeps readers out when the ASPM link is unavailable.

This was on an ASUS TUF GAMING X870-PLUS WIFI, BIOS 1805, running
Bazzite's 7.2.15-ogc1.1.fc45.x86_64 kernel with InputPlumber 0.83.1.
The fault occurred about 10 seconds into a cold boot. An earlier boot
on the same system had the same fault address and symbol offset on
7.2.9-ogc3.1.fc44.x86_64 with InputPlumber 0.83.0. Both observations
were on downstream kernels. The captured 7.2.15 kernel was tainted
O/E (out-of-tree and unsigned module).

Relevant excerpt from 7.2.15:

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  Comm: inputplumber
  RIP: 0010:l0s_aspm_show+0x47/0x80
  RAX: 0000000000000000
  CR2: 0000000000000030
  Call Trace:
    dev_attr_show+0x1f/0x50
    sysfs_kf_seq_show+0xa8/0x110
    seq_read_iter+0x132/0x4c0
    vfs_read+0x34d/0x490

The faulting instruction accesses offset 0x30 from the NULL register.
In the corresponding source, aspm_attr_show_common() dereferences the
result of pcie_aspm_get_link(). The read reached the callback even
though that lookup had no link to return. The kernel killed the
InputPlumber main thread and the service stopped answering
ObjectManager.GetManagedObjects. This blocked the boot-time controller
setup.

We are building a diagnostic kernel that returns -ENODEV in that
specific read callback when the link is absent and logs the PCI device
and upstream bridge. The device and the reason its link state was
missing are still unknown. We have not reproduced the fault on an
unmodified upstream kernel.

Would this trace justify a guard in the read callback, or is there a
preferred way to instrument link-state teardown and sysfs visibility
on this hardware? We can follow up with the device and bridge once
captured.

Kernel source for the captured build
https://github.com/OpenGamingCollective/linux/blob/f6857d4bfd614b90302903490796ef376be0a67d/drivers/pci/pcie/aspm.c

Thanks,
Louis
