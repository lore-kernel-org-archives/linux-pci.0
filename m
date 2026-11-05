Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865310;
	b=XsePS0eF4dPmBYbyIfHtZdrU6MU2tlXjubIMULwvIQy6ROGZ6PD6M0eyLGSd4v+B+3JK
	 Sy0Isz6DdBTEAH0BbwWUxu23nnKwj4PlCcfInemOZXtO18fx3Y0cdjWxN+M+nJkFyK2QZ
	 Wnn2Z2r3x0R/B/C6lYfifuC+WzXM5qCoAo9loPCKOK8mLJzVKkNIdRwepzHPSNyk1StAd
	 GlOZ2JtxAqRw1xKWUrzGoLisnL85WtaFEWd/dwV2Ay+qCvDI1xsuWZfmkX3z4Sj63bz7y
	 kSceSeQo63Z0viQOTJ9L9AsXI88Ru/f4WOsJ6H9tVeq0f1kz2eV5vqBHASDPPLwqPwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=49G1iqf2QmSyGLHl7Nzr1fd3WMkW1sA8C00E5igDa7A=;
	b=rTEq/PjovXV6E2zvXFI6ahDgo3fJ7G7MaYF4G1d8+15P+pExeY7wKIo6JDq4lkyr8mde
	 RqOAlV34GghwMvWbosOyRdjTTE0AWmJJRyhTGzH9NmAiSVAggWDBZHoLNa0EB5NxU1Etc
	 G6bPNPPr4tSObWxCk/Dh7ZZQzezPhxF5vk4RtqpbMz30r7QXS/de+MVuw++/t8dBy7BFj
	 O+LnjqsxwB+Z5yMTrOEGvaSzzEZk3eFNaqL3QEmeKuGhDolDgikifDc36w+p4P6iS8JQ2
	 +3OzFXu3LMVaxBAQGWz88kmddn66neDKsK21pJ/3rN3KxR1I9+lHgYLMHbNMlpTWFzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qdkfEXpA;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8766606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 07:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8766606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qdkfEXpA
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b08a162d4bso1113538a91.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Nov 2026 23:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793865309; x=1794470109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=49G1iqf2QmSyGLHl7Nzr1fd3WMkW1sA8C00E5igDa7A=;
        b=qdkfEXpAKoq74JnmWDYRgtODsRQ9zmfdbm1M9FUxuYasF24+heFKwIpY9FzZcACY0p
         El0o8osQWq9K5fvSDbDENn+6LdaUNum5yoCk3146guJ/qZbj9uj22ya+tFjWEGGXa3f4
         ekyUh8YkCiuIaqiiMnH/Wh/nw+F6Hjj+SalfVTbBxCkRjeRLcyS6wBsjqKuB+eSr0KPX
         34M3uiY9o43Z3Z004vymUxfwAEX+GUuCi1URgP8B0caI8wLII4N0RWdNfw8vaNqz/c3G
         yMwAtNR93yFQUtCXgI3AHCsUWRz8w+ZlztwO9mHMK50IyELyNCILSTozS/iiMiNdRsUk
         hyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793865309; x=1794470109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=49G1iqf2QmSyGLHl7Nzr1fd3WMkW1sA8C00E5igDa7A=;
        b=osOY4Jjm5KhEg8ORQNp6/33C7ttp0sD1vgiAncJSKevkBVxPiyrvww4Bq32BtfCYtg
         5SunbmuJOvZhCgdfhleU/9juuPyMjnKyx4zqqN55HxUy3DARzNA5YMSCw86D9uIOBe9Y
         aVt6fChJdYcD00iebW4pmPx/IO1btlP+xLv2SW1Vq72ePAYzdRI7grkdi/OEEuuLA3JB
         DOScUwVIXRJqVf7TpJZyxciXI7+QJiVta/kqIf81vPNrAshXKDV4YRCkKUlhptK85SpI
         KQJXUx7vq5Ar7+LQ5418EKq8NYiYczqcxLTVZnb+ONzOaQjbE2/wafZky2IPsBJwyMKv
         sHVQ==
X-Gm-Message-State: APuU4Z/wEQ/6ju5DvXsE92S3HF1hIUbJvTPhnH0amYuV90pcf5dysm8H
	YFslFiISwQzlYgccoA1fNzXZELcV6xrVI1QEXlF5/tpRgd9Oymg1ZlrOTDVoZYw=
X-Gm-Gg: AYBFou1Ka1wONEh2Ri33Wa6cQS+i0D5O+62U0JjluWlZaGc4E+IDyKM9XMKGbhwMN2y
	8zwJqzHo04L0p8lpgTE9aleDlS1/sBaeG16ogqzMNpbDtVBSPF6Ye0SE+XJVVXZQeZRA6pYO+AX
	8kVVTGvzQu1uCHrSueLVNJVtIvESUVTLyjSrjRixYbjq6esJRHwYZscdunepHxGB+Fxlg1BkJJb
	Fe9L534VGEVSghuCx1WhSJDHStuCr3ntLOn0HL5LPS3V0YtWdR5/gauXDv+4KLR3nQ3RqkIlLZ6
	ccJ+qBeL2ZewMSOPlm1EMI7zVr/9FRAI6jY5mZArltJc92vlNJHqrRyqF2RrhfycYh91ld/HHSA
	FIVxq9ogEgZMYbOVK0ixTZ7dVR4pUTz4Px/dmwyF/asKnQ7kmAeJVcHL4CYs4hAqrlH4dh/HW+s
	qZ3GU3Pftx6Zh6JpAZc9oYtChBkrGuIoQ40ce4QPCRk7P7QBJs/7jNrIqxhKIZjPUc2Pnvua05v
	Pnvfp+JwvFAdiY8W4xasemrYICrszDQaTzQaJvI5eWRFV7NjOGR7SnYyHEegxz0SNAbLNg63wx8
	SzbFHtsbNDaL6VyuYTHaPbA7ToYoBfA91FLehFbKfAXMRisUkjap911/0A==
X-Received: by 2002:a17:90a:5d17:b0:3ae:898e:a123 with SMTP id 98e67ed59e1d1-3ae898ea1b4mr11529545a91.14.1793865308835;
        Wed, 04 Nov 2026 23:55:08 -0800 (PST)
Received: from localhost.localdomain ([202.51.247.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31d2b5esm2622293a91.15.2026.11.04.23.55.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:55:08 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org,
	Daniel Stodden <dns@arista.com>
Subject: [PATCH] PCI: switchtec: Fix PCI device reference leak on probe failure
Date: Thu,  5 Nov 2026 15:55:01 +0800
Message-ID: <rc-review-20261105-vc-149-07fa7f0c8a18@gmail.com>
X-Mailer: git-send-email 2.50.1
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

stdev_create() takes a pci_dev reference for stdev->pdev. When a
later step of switchtec_pci_probe() fails, err_put drops stdev->dev
but omits the PCI device reference. stdev_release() only frees
stdev, so the PCI device remains pinned after the failed probe.

Return the PCI device reference before putting stdev->dev, matching
the existing cleanup in stdev_create() and switchtec_pci_remove().

Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261102 (2637bdec0535).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
COMPILE_TEST=y.
Baseline and patched target objects built from this exact base.
No full kernel/module-link, hardware or runtime test was performed.
AI assistance was used for analysis and patch preparation.

 drivers/pci/switch/switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5711aaa5df11..56a370ac9f27 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1698,6 +1698,7 @@ err_exit_pci:
 	switchtec_exit_pci(stdev);
 err_put:
 	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
+	pci_dev_put(stdev->pdev);
 	put_device(&stdev->dev);
 	return rc;
 }

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
