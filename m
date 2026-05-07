Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B109D175A85
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114503; cv=none; b=gsNDbuIbJ7Dty7IWFoYEdntLNDB56XhXwBdBwJMUB2pCsggbD5kBPOcBvwxRizTfzBVcoQW9A3/5zTjjIwWqTwahefJ822OPW82zCXcY4V2ACgGdD+bcSpVW2cerLInF3d2CMNuq5viEBzC0dr6oFbLtZMU6x818YamBWYse7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114503; c=relaxed/simple;
	bh=hozVGdurQuHkwbTkTMzyhB1vqcbTrdKhKFTpfvINR2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iELijSr2XpDIFzrzytWXhWpKyvLjHVPXzUEOIZbmJrBp/q1VIDEWQ4JrDRBjjQaJr5Ly2Dxc/X4doP7BG9dp2jVqQuhaQhbL8WLsRbbXMnnlzfsaTf8GAiz6fPtyjfyLnpbC5rqKP7+fGqCao2lQrtGrR/toJakXuo3sZRA6Bso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfW3pE33; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfW3pE33"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso89797a12.0
        for <linux-pci@vger.kernel.org>; Wed, 06 May 2026 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114502; x=1778719302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ5LFFAZbhjlqv4fN6kLXFN2tALXchu13wJuFe3wZrI=;
        b=FfW3pE336oEhBJFu+R0/Pe+DGVlEEdsyfXU5DlZZP/iSwjmkZakdgVP9kxGMsg0X4Z
         kYtqQnZbzzT055aqahHK3hMai4D7L7PhMclrMQ8/K/JijouKoN5/vVpy+us3ySjEUmm8
         6u4Qh/7De2rLz74RGQladmd7Xc4HHoD4YuzM2bJPlSbizobSkCMMxZuRnckSc2igjlJx
         7ryyWvh96xXJVMnMKItYyjbySOiCzkMkiaD6BmsT+yzNkCo8FB/eSx7IOJqb3QIu4c8x
         rOvOsZ1AyEOhsTSnzYlqTIPhH1ONpQ7YS2R/aJJUpmfp9GZpimQ6aDmKIU+Sis2S6Wws
         UQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114502; x=1778719302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ5LFFAZbhjlqv4fN6kLXFN2tALXchu13wJuFe3wZrI=;
        b=InmQKEKEzj5oezXfkrkqIOJjOSW07x21IHJXntLvS46w8qF7O21aKVYbyf/JM4+ttI
         aJ2h2ONyclaNBxgLDDxh0/mpYYnSOOwV0chzfaX7dbh+GHabXgTkl8l+YclKZbYDA0Uh
         2UrrdovPc/bQS78Bq5Q0OhxX1MUFYJfG0y2R3ksbL8D4lD9tx9GDdeXUzPY6unTeIKmG
         V9dtW4mmjiwLfjpOmioSAcTDCNj36yZjtdPSu8X1IabNsjOrLjH+kD44q/+1u4qQYYSq
         4BP66j/DBi2OwDC5h9WMfKlZvV6YTmy7wGcqZq3uKqwR0tldikBEi1S9CZ4JpVFk1PAU
         B5Rw==
X-Forwarded-Encrypted: i=1; AFNElJ8X4aDxbaK3FtXLaX/RmdF8GR9Yn/ZEMEPsI+N99H3J3+ymLHO8m57JotFQQS7qrRISzX95C2bXorI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJGf+/2YZrA/ff3SRgr80ej67tAMDs8d4nBKM+UXE0tk89mfm
	DgSHm1X/2guijYnCagAkTrLSHWRgi3pZo/A9VxP5pMIKyxqsvRRLWgJz95iyHA==
X-Gm-Gg: AeBDiesSY5QdKPWw7+e3/yLNu27qztsZHGlk/hu9VFve+o4iZGnz7iYY69kIM4hbmHl
	0bkJaRmiaM9Jzij1TJqxzDkMH4zTCZ6efKMzIvq2CGN/89MASeuXPlVgbFE/fL9zaaOLhpeqwYP
	YH2DcjU2SRvN2R2udOMGwqU90Q5J1FqLxzsCWdKgM8VyZopoKupdvaEP3L76KuF+on37fJd7BQG
	F7RrDLXzXvNMWKpdPfutNu5U1MDN12G+biAjahmsD5BaYN3IRMzAuy7issmKHt/gEjk3uoJMjrx
	PxZsVkikvGpZWQgT6xIgWFfY4eb99FGXHDSqXhHpwQbkdrpMkIJWATstg6s5f0HKzxeJB/oERWU
	Jy6HBAn6qF4zVaBJ7SL476b6AHyU4/IqYLVElfQV40aRm5nBhhouwCALqPZ0Ei7Hicq4/pV8RKx
	FhONiiaV0SGy6AIVWUTtzwkiTi0pH7WG+e5Q==
