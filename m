Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE72DECBF
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 05:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772082396; cv=none; b=IjZw1NUShhfY/Yo7IxHVPhttiD+/NiMl0X/5uQuJ18uu3sTJWmV1deBVvskBJJkg4x6N3mX/elv/Xs5eJjDf8Ir5KslozvRNKGMVgWysZyHolEvAuSie+6Tvzh+E1tGGLH4TK7P3zJw7oihyibMXez1jecdKS5ckV0aatN+J7lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772082396; c=relaxed/simple;
	bh=pKmLHC4ttZAACciM0OSMF4btoJdPKFJpJGewfgj9D/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4iA4AntysHL3apdD66xzNbW1NqnVUHINoxvyPg2J/EXthK+1iQvkFA/NCPu5VjeNK/Xuua7YDI6rXksqyWAKhE6B2o9UL7gaReeKFn4CcPIh0Sq4B/U9uUHxOBuubWBtxOkSO2wn9ZU80k78n9tPdm0bOvdAXN+m+BU7/VSUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyu3MZto; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyu3MZto"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5673fd077b4so245653e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 21:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772082394; x=1772687194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHjA+gD2gl/+zcPzbbJ9jvIxiqgAysEUeuXfqossHNc=;
        b=Yyu3MZtoaOhdmHz5Eogpn4tXmNnBTYuDsA23AIAdgED9no/nbU/fDACfylthkp4sph
         i3wrJnukB5aZ+Jup6KXHiQRaVq+Nt05EC4rDh39aLRYI/9cIdg1qi105WYPaitq6BR+E
         xf6C+DF1aZvYTxpAU/eZkZP6yadjVnQRMo5sEjQ3NKbsng4UhkMCc1V8AWeAuOrSOR8N
         brHeeMYic16Q0+y3wRbwGTYzaBkJJ5IvuurI1N7dvWbUYov/+cHRbyYgK+LdZ/zqQDQz
         UupaDZruh0xoRlhTp7jK4rKX336T6SXitzfZfhWA3iJZhlf2/eANSORcM3MPZdXyQRNb
         NFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772082394; x=1772687194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHjA+gD2gl/+zcPzbbJ9jvIxiqgAysEUeuXfqossHNc=;
        b=Abn4bAwVszs5lWpQirrzq8hgneaf05NI22hE2mZKRhhA11oxwtot+QuCH5KancdhVN
         PVCRxZUFc7DRTR2U8tBTP/5oAHOUD5vptD+HgLMppN3fhWKT3MPYXXj8BQV06q2lOS6y
         CfLYNQNB118yPQTlTRr2XiASkGpL4aDBZjh+owjNLJ+sbXtiNO5A3+kyJOQaecZbEgc9
         I9tGBABr/imb8PQt7h3fyTngpBW7LScnrElyAFLjMcm7fDAWWOZBLeZjTQm3S0amUgJ7
         +kDfdVZUyMRKsaLT4Lf1DYjhK0cqrFoCL70c1YmDfx56cXJ0j1w/+aHrCIKpRufCTWnE
         HR6A==
X-Forwarded-Encrypted: i=1; AJvYcCUzz6weeAXGfb6dILfrWMzrlkvIUpgwnjgunCKpwDpV8dhq0NC1WqovP4yS8cieSvdjzA5mqJLkTQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziUgWhmb+qA80G3tgE0PBQsZ9dPiBp3RCrQxFqKoB6b/ipk02E
	lrRAPuXfnHKyU/QACbpkfTK881Ye2Bzy5OIoPObBwnVeLgDGWIS/YmrW
X-Gm-Gg: ATEYQzyjmnYBdA261H4Dukcq/h9TvxZRC9hAS8VvUT5fipoTM8nlNR+F7Yns4gBVUuI
	KfE7Dv8eKLIW3kZRECvNGZYkWr3hLx7TYjWjgfYkqScqP62rrtiE63o28DuHrjUN8vEzgtjO96a
	KzNdSR6KsgyE9qqer45+8AhI/9aiZsuof7FgxDzPEINeAtHTcGWfRYV2VxNbYkzSBP0Lfn5zgeN
	72R2SEQC5iuWWSWLZ9i8f5QKVnkBg3mbJ1aKeVoYZNGj7dXh1p9tHsFk4VaFzlP8XAoxpt0XB6G
	O2yh7SONe6pR+Ydq42BFKfmJ4Cyb8MKDnXzXvnbwpXMDblyf6GTWvB4fopWggWrW5x+J9F/ZcK6
	KDDmwbEk301pPIS2VamLW9sFhctP1quvRgvBN/SU0oXkIv4bI/xM/1bR5SNZyOK6AxP7Cu+0LJs
	JD7pvt2hOWxg==
X-Received: by 2002:a05:6122:2a55:b0:566:221e:a98e with SMTP id 71dfb90a1353d-568e48f5862mr7505040e0c.18.1772082393912;
        Wed, 25 Feb 2026 21:06:33 -0800 (PST)
Received: from geday ([2804:7f2:800b:f14d::dead:c001])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a920493f9sm1290815e0c.13.2026.02.25.21.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:06:32 -0800 (PST)
Date: Thu, 26 Feb 2026 02:06:24 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rockchip-host: comment danger of 5.0 GT/s
 speed
Message-ID: <aZ_U0ASjuK2fZi5h@geday>
References: <8db835ffe384db63ee598a203751b298ad1cc267.1772057799.git.geraldogabriel@gmail.com>
 <20260226001229.GA3794668@bhelgaas>
 <aZ-RaBLVfEZA_FxU@geday>
 <e0aa10e5-ec0a-4d0d-6f71-6797286221cc@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0aa10e5-ec0a-4d0d-6f71-6797286221cc@manjaro.org>

Hi Dragan, thank you for the review!

On Thu, Feb 26, 2026 at 05:52:58AM +0100, Dragan Simic wrote:
> I agree about removing the effectively unused code block that handles
> the "link_gen == 2" case from pcie-rockchip-host.c, but then please
> remove the PCIE_CLIENT_GEN_SEL_2 define from pcie-rockchip.h and its
> single "link_gen == 2" use from pcie-rockchip.c as well.

Good.

There's also some code that needs to be dropped from the endpoint
driver.

> 
> As part of that additional removal, an early check for "link_gen == 1"
> should be added to function rockchip_pcie_init_port() in pcie-rockchip.c,
> because that will become the only "link_gen" value it supports.

What do you think, should the driver bail out completely if
link_gen != 1 or just let it force 2.5 GT/s speed with a warning?

I tend to go with the latter.

Thanks,
Geraldo Nascimento
