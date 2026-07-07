Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5133D646B
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462684; cv=none; b=txISSr/ukWX4dNXWHurRUNuZGvJKINPjk3NIj2prAXBE/rEGW0ZHKMWjWLUCNTiLaqIotvRyW/jNUAM+qHJchsBQAdPr5XoYzH7Oa4un5ER2teYAqUoGYzlaIguVzUdICsxy9RgVfbC3JkzVmCBhvhdenkdsKcsaLMN72d7XKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462684; c=relaxed/simple;
	bh=Uc0zof6LZh+Fb0Drs4uaiCtz6yJZ87/MeeJ+NK3MAgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcIfnvEarRA30CpGq6cHVUCH79gAE3hCpLd9tla/UUp/OtzYLRFJ2GQctkmL3SAMHt6FBYuVbe2tx38N6+oL23u4zkA+B420IKvBihsX5Nm1ysV1+JFYsRuJlfaEkY9W6HnoUqmd62+MLbpNM+hGe0fsfKRoo1hwtvcbXDKwXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOgcRsIJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOgcRsIJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847a52edeb2so29173b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462682; x=1784067482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dzc6zUnzBc09yCHRWQIcDGGskftQH+8tg7FFfD1h3jk=;
        b=dOgcRsIJ54mk7wqh81gJqyrtH9s8IBzZE/IAvqsmwUKpaMTe56gWW18k0ITIVE9nHG
         6CCRDh8IMb/i1gHjQyZ/wpGRQSlUJxahkraZotmla296xR7cX8NwWtzMx10haye4ZhPN
         0qxuEmgwKByRx5K3uZ2a8/Zqkimc2+u6U6yG2xJuj/r5xCJ4t8Gu03DEe4EcRkl9d9PU
         GIEtaI0seC+vq7pSm5LdAucl/AfXbbaXMVKC7QEX8Kf8EB/XPw9VSMrC/4w5TQEmj2cU
         E4TWVoKr6AOfc3ZJEH/bPaaxAprsObnwm0mAbGM4uA27e2yIhXTOSExQ1Zi2QWGuyIfR
         ZZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462682; x=1784067482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzc6zUnzBc09yCHRWQIcDGGskftQH+8tg7FFfD1h3jk=;
        b=j0E0KkxEKvlciuxqfaZdyx1AsBtN+kLTCwKBrhoLo8mTE/9GqvXP4RgiUdlGqn+OQL
         Nhrtck91whlkkBwgpz2r4wCsRjeXPNC48g1yTNMumypn6B+Nf+scu79GclMBGtMz47NH
         olNdZjM3dw7m8Mw4xCP+MaNU5idwfxq5/wT/Nc7IrWGAkXQucTWs1s5QJ1zoBiQKposI
         G9sOLRnIMwcEw0uuMkuQOcXFZhs4Lk4+XL2q3K89PUM0DC+Im0qHAQOWkkicMUXLTljh
         bEPS5RlvVcSVYoCcC6GFw04V6p6gJ+tF8KLlLE84wY+ba2I6ojr2Wg4yLN3x+hwBgCFu
         qu4Q==
X-Gm-Message-State: AOJu0YwoIQqIB9qHpH59rgPVZKvqRXwLlJe/IQpe+iFu05+OVEwOEER7
	vg5ZzxFxxYmTPW5IA2FMjnXIazGp1l+KDLv5t/MdhHw5jcn0HOIwOTz5xrb5CPih
X-Gm-Gg: AfdE7cl3EZkpw+mj2uW2ecxrFmxt7qJpPX4DoE/563Vt78Mr1dlc0Uu/cE9G1sixhw6
	PRgEzhOjjF1Otl3vwK0WDorv214T8nyxwb7T6T3Th0yKqaziLxnJTl/XPvG7nSSYiM089hYmiOu
	PJHnYbxVYVz+DgSFAJ80XqE2sfSjb7Tqlk6ZyMJ07JoRdxUrGVz3PT3cOxMvdrceSXxqjJAaLH7
	7OU4OnZW7V4r2LbWbRKHerFLKBd4WTd9OuJtHMEtY9onu4D6CtXf0FpsPOyZPL7oUAhhOf+vSbB
	G4lBdFAWbOVC6YNypudd1LQJH8f1hceaP5N3PjCmTX6xz10ZZxuf2PBGSiis4+NJEyIzLd8pPdH
	OCamAAqThE5XhE/HCkuJp3OuAnAupRdEGv0Hrn3waAA9p9h55pzybKf+F8B6yTKvl47mjQIC6f5
	B56tCQTLUwiu3cBubiKvs/AfgXWvf+XZ5EqH5yDUrGmJkpOMWbs8MQCFgYksBYDfICyOodTxIUq
	BH2ofvLdw==
X-Received: by 2002:a05:6a00:178f:b0:846:7507:4e07 with SMTP id d2e1a72fcca58-84842f9fe4amr35250b3a.39.1783462682220;
        Tue, 07 Jul 2026 15:18:02 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 0/8] x86/pci: consolidate x86-specific PCI quirks into arch/x86/pci/fixup.c
Date: Tue,  7 Jul 2026 15:17:52 -0700
Message-ID: <20260707221800.920270-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves all x86-specific PCI quirks from the generic
drivers/pci/quirks.c into arch/x86/pci/fixup.c, where they
architecturally belong. This reduces the ifdef burden in the generic
quirk file and improves build granularity by gating the x86 fixups
behind CONFIG_PCI_QUIRKS.

The series is organized as a preparatory commit followed by one
commit per vendor/family, keeping each move reviewable.

Suggested by: https://lore.kernel.org/all/20161221142607.GA8594@infradead.org/

Rosen Penev (8):
  x86/pci: gate arch fixups with CONFIG_PCI_QUIRKS
  x86/pci: move Intel chipset quirks to arch/x86/pci/fixup.c
  x86/pci: move VIA chipset quirks to arch/x86/pci/fixup.c
  x86/pci: move SiS chipset quirks to arch/x86/pci/fixup.c
  x86/pci: move ALi chipset quirks to arch/x86/pci/fixup.c
  x86/pci: move AMD x86 chipset quirks to arch/x86/pci/fixup.c
  x86/pci: move x86 ifdef-gated quirks to arch/x86/pci/fixup.c
  x86/pci: move remaining x86-specific quirks to fixup.c

 arch/x86/pci/Makefile |    2 +-
 arch/x86/pci/fixup.c  | 2284 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h     |    3 +
 drivers/pci/quirks.c  | 2330 +----------------------------------------
 4 files changed, 2316 insertions(+), 2303 deletions(-)

--
2.55.0

