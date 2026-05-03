Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27443A6B6A
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840264; cv=none; b=QTHF0fXJ0T07VxG2dCE4GKIoCJdV/pYCCCyGY7VcOptEPHNRWL8+I42AA+s/jT6284g+CrnjpP3TJZ9nJRsMeL1LwZIc36Vz1It7rXKo9rVtgsZHg4XUwivBrPPzkyArJyUNuFE5M0LI+jkiy4GuJhaIVgfZO4tXjjnIYfgEx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840264; c=relaxed/simple;
	bh=eLHoF/wGA3aZI/LpYSfur0tsW8EtC8WgaiqHaVUKpq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLPgFkY1TPfDSgMIUYJeVkrOxY7QhFDw7DmEdTGNXfKtyHqwzYLD+3ajBefZIHY6v6YebXNZUV95qYf3uOxTqVXawYQK7/O+Gxfju+W9L81aMrY52zKFhxJvekbpSAlgO27SRbbJ+92H0feeoaoGYE0ALAYbvrqdK7SccwhPpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8b60e54dso2586811b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 13:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777840262; x=1778445062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YtwuqB0hoMSKpHnfRml5OeZrZRHAiuCYySfGsA2RQlQ=;
        b=nUdvL2q27szmHX6LukPoXjR5JDwwAgXtIMQmkt42VrrVRss0/O3aMQs6uDw+0O4kzf
         isWY+0tf/ObNLRiPqcGQvPSsKy8EtL0QAqELx1PuriTpMqqtTAeoK42lhKGYm+qNCV9H
         j5PPXmKmwlndQ4XgT25zw6fCWCf8lopiBk3jHiWGc2XxIii+r7KxjUhHi9ujDkrScUwF
         3dCE28GS+FREotSQTNZO1mdZXvwEMZu0J1SLgWvNZTVnNvOzUV3xS4dPPn16mmQ+8WrD
         rJEmT4zTO9UT4WRSUeoInxpKbd5Q+Hbq5yqLZXpY05YbYkcnBRWYRkKyTlR6zS43NOD4
         v3JA==
X-Forwarded-Encrypted: i=1; AFNElJ9FrKx8zvWJArDfZDz5iwMJ7xN8PY+Lsz5Fs5JpIw3mOP1IdjWKZLnZOICRqwTtjNHXUnHCQ0yD9n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDbGEjc2nf2GdJta92LQUDG5poHggPvRfpGNurM0f4+O4aOZKT
	U+JwPoIXdjAd0yQhu2heuEZ1h+z1BKSddUVUgKpurLWMy46Xm1qnHgTZEie+NQ==
X-Gm-Gg: AeBDies5uNX+1udhUO3pE0Sw+YSKmVXYkKfNg4RX8RWodH8I9tbA+j+OYmNWS5+eXm2
	sxtdY68eL98ktDTRT6ixZ0SAnj7yrQy3xvLSY2PoYUV7NhXMZQtBc2oUXb/teKdT3qjKURwdSBn
	YLnil9bmUvlg8+UP9kaWjpcO4w5zYmck8AvpjbtCgAEM72+wACyj5wUG6EgSslJcF4rdGiUjw+r
	xFUc37DYeAhtSb0t7u2Rs38IjaWrZor+R7B1hTmQfRFyBfP56cqyCvM4owcYG203jQtLcfXllsx
	/qwWrOKQrkTX0ZdvaJRuBj3HibfHdjIb4h8NFQ2QCr2odrVBG2uL0bvLqYrlJzmtOQ51rG21Rx4
	6WU4oTuNGYLNktQhwprfMpPGOy1+b+IMHYiw6jfIvXv9lf8gJ6lDPVANHMRt1iIPhXiWLCyqXOb
	53hsYEgdNXb3fvFck9/yM06kYdixRun5f/BquizhwuRbAAne2WxXbcHEkv8WbWpQSXSHc+qisTr
	CBvsrGhfPdCifynQH1NHGbnpvNeqZqT8nnxRNHIq92rsIgyWCUNYSMx4q5i+KqZmVYno1Im+9Vt
	K8XmdwNUCV3vV48SUq5HDXz/UJwYoqK1X4XVtWF8TPqLIbl6+Hr1
X-Received: by 2002:aa7:8b4d:0:b0:835:388c:9753 with SMTP id d2e1a72fcca58-835388ca015mr3357386b3a.39.1777840262201;
        Sun, 03 May 2026 13:31:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad8770sm10048786b3a.32.2026.05.03.13.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 13:31:01 -0700 (PDT)
Date: Mon, 4 May 2026 05:31:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, alex@shazbot.org, chrisw@redhat.com, 
	jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	liuyongqiang13@huawei.com
Subject: Re: [PATCH] PCI/sysfs: Prohibit unaligned access to I/O port
Message-ID: <20260503200256.GA1393215@rocinante>
References: <20260408095532.1192625-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408095532.1192625-1-duziming2@huawei.com>

Hello,

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba97..c88910bcad262 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -31,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/aperture.h>
>  #include <linux/unaligned.h>
> +#include <linux/align.h>
>  #include "pci.h"

The "pci.h" header includes "linux/align.h" already.

>  #ifndef ARCH_PCI_DEV_GROUPS
> @@ -1157,6 +1158,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  	if (port + count - 1 > pci_resource_end(pdev, bar))
>  		return -EINVAL;
>  
> +	if (!IS_ALIGNED(port, count))
> +		return -EINVAL;
> +
>  	switch (count) {
>  	case 1:
>  		if (write)

Otherwise:

  Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof
