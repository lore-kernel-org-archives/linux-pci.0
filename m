Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC02E888A
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720206; cv=pass; b=ID0j2Q9gVPobzZkmZNsQWqI2OU1jdyicrDEq0MQ4BFAFk/3M8We6UMVeN8o5daYO1+B4CFHd307Xy58xzpBY9zDw8H05R+RKKXMFKAqWQB6PRiZedEWZJOg3/N1bEbUr/1VAbCwk8HH6L6kGW7rzcvwJ9tZr1IiISnlqX/Gau/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720206; c=relaxed/simple;
	bh=WbnawmQyDpkbaTjWoYue2BZ58MDCbSdSqHChLN8rpps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZag0Hz5r3BGqK/CLEwXbKsgLrH9Dxx3EC/4ws1SJ8nBnADahQmCM/sftGrlTokuEcD7QB47nEs6keBXKVjhi7IO1m4bDPVGsHI9K7g19XqYElSX48zENrLUdPtQ6U7SGe906ZiD4yt5lKlE8Z9ExYz6zl4goh/Lco5TM3QFgHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp5fE2i1; arc=pass smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp5fE2i1"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b35611so311626b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 01:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789720204; cv=none;
        d=google.com; s=arc-20260327;
        b=KZSL0M8h6AuxRrpx5B3t4XThxq8tFLjOJvp5nzGLtV7P2HaL/gLAy1ZrxcB/pmtesb
         AiqWbvxEi8JlZlb80w6sPUHN8KecHIJvoE/Ib4iPzdc81pxSRPsFID24sDfW2zpIkTDO
         DYrA6HskyNnmQ64VrKUQ0TTa08LeppHBGUIu60VbUbBNj6Hrt08k2x0nAoWN3N0iEQZ1
         dUDqvJs4gjxJCbQwMGcADFSnDg/V6WrxA/2+UNEpENf5UIV9LAKIAsXU0UeKWmDM3JUx
         DK57S0Hn6T9bUzIntW0oKv4mamtNiAkcQmVWTq3bLljry/A2lVAJkaTl1oZ3Bs0cTDmr
         VzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=48Dk3iwNBX2jdzyXIh2OB09+BWpkuBMXHAxnmCdSn4s=;
        fh=XmEWFZW1veZjn+6tjYoSCZNNrvkGdZrsZH/tYTGIy8o=;
        b=nDVGec9gEGHqFUqw0Yg7E/4iF/EXWJauNDg/tWM8ED6NASJ5BiEjcuctKWj6G/ZXQL
         VZ2qr1e6pLCUbqCEpZRdBYnq6nhCrnjp0I7HHhQTLDLvMaBpCTWlm2/c96tp9bp4aDBk
         8MFPDGqwzwqfQqp5XW55ftSiDeDVC0z01OZ2NMT60dxpixhJ9V8qCsxvHef0masC50Mb
         iEWuEwCQ5Qu3oy0W28URCRvXjqwmjOK/uuUg3jYpyNtsul9yj8vccDHQk3ILusi6T/bO
         WR3MOh6B4wzw7Q+f3h3gj1S3NZGGSbOxwBxepwVukDZVFFI5lq2lY+6fJ8TbwWyEEgeu
         YNuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789720204; x=1790325004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=48Dk3iwNBX2jdzyXIh2OB09+BWpkuBMXHAxnmCdSn4s=;
        b=Bp5fE2i1/p2Tqw+5tdmX69eGrfFyCBrWbE8baJI7ceEjEZPRoBZTUI1/Mz+qIac5/G
         IoZuPhVrGvnHXS6SJrG04L2gwEQMgbs3OtT2Y70iZAfaDSvGxpfuvJDScRRLSms1umAt
         FLFkL1igU6RfWWKSqYIZBoRG11uqyK6TaSotIqsCvcO1wlCCY7AjApsG8dDiSXZJ6JD+
         +mp7vF6iLM1Gic/tk2IxYyVXy7fRSlYa1ebvIPS58q0nKElT1rS7/8K1TWxkZiIk0T8I
         cP0eF8iy7nt+1wdGHwFMgupAZeB3wv3X4Kx8SQ8lgp9jnD9OOE5cW5yLv8TQbhLT26N0
         dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789720204; x=1790325004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48Dk3iwNBX2jdzyXIh2OB09+BWpkuBMXHAxnmCdSn4s=;
        b=ypd4vgz15Ubz9powSl2y66TMfYmGHicb21WGtlYLrnssyzBlTj1wFzXTLoDtenYsjU
         nJfDCDtoyaqUmlsxL51iorbh6zAwypV28qRwGJjpZs+NX6JyHPUaT5yGZoz3GXQgBtH6
         IjBSdg0o98zSsYn21nzxtWl5QVrgBkayIbhPHHqcoEGqSx1akvYFZHBlrIbv0Own4/TQ
         VgycQIOpjMRksCag77brTL9ReB0WTwpQc1TN/bLR1h6qokZMJOD8yWt076ghtAG/bhdI
         2O3m76b+yX5hvLWU7YZP50EnX0K34hrEeUjkHG+82AEJGPK2l4vRLb5y0k8MsaUW9jIA
         UacQ==
