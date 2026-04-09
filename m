Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2DE39022D
	for <linux-pci@vger.kernel.org>; Thu,  9 Apr 2026 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775778084; cv=none; b=RctGgnZnRSF3b0M22xhUVzHc2CLxLl8zTBvlpETkBT0K+ATmxTU6uxzClmK0Myp9oWgrV1pJpeuHkGDp/6nAq52PkUTpd0O/0dqEU0aIglFciS3X4GtixVdsddGmoNG0PliiCDP24cbhIG0fquus23CvxJdPGqk51Cg3l3b6f+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775778084; c=relaxed/simple;
	bh=crIvwTLDdPJZQO2fSBCNhoREP2VUZ/EBIc0gjhGlosM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st+JZsSBEYLYlYih1C6ZQz8M+0KqhdqXBvZ9XojCOapy1t2K3ak1uc0DQpxLckqoymXgXf1Euug4C8Xy6aPK8VwkeKxmh4iVMvjknMpShJ0N4bLvezmsOn3H+XWh29MOk59tic9FpHm98PZm3p6dSZBxZHreeh6ru9D8OUaWkzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JblYIJIF; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JblYIJIF"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c2575ff49so1087887c88.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2026 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775778082; x=1776382882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crIvwTLDdPJZQO2fSBCNhoREP2VUZ/EBIc0gjhGlosM=;
        b=JblYIJIFhjpw6THx6+gJ3znqFs7U9ihTBmwm0kkPor7FS7jcG/WO0bBYg/EzkO4aSC
         R5EVKGbiHGgkfAncFWB7NaBCAxI+/Te46GQYQ1+0lx0kYRX+PsBUh+NihbHjUvcoFqOO
         elbNPsd0Dp9AMfRWw/rzP14Wr/Aw9YejHqp5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775778082; x=1776382882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crIvwTLDdPJZQO2fSBCNhoREP2VUZ/EBIc0gjhGlosM=;
        b=cczMlkQyWUjtM0w0IOSCotjpyKCGxSWHgVM1DB+V7/qq/xBohKTjz7tp0Qko5GFS9t
         M1Op10+f4S/CDQQ/oK+GZ49NEVxFRDPnG5kg07uW6X6ZU3qZlZTTSGukLAk2Z6Zo4yCa
         EACKbZAfQWBbZYlG2U6JMlTXv3YN+cnLFbdHTk/bq/sTPwkBtsUg8adG6G9+1FeGQDkS
         NUj9XGNjjPKE29xaLxUWRzNflI2KP9IztcixPj4JGHS6aixLUyzwnXUHH1du+R59f1UT
         LiDMeLFLvYjFgUDFUFL2bNc9Hf0gqRN4e2f5Vw+5bIAqmoOnlR72JI/OWnT9A4e//QA1
         DI+A==
X-Forwarded-Encrypted: i=1; AJvYcCWkuRdAIu+Pyku95A46HEIFurVK4AmH2OifEfYJvDqzIOHX+ISDVuGowTE1cm/TvXQes61zgDhhKe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPWtrL4emqqGyahvrMF7G6TBSLC3Wsl6bhdITzN9t8tklQWQt4
	6h3x7xk4S07VaIxSiJFSZIxTECyUj/Y5TSriU8T0jT+lC/9AAFrYYkcEQsEE18ptfQ==
X-Gm-Gg: AeBDiet/Y/KGL+S96nbGfQeZ58utPbSwnC7vp6woacDaqLwlWIio43CSYLIf59hZIEk
	S5a1P79E6kn89yVDXkMRCFEALvMzoO3ZwXZ4lghrM7+ATdR03gfFVYlIU7hVPwDcNAUQ+EnKhKk
	SqX+EbjnRQNEAcf6kPq1M0t8oBiySsS9d3EVWZ8IFN6/CFCDo16uGaSxTmGYXwxVb6ppBBWHPaX
	9qmLmaWq7WBiEUkyW7omUnPm4585ptALq0ZA13LGOJibkl69jR+k0Bj8o+9n2aYfFBB9qXYgfbQ
	HQ9ORL4Dlqws3N8wGWztQz3cUhjX5C6dzaLuZFZurdM1hmIRFjC/S1xEpUHvM1mwf6J2dOZ1uNS
	vildNF7OWMhhRTxJfEcc5vYHxc/bNy7LNVb3qJZuRyGmyRi32Avqkp53Kln4lBa5zIfd2fBLr6v
	r6Zm/ydRqPd1AGfapBQzDwxR6tT3xnpSAhtjzusoY2nB8HrUk21MT232hqheLLiw==
X-Received: by 2002:a05:7022:6183:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12c34dbeaddmr714661c88.0.1775778082256;
        Thu, 09 Apr 2026 16:41:22 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5d1f:ad34:cf0d:7e41])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12c345b6208sm1610261c88.8.2026.04.09.16.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 16:41:21 -0700 (PDT)
Date: Thu, 9 Apr 2026 16:41:20 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <adg5IPWdCSv1UqFE@google.com>
References: <aZfIfn9viQRj4uy4@google.com>
 <20260220164046.GA3528004@bhelgaas>
 <adg0OFkVnT3OiSJd@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adg0OFkVnT3OiSJd@google.com>

On Thu, Apr 09, 2026 at 04:20:27PM -0700, Brian Norris wrote:
> So is pci_set_master() a one-way operation done in child services (never
> call pci_clear_master()), and the only clear is via
> pcie_portdrv_remove() -> pci_disable_device()?

One other thought about this: it's actually a non-trivial question as to
whether the port is actually going to use MSI (and therefore, need bus
mastering). It depends on the result of pcie_init_service_irqs(),
whether we succeed with MSI or INTx.

We don't actually attempt to answer that question today. But if we did,
we'd have to be scattering that code across all our IRQ-utilizing child
services.

I wonder if all that churn is worthwhile, when it's a relatively
rare/strange case that a port really does *not* want bus mastering
enabled.

Brian