X-Received: by 2002:a05:6a20:431e:b0:3a8:284c:fa3b with SMTP id adf61e73a8af0-3aa5ac98bc1mr5493704637.48.1778114501965;
        Wed, 06 May 2026 17:41:41 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8253582a60sm370848a12.1.2026.05.06.17.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 17:41:41 -0700 (PDT)
Date: Thu, 7 May 2026 08:41:23 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Lukas Wunner <lukas@wunner.de>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Han Gao <gaohan@iscas.ac.cn>, 
	Bjorn Helgaas <bhelgaas@google.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, linux-pci@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Han Gao <rabenda.cn@gmail.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Add quirk to disable PCIe port services on
 Sophgo SG2042
Message-ID: <afveQQI-CsQ2L1-N@inochi.infowork>
References: <20260331175658.1015829-1-gaohan@iscas.ac.cn>
 <20260331175658.1015829-3-gaohan@iscas.ac.cn>
 <q6wmn67lzk5c2pgmgkoezcvy3xj3yqecg675gx7xyrw3amjwpi@5pjla6j3krbv>
 <0f42afefd9322779af5463b696c55b08d2296ea8.camel@iscas.ac.cn>
 <afZUxYhkCQ0wG0Uu@wunner.de>
 <68d4a49bf1df785ae906fbc2dd16e64b667ca5f0.camel@iscas.ac.cn>
 <afcMtlBJYeuxSqZr@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afcMtlBJYeuxSqZr@wunner.de>

On Sun, May 03, 2026 at 10:52:06AM +0200, Lukas Wunner wrote:
> On Sun, May 03, 2026 at 03:10:58PM +0800, Icenowy Zheng wrote:
> > It's used in multiple products, but only one of them (EVBv1, which is
> > just an early EVB available for a few people including me) lacks an
> > onboard switch, because SG2042 is short on on-chip peripherals. All
> > other devices (including two mainlined ones, EVBv2 and Milk-V Pioneer,
> > and unmainlined dual socket rack servers; Milk-V Pioneer should be the
> > most popular device because it was on shelf) have an onboard switch to
> > mitigate the lack of on-chip peripherals in SG2042.
> 
> Who knows, maybe someone will design a product which doesn't attach
> a PCIe switch to the SoC, maybe the lack of peripherals isn't a
> problem for them.
> 
> It seems reasonable to accommodate such non-switch use cases as well,
> so I think you definitely do not want to quirk all products using that
> SoC but only those that need it, regardless whether it's the majority.
> 

I think it is possible to quirk all the SG2042 products, because the
typical usage already shows MSI shortage (And this is why SG2044 has
512 MSIs). Although it may left some MSIs in the test case, MSI shortage
is a common issue in a real scenario. And the Sophgo already maintains
a whitelist to limit the MSI usage of most devices in their vendor
kernel. So I think it is fine to quirk all the products that use SG2042.

Regards,
Inochi

> > > My point is, you want to constrain this to a specific product, not to
> > > the SoC.  Can you maybe solve this by not specifying interrupts in
> > > the devicetree for the PCIe switch?
> > 
> > The PCIe switches are not described in the device tree at all, because
> > they're all just discoverable; can we describe them in the DT and
> > redirect their interrupts to void?
> 
> Yes, somebody did a writeup how to represent switches and endpoints
> in the devicetree:
> 
> https://farlepet.github.io/linux/2024/02/20/using-linux-device-tree-with-pcie-devices.html
> 
> And then I would try providing an empty "interrupts" property for
> those switch ports for which you want to avoid port services being
> instantiated.
> 
> That way you could selectively *enable* port services for specific
> ports where it's useful.  Let's say you need DPC on a specific port
> to contain errors of an attached NVMe drive.  Just assign a single
> MSI for that port and assign no MSIs for all the others.  Much more
> flexible than globally disabling port services.
> 
> Thanks,
> 
> Lukas
