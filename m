Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AA28371
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067129; cv=none; b=fIkeFtaFOLI6rgfpDDmkP5NdtmuJvL+IoSpves563lgBhsUvl6UjAC/TpCs0nomMjSGhvewWEBfNVYa9uJIhFw1wyZD3//PVGYBjo03pcTD2ORlTd7FS3o4uRmtbBDgH9WzRmL7BxyF7jmby0BAC3EvNcqnLgBR9SC7hnAynLNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067129; c=relaxed/simple;
	bh=xv0S31PtwdmpQPHw0Fc3vOyQu5vNsfiZECnu7ZDWm6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvW8GL+fg7t3R3TiEQl3eaFdQvSkdqODu9qsVDajgUNm/ly+7mVe75L3Y3CyKn+D6mFvDNznjuALG3zCIq6fjVYKtIMwUrKV0EtwUXNeWkNzFOunOO+BvBQocIpPptFwtp5pdP+vKJu/t9Nbfox9obhVcnkJTb6xtdcrlqT6jYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkTbae6V; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkTbae6V"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-83ef1d17904so1646022b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779067128; x=1779671928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vrkXl/tb+VJX1ZNHX4vVsA7L7lm6KoE09cNj85XuTpU=;
        b=XkTbae6VmnbOyE7v7IRER4USm4lIo2IJiqmFgRaWmgSa1u5LZo7Cz5yahseIlzfJFO
         hfppM8pqkHJyT2YPKrchPw0AdZmOIKlaIe8zmiJj0gupVfrBkqG8LBmEIySIzNI26hP3
         ZHj/BsWe+F7W5FPw7MBiu+8JfOV9bVh7uNY/z/mDx492caVZEW/Ke3xKDVB24GxXaqMe
         mR51lSVU6xSGLKsg9ZLiWjpJduQHI25KdXtv1QEP9q9cqUjBg3JOergT7tsCF4ATXj+X
         EpthtdDocffUGAa8yxxlAQmm6PbpNzJIv5XdAHM1f4SiJhlL0gj1PeQ4DFF7kw6NlkIP
         8JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779067128; x=1779671928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrkXl/tb+VJX1ZNHX4vVsA7L7lm6KoE09cNj85XuTpU=;
        b=FCPaHphAYhTmk3MbbBE44y0zAq/58eMofW62YOPMkvwKqfp7C5+4P6nXC4IIk2hiaG
         zdL4w5N/YT78gYIoKDi7eEMd1rZdRGVM66zy1T5ZMUvrIWWNC2S/WBC8Icr3zoO+iVLo
         K31jDpkkpk/+iKqY9gF8UcYCYAKtSX8NgRmOaq7ApO87ialY4B1rBH2JcZQEyFTGdM64
         GQLUOxeR14E20rAsMisIWSooneEkhNt8PcZelcvEgUXjVqpUKfQX07Kqjn4neVRrlA3L
         lAjmkgUVqvoIzmiEs01M9DhsYxM2bwWU5IL3Gz0NsU5TbFq9fFTfu8vP66mxaco6qjm0
         /uyg==
X-Forwarded-Encrypted: i=1; AFNElJ/+JNvfHwYK5AtldAIzW/Hh+kCcQJEVtfT4itnhQ+0Sga/l8nQCGXZ9SGwV7J8Tjk0aUUZMSu7ud1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTYZttISNDHarJgnT9GN1LW5/J9TZmO5pYv20tQa5OtaMTpmC
	fbLRHx7IFXLu38t2nR7GQU1vB7Px7BdZi3wX/oRKif/3LjjebZzDPlIu
X-Gm-Gg: Acq92OH2/PwOig3Rh5bjHxc5Q145+U4phGtEUNJl3fk+AAux7QD7y8HA+C7kxY9M8w5
	nkVK5wiMBaxUt5Z1BrBrQH6XVQUQSe5P/5Ye/RaIsGmzRpnuj3S7GjtQr199l+ndHCx0/NmrrM7
	BURSVUyvTSXftfWN7NK42VrG8IZDmB6957IWfR9H/23G2Ia3jlJ8WTAwgD6xL6wz+EEcU/iuBXh
	5nUvY5NXI3/nY6zgOAh9w/BVIVMgBmmAVnoFkEnkw8gO+BdUvwSYINnyRFWc/6oS3VNM4gQoIFu
	TFtBedVy0wkhAayusANTsxRUTIMP8y/NsYySic1jFOaUTpWIJv+uFlJtz1Xzq+pmDqLI211Sezk
	iYiZIQB5tDQABwrwkdXHzEJpjRGOzxJ6hYyIK+vWAjZhQ63ViI9DLNRUyQ/pZ+PCO6DNf65NHzM
	05r5Tz+iwK8wdnUZFf+93gBOg=
X-Received: by 2002:a05:6a00:2908:b0:82a:6461:6d15 with SMTP id d2e1a72fcca58-83f33f166f9mr13591304b3a.46.1779067127790;
        Sun, 17 May 2026 18:18:47 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19778c87sm11922977b3a.19.2026.05.17.18.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:18:47 -0700 (PDT)
Date: Mon, 18 May 2026 09:18:13 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Alex Elder <elder@riscstar.com>, Nam Cao <namcao@linutronix.de>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Randolph Lin <randolph@andestech.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 2/5] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <agpogZp46N_1B0ps@inochi.infowork>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-3-inochiama@gmail.com>
 <agl3TJrvJMtEpHyl@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agl3TJrvJMtEpHyl@ashevche-desk.local>

On Sun, May 17, 2026 at 11:07:40AM +0300, Andy Shevchenko wrote:
> On Sun, May 17, 2026 at 09:48:37AM +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 may use multiple PHYs at the
> > same time. The feature is not support by the current driver.
> > So extend the PHY definition to support multiple PHY handles.
> 
> ...
> 
> > +	k1->phy = devm_kmalloc_array(dev, 1, sizeof(*k1->phy), GFP_KERNEL);
> 
> Hmm... What's the point in having _array(1) ? devm_kmalloc() should suffice.
> 


Yes, you are right, I forgot it is "struct phy *", so the devm_kmalloc()
is enough, will fix in the next version.

Regards,
Inochi

> > +	if (!k1->phy)
> > +		return -ENOMEM;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
