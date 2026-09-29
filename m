Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B84DEC0C
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676370; cv=none; b=Inf8fF9CvqyLrPorkM4Wy6Gdzj56w5AZF0lNaMfFy5SlXIS6hOuOTPj2BS3z8d1CXyDiD5P+hwN4gmfyo6c+PdoqqXAS3YIFwUwa/X09vSnNlKBi4RyCHAavrcPuOaDXavZvllunRsohFa78ebc6HsAK+fYjpGaMo76WWerAxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676370; c=relaxed/simple;
	bh=qOkoB1UvmuC4YZqe5Fz1zEEcDa7BiDDxjJDSjZCF8fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkxBzgggT5XhKfd6utwJqGVtsQj1/71Q9j/ck0H6mBlXsr0agAQ6OJPalIeJPNQjlotnihxdC7VIG+chkqRBE4Kg3K4JrzNTjHx9RARfmlx5+5PpFQeBgci2NfPFTChS3pZZjlKZE3lSNlD5O66tzOaz6nkFKdmabQ7gJnAH+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=B99OoG1s; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="B99OoG1s"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4888129c46eso2225276f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676363; x=1791281163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPuRlti25Fuu3NRfeKW/Nl7M5gDTcAuzPve5dEthuXw=;
        b=B99OoG1sjwpsNIExhUSsPk5rt/KuSYlxeKgYVRIOTHTbcgkOpb1nWwn6wsMwH0Oz8V
         o/7lLEIqgfC0iAVSH8XgRvUTFAllJ+r+394YKMpn041IesDXWJrw6CJekFTQuY9e4wfl
         F65Zg8W1xWrdtMIrVXUVPlSXjlgnCUSAoYtze6gZFbf4tM4Ysd+21NvuC+sYJnIAaqaW
         qwdUHu1fx71eZKol6umL4LydGHyiPPNvVtw37MX5+07gZogfsrjAflmYZkQ9a1a50bq3
         Ei6JmnNBRYBXnZU/5o1zEv4QyxdS7qcKrMLOeSY58RgC4rETnJW/KghHyeJ+70MB+Jml
         ZfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676363; x=1791281163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPuRlti25Fuu3NRfeKW/Nl7M5gDTcAuzPve5dEthuXw=;
        b=aAkDZRlwqFE9JKAMAS7FMeKN9kHQBsYz29l4AXpj2+W0jjAH9cMROhapeOAVGTkW13
         XNPbfY6+lHY+ILWN6wyRWVmGK7rZTIqIsnZEzeGqpAv1ZZVdMhiamm6h6GjFsCa7Cvmb
         f5XVoWiMjMlUnm1IziDFrW2PUvgO0tcaOAaxqFxzbovcAWiFFPBKs7GNlUAp7mZoB4Gu
         hxmHepR9GvHbpDcP6P8TDUvGdzJLtqJ17ldaTJ3lusezt0cCQgv2EXVeImHokboO6Wma
         dS0/+G8xEUKkOriG95AksFAy39Ly8fPfPFwxM79GZ8QcFely8BGwy/d+lVkRFEGff33v
         PvWg==
X-Forwarded-Encrypted: i=1; AKwUvBwwkw7LfQ3DzffWNAxPfsgNcajD0IxKapjX/wTGALugkoOr8c3t/eEYnd6oIrcZLDzgKDEjHmlbKUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/r44SspXQYoBFuLI+AJNVTahaJ0LYWNsYWNVBc5QeO3TbP11/
	oxpb0AYx2Bp+j8wEoBfPlAGGqhtIkVgFFWio+1Fysa5k6PpkCqupWLf+0/hV4Rlk3tg=
X-Gm-Gg: AYBFou2BqIZu3TH01oxrvN+eV/hE1cvobKbPa5IAb4taKBnmBRqBfRjN8vo8iEl6Dan
	ayW97BC6GJoxMRMO105Tcm6gV3qQN2d605noyEEGf8dHzOsq2+YoaWRPqxhW0pfkSPDvgWCQ2yp
	BIawLrhIHPhcMEWPF+m6OEIowmdvPEAc6T4Yew62LOuEx4puZGPNOYUPxs7FE38i9nB3QUuYyMv
	wQkF+7Db4AZKE35z00bMcyNw6ikssO2zh81vgid2Sq5yCSM9J2wdfmQL0d7fdKljZLNV7aDUhpj
	nyJqTm7q/NS0ZSdWVXTlptxFsnfMFmvjIr8wFGogi/4Qf7LzaFD36bW+BxVGXSsHb7cMoOYd7Dp
	MT+yfVdzLhDmNy4J0dGFKkgmmDvnCqfOXs/fXchddyUMEN/yKfg32y2NxVhNmDYc/ZWq/SAk0lj
	m6KNitAZD8aaRWUvI2iRT/ZhQaC3t2pLOgqQ3+2Gp9zP1yKhvQskOV3c4C9SrVKNgNQ5vh5qoAs
	ppR6zdMaJI7/Eeb
X-Received: by 2002:a05:6000:2504:b0:485:ac3b:4a79 with SMTP id ffacd0b85a97d-488716a1af1mr29004379f8f.43.1790676363094;
        Tue, 29 Sep 2026 03:06:03 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:02 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:47 +0400
Subject: [PATCH 2/4] regulator: of: state who owns the array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-2-e887c66a47f1@flipper.net>
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
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=alchark@flipper.net;
 h=from:subject:message-id; bh=qOkoB1UvmuC4YZqe5Fz1zEEcDa7BiDDxjJDSjZCF8fI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m1Z9Zv1RV2w79x3f+tfB33/dH7WkgfOOjL+v5pWb
 /dpfafr1DGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUt11i+M1W7xUyq1a993NijNvBFa4Pz3dnSzZuP/B/Xf6G7HzVgNOMDBPNz+0
 4vmpjcfa2gqLJ/yetzvwd4vzok/rE+GtPTuQGPGQFAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumer array and hands it to
the caller, but never said so. Its own error path frees the array, while
regulator_bulk_free() only puts the regulators, so both callers release
the regulators and leak the array.

Spell the contract out in the kerneldoc.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/of_regulator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 785b7a11dfc6..09e26febfc83 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -929,6 +929,11 @@ static int is_supply_name(const char *name)
  * before returning to the caller, and @consumers will not be
  * changed.
  *
+ * On success the array is allocated here and handed to the caller, which
+ * owns it from then on: release the regulators with regulator_bulk_free()
+ * and free the array itself with kfree(). The supply names live in the
+ * same allocation, so they are gone once the array is freed.
+ *
  * Return: Number of regulators on success, or a negative error number
  *	   on failure.
  */

-- 
2.55.0

