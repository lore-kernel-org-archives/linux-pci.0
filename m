Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5A390200
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478491; cv=none; b=JhvOt5wck/MnqQ20h5IeddC4jg7bf+cgBU895fb4oZ2V9qMkiCL+pZN6onpEV1obxdC+VB1FrQW4oKKatiSAAt3YU2Rr2vqm9yT6SQv7hC3rp62WrFsEL5jfXRv4YOBKsw22s/bD+BbO0I7Hvmly2JCr/jng0yf/rJ9FfptnVEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478491; c=relaxed/simple;
	bh=M/Ozed0nksdp37DPAu/RhSqJymREkLvE40C3ZrkbZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcAdJYiKtwZ4vPpbz3GxSsG1F5xznJkPpLPVVpy4i1HuQuWVKKg7m8SiHhGriCjMWl9ZOmjOrON2z8LIvqWHclw5TV23vtmhmS3jVNyzkd4OWnO4R0oSZx4PkTiOy8NDIdv81oy2Y3z7cKWXaxafCeFKaN2Ujtcux1BTRvTK7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7lCBjCe; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7lCBjCe"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cbed97fa26fso229443a12.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786478490; x=1787083290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wMP0hddgxDRJDSmMUhN6Ff8CjFaNmUc5wsXEddg84DA=;
        b=S7lCBjCesVWhqzZW1QlBnGRkXtEHCVVxO1tstZdmNcc+oYVLlqZOILxg+FOZWvmcBP
         HB6P5h/ZIDUrmDmCMkWKjal87pSxdbp5+GjUsGEg9vtjZ6bBWUfbR0GijLjiYBrUzDFV
         klvVVZBMqBHAcjPWNBFOnqOeGFtSQ/Ptc2lXfsBTlWksq/Sa+8B3TTFjZ3dgs1+SNIsu
         W2+JGPCUT4+K6zhvVGInfNfXjy2Yvc1hT6r2Cchea6EYBmWNR+bJOvj5tOlyTXT8iGfA
         tbYGu/GAyh/fczgGFwQza3bkvU+zC99Eggj1/0ZGFVNW/RQf29EILtwHzhZGcbC6vNLs
         92TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478490; x=1787083290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wMP0hddgxDRJDSmMUhN6Ff8CjFaNmUc5wsXEddg84DA=;
        b=S+NtBbtwXYW9XaPVe+1FNaDJERHZ9Y0JZUrk8tFwMXnzTwZt9HBxnf0ND9yZKj14Kb
         HzvIy14zm01CyGaymgtxeEqnudAqSjYzsB7QdyqFjJeqzma674/+/hp9PBWJeW37pu3c
         8mGg1STp/VLfKLYa1ty/AMC1OpaoVqikIaeh8pBhl0/Tn+zLVYcX0nZcAhuTHnSVhV6x
         lfF25r2ek1q0YNoH9A+jKiNAgEeDsK2jlYrejM2J037tCBnRE9MMjNKQ9bDMDop1efbu
         Bk4jUbru/12FceiOe849Qt8h05/f7W4aA3gH8RomMObfDnYoDoWgYu13ZhQuifsyBARc
         Fr/Q==
X-Gm-Message-State: AOJu0YwGk1p6pTxl/w6BFMkDliln1BOk0iSSVvO6dgP+x7fjLTjy8ssb
	AGZcyGk+pDpHr8KbpVlcuTaTKPAgPPmG4M63Nzm9zt+yDCtphyBtRuER
X-Gm-Gg: AR+sD10r/TnXMf63btioaA4B0Cw6gtrjCztqvNBalLqHyVvYOFV1lMLNzUHF9bkR+a/
	F/KKKyS9TZFo5/rFpdxTPsx38dpVdnmzBOTMMomM45t/NJdyiUKYe2r79gqOrrGy3i0FwH08vbq
	qDoXcKbMnIkZnBevtmlVuKXvb/iOR9h4pQHwDTnB9AxjrxcqmHU5lZZIFhIQsPopfZZJC49MFu0
	kuurFOv8qaWcc6r3z81rVTR1DvbE59BexUJe4x7+1fCWBLn8YhQuGnHfbTINKiiU++cS6zOy5VB
	cCboGwHg+h6RHB/CK9qSYDdUjhGOdYE4AqJMKyI4uupNpcVYmnqULC5dJGg7BtoqhZC1/4giUPp
	fHc771nW7Pe3APEnl/b8zRxMUSQw3JSX0gKfptTZuY8OvQ2qHiQWEB6oHZeQeUe3timfjWKJIWn
	KLXneIYX3ZuAcf0WR9Sjv7rdYrX5jIiJ5InVoVXVRN3XGurCWT0uYZ7of8eiI6jnvWkDg2WShLA
	71D9UslQlZmjk57l9/R62Gpn6Csr1ZEuv426mCsHBXH2tmZufaD+1Ufb6NV2+LSIbYE4LrQ+pnF
	KY1DJgBM0g==
X-Received: by 2002:a05:6a21:3117:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3cc377db1cemr3874600637.2.1786478489770;
        Tue, 11 Aug 2026 13:01:29 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c07:ceae:5da9:e5f2:ea74:b6c3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf6791351sm2216447eec.23.2026.08.11.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 13:01:29 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: rzg3s: Disable refclk on probe failure
Date: Tue, 11 Aug 2026 21:00:11 +0100
Message-ID: <20260811200013.185956-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2->v3:
- No change

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
2.43.0

