Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE87D33F8B4
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791617; cv=none; b=pOzky77EjI9PqNfEAR9oa3iBnojJpwb7L/XXZPbYw8eeFcklajXNpnv7ojnKsDT50k2NR/GPq/iqES6Bs5tLwPsYArelsfTysPkJGvOW1I2tX8dyPi10MOkIxNA8BCZNJbBS3zM3n6WzOhqqvWNp4rtTcQGE2U35GvpNWdZTGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791617; c=relaxed/simple;
	bh=dNPqhdaCExXnqljjtmyEiK2FfGUZQrh5olPv++EE6Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otAn3o8Yp8qtnoDlu6HTxf+qCvVjgyr7+BGR+OEn6xFdVTt3L08Lse+qzLPPkyLfsoIkPqsfqV1eNNXcWBF4JxzEyFrqCDys2hqGFsxweTJZruZYwYCiHrQD4FDhI+Nq5rABqQrf4lxnj3H8118JEOwR3fUQ0g+3y5CIibxp6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b4583f0a1aso28313265ad.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 10:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791616; x=1777396416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOptXCQFoecDGSEMq5oXbgb/TQScxdLgsFvp93S1GiI=;
        b=TyWuSlsKG7AdZ+/8igOxGVWZnNtZvxt279CZ+JPq3obl9jAmDdTb+Poo0uFNt119y5
         efkv61fu+p4Nhfdco2++d5/8q13lAZ4lOQB3fc6sm6mQuMJ1MDwRSQlHt6s5xKBpCr0Q
         IrqyXKdrwQhGgau+wyMzgJzqMi9mUP4zE+xnaQiIG46NoyIr+JKDqS3SXwmPUSp4Y4ec
         FUSXCwe4CkmxynqQHNyeiLgcU+O2sxxYg9jWidE0LP5fWBLcuPIOFJjE+zgygvTPZEbp
         FJ581VZpyesCCJdWFB3KPks1Mgat6moo8v68oDR17Td7dlzz7rcj6/lU/erAdTfMAz++
         h6MA==
X-Gm-Message-State: AOJu0YyyHLQovnhjXfh5s3eo3MslHCTU4f+c4sWik4cfg+9SxmCFG/hp
	dybAWao4aPQRhQ0FzdOfF2BVgpmr2Y0+i7QexfidJXJF78bO5GwKSRif
X-Gm-Gg: AeBDies1VxurIdbQehvB7osbtvMOodK3U8j86ltYUOCgPQ6I1BVZJOJdk6l9SbQ8Kdk
	Ks9IJDkd7qPugv4xMxJRJmNi6z64VWhJr/L99gNcXnY0yD/SM9ckUEE3GWkkenBwHjvmuIoSWDn
	wdVc1aRPfj43e+G6CWdV36+lnbC4wqUELaQPArjvNipa4fKu7ioHZgOX+tNINNs49+1asHQcjDp
	UD1C9AFevgtex5Yt8pc5k8B130DeYBxXSHbrdQu/PEO6zZIXQqTeDOFZAUpSlwM8jLkr9x89quO
	3esnigEYU/zbYxmQZBh3CPsuO0qQzHSWZZ9MKG5y/Rjp98ioul9k0KsSyjjP+t961zHoHtFmQLI
	4UnxPc025H5XfRjTolRorJxjHmhcs1ceq84WOlLsW0dfgyTB3bTkSM1Q2cwGLV395/DjVE83AhC
	8PxtLNa5mFDqQOVhPJfLvYHgDNNpuYHbFARsLhRwgwN04gX0kyLuxP9y6gL6CklbLFEM8ZLuTxu
	Q80t5MCA9QhMHb2ozjli5pJMdWGGYQQbuPphZmihi8dtpA+ER3NSoykMS6hZfJPfTJWD16lKkvj
	dFgFsRZvJLuf20dogdFUjhYcdY4YXUaGDidKyyEvrQ==
X-Received: by 2002:a17:902:bf4a:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b5f9e79fa8mr145008315ad.5.1776791616146;
        Tue, 21 Apr 2026 10:13:36 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff713sm142070275ad.5.2026.04.21.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 10:13:35 -0700 (PDT)
Date: Wed, 22 Apr 2026 02:13:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] PCI/hotplug: Add 'uevent' sysfs attribute to
 trigger slot events
Message-ID: <20260421171334.GA1684602@rocinante>
References: <20260416213909.705753-1-ramesh@linux.ibm.com>
 <20260416213909.705753-2-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416213909.705753-2-ramesh@linux.ibm.com>

Hello,

> +static struct pci_slot_attribute hotplug_slot_attr_uevent = {
> +	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
> +	.show = NULL,
> +	.store = uevent_write_file
> +};

I think, you could use the __ATTR_WO() macro here.

Thank you!

	Krzysztof
