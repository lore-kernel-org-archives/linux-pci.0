Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5634FC8FA
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676376; cv=none; b=hJAn7SnIv/mR8yzee924lSVnrHutgIoRMOoRWksuONANEKVQIUFX9lN1uEjyrn0biMSO7cTHfExfR9PpzOLkI+WOav/08CY9/vGH54GKXi3wiVU9w8u5ZNtstjVhuXMmX1OwAEZXag90mXI6lw1Xm3d/qPsVjO/hLG7rAzsXnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676376; c=relaxed/simple;
	bh=92VE8r9mzYOK8AC7tCzlvbIDtHDlmpg8zlN0tg/3Zcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVFC3rhryE6QkoTXYM7UyWH5MtygslWaCizEQNeV5WdbxVamh3h6NrFlpxRcPkOHUdlaK/VZ3GKByDww5vJsuKNXJ3B62VXyaOvsLQaUKHUyjiPEq0bxD2bVfUP3EFqDcc7KXXWzbdSghGKatdT+Ct4NOuZSC8NR42+Rrp0G8JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=tCmaeZVc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="tCmaeZVc"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-488885c3844so436488f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1790676369; x=1791281169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYE9Edgd99flwjX5TMY3XUDStNFD9sn4w1TpgBQJ6eA=;
        b=tCmaeZVcwD1h4SN5M1Br72TaRuAmYEW4hEWLCPrHRMeF5IQ+pFgP1Fp+luyWIsRoUa
         sm93UFzFNsNCxvaK/rOFbHeSpB8DG/GHYP2P+MizdkIImLgM2re3cPR9e8Hs/CTxa1WP
         qGNxNP/kDhAXUs+rd10VA5tCsi9/kvAb79EQo9Jyhz5YNkGPKGhYgXUDSNT3bAcIoXja
         Ej7l+WiittEMl+ZPLnHrQJvttXngWppVU1vC/ahPVVzX7LE8d1+rZICW57HFpC/ss9Jw
         gXYLFQnFX2rBKDTABWnTQC9uTs6zhWvQeW6FoujjErrU44uLwonaQRjd5y9s3rFFz0u6
         1sMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790676369; x=1791281169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eYE9Edgd99flwjX5TMY3XUDStNFD9sn4w1TpgBQJ6eA=;
        b=XH+roKOzOg7qsyqkNbHhVB0Pu+ukBtoTtT+4CLevHAD57pTPr+7+r2oapknjJb0QOE
         wxRVH23onVn9nQD0sMz+HWzbXP4fDIBwhOMG5gNFEBRUF2gpWScadRKk7EE6akxa/r49
         2vf/xDOIa5EDbLD4qLwrIsIxODv62h6dl/UEKLX002LyvyL0jg31clYmlQuEnvG6uPZH
         8wEVAz6fIdoBDI6yfQbjKOMXfliTxOPRndGJXBubj5RDIRILd6/FTvMxz0wpZ8RSDLb/
         ktq0TR9yzcFvfhuXMdIUF/ZFCMkDNjyRAXMNcGPchnhmoxftVL8yhar2anvaMGm2ZGnF
         DhzA==
X-Forwarded-Encrypted: i=1; AKwUvByA3C3k966NJ06KhMTdnuD+gqdzWWsTUio5nOdNyZZhhP/0R/xMW2D3eQxlvRPTbUraldPOH8QoI/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxVIQXcDLzYfm1LOxa2qDS1RVPXMKvd6s54NKXPgCzEk2Q9/Dh
	iAGaLMIEtoeV4AKb/qmbO0ehynXwSPuKQLYApcvszNAUTcgqig2KEUM4qA46hgCyCl1+GNHBijr
	NliDO
X-Gm-Gg: AYBFou3fmtB6MQb6yC4Y80OwGPmp3raEpITyeas5XexrYO1TMoI5Az3ZnjeezGV17N5
	7PAHqmKMPo5v1SHtddQZU5x5rxDnyCr8RvPfkFgZXL0uHUwno9enHDH9jY96Gifyhp6bANQAz98
	1jBvwrd2tJBwrFx0HdHzF9MRY+k59dN2ena63hVeSG3T2qkm+1x7qKbrGBmiebEdk9H1VqcVG0j
	2Hs34SqkvHrD+xRrFWwGFAiTmjzYMNMLCzxO47Vl5vn7TrNPmS+UJQUZnvVTBezyqDdITEIlVIR
	Zb5jogEaLqhdv5Ah8vYzRDwEuRss4bmclbSeFpSd+ebQonSWdnQgbEF9Z77EYxFseTWOVBS+uhX
	COTEc215zT9r6RcCskNeGmRG+WMgpmQ3KbwFKvF4aGeiUw5WhosTnKAwldsAcBjeU2JRkXkxAlw
	61ICEhXuPMjcKYyGE3HBmct5QMKU4Trzn7QAbd7Kufjp/p4nBibdvr8bvLbkNd8fjc3YlMW3ql6
	lTseFwWaiXYiBsf
X-Received: by 2002:a5d:588d:0:b0:488:80ef:7fd4 with SMTP id ffacd0b85a97d-48af1b36244mr3851230f8f.7.1790676368816;
        Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.93.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af502f79dsm2954995f8f.6.2026.09.29.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 03:06:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 29 Sep 2026 14:05:49 +0400
Subject: [PATCH 4/4] PCI/pwrctrl: generic: Fix leaking array from
 of_regulator_bulk_get_all()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-regulator-get-all-v1-4-e887c66a47f1@flipper.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=alchark@flipper.net;
 h=from:subject:message-id; bh=92VE8r9mzYOK8AC7tCzlvbIDtHDlmpg8zlN0tg/3Zcs=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTt7m15s8EzK/JN78xJbtPerfnDtOuVWBHHzrrMAwa/9
 y66bdS0pGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpfhvK8N9NU5T9zdJA/U0CAuc6PuwMPCvy3y0kJCg083aWzbRMpg+MDM2xKRm
 v2RbL/j/53Xr5u69rZfcnZjxZvzw9q34df2rwBm4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

of_regulator_bulk_get_all() allocates the consumers array and hands it to
the caller, who is expected to free it at an appropriate time.
PCI pwrctrl never did, leading to a memory leak.

Add an explicit kfree() for the consumers array.

Cc: stable@vger.kernel.org
Fixes: 75996c92f4de ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/pci/pwrctrl/generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
index d56171e0ee24..4b6cbbb52248 100644
--- a/drivers/pci/pwrctrl/generic.c
+++ b/drivers/pci/pwrctrl/generic.c
@@ -63,6 +63,7 @@ static void devm_slot_pwrctrl_release(void *data)
 	struct slot_pwrctrl *slot = data;
 
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
+	kfree(slot->supplies);
 }
 
 static int slot_pwrctrl_probe(struct platform_device *pdev)

-- 
2.55.0

