Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED37501284
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676387; cv=none; b=F71/mmEMfoawNSAFiZ6uwfhJigTJNXDtvRH8mZHJbiMbyBpSbnj8BTNpBOH8/UHh8h7R4WFI7mh4B5TzbN51eODiRaH+wOxmnKWrnW1N4wiiJHnHlAJpGh9AcZiB4jZCf5QINmws48RaXM99fwq9Y99Z7oAY39s1oQQmREu2D1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676387; c=relaxed/simple;
	bh=ShugmlWzQ+axlYeISSDfAQXNJTdMsRRo0wVSobYI9Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nbYTglypzYwlYzOPMhwG3VHhNkoZMmDHPctNKOKbfj43twW3HDkBuRDgkJXGFCIpXn9hI29yQWdI9rFog+TjcudXJZCFR8ci3ju4VUurec1HlVhHZHGABFQcLDECT83xRmmLlvTO8PzAyg8U73/Im1QGbUB5oq90KvHipwVreSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=RvTe9qwd; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="RvTe9qwd"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so29748525e9.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676366; x=1791281166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ukRavR0+R/g1KM+J7IJTcCj4Xa6LxCCXFXLdFwBmwpU=;
        b=RvTe9qwdS1wtNDCbRIsnLKiGnXTSYhU2aArwaWST3kti5NAgzI9/ti+VrT0JvAfRUy
         EIse878ODl5LNjlTy77n0YsyRPZtmaf3zbrrpDUCKMUrcvxI8DfyuUXuxn6hsBRz8eav
         MofcGLgEhgR2cL4LSbyD27ey4vcmTXMRe16OVWPSYGXmvogqaP+xD8YT8xVb3p1M+BMV
         yvq0Nz7aBFW/FNB2Y+/hayCxVbXb0aQUrKZKEy5hOjVCIdY7+YSOE+k0oZjS9RZKlkmL
         4pD+ZxX/9Q+COGYbNcF0vMBJWrspteZ+G27rS8ku0uH77CX4/A0RJLCRobao4efjIA2r
         q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676366; x=1791281166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ukRavR0+R/g1KM+J7IJTcCj4Xa6LxCCXFXLdFwBmwpU=;
        b=tXO8GNQMoOpOeGA4n9XIa9KFg3HbZWA05ikVQ65Jwu+77Lm/5PtugpN6nMwp80vZN5
         Xptf0K2JmTSbQ9+fzYsQec2JfOcEdNwOuuJEw76P8Oza5RQclPcLcfmboS3qyGsdbXNl
         W3aSwPNtx8O4xZBiCtTXWoAD43P27pdxm/lkzdS+oHSdVeHF1pSzsNDglPdR7vt+hZCa
         wcRB0IFxt6JCOYKmSWqe3ALlxPmQ3pRetLAFCD41/eKUpg2r63qRy9Or2q/DX4GKusdn
         d62w5D8I3LM9HN34eNadxW1W2204c0bGdJ9vTTYObuy9Qmz5xuVZXpZzqtupKRk4l2gF
         Pjcw==
X-Forwarded-Encrypted: i=1; AKwUvBziF80KV/LAPPUnrSV/lOgh0nHM6wsZYERs1cQUNStcNTDF9LVFlpz2393AeFadr69W19PPbIadwLA=@vger.kernel.org
X-Gm-Message-State: AFuF++kXARZwSmIEdei90lm1xjO1TIBwu6c17yOcNiPLY3QFTN0sRHkf
	i1QW+lb9WWPLpynQmMuF2EaquSvFuCk6bGR3qSWLZixTMA9ns1C1e+sfQQYNWpNFPTY=
X-Gm-Gg: AYBFou2aoxFbweuSDSe6tL2qL4DDcpM72ixVC9xxtR2sTUiPzhQn+OliBhrs98cqKcK
	YyKUL4pfQS4Y3Wgtrkr2JMPEpvUo6exmWaGt2WZfhPSWEegSavpW6gZdxoXUn578rSgMpRy6rJq
	YE5ybtXMURSUcC+hW9wU7uK4uzs03ImQhWVTDsygeZNTeMZOHoidP+YftTqWctyEeVaC9nMYrZ+
	oFlAgcCjzF/bT/DfqMMCncuGi9cnhfqmEo79yyAuBEWg8NcFl7IMSPqHS5MMGg1AWKqQ9BtuzFJ
	xyUtdT9H9Dun2M+zDlms+nVtc5O+IVW++hWN0eQ1F4TxVXtxFPJ+gfD17QFb8RVi4xNED7ieSUG
	x14FnoxaY2f9Xo1oX83DOmt1yUVYi6q0tsKFZASowzUC06MPTMC6lhm2P1uz5vNZL1yxE+ddWCY
	AHJYf3JwiFrbXt2YpIe1zUm13IUuaAFp93OwFOP9h1v/0sKQqa5IXpoWVwGDlPU5lK1xG1TwEfw
	544ORfD64MrAWL/
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fe66f9fe3mr275023955e9.31.1790676365876;
        Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:48 +0400
Subject: [PATCH 3/4] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-3-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
In-Reply-To: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Corentin Labbe <clabbe@baylibre.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ShugmlWzQ+axlYeISSDfAQXNJTdMsRRo0wVSobYI9Tk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m15c+pMVMvP3nmVCzY9SDy54GzM04bw+nyrExdDN
 4lf7QwT7JjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqi68wMsxI18jebmlg+G2XWuSld11BNwUXLzhvdu4BV43+y3UyJnsYGdYwz2/
 +37siqnD9lao/K0uSyrjlHCKu6x9m8l7JoTqLnQUA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
pwrseq-pcie-m2.c never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 91916768e922..0febe4b3d980 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -613,6 +613,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 err_free_regulators:
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 
 	return ret;
 }
@@ -626,6 +627,7 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	mutex_destroy(&ctx->list_lock);
 
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.55.0

