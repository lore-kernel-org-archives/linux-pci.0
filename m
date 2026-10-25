Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792886921;
	b=NjqcrIhoQWu5HpulBOH/Odu53fQ9Uhe2N49Vkf2mCtVQbdnqMDBqUZl7CU/vfFFnu5sn
	 4oyU3n9v54lzyTD+CQhuv7LrAXll+qMRHWLP20TGVefEFVgfPtX57r388mDHrwap/t8vz
	 wY6GrrE4z3TWJe3S0/sPuiDSzIp5oE6JaL7cB2pMFxvXfdKdT9zzD6q+nMxAigjRgomMD
	 oKM+kU5YRlZ9RXUSH/+Tp3GDanRzYsGMdxhbZh0Yxctb4hA3k8948Jh6tE6lkUHouEswu
	 gYCnbPVuqoBlIo/nX891r037wk+J8+p0xdkYjkLvetCB8PY+I/oAytFDC+o4Z1wMQjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792886921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/qVk/Qm5KB2NtxRwDV9R6TEykk+BaYAsUC+sF5ExwfA=;
	b=hiEOosyqAiQi2t/0uYXY3lhaI7/OEmM0eoFz9FkfQ+WdQizx/fA19SFT/JspktDjHmXP
	 jMD+nuJPsFkORACEjGoSNFQX+5K7dsjFhbYz8ugb9kRpCDWZPI02mt2l6DS+OFyd2KGaM
	 tgBk8mS5wO9XBIu6v4H9Njnrbv9GaKwR2aeWT8A7+EfKAqpqOgCq0efuM6Mh0TxOLdMvp
	 Bcyi2pS8BC8MM/jc9mWKN1YrF/7SMNuxOuj3HJX2nmVUrYRP5GwA8J6inOd6u7RhP7JQG
	 lOehKKw4yFzb0LHosa5sX3MLmUG7GiN9YzGfyARxVs/l7hVZfJCVqX/WG6Z1CKXscCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmxg7SKO;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1E606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E1E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmxg7SKO
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ab37e44643so12144317b3.0
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792886920; x=1793491720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/qVk/Qm5KB2NtxRwDV9R6TEykk+BaYAsUC+sF5ExwfA=;
        b=pmxg7SKO5g6vGaL/iSs3OOBR+HLuy1mCfumm5Kg+Y1mkNehopY2OvCeOn92yWXOjzn
         0h5A2vVuDoEiic3cXKvO90Gv2Ek9bWTMSJOT9Av77kqlFo+S2DEAglyToqj2RcpxwBdq
         kxkk8QO7lvh6WRaKra8uo1T58KOh2M/w9YgsWApA3AdEK/55iWKxXvKPz+cdTnkHm18c
         andS2f3LMH/AN3t+GU/6aHSuvUhs18fFgPRGyKdClqpEtWQG7QZgUv6GLP+P3xJq2zL1
         YdZBrq4LXDKWvGasUkmqCLZ/4gu9FmRBah2cnH+D1GP9RYVZISzcorLhyX42Gv2iZ9Sb
         FgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792886920; x=1793491720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qVk/Qm5KB2NtxRwDV9R6TEykk+BaYAsUC+sF5ExwfA=;
        b=YUI16exVoERDJvDieGY9HnSkTdttNwdIGtH+4qRv3r8tQSE3PmQ8OD634RqYMTcRW2
         4ncOZggNeN7ymp+yrFBCY5qLo3DBKwlcX5oHH8T2DVEz032AjZcf0i9aiPVqNIp/9fb3
         1w6Ko9UO5ZDqmaNk7jK9FPKbMzYzm6KFtx5MZW+7CjKWV2XwqcEC4gkbndErhRptpFZI
         fi5rYVw/8BwWnAe6dUFonAYZwaKddI1HjSsbJM9wPOJQWEJK0o6hy7xUE2sSV7uHt5xT
         64tqEU2u4MQ3HeLEfYa+UdBZJudvgZw+mP5nYjzFEy4z1g/mZp9R2LuDrWeckEjyyun4
         kNBA==
X-Gm-Message-State: AFq9FYKnztuKI9/idE6PqNn8OYKYPt/DYPC0ux4BzjMkmvSNUIb8wkjh
	fI5g5p6bIPP7ktMeowpmS5WriHosVEpjASL0oYpJgv2q8/XMhE+rnJVPBywqag==
X-Gm-Gg: AYBFou03WBVj6/f+cuyfXwxEImSJlG6AVPiNyR/WMM8eLfF+7Po8qCMkpp/iOeUDElA
	T2wCxQzo1El9L4bycCZfpvOmzDseF4AP/80jMvMNLIR8wWXWCphsrjPjgAJ7cVXuFO2yolsVZ0u
	aAvEc8h56KWnU0NgVy5MOHW/BF+LAbJ/1O0j1T3SY2PmgjqDRy/2LVzVkZp6tRhxmBAFekcPLx/
	Iq6DgfiUkOe7wpC/VUD2nXxZTXGtjUrrYhVL3lwKNRYH0qi0Nr0uxoAx+8oRYZQlAabzDlCII7v
	q4bWifX4wW0HkP9jOxmmMzYPKE32oEbCEehZz2IgUbRiRACZFRvctmUccVV8gi1qtJHdDkiWuGQ
	dPBMGniLt343o88KjVP2IJdlGNAF2uPIxRSq+cZ+Q4oBp5kWgSBbtzGHO6Ces3Ou9ChzCBihXlR
	9ZBdpXikH6EgFYElQMRS+I3NrtplRCQJh1GRNhsek0+9zLH9ChEFqN2XssU+vQHooz6w7FdjtTP
	TSSojm0AmyWc2LsefN4zHUurYnAFvWgrSQRGvYBmzPeBCSwEqGJeg==
X-Received: by 2002:a05:690c:39a:b0:8b0:eb9a:7383 with SMTP id 00721157ae682-8b166c3cee8mr21547227b3.77.1792886919768;
        Sat, 24 Oct 2026 17:08:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e0bdb6sm14384667b3.19.2026.10.24.17.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 17:08:39 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org
Subject: [PATCH 0/5] PCI/sysfs: Wait for config access lock in sysfs attributes
Date: Sat, 24 Oct 2026 17:08:28 -0700
Message-ID: <20261025000836.58294-1-thepacketgeek@gmail.com>
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

Matthew Wood (5):
  PCI: Add disconnected device checks to user config reads
  PCI/sysfs: Use user config accessors for bus number attributes
  PCI: Add pcie_capability_user_read_{word,dword}()
  PCI/sysfs: Use user config accessors for link attributes
  PCI/sysfs: Use user config accessors for serial_number

 drivers/pci/access.c    | 57 +++++++++++++++++++++++++++++++++++++++--
 drivers/pci/pci-sysfs.c | 35 ++++++++++++++++++-------
 drivers/pci/pci.h       |  2 ++
 3 files changed, 83 insertions(+), 11 deletions(-)


base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
--
2.53.0-Meta
