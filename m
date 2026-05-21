Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D643C343D
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364746; cv=none; b=jC41X/6VGH79NRV4LXj/jnGqL6G6uxxYFnRN0rSuWqUNz88gHcbuVZGm/zDxeFvbXNRDucoUfRSVq9TiVfRUnvBNw9A3ObUpri0S1+x3YV2qXQtswjlLjwHyJo+mjeEpgBK+a0EHjB6hLFiZgvwRGDEvUYA3NsGojs2q9p1aCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364746; c=relaxed/simple;
	bh=9QNDz0SiTVVe4NXAzmtAyUk/+gd+KBofCbP69W8PMH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6LUdlBYzBe3uu63n40KCwrN0M6Pw0ZQV2APXvSc1gvjawzd5wTftEVLKOfZi4akurvdYNG3BkhufVVpQqO5JZAoV2Obbj4TWrZhlZSJzQ2CNfvcK8n04EjwN9u9ojvR6tQT8i3UMJMZAYG2RCH4LDvXLtBZ3MjuPYQY/x2Nu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36a15ed5119so2399866a91.3
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 04:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779364744; x=1779969544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0n/yoOj7r3WTChH1iCOeo3b0bKG1oOEOnSnWhVWyhQ=;
        b=PaQr2+blxjdvsa+8DvXZ6lhRiAE6sXCi9KI69EU0+349Qlaiki4YBHETp61PNt/KAq
         zWZCzMa5/6Ag4spFFgzEZftEL0uO/zbGM8bOwKh6d1XtWQNoR6nyVTVHZh147B6tG8fn
         hOnxbir/guVhLfPS7poC/6jNgCGaW70TngiAl2RKJ5opNsO1pEl0Hj/jsEgtvuOl499l
         2CvEJ2ATzZNDtFe2wIgpvnuCCCr6WzkbRBQZhBXGd5paeLxXRXltD+cH5UAwcyDmWuc2
         5PtYty+WuzwyiRTcofO4+IT8oZNbhv2aEoRxPQvYf/C81ZhW1blgybCa9SlafZHD/y2Q
         1+Lw==
X-Forwarded-Encrypted: i=1; AFNElJ8ciCAu8BwMjRvK5P00LmL9H5zUhN7onZnM3ORaxgBEXuOVGuFqdKcRDUOymch3kbt5TIPP8V8EoX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW+4ig5I7ATXlDv6QhQx/KORRUS6+L4zdkNOsob75swcTzxevD
	ILHeTlwlr2UY7iBXATihOfYxj4ZcI62OEM2P25rqT47ZrnvlJtvs0TZQ7AZUjA==
X-Gm-Gg: Acq92OGlC6szdEv1+2XBG2aQXk5DRWr50vmNciauwAsFNO7rVUrVubevCyfBDn539wa
	UJ0OyiJb3JeG6NRslH2R+LF2gkFJ3o9h6oaEyPAHJ1PVp5uCb7mPehw550CDa3N0awkMUmokIqX
	haj8/zTAlsNHs6abiEVwYi1Yu59W3gmdCw+puEP+Al3eX6TZrODtARoUPiyXr333rRfaOrL2ZG0
	Drywnb/wlL1pQ3n56V4NQJRpaG4sx7h1vj2cyhCwycvwhmi4993YoGbqny3cKVjhRg8aitzTx4u
	7hhtuA4mJKGHZXuB/mBeDY7LiG38qA6MeBBIcIRpG85lsEbY1tby8bV9dfJBqdNOAOkr7f+kOgQ
	6kpqiAxdED72KZ7miXLulxxDjEUJX7ZmSdaTFKm8wMhjVGTl0hcjqMIbzpVf8L3SvUn8FcIZoLb
	2CYstl5KAIngL03msaroRBCR8pQW/D3Tc/BZd2hrCzUwSsarLHW+3hiVyLaQt3RrBWTDWCkqE+j
	JMAO8uEgow8OM9v4FFOenpUsD6bgD9yjHUcL6gtSIO5UDtOrCjJHjgvey89uiMfENtNn+EPZI2i
	a6xXNHerZOJMRBU7twiCP12f9Xgn3VUP6xr3U8m4lw==
X-Received: by 2002:a17:90b:2d43:b0:369:a74b:28cc with SMTP id 98e67ed59e1d1-36a45c7ef23mr2530942a91.18.1779364744399;
        Thu, 21 May 2026 04:59:04 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a440491a9sm751306a91.0.2026.05.21.04.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:59:03 -0700 (PDT)
Date: Thu, 21 May 2026 20:59:02 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Gianfranco Dutka <gianfranco.dutka@arista.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: NULL res_attr slot after kfree as defence
 against double-remove
Message-ID: <20260521115433.GB647881@rocinante>
References: <20260520211306.3301893-1-gianfranco.dutka@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520211306.3301893-1-gianfranco.dutka@arista.com>

Hello,

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1228,11 +1228,13 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr[i] = NULL;
>  		}
> 
>  		res_attr = pdev->res_attr_wc[i];
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr_wc[i] = NULL;
>  		}
>  	}
>  }

Similar such patches (for reference):

  - https://lore.kernel.org/linux-pci/20251010093023.2569-1-guojinhui.liam@bytedance.com/
  - https://lore.kernel.org/linux-pci/20250629030547.1073425-1-zhangjian496@huawei.com/
  - https://lore.kernel.org/linux-pci/20210507102706.7658-1-danijel.slivka@amd.com/
  - https://lore.kernel.org/linux-pci/20191024172157.878735-2-s.miroshnichenko@yadro.com/

Thank you!

	Krzysztof
