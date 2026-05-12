Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310F395AEF
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581082; cv=none; b=ZHo5kNlEgB7VekWw6xpt44ttysGuw1UwTO0+2i4MZhVEGkcOSYoHZAlLuRv3TECZKcIbvafKqsQrg/FXbweh8j+dU0CKGnuKud2FEsFU9V385nRW7+l4NrnKo6EjlsdUdVDDRGJ7DA1v0aj1ac31nsgDvdXLjnOIS25PeUsCOMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581082; c=relaxed/simple;
	bh=1ihYxeZy0xVM4ZTgNCYSrPgt5wfbDLc6o4wFztW63Us=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jn89x+Mm6ZVhzk/5egANltWFhjZ56hqSdKmbIIkbvfHE2Yr8d0TWLfftC7/JPqNux0Yi40xtHOJ9aRhcZHJG3RC0eYJPuaEokCa7l4PGIgmFLXiGh6+7ETntcMMh75xcE0t9VaE0euIWCpi4hQKnuFCPndR6nfLpWvJmqVcOd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esjjwCl0; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esjjwCl0"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so56596235e9.0
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 03:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778581079; x=1779185879; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BPjmQ+e1w3H/ZdOVio7epboMKxq2EH1m6tGkpmimMY=;
        b=esjjwCl0osSmx+RA4ehzn6n7aLqcdNz+6/yp79ri/ENWuUFygsWNf2d125LBUq5FPi
         AkVWWzxFc++jxNtcfQh08ppm3t1w7FsjHyp+2kad9pEg2SJU/vpsy0TE9Hq4B4Fwv4qf
         lmqevuIMgI5JJUllh6MJQvvaltgZn9abPLo0UscAAuefs2EFjq6s++BYgK1Tbl0w7vct
         If/LAJ9oYedE74mTSb1ZK/Xo3MLbACL8MVnL1aVXADt9SOpFPth9RwR4PedmLS28jKcP
         v1SdxFXslI2BfpPo+zqrULfrV5d/zqDk/QVZU+BmCOlW6YKRBeYbVTUHwaAqy7Z7cDSG
         gbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778581079; x=1779185879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BPjmQ+e1w3H/ZdOVio7epboMKxq2EH1m6tGkpmimMY=;
        b=nGbnCTp2NUI1o/24Uz/QbS5trKGXxVBrE/aXUeDNds9rCBWoyD3EkiDMkrzby8xxzQ
         upP3keCXOEhev+2c9h5vTxAuId069BCngxhvqGesDnNUjHV32KaRXE13XB9aD8dSA92n
         /PWxY0m9+dhbDsLGpnB7KbsGe/VS6oiD2XbnCKuIUGVdQhefoXSpPhcqznE4ZufQqj07
         xtLrpmb+ISsjRNmOVHLQD78atHjTtHIlgidiBKQtwRuyDDAc5BHQRSliHS4JGO43Fe5s
         +hw+LRYpuZMeOzdiz6B71zJvi1cpO1HKt6P7O9bFwKccItALIXuyo5VOskvIgrAbD8Zd
         rjpw==
X-Forwarded-Encrypted: i=1; AFNElJ+Bz0vVDG+RVzjFw8KQ/yGsA03hTIN3fkvFpk8yOT/JRezoOhwPh8IH2ZZCJQAXPAO0wFuzB7WuyQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9L7ipRarQrytug3HNBJdM6Lh74g/HyoGswbK5NEc4+UtjF9Up
	HZlMEJt8dV13elI9yWKwAprB0je6+dB4WJ9MHGWBlOEbkR5ComC4HHeIRyvOcmmLkaA=
X-Gm-Gg: Acq92OGs7EWJBXJc9+IcVRnurMzY7UcIht8xem2W56ITwx0y+C6orp573seRurNzYB5
	rSegiPR7lRCIFoFqJvYxm3l/BynmjDTmmFl9P3PF6KfTtJx7uqUj8eeukc6FwbDLTqHUl0+aBTh
	N8iul7mzIM34OoiQmXEBle6qj1cS0exPYLssGimeBgA5lgfZ5SLS+kzPryGGfxW5/N/3eYlwmhb
	5Ixfo4Pdipnmt8Z+cwirlDPpYSR9WNQlHCj8URr0kdBov74qZZhsU1NP/aIe2cLIlwpLcyKym06
	RG5v9xnwEXRYhDF0XVbKvGGQ+YFmKH/lEtxdWCUolXQu/oJ6j02em4lRL1ontWJhWRH5lPwSdPH
	glqi4VH/LP2ra4YRGY0jSnfM6GzUnqOTZfHT7b+BINf7KuIis17Ffyyekk91n8v5aDFmMWGapMi
	GnnICDCnvhRbD/wNB2r5E=
X-Received: by 2002:a05:600c:474b:b0:488:9e54:94c0 with SMTP id 5b1f17b1804b1-48e8fe5017fmr34845395e9.8.1778581078730;
        Tue, 12 May 2026 03:17:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm24709975e9.1.2026.05.12.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 03:17:58 -0700 (PDT)
Date: Tue, 12 May 2026 13:17:55 +0300
From: Dan Carpenter <error27@gmail.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Fan Ni <fan.ni@samsung.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] PCI: dwc: Fix signedness bug in fault injection test code
Message-ID: <agL-Uwfn26SI4Gb0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kstrtou32() function returns negative error code or zero on success.
However, in this case "val" is a u32 and the function returns signed
longs so negative error codes from kstrtou32() are returned as high
positive values.

Store the error code in an int instead.

Fixes: d20ee8e2dbd6 ("PCI: dwc: Add debugfs based Error Injection support for DWC")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 945f8f9b6d0e..a6737bdc46ac 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -305,6 +305,7 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf,
 	u32 val, counter, vc_num, err_group, type_mask;
 	int val_diff = 0;
 	char *kern_buf;
+	int ret;
 
 	err_group = err_inj_list[pdata->idx].err_inj_group;
 	type_mask = err_inj_type_mask[err_group];
@@ -326,10 +327,10 @@ static ssize_t err_inj_write(struct file *file, const char __user *buf,
 			return -EINVAL;
 		}
 	} else {
-		val = kstrtou32(kern_buf, 0, &counter);
-		if (val) {
+		ret = kstrtou32(kern_buf, 0, &counter);
+		if (ret) {
 			kfree(kern_buf);
-			return val;
+			return ret;
 		}
 	}
 
-- 
2.53.0

