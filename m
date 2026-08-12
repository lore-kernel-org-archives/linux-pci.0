Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E6847DD47
	for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786555378; cv=none; b=kFhioQkyxvgx7NkUQmTiM2IB13CYg7+mzYZZKrKrHpi9BtkpesiuIwe5y7DgE0cN7ZeQ4nYQDIB0W/vAkaUTg6mb3Z6NWB5FGCOKjO4MVF3G7e0oFy8r7Tdd9gFDgmiQ5qaW4nIa3KBzXRMbLAXeryiRmRDf1bI6TzZAQGLfUdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786555378; c=relaxed/simple;
	bh=BtmQtSAcOc1sMwXsSXHd/N0LJhsNzGr+XDlMMcgHhfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T71l752RNpGoefvGSRkBIDMiTQBYHnss1S0BnWB0qt3HPIztVUA4r7rBPMEixBBE/QGFvrjzYO5tq3+NsYfwJoj4+E7OssUYR63ru3NGXgC2UsxLMU4M2imKhCzaaLdgufbcxzINSE6V9Tx7NwDcMCw7wint0qmcwYx0i8hz1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ub1ESb4b; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ub1ESb4b"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e54f8c051so57318285a.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2026 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786555375; x=1787160175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H/KJ6sckLCdEVJDbpdFqbeYqPNdthT6c5yyUBXrsMRU=;
        b=ub1ESb4bq7Cw5S2kHeARt5oVAtAfhEkHYf5hTHxujEMAKKj05skRtsyxjj4HleHk04
         R46hlXOjyEKIveU9dPsl7vVUHhs7snOKGkLPBOYfre2uJ43UOmZd/LcKtDECa7eJ9hj4
         V7ABs4tltxlN4xxFYHSrf8KJC7SNz4pWxLvXGMnRLIv/g3cYV/s3pQGgJsWbYwRgoRb8
         /K8l6wem26pXXzpWVMC6qswKJqfrwAtEZ7N8bqy4NJMx5Ee93ABv/W0wTvuZrqK5fGnl
         LaIZdYihofxKMzrF35tVwA3TL06A3Xe7JuQyzuzHTa+s/IsLHXDHckczoAF1AVEkMYLn
         DjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786555375; x=1787160175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H/KJ6sckLCdEVJDbpdFqbeYqPNdthT6c5yyUBXrsMRU=;
        b=nep/1Qyf3Q1rSFVpDLFieh/hygBV6+0kh+AgTXD0J/4jrDm0UWqo8h6dmL0tFCnaJl
         HgBa7+OPTX3p27oTaVKfenKCN1YsWLWCqJWRsRuvjETVKX9JGO9n8CIQ01+CVMcsm+WS
         Abx7Ds+bF2tj0TxtUW31LdD3e5dl7qtgqIkedyXoB7xDpgyTrD1C58C26AtBG+AMEL4J
         XV2D0camF9ZtFOnditmldBpSs37gQ1rJNx7zMn1LmiJeMb6hlNsidgFTNtUhUG93zbiJ
         +ZMHobqJEVJmlQaJYeY/SnmdGdgfeWR5VxGfdy17wewV+WK8p3+zeLcmkkhqfpes6vn8
         nHAg==
X-Forwarded-Encrypted: i=1; AHgh+RrSao7NYpOItVyjLNgatv0QQnlls/i9/yNaUONA+cB01U9+R2Gxz4a5phv+YsC2UweKZd6FWEgVtzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0gJixd2pzEc40xyfbEFnHr9oeESH0e+Ud6ieMGTjAJpEODMB
	wIH+q7lQGZEoE4LD7qCg0PzYERReVQIUPS/RwYFWTDfJOk9Qy2YPA3g53iPOSw1wGBA=
X-Gm-Gg: AR+sD11iKCRVz46IOXSk6VRQvwB+Ejx3flaRZPWw1ogE2ay4fKmeWF7CqAD2/GUU3KL
	amIxp9xr+rurbZv8f6IDkuxJ5cn79c9HDWd12/j9NaqWUsgCN4q6+8TyZYPlRqx+6XbCdz9NoZa
	WH6DAE026js5mXyNZMigW46FSsYyaTRTUJCra7YlUk/FDlwRVAi/sDg86au+MMcxq75WWGMBYMx
	RLOED0H96k/JR4Jj1rMmF5ZZ527HyFMDEa4c5sd9cahOgln+EzUeT8A+DrHmLqhU3GOTrKyyUBi
	Bl0NpFvM0uuwhVBDX9GXvnfQRTqNK20KQBQYfgRhWyzghNTcIap8TIAf8XG0UQwq+XbrHZeslCn
	rkM/p/4hXeuseZrQwZ2Qj/Xd6qm99RYtjp/jelSnd40jMUT3BSoUJfHHtd64Z7f/gf5QYK9TNbZ
	94GY0oNvBM+XNCLe+XZUHSx0EmjHuwpSa3/2wGeiDzv/MMuKCTBuxr9ztCTJmwTT8r
X-Received: by 2002:a05:620a:45a9:b0:915:9e84:85d1 with SMTP id af79cd13be357-936b3d3ad7fmr560175485a.23.1786555375639;
        Wed, 12 Aug 2026 10:22:55 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936b5f720eesm173587685a.47.2026.08.12.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 10:22:55 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: bhelgaas@google.com,
	robh@kernel.org
Cc: daniel@riscstar.com,
	mohd.anwar@oss.qualcomm.com,
	lorenzo.bianconi@oss.qualcomm.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 2/4] PCI: of: don't zero flags in of_pci_get_addr_flags()
Date: Wed, 12 Aug 2026 12:22:45 -0500
Message-ID: <20260812172247.276554-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812172247.276554-1-elder@riscstar.com>
References: <20260812172247.276554-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flags variable whose address is passed to of_pci_get_addr_flags()
is zeroed before assigning a value to it.  Skip the zeroing and just
assign it instead.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/pci/of_property.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index 505226b876c56..22fea1905a080 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -82,12 +82,10 @@ static int of_pci_get_addr_flags(const struct resource *res, u32 *flags)
 	else
 		return -EINVAL;
 
-	*flags = 0;
+	*flags = FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
 	if (res->flags & IORESOURCE_PREFETCH)
 		*flags |= OF_PCI_ADDR_FIELD_PREFETCH;
 
-	*flags |= FIELD_PREP(OF_PCI_ADDR_FIELD_SS, ss);
-
 	return 0;
 }
 
-- 
2.53.0

