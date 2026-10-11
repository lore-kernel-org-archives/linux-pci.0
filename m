Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FE345EA7;
	Sun, 11 Oct 2026 16:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736380; cv=none; b=hO7nCurEyahifIA+C9aZW5hLgwdskiE1baH3gBjE0gCtdDPM7AAo5y7IpBXOmgkDiqR+JfvlL+vjBr+hxH7WLv/FFBw6JnqWQCMtJ2C240/QNbuOyFArYDZjYA2Y7LnDSLEi110b+O+DrpkxhmwPdo2DBMqD3H1xw8Ah2AcpbgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736380; c=relaxed/simple;
	bh=/cuBUaquJ2a07DhLKJpcdd1MlzI9nlDsrijVzpfKbC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpkBrncybfYMREPMtVPJ4VzdbFSUJ90t2Q2DZIe8o35fwUK0sdZlDg2w2Nl6ftuG4lTsQ1KsosIwBfAXL21y/7nBQQGLVjYUfsgWYrscsGeknm1c7t241AU9X+J0Vc6WAmMEM09pZLwHtAIPAeUW0fPi9tI04BRKhW670fbXg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aaNevFrD; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aaNevFrD"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4j2mNk3YZ4zMlD7;
	Sun, 11 Oct 2026 18:32:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791736374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sYYycMqiVoFa/In0q5D6DkIyhVz7l1DSpsMozbaO9Mk=;
	b=aaNevFrDBY4/BnVUFn3fce1d8/Lf6xGMO9mu0Cw0hk/Zf+tBpOwRdcU9haHXw9glnp3yiT
	sJEW+mhr6FNbsHz7om9i0npoTfRaH7Qw9kdKKaJqGn6tkh8rRW47D2iad12hmbdGWEDguO
	YqKEdtaANLVchnxf3Pczbi4CnUIMoT23UgxTEffbu2EO5vEi0ccskgnlXzLP27SkEUM38a
	g0LO041FEujMHf/YTHyNcDYj1wt28NYkf37Ybz6epl82mvERuOw1txSrvS15c8fuEGmGKg
	4ryzN54AqPx5kYBGQdYIVKb/8jjgUxTSIKA/4Hp7FI3E6oT6RhwFSF2gw8NPvw==
From: Alexander Gruhlke <gruhlke@mailbox.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Hui Wang <hui.wang@canonical.com>,
	Linux-Fan <info@masysma.net>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev,
	Alexander Gruhlke <gruhlke@mailbox.org>
Subject: [PATCH v2 0/2] PCI: Wait after FLR for devices that don't honor Immediate Readiness
Date: Sun, 11 Oct 2026 18:32:47 +0200
Message-ID: <20261011163249.18479-1-gruhlke@mailbox.org>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wcbrptn7dtw79cc8dsx9thu4bp6dbs79
X-MBO-RS-ID: 84e71635b72763824ef

Since v7.2, VFIO passthrough of a Samsung 990 PRO NVMe [144d:a80c] fails
on the second VM start, and the device is inaccessible until reboot.  The
drive advertises Immediate Readiness but returns ~0 for up to 7 ms after
FLR, so since 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring
BARs") the config restore after FLR is lost.

Patch 1 ignores Immediate Readiness on that drive.  A 990 EVO Plus
[144d:a80d] reports the same errors [1], but it isn't confirmed to
advertise Immediate Readiness, so it's not included.

Patch 2 is independent and keeps pci_dev_wait() from treating ~0 as
ready with RRS Software Visibility, which also affects the Intel
[8086:0a54] in the open d591f6804e7e regression.  Hui, Linux-Fan: testing
patch 2 on that drive would be appreciated.

Tested on v7.2.9 (Ryzen 9 7950X, X670E, drive firmware 1B2QJXD7): with
patch 1, three VM starts in a row work, and every FLR reports "ready 0ms
after FLR".  After updating the drive to firmware 8B2QJXD7, it still
advertises Immediate Readiness but responds right after FLR, and plain
v7.2.9 works, so only older firmware is affected.

Patch 2 in this form is only tested for regressions, as the drive no
longer shows the problem.  v1's variant, which read the Command register,
was tested against it, and the drive's Vendor ID read ~0 while it wasn't
ready.  Applies to pci/next.

Changes since v1:
- Replace the pcie_flr() change with a quirk for the 990 PRO (Lukas)
- pci_dev_wait(): check the Vendor ID for ~0 except on VFs instead of
  reading the Command register, and "may return" in the comment (Lukas)
- Swap the patch order, as the quirk alone fixes the regression

v1: https://lore.kernel.org/r/20261010160529.27974-1-gruhlke@mailbox.org

[1] https://bbs.archlinux.org/viewtopic.php?id=314833

Alexander Gruhlke (2):
  PCI: Ignore Immediate Readiness on Samsung 990 PRO NVMe
  PCI: Don't treat ~0 as ready in pci_dev_wait() with RRS SV

 drivers/pci/pci.c    |  8 +++++---
 drivers/pci/quirks.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.56.0

