Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445489;
	b=H15jcEtPIj+KZsWWRXyOYkcK8Lgf+rFh5RUqwSYOi8wPc5OyV04cCyDq6ObW58yjZJow
	 NOu2NtduXVdxWjiQEoklZNL9p9kBx41qhST68WQt4EqBaPFYKMhL1FikKQfeu9krvh8cR
	 CNdEjq4B2xgpHfYUpsa9lnQE+b4y4TULypTn8v996+A4A1wmaULi7gGx+dEgYep7HI6Wv
	 txnZ4fP+Qk/pHsggzfJ8CMvJLQJKD146MIJ1gFXtiVXqEb1lh4TbwA8NZZOQrIqUl4guf
	 NRAGtYwxbzTxarIuCrXjofcYB4miviQtYeYbAG0nAmqZoz7xp7ZFisxoAjSOtXUZxfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=aQspCOyRyocPeuGvIH5YlNChv9LGZMbmr1LWcFqx0m4=;
	b=Q1FAgQZ5jjf/RfyIN4AMaymiHjjI3injZnmyVddcQb6iLetcq+ruok7c8irLoCU46gMV
	 afQDnLlk0Qe85pL0F3YPokaJpNCdG2e/fH7Rf/2NL8G0KMpukH3LKsHbKJ3ljRb4XMexm
	 G0sOljZFXGq76RUA/M1xSFh62UxBYP5uu3AHfKb4Hqt9NA0HXy3QZLSNzDORseMF68TTb
	 i+yI1PBu892s4w8nXSG6yU5SGY6wQPAmmWcHaM2V79C363D87fsCvqVe9djwHJQW4dwPn
	 eikkVhQB4VTijpZYzrcRHtxB+KFibLOgiBMywy/qvWOaDPtiPHnheN/gV/47FNBdbtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qhFjDY5D;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB4760A261F
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB4760A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qhFjDY5D
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so2934661a12.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445488; x=1793050288; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQspCOyRyocPeuGvIH5YlNChv9LGZMbmr1LWcFqx0m4=;
        b=qhFjDY5D4p7t7LnkELeXiL4SLoDFvPe/hevdCly4D6YNMjJM/ortuUazpb9FEaTJcu
         h7uUTeCQjkmfNlNt3rq41WhYuifJ5RbPU4FG0sQ1cIPTtPoc9H5a7QEiHEsZJlVnMmBE
         kz6IycTjoFM+BLHWJwD71BjP1R5PMiNfiDwXiQk97EXhoosBw2hAXiM/ntdlSHp1W16B
         tZCBvma0Ps/fce1J80AYIZ1OHKDI7Z/Fze0/wgEoAAIZJRnT+aH3rxvGbx93T1tOnyng
         Y7sKUVEgSV+1BtGWmUHWwhvV64DSc7kAfdcgDX/J83Q6g9JFP85YBFu8r0/t0mh+3Z43
         ojOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445488; x=1793050288;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQspCOyRyocPeuGvIH5YlNChv9LGZMbmr1LWcFqx0m4=;
        b=tpcKY4MaVzWM1FkJ6TsWEWlISE0mgHSe6fHgUHZGmK5449UBWXQjmYr0inCGeg5XGk
         us2VX/uLgXldSulR46zUnkpjgiKZn8ICMBfcxdjzL2lwhCQgfapJevVwRoWziEuuqF0q
         y/TUoEuMhvD4QxzgIxMWyS0P5V4jIXk/cE4pDIKcK8UuR1e/AA3HNag7fFbR7CmsYIDY
         rZ7/oFRbd34AUcDMFPQbFbjaink3OSaWMXqsJ37ribh1m1v26N2ANMgkwQaP+Ubn6UP6
         zGVuBqC/5I+iK11aopfizS4OvjBeAcnTxbv8REZ1fqRTIxKxnTF7l7yh8FoW3a05MIEo
         2XUQ==
X-Forwarded-Encrypted: i=1; AKwUvByu6/m8s453uzi5tDhVEIWBYNr5ALvmT7FXs/SnwPKVGeWNslceYIelt5TsVPJbtZLCK1r1UdszeO4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWFS4uZmkSgi8VPCKIOJsQ0NUUbox7Z9VOl9rzHy1uKUtxjahx
	ET6aRSuzwzgzKhDb/GnIYEB7ecAJGeQWdIfCwzM3wcItI2gAbopxIZixgrR1yXhgVEJVXbsb4nU
	tobAVhocsWk1arg==
X-Received: from pgld2.prod.google.com ([2002:a63:e02:0:b0:cc9:f746:40bb])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6f89:b0:3e0:b937:883d with SMTP id adf61e73a8af0-3e225fe8995mr7731521637.25.1792445488192;
 Mon, 19 Oct 2026 14:31:28 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:52 +0000
In-Reply-To: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019213054.3157159-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-9-dmatlack@google.com>
Subject: [PATCH 08/10] PCI: liveupdate: Prevent releasing resource windows of
 incoming bridges
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Prevent the windows of bridges preserved across Live Update from being
released during the recursive "realloc" failure paths by adding a check
for pci_liveupdate_is_incoming() to pci_bridge_release_resources(), and
log that the window was not released, similar to the message that
pci_release_resource() logs when it releases a window.

This prevents the PCI core from forcibly releasing a preserved bridge
window to satisfy the resource needs of a failing child device.
Instead, the child's resources simply fail to be allocated. This should
never happen in practice though, since the previous kernel should have
established a sane resource allocation before kexec.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/setup-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index b82440394ee2..7283c4be803e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1700,6 +1700,12 @@ static void pci_bridge_release_resources(struct pci_bus *bus,
 
 	idx = pci_resource_num(dev, b_win);
 
+	if (pci_liveupdate_is_incoming(dev)) {
+		pci_info(dev, "%s %pR: not releasing window of bridge preserved across Live Update\n",
+			 pci_resource_name(dev, idx), b_win);
+		return;
+	}
+
 	/* If there are children, release them all */
 	release_child_resources(b_win);
 
-- 
2.56.0.212.g129ede20d9-goog