X-Forwarded-Encrypted: i=1; AKwUvBylMJi5AYlCiDLPJinNHibq5Ea9+fuNjlSCkmxwBokBYvUhiK6fprlzsgJgHHrIJXnDEnxlvuwUq1Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lsKCqL5bTR1A5BjRu44RtqTCr4ytuUyp8oYl9nNyTeDrcd4OIk
	/cw28rBG02RQpPdh35dL0bZhFdqy7pT62LDByfiiHlFLzQRPBOr/A+U++RjUNYXjq70EM8LL5cO
	R4mW22Zs5ZgB54s/vTsKGOIpGfYDiQo0=
X-Gm-Gg: AYBFou18Wivf71sWuYm4HLFGr5/HoP+cQltn99FeHjMeZz7KqA53/vx1cQWvFUqrh4z
	8e35U4vafzKCK+pxOrxZnXh8c3JSDpkgZoB115LagvK9/PGZ4hff7lPd83hKA8h0hi2oVxgC83U
	Gjg7LRN+onJG/d7Bh0Q79g5cXX62+qtzKMKHMG3FxgJ0uo6L5inL/rB8AIP0p/8csNKoIkAptWu
	0n7qe450QfpiHUWrM8lS8oCoBr8Vt81DdwSOS0aljOOlya7pIb+1h0otGu8RRdaomK3bIws993h
	lJBX4aTv7i4SoZEuHFUER05USAZokD+upJX9njCOEXVtDsUNWcK5MMopyP7kdPe5LlkIaA0uE4C
	4i2TWZEd1QESooo7+LVRzitqRyMtYA7wKVhc=
X-Received: by 2002:a05:6a00:1f06:b0:857:73e2:9108 with SMTP id
 d2e1a72fcca58-874ddbffd9bmr3487891b3a.24.1789720204444; Fri, 18 Sep 2026
 01:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917183602.GA1036092@bhelgaas> <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>
In-Reply-To: <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>
From: Semih Baskan <strst.gs@gmail.com>
Date: Fri, 18 Sep 2026 11:29:53 +0300
X-Gm-Features: AcwNN1Vmx2igfjBEkpa8Vuj31sAw9NZLYiN87fYoRwyCYEORDw-WFA-KB1pOT20
Message-ID: <CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, bhelgaas@google.com, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Rosen Penev <rosenp@gmail.com>, rani.hod@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:27:54PM +0200, Arnd Bergmann wrote:
> Would it be help to change the probe order so the bcma driver
> always comes before the platform driver?

Only where the DT window matches the EROM one, because that is where
the platform driver backs out.

In the tree as it is, the platform driver binds first.
bcma_bus_register() populates the axi node's children before it
registers the cores (drivers/bcma/main.c), and with both drivers built
in the two PCIe drivers are already registered by then (both are
device_initcall and drivers/pci links before drivers/bcma), so the pcie
platform devices are bound as soon as they are created. The order of the
two objects in drivers/pci/controller/Makefile does not change that.

I tried both orders on an RT-N18U (BCM47081, revision 0x01) with both
drivers built in, on an OpenWrt 6.18 kernel with pcie-iproc-bcma.c as
in this patch and no wifi driver built.

With the platform driver first, the board did not come up, on two
flashes. The same tree built with only the BCMA driver boots it.

With of_platform_default_populate() moved after
bcma_register_devices() as a test, it boots. pcie-iproc-bcma takes the
first controller and enumerates the BCM4360 as before. The platform
driver then probes the same node and fails in
devm_pci_alloc_host_bridge(), which it reports as -ENOMEM:

  iproc-pcie 18012000.pcie: resource collision: [mem
0x08000000-0x0fffffff] conflicts with PCIe MEM space [mem
0x08000000-0x0fffffff]

On the second and third controllers the DT window is
0x20000000/0x28000000 and the EROM one 0x40000000/0x48000000, so the
platform driver's request goes through and its probe carries on with
the DT window until the link check, which fails because nothing is
connected to those two on this board. That is as far as this board can
show.

On the first controller the DT window and the EROM one are the same,
so the window plays no part in the no-boot. With PCIE_IPROC_BCMA not
set at all the board did not come up either. Clearing
has_apb_err_disable for IPROC_PCIE_PAXB, one line, makes that
platform-only kernel boot and enumerate the BCM4360; nothing else
differs between the two builds. The flag makes the driver read and
write APB_ERR_EN (0xf40) around every config access to bus 1 and
above (538928fd6ce8). In the bcma-first build the platform driver
never reached bus 1. The PAXB_BCMA register table has no such
register, and 404349c5c806 ("PCI: iproc: Add BCMA type") describes
the BCMA-based NS as a legacy PAXB with some registers missing. On
Rafa=C5=82's BCM47094 (revision 0x07) the platform driver as shipped
enumerates both BCM4366s. I could not see what the access to 0xf40
does on revision 0x01, only that the board comes up without it.

Best regards,
Semih
