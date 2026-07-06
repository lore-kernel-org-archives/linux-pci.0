Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08332E7391
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333284; cv=none; b=YPrRR4uKqpWrCBWbkldoLcWG299S2bP8IImh5FpjqalTYYYeGxj+eg7HLKFhKtOTCQGMXZKvlBRoDC+BfhJeMhx3uz9FuyOwKTxfMYUWPznm5nJxQw6YdOs2yUSYinWqR7VgFOvjU0gWXql1UpIv18ETv+MvOoQI7N2QwN9RsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333284; c=relaxed/simple;
	bh=Wpsv7R7vBhl4E1ynBD1r1e94AV8sm1nfTctYrLsbpEY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdPxub+WNbdFYc52DCixqLAciEeJvC3hGRo4BfjdgruKyg91C7j5kD9yoOCK3H/UF1rgRK2Md7U/dTeYnvodEFeMVSFl5zaq7M3PuILxHwzQHDd5fxdxcdFB35TV8UM919ZM1gRezwfjavORahvUNiYGODQkyOLoeES8OikoOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Tut55WwL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Tut55WwL"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493d3135e9bso9673175e9.2
        for <linux-pci@vger.kernel.org>; Mon, 06 Jul 2026 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783333280; x=1783938080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vr1ys/nB1mK/ihSehWKTHbT7QY7wm6kylG81Vl5Ds+U=;
        b=Tut55WwLZFL5htz5DKIPgfh3EHHWS3N6UMds/HcSUsIR5M2iRXJAOCMpHcP9zgjHp+
         YgBB1N3BC1E+vdJf69rtdabNdP4zu5Anu6ptlY1R1kRWzOl13OqlL5oj8GQrqXgfb53v
         S3MZ8/j+83+iCn2cslxEMXxKyNGilrWXeKkbuesDsUZEBeg+YdYvc69l5d2MbKN28Us1
         JkcsSQ4tbZrkWm54JMGqnkvW9j2Yl1JpILpVccbJANwv5FnXlkULrZqHaoyXyxvTQ1uP
         ho3sPzRQG545wzDs0pcXnvYUxqU6Tt9zO8J8obga6I5BGYguugsCQNjulJMppC0Ga09M
         c4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333280; x=1783938080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vr1ys/nB1mK/ihSehWKTHbT7QY7wm6kylG81Vl5Ds+U=;
        b=DqU2FdGsaLJtoVmha03zgcrISlqLpyLURE7QZKR5eS5yrsSRPOZGcwUM5eOH8IS9Y5
         IwGK4mo5cCRx0f3aLAOcTCuCT1zuxKDcoPWrjWQB2Tqmq25oVqzjioJEFFaXcuJ/3KRa
         3wUTud3C7OXQCWKFo1hcBMp+A+r2uUjSo47Pe5xPoQGeeXM3agVOPH0Y3BCuCXv9lCD+
         M5r33lPxe6FfzWFRRO7AEWzbuk91bYKQ4aDwdKOIdj3nGKJfIxwBaxPeaXOmEnFjQ/4T
         hJ3WAiL9BwyieNfzhC5zmyFgMxOzebUS37w7gWvGsMG7fT2n010KSsxqWlGghvpLO2bp
         z6fQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYkyf6SIut/bE/REKV7p7zMtclk0M9E2hZrKOfenkD6N91iaJLEBR4PDMhDhUwe+YwcJ6UoZJtNEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwebLgkCTUMleOrsdHAUzI7Zt0lXm8A0v6r6pXFVzw/N3JFZlkc
	dWVFU1se9VyiMxP0SwxibyYV5hTtV3aD7WbP95Dz2EQzU52VEnBMYoFKSa6UIBz/DCE=
