Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F0D3D75A4
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783462685; cv=none; b=U8r8UYDAj6RPjNwlFv47cggPaDBNdsCRxJKqGgJFgMkD/icPtEXRc1P5TgKQg8wy6f6vTQrIHrJh+PA8djwXC9wnMvk1Mb1B1H3tBp8hK/AdyUp2sDF3rRxh0mInjlOYKJz3Msrm3/xMH9fJY1u5hbFzorTFt6v7/J5Mhd1uI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783462685; c=relaxed/simple;
	bh=keJFmUDE9eYTIUkU2BtPM6NdQhjVMwsXz3k/octdvxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCpPp0a4auWkFHFDJgkHfegGrCaHQLHwq3jZ1XO5OOYNSQxk2NMzHjQBLkJE2gcgTehzFBkoDLVU+sNUoBUwyQ3uhzCwfi9+7eP9l4AbK3ZggRRz81KdoHb9Ee9YGUihBDfNKHrRIQ0r+CkoJhoPsbf8mZFUMuJCVRH/UoSE+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTf+rmVz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTf+rmVz"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8478a25f268so13458b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 15:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783462684; x=1784067484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Z+gXnMHt+I3hUv9fEYe3mjH8MUPTsA2HkK5nnE7LNQ=;
        b=MTf+rmVzaxOt238gpS2AXxD91Xxb1IrQ5h2HuEuOPKQOl7NSk+NEhKbF3QxUdaEZOm
         aj1zHT7rmW1RBvpFnhZQz3TtsgtroXeSBWOFVY/Q9PG+2cYYia5XADnTJq/DHwx3mFk1
         sTx9SYDn1rpQjcvuxHULh81v43vzxRQBdOMDF69YDOW8ECnr7ib1MGD1oPhzRWpJqZsm
         69gAXZv5L4Fd6TxA76KHtXUf4dzbU0uQIg8VxjUpig7qqcNk1MFRezdXslZspzzXkIxH
         mkM93swto7EnSbJg4k/w2FO7XCgcTVv0nrBgr8i/T3dH619NX/SE/4Wq9nYclpsSnQSh
         fyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783462684; x=1784067484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Z+gXnMHt+I3hUv9fEYe3mjH8MUPTsA2HkK5nnE7LNQ=;
        b=hE5L/0n4KPjO5vuHcU2Fx4MNQlXEsbA5QFlV+h+H1Y7dzvmrp+4ao+NQcKkvIFiVGT
         fRKPfFjafzrt/O8q5w3ouXa+yE09KHkUN+hziY8ibaQmOjtuU1WDTLzRt7njZC9UF2Z2
         vvCDUzw8hazCN4uEiK0itu9mhQEWWy7OWulWg/Fg9+//EAPkQSlHGd/W7/sI2wepJvM3
         z4tIYXQWWRgekjYIGQ5S+LVOI37nDA+RXHKoHSUZAEeKeC3b65AQ9lytBRX5iLtjZpla
         ygEH5roHDBf+mZZSCI6Vj9nJrWWG5aphEDud0UPJi4bIzm75y9VCBy20tl7bUXRTd3dH
         3N5w==
X-Gm-Message-State: AOJu0Yy7DpseDhIEl04zMF4GeXhDjJPtGIfovnZe8S75Ek6znqf53LIA
	OHEUO0twBZrIm2sQiS+K7QojvTpf58wr6xJOvtz6HrwQAtzzJDJjhDqFnLYAJYlT
X-Gm-Gg: AfdE7cl9Mr2VYNQJjI9xhGI4K3nnxtvSWtTYEidiDCATJNYmw4otothEtkDy099MaDk
	GVjj+ceAZ9B+oRh2MGVoSlBowTICAxRrODQc9kVHRiLxe9pw9MHvTtHrFRNIRCSUlYp1rrB+3CZ
	ncbduj2KLogTFNFv/vYQ57JoPKAZ4HK9+LZXEqMp2SxUE17bx50sZw7p+VI0K8CZD/dQfgvay4B
	RySpdX25kPtURzE7QeCFIs6Djy4BGvXxJVmaLYBRaDZUNOS3ijorxJeCi3OiUORVEABcb+dAnyl
	oIvVbiKJz2GDcxOVThheENxIur/wHpBlRD0LP9mWqCB6vGwn96YfP0hl1KB5vl3me32wwMrdN3X
	ObCk+ZUT+9jlBcOfS9lH1DUobD4WlxPU6cyziFSAeuqrawRSs5jYhtrnCwq0yfqJWYSdaBMmkmg
	lpIvfSVX8IpMz2Gn8IALPubj8CpEWxGY/fxDTkkOTmvsOo+vJtUrsWxvNUw7epa6fdQTJH+lbaz
	dYU2gxhiQ==
X-Received: by 2002:a05:6a00:b48:b0:845:31a6:d84d with SMTP id d2e1a72fcca58-84842eb7ed1mr72550b3a.7.1783462683786;
        Tue, 07 Jul 2026 15:18:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b9b389sm6180281b3a.13.2026.07.07.15.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:18:03 -0700 (PDT)
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
Subject: [PATCH 1/8] x86/pci: gate arch fixups with CONFIG_PCI_QUIRKS
Date: Tue,  7 Jul 2026 15:17:53 -0700
Message-ID: <20260707221800.920270-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707221800.920270-1-rosenp@gmail.com>
References: <20260707221800.920270-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

arch/x86/pci/fixup.c was compiled unconditionally when PCI is
enabled on x86, meaning x86-specific quirks ran even with
CONFIG_PCI_QUIRKS=n.  Make it depend on CONFIG_PCI_QUIRKS so
that disabling the option disables all quirks.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/x86/pci/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/Makefile b/arch/x86/pci/Makefile
index c1efd5b0d198..2ceb9f94db17 100644
--- a/arch/x86/pci/Makefile
+++ b/arch/x86/pci/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 obj-$(CONFIG_PCI_OLPC)		+= olpc.o
 obj-$(CONFIG_PCI_XEN)		+= xen.o
 
-obj-y				+= fixup.o
+obj-$(CONFIG_PCI_QUIRKS)		+= fixup.o
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-y				+= legacy.o irq.o
 
-- 
2.55.0

