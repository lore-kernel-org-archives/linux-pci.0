Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572026;
	b=ZsSA6n2uGNVLfA6J1te4FlN1ypyEFh1k6uKaDGuYgMeEbE3FGm+kqoerfYqSxr7AhBUK
	 nOMSYpijXIBneGoKMJJnv3z+q58S2Pe9wfhFKaoUuJVkPvmaOUcmI/2i1vyK9H80jmWL4
	 2y+D5n+dTFPGZmcICyXBceiEWixTYhwf0QnBeZkj2uYAxfxrxtcaoSIHBbWPZ2Q7kdaX7
	 oTq+clCtzpUeyFX3wHdFyK0gXUuSKw/WQe9OS21CR3csLXRa8c1RX1un55cokZRsxhru0
	 TWGJrT3dg6NTvWkle6emsrHh0tuQBh4aMhWhHG3nXqzwXb9FsoOhq4ckg+OzoqmhDuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CmBnezBjBNUlOHWa9u0VCe+lFB+x5YUvV2kyPTDgM5E=;
	b=cIkZ5nesh6EeCgLPWzRQk/QpHraebZvDnUQdQotbnMFDIoIwuJkAqeYexqajXSplag4J
	 NZvGUg/0+GbUao1J3biQdQFnR7cZG3Vof9qLU0ziAqJ7Z/1HCJLtRB3cRnptzFci3AgyQ
	 +e/4uHcsgmEd0eU6wJ/tx7K7+COX38ti2tlKGJzm00GxOAB7zgoC4ngifha20zGc5hvMm
	 Fb3EZP9x370WEFh3m0+oR7l6cstIIUsPK9yyn4oAm2dj7GejLeuWGUp50KnSAGZX89nLt
	 wr/xwUZg+okuB7rAHfYUrVHA/ztUO2ra2GrBasBK8HgSdTHUQNQhWSz9x+C8u+XHt4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b="oB/VaUeb";
	arc=none smtp.remote-ip=185.125.188.122
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA8606A321
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 02:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EAA8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=oB/VaUeb
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 911943F781
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1795572023;
	bh=CmBnezBjBNUlOHWa9u0VCe+lFB+x5YUvV2kyPTDgM5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=oB/VaUebTi6lZYEjWYmDGtDnM4Eyy2/uLNNqK/ruAIpt/yCegfUhtlN8idpy3mgPo
	 MgwXUEgI/wSMnQ2oY0s4mh0f8op6M2nW+50kwki32lP7rtl0fADgzU/Q8DCPb+ui4P
	 NXq0f0vverZXbCRs0ruUFjcWqknbzTuyvCYN9nMaa1dmXebVBxyC1oCcjtMwuExUNb
	 KeQ8Pdj0e3FmN6lqjtAGXSzoDm8Lm1OKhFdapxfaDHz32m0CNtd3hkkBkdoXoXfbDB
	 R0VfBhuXv0IwUrqalXv0GR3qOH13/r533uBlLaEb0bjDfONyr5Y4N68LQnsQ5facAH
	 5sWqaQXlZhdFLhOtocwRSU6H2X9gpge+xhvy5s1v2vkAeWFylvl2LGvaAb3JpsXZM6
	 4GnqMMg+fsZ0HpCe0yD5/FGkjzNYdaXUH9oEtQPNCN7RZW4c532kaVsuD928OPovwK
	 mS4DOjhgnUcV23yCYZ39s4tE24afDqtnS2cr6IugjWXvXWaEHCH0/pUoO6XYW/Qeki
	 p0Qe6kgB/KMn2ENJKr25cgDXIV8bELaYUMoUHv75r0bxAHx+XeVjUJQWrqwsS3OXjY
	 Wm//iRKumsvhlY/UA7NXBb0aa/j2tngAA3AvxBekf5XpZuzLXhNGiwk7sU2Hi4oeWW
	 vIYGfXF1OZWRopnSzeWGxYJ4=
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b4cd0f130bso328135a91.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 18:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795572021; x=1796176821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CmBnezBjBNUlOHWa9u0VCe+lFB+x5YUvV2kyPTDgM5E=;
        b=bdT+PMc56FuXWRmHRKF9QNncuE7Dh3UApMSFh0UoKKOGfBnCw2IpE8Hm/wiblUFOWG
         RlnI5teuOY2LXREvBi6yCVs1/mHF2Xu4HmU0uEqmHdlSHI+rJnnEem2E1qBEcxdcbgBh
         ufhvhllaA1GMNvwzphj3ggEtKsgnqMG++a1lbweU2vjCnVJYhP4DSsLk3YoMIiRpVbAd
         907yP2TCoI6SGd4/xMPYlCLjQOY4vGsNTwFDd5FsTE3b51k9D4O52GXzDILdDPv9Qvgi
         L5ZWmmIBBIEMVZvt1JBLEEe2Bd7foLu90mcTk6y8NV94xZG1KCwoXGyPzBjwihrF7VgJ
         eStg==
X-Gm-Message-State: APuU4Z9z1BKQhw6iRHmXXuPMIyhvvF1keuyEcdVKerFmHzfdZVuGpMPi
	LHUnk0WN7B1tf2dIvP3BtZhmnpmhH1tCXnebrZfSYvchd5uEQWRC3mNwqGEJral6dnoianyyluG
	9/NXYgfhAlb7xF+HmvDO1sCl3/tS623kMd9ApunZUFv6jk3eLa/zuJ0shlECel+dqKa88+BSgVo
	N2NQ==
X-Gm-Gg: AZFdTZc0v3hye0wbYtjCN+W/5ImWr+m7MHBkT98l0zcIDz/Z2Pnfz19YOJHl6hSGXXq
	nnXJqtgCWXxPAg1guk4XasnS1ztEOpenCurC4/FPYa6pOYoONGnTAaZozeS0cDAXNAeSVcYz8YG
	PE0QOAv3fzKU/kl52HKmTe23uUN8QLKlw0V99Tx98s08RrPJgYnPEUO52dgF10g3V564qwMvz7L
	5tsYV/KHfz7rGDAv0ZL4JWX7pRECTEkqyI3ojyIY9PeL1ZxrBGqnoETkwJq27ouIy3fMOjEHbqZ
	ZP2HnZDco3F4iGze8/54BS1fQRQ+ghUBShq5Z3pZG4aeOjBh6cudZ10j1xPUR7FOx9wsHzdAdXy
	k5H5sKxLuMlEsRXUGYWelOMuXF0r17+Qs32XIyRUAPceDfxiOCqgtYzkL8rpfbzuFBCKev1Gubm
	DUj4YUHONLnohMaYjjSKiUFHbjjAJh3EFh6Im9Of2AwcwpOD69TCrGpmhTxJJKu/a0oNu2rpuBm
	9hJEZ/d2+sF3pJKUSLvqHPCqjQNdI2LQNpNeybjStfiWpJYXN8QRR8GhrJedgvPg5UqC6XECeXC
	OdIWE/oTI+e1/BDK
X-Received: by 2002:a17:90b:1dcd:b0:3b3:bcc2:490 with SMTP id 98e67ed59e1d1-3b41c7c77f8mr25857490a91.1.1795572021340;
        Tue, 24 Nov 2026 18:00:21 -0800 (PST)
X-Received: by 2002:a17:90b:1dcd:b0:3b3:bcc2:490 with SMTP id 98e67ed59e1d1-3b41c7c77f8mr25857411a91.1.1795572020632;
        Tue, 24 Nov 2026 18:00:20 -0800 (PST)
Received: from localhost.localdomain (2001-b011-2008-6747-70df-a308-14a0-6404.dynamic-ip6.hinet.net. [2001:b011:2008:6747:70df:a308:14a0:6404])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm24959832a91.8.2026.11.24.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:00:20 -0800 (PST)
From: ChunAn Wu <an.wu@canonical.com>
To: bhelgaas@google.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] PCI/AER: Keep ANFE masked on PLDA PCIe-to-PCI bridge
Date: Wed, 25 Nov 2026 10:00:13 +0800
Message-Id: <20261125020013.639193-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
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

Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
Errors"), pci_aer_init() unmasks Advisory Non-Fatal Errors (ANFE) on
devices with native AER.

On a Dell server, a BMC VGA sits behind a PLDA PCIe-to-PCI
bridge.  When enumeration reads an absent device on the bridge's secondary
bus, the bridge returns a UR completion and, with ANFE unmasked, also
signals the error.  Platform firmware reports it as a fatal error even
though the hardware severity is non-fatal.  The kernel then resets the
Root Port, the bridge loses its configuration, recovery fails and the VGA
becomes inaccessible, so the console goes black.  Kernels before v7.3 are
not affected.

Set no_aer_anfe for this bridge with an early fixup, as done for the Apple
T2 Secure Enclave in commit 7209846a169f ("PCI/AER: Keep ANFE masked on
Apple T2 Secure Enclave"), so that pci_aer_init() leaves ANFE masked.

Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
Cc: stable@vger.kernel.org
Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/pci/quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4a02fc80755d..511eb65f9872 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2610,6 +2610,15 @@ static void quirk_no_aer_anfe(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_APPLE, 0x1802, quirk_no_aer_anfe);
 
+/*
+ * The PLDA PCIe-to-PCI bridge in front of some server BMC VGA devices
+ * reports an Advisory Non-Fatal Error when enumeration reads an absent
+ * device on its secondary bus.  Platform firmware escalates that to a fatal
+ * error, the Root Port is reset, and the devices behind the bridge become
+ * inaccessible.
+ */
+DECLARE_PCI_FIXUP_EARLY(0x1556, 0xbe00, quirk_no_aer_anfe);
+
 /*
  * Under some circumstances, AER is not linked with extended capabilities.
  * Force it to be linked by setting the corresponding control bit in the
-- 
2.34.1

