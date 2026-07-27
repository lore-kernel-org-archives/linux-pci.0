Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371E3F412B
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146331; cv=none; b=IzOtNU72x/1lizV3FaCYBRBDSbzYRdo1lssTU92+MYZ7j4NLvyngLUREJ+sjBieb9o/PhQOHz4bb9icKQLTOcr8YB2mcWu+eH4Ck750UftBcXgx6sK+XdI14tqVx4BLcpKo4R/gs6FhYoFto4scPhN2CphLNY35zoq+9HLShroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146331; c=relaxed/simple;
	bh=quGlo1AAMz4MdcR5eJvUFdG4S3/8Vcmu/B1ry5mycPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVxVKjaV0GR9sUgnerdCsIT63dhCv69Jtyu9vzgrj83vxhtA4W+E0yL/OSncLuDRIuZMCs2nRpTXJ7zD1ZvQ/NaFdMo6t0bvGlVys/vtLLNAytO7eZpLW0U2c+TrOu5QKdFA62xYgWWma9/LU5PRy+GpTkY1oAVsplYpMiOa83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq0Qq/Tf; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq0Qq/Tf"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso12381265e9.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785146328; x=1785751128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mamcx34JMeLjC6CN46Yh4hwjjs2Agi/cyzZ2FrLvP38=;
        b=Wq0Qq/TfXt5C6WiMEaV2aa/0iM5sotKOqKHB/KECg9sGxx0TBYHnEZLpQhb9bLQvAT
         aUeD6K9qdoWkOFUx7pVmJluNx76ke0cyFWNPlRoShu+t6fiT6vvuc2iF79EW9KNCQXmj
         axCyJAWA4wntdGTPNWcesJpwlVWqi50yxmFS06DYtLbLmW3K9q5atkbvSmUWzNOP14tY
         9eW0UNJqloU5K5gYRvDMLJRpOtJNJBriMe3me3VOMcLvs3gtLKCxhO263V85HwGua34F
         39BKfQVOkehCakkHyciFkw8fyR8W7/JVYuBgMQ1OPkCtA7ziFWquhfynAKZAhalgXZ+1
         U7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785146328; x=1785751128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mamcx34JMeLjC6CN46Yh4hwjjs2Agi/cyzZ2FrLvP38=;
        b=WNsAPE/Vml0PeltaHKN8lR7rTcs4L/1Q28Qe7QJpiFfIE0ZGzNT/KtWGKihJnfTcOe
         esXHz/X9OdYD4u7szdy/gbOM/lOju/HF0JcbYMmAcxnaJbcmwRupzPPYh4XFWMG9LU4b
         tR/XD6PrswxGG0NNmpxc7N3RKaYm7hsEZvVXSoQQrYP8bO0egoR0eL8hg+W8w+eJiMlp
         Dg9zRQ2ZSJnj9gWl/I+TnTP2v7mNRQGLhxBFzk2RKl+Rplqh4+r4PevRYg/5yY/kYi6F
         AWKbgfSWqJZE8bFWvVurPO1PLkC3xzl2Cvt/+kwrs9LrhZBLnlDXYBiYde041cl3UWZE
         N6zg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3drowE92+0vZZKOa1S6BQ8TAIWNF7Wc5QdEL4AVozt+j+MKZRM9AsQhPHgj13ZylPWXHjWocOr98=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKEHgXyfeqXWT/XCWL5Z2RkYXZa6nIlUORQX/s2aQ4C82Smq1T
	L0LMb3x861nXh+wzekRoTn8MdkG2lMLQxLR94wAOeFKlCHVr5DD1zmac
X-Gm-Gg: AR+sD10v2z6sNRLKSXA753CoYrFmAS/O6RPOxGWL6kNITPuUdqJCjv7lWe/kDfzc5k3
	u6PYjHffL+6aFPA2aDIEtChq2a9Xqm3buPSOOyH0ew7tCMxSQJN5TyA9Ka/9ThinZJXJFQsQqMV
	G6Kkah1a3zb3ZWh4bvw/jfzYd0ZPIZHOqt25txA7NrYC1cnObfXCczCKbDzO10mR3mIL0H3RaED
	a2+FibTzuO/jPlhlnD1t2fmzTL5l3P9Fno2JOzRlmHfWDXwFXaWoxrtAGWC3w3MBD4KZqWzgpmC
	qMaJlSQcb6L2CFeatmxbY5Xxw2guO6MYdNh+MJgINJlm5yJDdBuaBr7Ejegsv8VOBvShkToL14s
	oez3roPAASc4GJj/XR7m9Md1NltaiPAWNSEnKia1AR9+NKAji8pz3mBdexnAzthm8wHwxI3lxMA
	NRndQHZ9Ud/RGPDJWrz5dvYuqK2AYR16I4B7QnF861e8hhBsZJjoZkGYTQRlT7LMueId27NuO80
	/amKtBnvkeSWjrp
X-Received: by 2002:a05:600c:8214:b0:495:5e07:649b with SMTP id 5b1f17b1804b1-496b570dbbemr95770795e9.24.1785146328138;
        Mon, 27 Jul 2026 02:58:48 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:8281:5343:33a3:cac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957b842691sm238346295e9.1.2026.07.27.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:58:47 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] PCI: rzg3s: Disable refclk on probe failure
Date: Mon, 27 Jul 2026 10:58:41 +0100
Message-ID: <20260727095843.116950-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260727095843.116950-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

rzg3s_pcie_host_init_port() enables the PCIe reference clock using
clk_prepare_enable(), but if rzg3s_pcie_probe() subsequently fails, for
example because pci_host_probe() returns an error, the probe error path
only releases the clock handle with clk_put().

Balance clk_prepare_enable() by calling clk_disable_unprepare() in the
probe cleanup path before releasing the clock, ensuring the reference
clock is properly disabled on probe failure.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v1->v2:
- Added RB tag
---
 drivers/pci/controller/pcie-rzg3s-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a1a78bdb7af1..01488660ab08 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1897,6 +1897,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 host_probe_teardown:
+	clk_disable_unprepare(host->port.refclk);
 	rzg3s_pcie_teardown_irqdomain(host);
 	host->data->config_deinit(host);
 rpm_put:
-- 
2.54.0

