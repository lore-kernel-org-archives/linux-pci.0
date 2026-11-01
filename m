Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793516524;
	b=G85Sl7CymXMDBTZonlDB0Zp/lqWHj0h0qxoLsWww/uPsMhhN3bp1elW5dhSdTkLzhsPt
	 rk41eD6EkjgXDULQI6C5sjYAD0J6RM5TTCAuNnHdzYIwMNtIfp6cVyVCkIAbGGskZsOi+
	 e6cXy8F8sCPubzhLt0NhjM6//wRSgqdvdftm6+MOFKKc5EgNlHTN7kosEblqyaixfv39s
	 RrqaOyHvv0hqtoekfngMl5f5PMZZZDlRDw+tdALhzhs6dyb3SpWXXSXllwovMj4UW1hoW
	 H0UVHvHYwvmwS0GmjiH2m0plupBGK51pyWwF/9JrcSGlBtoW+zSKFVoFrmeqYyzbKLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793516524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VoA8ZatI3XBB1U2/SoghhJIwCX1MF+HDGH5+WILuFZE=;
	b=yzK9HV46/L5r2hD2PE18+ro4cRQ/tjWL6t9IFBfqyWaTPKgYzPH+xzzho7lw201Ib4Dh
	 lyGyZEJkfozUM4xHmjSfG0CqUW9kAF+EJSLertarYjAhRRPgoS5Qhbr2UPNaGZB1XgwUZ
	 odeAu3IPp+2u0W7+4okFitKUYdkTZaGebEJqMs1f1wrizXntimwdTbTr9g9eKVqwzeRkS
	 x3/xrh8LDe1SDiQbvtTzqqhOm1tRPYIIg2LzHOAnNNDC/cS0WPSSDU5CipEddFToHNYvS
	 nnTcNcZ0umHruuZS8WSa7veKOyHmVjjdiFpQv0vLIGG6xAXb92hwRcU3EKQPeQ/9ewQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kA7pPlvQ;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8772606A325
	for <linux-pci@vger.kernel.org>; Sun,  1 Nov 2026 07:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8772606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kA7pPlvQ
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35829219da8so3619407eec.0
        for <linux-pci@vger.kernel.org>; Sun, 01 Nov 2026 00:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793516523; x=1794121323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VoA8ZatI3XBB1U2/SoghhJIwCX1MF+HDGH5+WILuFZE=;
        b=kA7pPlvQhwhKLULELE5/CBmTp6vqr0g/M9TexM2LeVp9dPO9ABH1M4zgdyHVVZbk6N
         qTEgz50ffPFUotLCboKfkUH7o+y4+6IzZitVvgh7aoC/G46G/KCoEjjlmUTUEUW/q2VY
         bo5xHEwakLulV4Brp1f+dgtaSQJPfIeR/9SVaYbbwFZLkbANlLT1QIU6UMYepxMJXF7c
         gFl2G2bLcC+vX/Qmyl38sRA3cpGG3ItG9cmgVnMrQXZRu2gvoi8guvfhWGeF+ZEoyY1r
         SiHje3WV1sJz6C5EvKz1YEZqNRtKdfFbaOQ09I+jPjdFXPJfx4FQV+shoQJ1nhAHJZEq
         yKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793516523; x=1794121323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VoA8ZatI3XBB1U2/SoghhJIwCX1MF+HDGH5+WILuFZE=;
        b=sdPU/Xm5a7+ZFEMsK6yYnR86TeG1C7kpPbp2a9h/imlH9pP0vH48NdAdjPEMySM2uQ
         Kkb/jOcI0Twb9qIwk38zu65xloygQhI/TLqrWbunFlLDqPEoSPjwsvFPB0nAdHL7UjDA
         drwMJp8gspMFQqNrtuZGtS8DNal/4vmajU0pfioQCgwaPAXc1Idcc6/c8HwP4I0/iobK
         tMfu46IxfjLNnfakpkgyabXe9BfVmOqsZYZpzUbp16pWFmCoZGUjQMKXcHF3BzJA5vaA
         8LnyDvZzaI1FpqkBBPZvKkL7uGWHcR3tWgbY7IMjb4u0NqOi4tzqVi6mlpOpN7f/5rA0
         Iddg==
X-Gm-Message-State: AFq9FYLMqWC0ifb4t95L8LXCiMpK1Jpubq6koQcC+pR0dFOlPx2Vjee/
	krbkTP51b6hQL20Z1ejhYreqynYThL3/fIpGHbBxtfQrxAjBLma1Z/z/
X-Gm-Gg: AYBFou2pnAuicPezJqAa1iprWXLLdmaMC2HQKv2Ni/anXEHvbhrCKyAhzi9BJG8b8Yw
	U0pm6cW+rkH4OcxdYPtDg6o6draLRmUx7HBDpW9515Z68Bt4wa7wJwH1kNt0gKHZQiyfmIMeJsc
	d4jrwbm9rfsmDHfUWZMREQGjY8mW1apc35NljLEbCWE+LrRfTfy3a/i6dZLcZAVaJBtt9ItF5L1
	nlZb7lPMeAsgE8xc4keRyThLc5jqfUJTJXeFd7lHRVaRWhO+k+4Un9/gfya1dMFI3q27KV+nP6M
	rrixwP8DYQZYyGoEmZEcjDvzRDxG3jPDOMap//4RpF/gtOHeWzZ7/UzoxornS5GYc9/gHe6hGX0
	kejqHGIf5VkaAcgO7xcqWpzCkVgPiSmSFwKd5RNBiKtyjI7aXLmzgC4YANTPmuRciFWsmSf5PwQ
	e2yY3MfgogdJH87ZtjaHlLd7AZ4lFumW6FVSiKCrH3ii3yBMnFALPfHJ5cOYzxFY7AT941lneIV
	UdQ3DrfY1SVw7/Ob+/2GMjni94m/ITbx5KVsxdBVKaI7ZGIsag2Ar4AnGoSLfliqu2stcAOX+Nq
	RNDTYNMH5X7eVEpzBXMSIUwGV5shWTkEKv2UNGF38huOH2hTBsy15A==
X-Received: by 2002:a05:7022:7f02:b0:156:d588:c881 with SMTP id a92af1059eb24-1a9420e36c4mr14043652c88.2.1793516522423;
        Sun, 01 Nov 2026 00:02:02 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.181])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm38735421c88.7.2026.11.01.00.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 00:02:01 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: sergio.paracuellos@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] PCI: mt7621: Fix reset control leak on PHY initialization failure
Date: Sun,  1 Nov 2026 07:01:21 +0000
Message-ID: <20261101070121.2714-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The PCIe port initialization code acquires a reset control handle using
of_reset_control_get_exclusive(). However, when PHY initialization or
power-on fails, the port is removed from the PCIe port list without
releasing the acquired reset control handle.

Since the reset control cleanup iterates over the remaining ports in
the list, the removed port's reset control handle is never released.

Call reset_control_put() before removing the failed port from the list
to ensure that the reset control resource is properly released.

Fixes a resource leak on PCIe PHY initialization failure.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/pci/controller/pcie-mt7621.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 01ead2f92e87..1dcaa2829609 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -361,6 +361,7 @@ static int mt7621_pcie_init_ports(struct mt7621_pcie *pcie)
 		err = mt7621_pcie_init_port(port);
 		if (err) {
 			dev_err(dev, "initializing port %d failed\n", slot);
+			reset_control_put(port->pcie_rst);
 			list_del(&port->list);
 		}
 	}
-- 
2.55.0

