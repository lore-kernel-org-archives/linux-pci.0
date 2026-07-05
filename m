Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834235AC20
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783250580; cv=none; b=AaVx1GBwzGfK9GrYYP4xEaWs90wyKstbZx4BGEKellxUHJ7pPuYIGDbk1Pe4LwuTa7pCEBbAYhB/Axwih0wdmbqZoBuu6M2eqUPUI062dfr0OeZ2LkC9zDZ9xptHsaPQ0vLBbL/1uaejsBtBHxXSz7cpPFn3jEye7rcnXbrsPkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783250580; c=relaxed/simple;
	bh=9ihfPJWrXsFx42x/DvnAeOl++cQYozhIWwTp37iIRX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH/yTO/+VJK6kF/BEQQzMXmBvGBd6jcAIF13t1jYvlj2Ih77kF1win0w/sC5LgcDwnKiBKvU3vwWyB+S6UpmDo0AvXxMgIVLnFczgBevTyV5pAorqUNuuve7igl+9PC3h34MrZ+lh9P37zwj/X8JcpLWGWD1cwoXmKRa4QOVmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYvj5hXP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYvj5hXP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c821a50615so16295825ad.0
        for <linux-pci@vger.kernel.org>; Sun, 05 Jul 2026 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783250578; x=1783855378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EP+ltuqOMcIt+xpZ8qdpKdZOFHQrgBBgO+zhJMTh/i8=;
        b=sYvj5hXPAlCsOMllwC2FIWxSzefBV9VLcyu/T/7bDcoXJC0W8VQr4VTILWM3sw7Uy/
         eNo3mGMWmHlXHKl/zGs8Ae9aZvTH2YnaKCxPmgKfGs0Dn4umVnzUPuUiP8kaz+3GgQ4R
         i/TuG8xK1deJx/CObDre1KK+MM/X8lkO7wzDpK3BMjpny6DzYDSeS8jPtWkAtQxTj9S+
         TqFsBOaTYNkFbnQFrGXI7eDILOhZHXa8DmodZHjfgBu3Ea8D4g6GN0Qo9QLaONqXTUFn
         BTQBaVQINAtqhhGFOZt1iVcTjelPgCGV8HyspOSF0nEKxMjciNj1tDaUYm1NpxKn/28o
         FUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783250578; x=1783855378;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EP+ltuqOMcIt+xpZ8qdpKdZOFHQrgBBgO+zhJMTh/i8=;
        b=HL4i22SCWtGQs98R2hoc2KpJXKRd+RLhoPs9AikJJQkHp8UOX3fjTvE2iiwxPuA+rm
         74Q/dqBmuDkNLD2CcOz10KiLktZbTBLyY/dnt9oLEGgUgGKncCwMB4PPIq1HaA4qpa3I
         jceWSjTjMheRX9a6uWLjKPcF71+xhvKQEWTvoEpOfCEm9v/h1NbmfqV2N+Jd7GEhcjvc
         L9e5Azzq5OCGRHeR2zF9RQRjne1yn4rvModAeruOyBiu59toXqLk8WiZ11jlWaX7G0wU
         QNLfuRYBON/uAQgDQHUbuOXB4Z9uSkGQuZUfTwQAbZajSnNt5gER4Rb3r9l+KVi2X4Ig
         HcUA==
X-Forwarded-Encrypted: i=1; AHgh+RrGmaSzO8vbc8dRxZi0HzDBkakDDRQ1by4wugGHXzDjEnXU43FDMCV4R5eZRVUhg3ZkK0+FSrPsIjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR+kXKkYnInh92fOey/zrxpiA5aAZpNlMcUs7hmaYytoNSBTQR
	xsBNrNhC+YElIw9aEP7dlAhUV2hQGJ3HGjMdQJWjry4iGmEijX5JZMbw
X-Gm-Gg: AfdE7cmHpVnPGg75LNCQms7I8pVei1MvxftYFP3KF9JtN7m5EUCXpxTdA49S1uoaaAK
	x4B5HxpFHjQG79DrsNhiTrGywo8ClPMn2zfJV0KyPDqgoYruJVlSAJMLeOcnb8KQhqFI2V5o9K+
	Ugvvv9rEKa4dbWHjWDO/PrTiuvhHPkyrQZbri0T0pp/M2/MSHc9vgN9zj12EbLiX6D1qrfzXX1p
	+rXTQ4ufx+SeSyQQ3Z3Q//vaD1quA04veR3Vs3dojYZv5eb9uI3OJW2IJpkptziRd1duj52keAj
	66VfOA7e4nS8JTP7pMKizQXA0O6nMC8ypMzi3VenJnC2fM5AzkoB0XyrOcG7kOVjqnY4dRE8+m0
	S3yAacXlNyWTPF6+29hKVvvmcRwXMHuGXq3dNraCI5l2/RZmNAhvYUPPpwabCH5+N
X-Received: by 2002:a17:902:ec87:b0:2c9:e5e6:8621 with SMTP id d9443c01a7336-2cbb9eb4b6emr63113945ad.25.1783250578209;
        Sun, 05 Jul 2026 04:22:58 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7893f0fsm32340485ad.75.2026.07.05.04.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 04:22:57 -0700 (PDT)
Date: Sun, 5 Jul 2026 19:22:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Alex Elder <elder@riscstar.com>, 
	Randolph Lin <randolph@andestech.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <ako-AA8uHfocQHnP@inochi.infowork>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-6-inochiama@gmail.com>
 <20260705-versed-leech-of-glory-db5cfc@quoll>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-versed-leech-of-glory-db5cfc@quoll>

On Sun, Jul 05, 2026 at 11:37:15AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jul 03, 2026 at 10:00:01AM +0800, Inochi Amaoto wrote:
> >  required:
> >    - clocks
> >    - clock-names
> >    - resets
> >    - reset-names
> > -  - interrupts
> > -  - interrupt-names
> 
> Why?
> 

The K3 uses external MSI controller so it has no interrupt/interrupt-name.
But I do make a mistake here as I forgot to restore the required for the K1
in the allOf check. This will be fixed in the next version.

Regards,
Inochi

> >    - spacemit,apmu
> >  
> 
> Best regards,
> Krzysztof
> 
