Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723467;
	b=ggW+yeqDDs1SZN8v8iZvYGn71fNVbGLn5WPZgKLd8xbPBKUJy2tYOev7FqpXK95YuI+u
	 6nxbR5k/BIavMI17dQWXkARQ02AgU5tafwumNNXTM/37+sNP9eRDJaaUoxr/0XS0gVZ8a
	 ZVeCxGvft+JdtQc/gH4UFIl3r5I15fhVNKBWt2eMnuREtT/vY8gt/EdtLKBTPE0TI19tG
	 QcvkI2VDzFolh1u0wN30BieaPZrzpxHXLHrWwndBlJLBgcl1d1DsDyPyoBhDAwNnfmEGJ
	 V890e0YlQ9W7Uw8V3BhgRPB89wh0ltBEeF2r3tsSBDWtKt6FJ/JFhLBCwdRlPNZ98HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=saAz69dB7scZwVRL0Yalw8vwS4GVZnSids2QJDnG3Z4=;
	b=RLFWxAk+UO9LTsixih4/HUEFIuIwZzdZnSxYW0SldnMO5Td2hpx4J8GwantVHc6Yavi1
	 BBSqkvXKzxGWyIhx6EGO2RWw/o0wjOEau6voQX8dl65OMx2ZrMoTyT4gsEFJGW/G1+IIt
	 VBABNBi4AWShXcqgCBiwYzCYB+kjDz2VNsUW6sO//5A1LcOYEcC4qpHNK8/LucuAAi1Bx
	 fF2Vb0DvUzrTWjNCvXHtj0hoDTZ646mKMS4KJS4VW2MYDL574YR5fwaQOV1BMb7YIwiuD
	 7sCIomutjU7q7f4tl+iPUvHvCqIX5HRaxBEW1J/L6OuG9iJCcoeRamQ67Hhdxhfn1aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hD7+UlPa;
	arc=none smtp.remote-ip=209.85.218.72
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CB606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D6CB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hD7+UlPa
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c3f88d2ff28so374962766b.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2026 08:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793723466; x=1794328266; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=saAz69dB7scZwVRL0Yalw8vwS4GVZnSids2QJDnG3Z4=;
        b=hD7+UlPahOYbvqzRaB574vfJ/bX+Td8L0TUv+s1CEaBmALDsuV1eE58pK8V6i90tAz
         XzzX62P1Z3PScjnYgqjrL0G/LwcWDRCue7lhpbaoB+BxxtzHE+sETeg6tMFxyly+lgB+
         jT7kRwronhtmosh/PeEZruVsYVRNgC+G1xPxK4HIFzNP6jjCiu0Kzj5eWZW+ce8YzY60
         Tg+J2Oer3J3xVOkYxuRT8dj++Z8TYnAkvL3K8+KExabuxmrYrvTz6kNkEu4IiIvTAkCP
         eRu3zYwWsou77utLbNozCm+Vji5cONRL55XO+T+NUiHoCAsaq4MVTvML+d/i6DYFoXBh
         fz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793723466; x=1794328266;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=saAz69dB7scZwVRL0Yalw8vwS4GVZnSids2QJDnG3Z4=;
        b=2wtlOl7REIjix9V6zU9UKKpMVnHsE66jkmui2LAoV1i5VrCcGGGOtgku4XPYRv/BYo
         yC6SNMmr18HkFrYTLkTbjQ2qgdKMRrwtN0XoJG1AIuSHA/7KIH2CSli2oMrKMXniXQmr
         is9NPwUk5qiIHcCUba5tiWGYg8i33IJWGWpVNmU70s9F8y55LOEKotLrIx1uqkDuGzFQ
         gRZSoS0o+aOxXx/9QVjxlzhzqglN2CgOv9gElNs+JSb9kYXtaICHRl4YM8seI6TeEt1X
         DeP02yxCcApdiYpnkNT7ZHWy96vrr1roqCb+bdC1wTwoehXSeA9ZIJ3ZLKvihbLy+w0Q
         hFgw==
X-Forwarded-Encrypted: i=1; AKwUvByC6wcFvgvHDUOYb9widgXJ4luwzeoTIzb8r5Olv8yQNEriRmkkWpx6HVxYBzV3cy8QbiTSGAQZh3I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9M6x4+RjqBeIAqm/QPT3fXG82vKZJY4ME0eN6K31nrZKo0ZPM6
	B/eoVNgIhZa4PxrA6h4o4f2V/TFLXAQXo/mwBUoC4/03xB8ZuULs1IUznmaoD0FixpPRudAF21D
	MnHPq9Gb3NIRyQkkAz/822g==
X-Received: from ejsh15.prod.google.com ([2002:a17:906:584f:b0:c49:af9f:aaed])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:8e12:b0:c46:7ec3:fde2 with SMTP id a640c23a62f3a-c4ca7a4e646mr1054401266b.11.1793723465485;
 Tue, 03 Nov 2026 08:31:05 -0800 (PST)
Date: Tue,  3 Nov 2026 16:30:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103163101.1696520-1-mclapinski@google.com>
Subject: [PATCH v2 0/2] PCI/DOE: Speed up mailbox polling
From: Michal Clapinski <mclapinski@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

The DOE code waits for mailbox responses by sleeping
PCI_DOE_POLL_INTERVAL (7 ms at HZ=1000, 4 ms at HZ=250) between status
reads. Every DOE-capable endpoint goes through several such exchanges
during enumeration: an abort when the mailbox is created and one
discovery exchange per supported feature. Each pays at least one
interval, even though devices typically respond within about a hundred
microseconds.

Patch 1 fixes PCI_DOE_POLL_INTERVAL being 0 when HZ < 128, which makes
the polling loops spin for up to a second instead of sleeping.

Patch 2 replaces the fixed sleep with an exponential backoff that
busy-waits briefly while high resolution timers are not yet enabled, as
is the case during enumeration at boot. Time spent in pci_device_add()
for an NVIDIA B200 GPU drops from 45.9 ms to 6.4 ms.

Changes in v2:
- New patch 1, fixing busy-polling when HZ < 128.
- Patch 2: share the fast poll with pci_doe_abort() by moving it into
  pci_doe_wait().
- Patch 2: replace the fixed ~2 ms fast-polling window with an
  exponential backoff that busy-waits for its first ~255 us, but only
  until high resolution timers are enabled.

Michal Clapinski (2):
  PCI/DOE: Don't busy-poll the mailbox when HZ < 128
  PCI/DOE: Poll briefly for a response before sleeping

 drivers/pci/doe.c | 49 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

-- 
2.56.0.385.gac671c819a-goog

