Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B332652A2
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777739063; cv=none; b=s9vl0Bt1lCsyv5NX9H5QxjjAtMnmtCShvdIrSUg36baMt8mW0+89nBPEBXs8e3IIMD374PPyC/7JyN5yHKuTCYsURgpCEFne8B7xMq76pBWCSkx9YEYWauWsvUW0VV/snJgn0ZJ53GNIpBRY54fuTeVuFPsNQ3KY/mgLQCJHzmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777739063; c=relaxed/simple;
	bh=2rG+BmqF2L7Z3SXRX2evVS0766cCoBWD40kLCjLjsPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N61EyuZEc220kkZvwPAA7yOWQqiqKOiGIL39oQvyPg+e00VGMGKnRriWo7d++IRh2d8fp5O0tOG0Sj9jo7qrWTqCkbizDgHKQ43uVQJ+e3V7gI6Md4mK+bSu4jE4SZG6h9VXFpio+Bz1L1e1qDzjIsoASl4GeoMuIUMGAhkJqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso1649194a12.0
        for <linux-pci@vger.kernel.org>; Sat, 02 May 2026 09:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777739062; x=1778343862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUG5TbVa1RWcqk/55upOjf0WsHYgGEoiOowtAjLAhnk=;
        b=FYkRbCiIm5ASaq/3RZtdYpJD4rnoaDcizhlHaXJf3ivY29YkKswH1Up7SlL/jc5jVs
         VdGittzEiQD90VT2YPvecza53I2cWVUOFU9Roq5bjCa2xAkvfx/aBpLlbVXpqTMKNkvJ
         MuGwggPZJJc8Ah6Qgr/TtBt0Wmcdk+SEdqha3kP7QKRHq5yh6yMk+EhkqjUk0IvNyuYP
         BsOIyPQUN3nBiGz1kQBRm9gwZSSBUw1dadzCc3qhQ+EjJyVGt4Ew8JTq3fRyciLwVVqD
         Cxs5UbZ2Fd9NBPSq9qOE1eGWBbY0+yejObuGMcE6HUlTL20nZuaTb7xPbj26PqhVeHuS
         Umdg==
X-Forwarded-Encrypted: i=1; AFNElJ/S5r2C28BVPDbqhrM+himRlan11ZJ+jFZp28TIAy5SnYbDfPpTISgYLrgL/EMGPKI4gmOlVTJjMb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxMwgZ+UO+76mk1LGAjCSC7TJdA0X4roMxBZiVtMgyi7kXpbKN
	4kS3w5zg6egZS9ZPuG3sSglY4JqPUbO6Q0M43WAqr7aOTXK0OMUulG3qluy18w==
X-Gm-Gg: AeBDievFQ0C3A/x9JkTALz7CCPkzViG4J5UrsEuna2Pp4T/VdjAtL0uu5mTrrf/yRyv
	AkniTMThvA7pOcjdmHn7JkEC47KatmWWDIhKLS/Ta1/8B2I/mdH5zaE9xZUcpQ2AnSPMz7S5Q3/
	UKk5lU9y6crlgMtwiWef1BRrOmcsaj44C4wJJjR/f51ZecMOfx5pWmd8XLt+CMqcnQTwSJx31FO
	EA1Gu8AGby0Klr2y8U2pJzRidKNf4E0oM5VDFZkLPDX0vr4itbCFT5U2X+b6s3A/vetTZfS+S/9
	c3k3Tw9rc+JH70V2rH19Z/PZSVaUwfIuYuUwrbCREwHvvoR27nMSPERixP2IWPgwH/8AD11DcAR
	0l7YI+7/rZKujSqvPYEpiwtjFnG9o8qWyhHpaA7+uyAqA+JYb8WTMkqVha8dzrf7V0GPcNmF6Q7
	JiP6bJ357zdY2IL96w+cu7QqypJotMLRJ1zKDI+19CzUejvj3y/9QozLxh18Pau7lg089XjmpuC
	g+7+CvRMgG9c/ZiqQOOZVOdgHPUftzDz7SB0vJg2KxPwv6rAhbYwphcN1jKySQB5mBCfZCiM3qc
	5e/5X4CybNc7GvC1vCZO910o1UHc6vNpNpE0vmH6DA==
X-Received: by 2002:a05:6a21:7016:b0:3a3:a69c:214f with SMTP id adf61e73a8af0-3a7f1c97a82mr3985899637.36.1777739061904;
        Sat, 02 May 2026 09:24:21 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm3023579b3a.46.2026.05.02.09.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 09:24:20 -0700 (PDT)
Date: Sun, 3 May 2026 01:24:19 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: duziming <duziming2@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, 
	alex@shazbot.org, chrisw@redhat.com, jbarnes@virtuousgeek.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH v4 2/4] PCI/sysfs: Fix null pointer dereference during
 hotplug
Message-ID: <20260502162024.GA1323630@rocinante>
References: <20260226171403.GA3813150@bhelgaas>
 <502de80c-d062-4253-a2a3-cfb240d7dab2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <502de80c-d062-4253-a2a3-cfb240d7dab2@huawei.com>

Hello,

> Given this, would setting the pointer to NULL after kfree still be
> considered a worthwhile defensive measure?
> 
[...]
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 18e5d4603b472..fbcbf39232732 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1227,12 +1227,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
> > >   		if (res_attr) {
> > >   			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> > >   			kfree(res_attr);
> > > +			pdev->res_attr[i] = NULL;
> > >   		}
> > >   		res_attr = pdev->res_attr_wc[i];
> > >   		if (res_attr) {
> > >   			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
> > >   			kfree(res_attr);
> > > +			pdev->res_attr_wc[i] = NULL;
> > >   		}
> > >   	}
> > >   }

If the changes like the following series:

  https://lore.kernel.org/linux-pci/20260422161407.118748-1-kwilczynski@kernel.org/

Will eventually be accepted, then this won't be needed.

Thank you!

	Krzysztof
