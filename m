Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD3E23507B;
	Wed, 15 Jul 2026 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122413; cv=none; b=QVs6tDkoCAvSOdW+2klEcyDXwIHI4TYfFvxLmvVQH97V4dj1urx8do3jUn3G1GJVkabvDHtgcHonFzKJDDgFEdy+CGqeaS0/TcSktdHNGtl26O71LUG0kyY1zuUP5vFuAqyMeEJgAWfvL51wVU9LOz9jkEFofq8BP/44EULOVac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122413; c=relaxed/simple;
	bh=yhK+gWds0kqmJMK8oYokhqCx2haI6WBmsi0ir4zS+eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTCwi6lbZSQC3Ul0XpbdjZ3Y/6Slh2P5U5Wnw2QwZ1zVceuKQ0cH+C+nP10cjp/5ENuZm9wXNks6OEXpdRi9CgxSTbNf68GPYrcbLGqUZ2ZbtPQL+MtmyKhRAktU3RktKOK3ezAFXPG2k/WTJ4RwSyEPRhiWXRq32xR00x3jKGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UkUElBTc; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UkUElBTc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784122404; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=JCr+B/B1w1jArutjB0fuPO9lz1kJ/HqQv993yIGFPyE=;
	b=UkUElBTcTugk4OcYWdQ+ZxD5zVrSQ8dmRO6wTvR8NGtAKvg6qFSxp5N0MFOsi09xKg85cinwFtm7NCMgfwbKX+U5nyBTDLEIzMTa8PHlDLzexPlZX96pODEUqhpw5fZoGzI875Oi31qbBG1BQR5SzZTlkB8J5L+x/o1otBNTHb4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X79XPtG_1784122400;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X79XPtG_1784122400 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 21:33:23 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave.jiang@intel.com,
	alison.schofield@intel.com,
	bhelgaas@google.com,
	rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org,
	sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: PCI: Clear driver_data on all error paths in acpi_pci_root_add()
Date: Wed, 15 Jul 2026 21:33:10 +0800
Message-ID: <20260715133020.3282712-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707122549.C01DC1F00A3A@smtp.kernel.org>
References: <20260707121258.11640-1-cp0613@linux.alibaba.com> <20260707122549.C01DC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review.=0D
=0D
> Pre-existing issues:=0D
> - [High] The acpi_pci_root_remove() function frees the acpi_pci_root=0D
>   object but fails to clear device->driver_data, leaving a dangling=0D
>   pointer.=0D
=0D
Agreed. acpi_pci_root_remove() calls kfree(root) without resetting=0D
device->driver_data, which leaves exactly the same dangling pointer=0D
this patch removes from the add() error paths. I'll fix it in v2 by=0D
also clearing device->driver_data in acpi_pci_root_remove(), so the=0D
add and remove paths leave driver_data consistent.=0D
=0D
> - [High] Lockless access to `device->driver_data` causes a TOCTOU=0D
>   Use-After-Free race during hot-add failure and hot-remove.=0D
=0D
I don't think this is reachable, so I'll leave the locking model=0D
unchanged:=0D
=0D
- driver_data is published early (device->driver_data =3D root), but the=0D
  PCI hierarchy below this root bridge is not created until=0D
  pci_acpi_scan_root() and pci_bus_add_devices(), both of which run=0D
  only on the success path, after the dmar_device_add() error goto.=0D
  During the error window there are no child PCI devices yet, so an AER=0D
  or CXL consumer under this bridge has no way to obtain the handle and=0D
  call acpi_pci_find_root() against a half-initialized root.=0D
=0D
- The early publish of driver_data is pre-existing; this patch does not=0D
  change it, it only makes the error-path cleanup consistent.=0D
=0D
- ACPI .add and .remove are serialized by acpi_scan_lock, so add cannot=0D
  race remove.=0D
=0D
If there is a concrete caller that can reach acpi_pci_find_root() for=0D
this handle during the add-failure window, I'm happy to revisit. Adding=0D
RCU or locking to the find_root() fast path otherwise seems unwarranted=0D
for this fix.=0D
=0D
I'll send a v2 with the acpi_pci_root_remove() fix.=0D
=0D
Thanks,=0D
Pei=0D
=0D
=0D