X-Gm-Gg: AfdE7cmW/cYLwwjZ/irvJdFk+Eit8UPr4BjZoMq1UKQCVdIsGIW/PYsRrIdt7WKNStX
	p5akTucK4GqHhvzOC67h/WB1rYCVZe5Dg45+PASH4TIJTD3tz41I+pRVS91RmV/f0PfWk1xK3Iw
	N3AV0A3nMN9dkO2kA1HnKsTFhsZ6bGUHHTRG+/dI56DHYZKGktC5WFDgfCzMnqGwIniPvsskAOO
	BIb/pklLqVxbMipjedbLXi1xq4QUp1NEiY0WQTT/EbrJcfw/rfN2e/hwpaBWzmWHtdCAOROdj1q
	4XkdSPBKsnPK5xZAOSDAJY5PwrQBrLvnL820hqoHVfzLsq25tnLfeBrJe/hIhQzUoWXGEhRVzsj
	JSSlACkxxQSTVlLfivus2uY7za3HBsQ4gbqAj+zAOYy3v7GIxSQaIXfh/cZ09fPwxhMTCg7KpL+
	Fu1/QclTUZ5HFvR7J74B4Nnn5VA9R9BEY2gBYoVw5XC2QjswzPpXTotuGyIY31M2oioXEDcCoWJ
	8JH
X-Received: by 2002:a05:600c:5487:b0:493:c389:d436 with SMTP id 5b1f17b1804b1-493d11d7b91mr110710245e9.9.1783333280093;
        Mon, 06 Jul 2026 03:21:20 -0700 (PDT)
Received: from localhost (p200300f65f47db0426af56a07ec3b32d.dip0.t-ipconnect.de. [2003:f6:5f47:db04:26af:56a0:7ec3:b32d])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493cce12c40sm458632215e9.13.2026.07.06.03.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:21:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] Documentation: PCI: Update header defining struct pci_device_id
Date: Mon,  6 Jul 2026 12:21:15 +0200
Message-ID:  <a01d1cca33187c8b2715227d3db7146465513ced.1783332821.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1488; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Wpsv7R7vBhl4E1ynBD1r1e94AV8sm1nfTctYrLsbpEY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqS4Gb1IcbeZpsCfZyAGZWjJVpNrQeWn82jbHQU K8LuuzxZLmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCakuBmwAKCRCPgPtYfRL+ TjfxB/9SWYFywjXLqHXyqb60XbJLPsTyrS66EdBCuqeZZQDbgtNQ6TxIVIptlpvNd3y6Uhj+wRo vCi3LNwDjDoPBQPmB/J8S/hr4yfE0rbnVheq6THD7kCUvybtlDjZcWgnB345tXnjIsYN4N0bV+A NIKdLUDJLG49/WA+/P0Vjex6sYehvmBNUPHNTadtXAdeQ1DyLfO8mnTvceLBO+avdwgaFuGCzgg ReaPcd5Di+GKtlaSjb+z/8c2IiCNrP79myebsm9fPQcZdgMDkrTInWFhVgAxEo2Oou+/KraKe6r OKg8CJaqjJfkdW6dohBau1uZmiTg9xN5oX2VgkfJB7vNsMJR
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The defintion of struct pci_device_id was moved from
<linux/mod_devicetable.h> to a PCI specific header. Follow the movement
to get the struct's documenation back.

Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers")
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I'm unsure about the best way to apply it. The obvious options are:

 - Linus applies it as he also pulled the header split without involving the
   PCI tree; or
 - it goes in via the pci tree
 - it goes in via the documentation tree

The 2nd is probably preferable if there are pending pci fixes for 7.2
anyhow?!

Best regards
UWe

 Documentation/PCI/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index be35e9a1ee75..71c42b0bfa8b 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -84,7 +84,7 @@ initialization with a pointer to a structure describing the driver
 The ID table is an array of ``struct pci_device_id`` entries ending with an
 all-zero entry.  Definitions with static const are generally preferred.
 
-.. kernel-doc:: include/linux/mod_devicetable.h
+.. kernel-doc:: include/linux/device-id/pci.h
    :functions: pci_device_id
 
 Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set up

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.11.g153666a7d9bb

