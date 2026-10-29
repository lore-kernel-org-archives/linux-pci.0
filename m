Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301637;
	b=jHrS7NLtgtEsM8wHJ75YmdUlHAJkCRuFolhDOXse8j2zckMTNRnHX8KNhGgeMcxQWANC
	 4PhLBGr8ivcmKwz9+0bAjmBF1L+jPAwNfInSCUhfNppCxlNMbusuROESCc55nc5794EUY
	 XldW2g4QUKcfqXZdNkrRgCHEdZ0ckXOXJen6MWZ07W7hlQmts73RYEOC/oL+MDlRRt/D1
	 9H3rGtSqRiXXzHEekxuaT/mGqvPXSXRMYCITiZACyUqyad+VXW2MaDtwjIjFiYgSTBPy1
	 kHQ2pwj6iJiZKueg9ONwjzIg+2eVTiZd6DuwWQYuixTUe6BF2nUOpaYuMyLH8MaXTDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301637;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=14aLGLsWkqwOe+y/LxSquOFPPznEs4fAM/FiOWbWkA4=;
	b=zt1hzfvufswADPT3nMosvNsbzJgY19TxkDlvOunE/CIWU0R6+zLgKxs3Gp57gJkZKjBo
	 HJG+cNzB0RgfxcgBYkXfUqVkyEzCNa5T3+7Z69ffUufCwACrPyka33ZP7EjTq+waWBlDw
	 1qALm5EHa0spRjPI7+6MUHlFimp/msH77go7Tu/xt3G1TqqCyltEiHkV6g310vruiI2aM
	 RlurK+7jLW+wHI8JaBbg6V7EaFd8Vm0zGCsvih0RgrCnvAzO3Ka2AJ+6rJc32zLMl6v9F
	 czeWkZTOPthB7/Ezc7vJX8UdJ+vGsAORMjDJnsou+VeWYhdxynR5vPasLUqGEpwKdaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZnlSJYZ;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C86606A31E
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C86606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CZnlSJYZ
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ad98c3fb15so23668477b3.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301636; x=1793906436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=14aLGLsWkqwOe+y/LxSquOFPPznEs4fAM/FiOWbWkA4=;
        b=CZnlSJYZ/tWIl/rHPEYZboy9t4UflbqKCUbeQ2R/5vGK6ZnLpKMhxvQFjmrWEJO4BI
         cBC75mIRcTo12jW4KwWFARPrKsZgUSfYp1YFmfrMVoG0V3mTeIFYpDuf8bpmMoGQsAWd
         VhLNG2I6AemeQov+6sEGULNIas+2oVCz86Z08a8SCBsfn9+yOCSzY/aHSTjqXbTpd9hi
         iHeeTcppH7a86dUfRtUvBj1t44VvbseC5BEd5CCuZ5UZtkjkj3d1w5YUm3Q33dtVTh3q
         7Kw1zrXfiqkfOM4RWfWfQbNvVMGoBxDd/90RH91Pfp7NMomlxt+df3M9EF8Elh69BpMd
         lUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301636; x=1793906436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=14aLGLsWkqwOe+y/LxSquOFPPznEs4fAM/FiOWbWkA4=;
        b=SbOHvI3P5Fu+NvdRWDim0mFFRTITDnl0rHfZ1ry6FZT3GCvYV/xbCPIntDzSJSdp9h
         PxVnwvnX84nfLURu81hfY76VcODxEifWT7eF47HEfxdVKr1+nDYTogXb9lymChv0Yz0e
         cQviXiqyCWxwB9NqvjvPAjHgYNEYfbfcU4E3bL2WgkUOfMjg9koEfLQjaE6KV+x9A4X5
         fLDQ1IIyRNhZD8bf+ivgQNlLfXv6maeNgOrYZr8H8WgdYdyTI3S3vkUhfW3yOGRSfSqD
         SgCriF5GkgTNAtijmfFdTqsQ7oOxOdc6FjmWImnGswv+JpDyNtJOljAsMplvD2J9uyQJ
         rR/g==
X-Gm-Message-State: AFq9FYKK1o9OOBDQjDY2ID7uD1di7ZRUugURexslMX1xqL2Z5AXPI9xV
	vwbynJvi2cyRGH4JUtR4F2OHzBjc/O5phSVQzGWi3vdQvQDG99kudTTA
X-Gm-Gg: AYBFou17lDindelOnaOFoi/5RDS10vZ4j6c2ixobsOKj3e+aQ+unKnjrysiyNz/z84z
	t6SmnO420/Yb4e4DQCnGgVzomQ+1hpXJePIqIT+gg4OjC7iTw2wwoJ/LmbR3jwkOwZitu6KodCS
	D8N49XQV1nMEds39nIBY7zhN2NK9B1E4gfPwJ8qB3r0jOlYBM1ql47/NiixUi96GpMFDpqAeb+3
	5CIj1J2A2HmxjdqVddo4/Hdfkj8F9npmgpoyjDLOkXFUCPzEZXdb33NbchRdTVUCid4298odJHn
	uTUFFhbDtnbMpOj03ulEpqOX5SmS2VJdkxujklvQAgQ7h9PlJDCYmkqhrl545qrGvjZSQqentYL
	XFsFccOUmAxXX6Uboa7de22hs68t9C+maHyR/ho6n1UE9mCGOZVEIHPRaJJhVCqPue4j0qn1ti3
	/M8DQsoh124R30Z4yI0SIGhz+Y4D68Z6MKvIyWn19rm5gW6Zo9OW1zQDzx7ucX2+pEyRMhp9G7b
	a6lIYkuRmELVzh9PCmlD2Am59q8xfcrNhcL2eEXNGgKrX//PL9aE1UMxUPH0fd9n+bJCK1RDsTt
	NwJVMdk660cvNG6xdl1D5nPeTLU6QtxP91rp3x9APTD3tLrcaJk=
X-Received: by 2002:a05:690c:34c9:b0:8b0:76e5:ecf0 with SMTP id 00721157ae682-8b1b59e36e3mr50161477b3.4.1793301635871;
        Thu, 29 Oct 2026 12:20:35 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:50::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b4b396basm668987b3.32.2026.10.29.12.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:35 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org
Subject: [PATCH v2 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
Date: Thu, 29 Oct 2026 12:20:24 -0700
Message-ID: <20261029192032.1325629-1-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many PCI sysfs attributes that read from config space are using kernel
accessors that don't wait for pci_cfg_access_lock() holders before reading:

- serial_number
- max_link_width
- current_link_*
- *_bus_number

If userspace attempts to read from these attributes while config space is not
available (e.g. during a reset) there's no telling what values will be
returned: All ones, zeros, or garbage.

Looking at attribute addition history it seems like this was an oversight
instead of a specific decision so this series tries to resolve the attributes
above to match the sysfs attributes that do use user accessors: config & vpd.

Patch 1 is a prerequisite for the rest of the series. The kernel
accessors these attributes use today skip devices marked disconnected
but the user accessors don't, so switching over alone would make the
attributes start sending config reads to disconnected devices. Patch 1
adds the same pci_dev_is_disconnected() check to the user read
accessors.

Note: That check also affects their existing callers. On a disconnected
device, VPD reads and writes, VFIO config reads, and VFIO writes to
PCI_COMMAND now fail with -ENODEV, rather than returning ~0 data or,
for VPD writes, timing out with a "firmware bug" warning.
pciconfig_read() fails with -EIO, and the sysfs "config" file and
/proc/bus/pci still return ~0 data.

Changes were successfully tested by continuously reading sysfs attributes
while a reset was issued.

Changes in v2:
  - Patch 5: check DSN read errors in serial_number_show() and return
    -EIO instead of an all-ones serial number
  - Collected Reviewed-by from Keith Busch on patches 2-4

v1: https://lore.kernel.org/linux-pci/20261025000836.58294-1-thepacketgeek@gmail.com/

Matthew Wood (5):
  PCI: Add disconnected device checks to user config reads
  PCI/sysfs: Use user config accessors for bus number attributes
  PCI: Add pcie_capability_user_read_{word,dword}()
  PCI/sysfs: Use user config accessors for link attributes
  PCI/sysfs: Use user config accessors for serial_number

 drivers/pci/access.c    | 57 +++++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci-sysfs.c | 37 ++++++++++++++++++--------
 drivers/pci/pci.h       |  2 ++
 3 files changed, 83 insertions(+), 13 deletions(-)


base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
--
2.53.0-Meta
