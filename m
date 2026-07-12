Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581515E5DC
	for <linux-pci@vger.kernel.org>; Sun, 12 Jul 2026 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783835160; cv=none; b=LGmf6uy9czDPlJm5EpPWgLHNJ/G39kqGsOODXGuT7zlSzpHU/QHq6LlswPh6Jnky2ndOpIxZxq+cefZXV6/SeUBTYvfEboKB8oyAWYc/YIrJHO6joSNqxWlFeo7G5xjFPJG9oOFQAFIM6cTKoIW+iD9v6PfdVXxNEDD3JdA61Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783835160; c=relaxed/simple;
	bh=NO1wVHhYcEvuN+Lhqd6k/I8yI3Bz4oGZnZ8lkUJdfvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e62kEHGWd8N3tV56hkgm3X0BqJarVJzs97/P6bEYsp9WtwKe82dZnoPfOpn0y2EUbfxG1NwlJ+mwA87JTMngIfvK21Bd5owZ8KbaIgoJCZie50JzVHJ58vzA60SPcaH9Ibio8HO6pxJH2WbmuTtfGlxaATi3MQgbehTGtE/WKZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahpOpNT/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahpOpNT/"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2070751a91.3
        for <linux-pci@vger.kernel.org>; Sat, 11 Jul 2026 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783835158; x=1784439958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p5T9DanspdTbxdaM1wq6G9SRiLHrncHsKrVHDW8gIgM=;
        b=ahpOpNT/tJWp/tfFo6LgMqjV2IdUYTjcLs2+MitXrE33ESi+AHJeO6pqtb9QnzX8gd
         b8X9OJyAW0M7LHEqxgsr3bLDJG0ApxB0Nb7NSVZ+1tf8JD0zbMOz8OJVseC0hT5+X2q9
         kPtsMoHU0nzLKrxMJa6XIGlTkEtnta/8xgoP7qnajr3AU1Ix8Ar6oso+w4SXnA/pDkif
         ZTxtIh7z0ALV1lVgr16RNwrgNoBJbiS6xMjq8yQaLiBe9QNgqeB7PIfrF/8aXWyQ6hxx
         jHTz93UGuuYoWgBZuhVcDSx0fBwlcLvPbgYRnBdKFVy3icjSmBd4dleThzV9SEefw65S
         mTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783835158; x=1784439958;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p5T9DanspdTbxdaM1wq6G9SRiLHrncHsKrVHDW8gIgM=;
        b=F2CQ0XR9mF3iq/jyljxOkthKQobLe6/yyL9aiUTCFKlaBoIi3koDQZexQNo6eeIgvF
         APdScAD6CvYWjSb4wi9CpisX/e7y43fE1IGge+fKVlin9hz+7vs/f8SbxBt6QYN/oPq0
         erv8aoSisskiK+bz3PZtx+QT5NRCMJmlMdqREx+yAH58vXKZGRHOsf4TUswMYW+34nv/
         kD/JbfYIYF+N8cetCz6eQMCvv5q2uhDwD1c2Dx6aCwb0KI7KFYmZpfFjJxP0A3KiZX5U
         TWQfHZ/RGduUYM70nSozObRywMN+EUoWRCanTzaqHbTqjfgamsI/vUEwTd42qWNMVI1U
         //fQ==
X-Forwarded-Encrypted: i=1; AHgh+RqT8avXKnxCPvDtCa8YhLtVkSfspLByYk9YD/JYTOlnZIGI9c4N/SLSsEpNncHAkGuKx3Og4+/hFec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncXKFs/FQUNC8dJ8fjoZQhKh4kEPufAdrWwwo+bBmHKXVssgy
	Jvp/DQ/ohhflV3KAgIBn4NVxkP60sHkUelq0kG9b2Qn7B3a3rBAeMKsa
X-Gm-Gg: AfdE7clFw09AlWs3ntIF72pKe/cb2f1Bdb5DlS4Lri+sEEFqJ3ctRm0hs+CwcLhJXWP
	Et+XW/veSCfmCupq2SjOiHbENfQraJzDbmjHlDKLofz9MRXwh5JKbFozkggyhm3d/kR+K/nboKk
	KSpcXAm7HjLa3GIaheihx73NscRhBhkZIMSBsOwEG8YxCkfXwucJOGWahKz0y+2PJhSngHVZscn
	lL79bx2cT0+oqSOts49MACRc57/1gFgEzuN0T23JRE9StPklKT3qs/3Aq7s7Mw8i+Ydtfd2qo5y
	vwnKlgy/x7wQfW5jOTILpDCg0Jzig/Tua9g1SuIeQBSnc0E7YkKcKRh2GD3wBeyaTF/WSe1hEG/
	fbQnzX2/H1Vlb3glFJdgKzrPzMhzCczXcn19v0DjEr1HxI92O0LhuNdHHDV/3DYog
X-Received: by 2002:a17:90b:4a43:b0:37f:9ce1:cda4 with SMTP id 98e67ed59e1d1-38dc773bf14mr5210607a91.26.1783835158527;
        Sat, 11 Jul 2026 22:45:58 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38d11b82d32sm1866372a91.0.2026.07.11.22.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 22:45:58 -0700 (PDT)
Date: Sun, 12 Jul 2026 13:45:15 +0800
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
	Frank Li <Frank.Li@nxp.com>, Nam Cao <namcao@linutronix.de>, 
	Qiang Yu <qiang.yu@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Alex Elder <elder@riscstar.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v4 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host
 controller support
Message-ID: <alMpuGY3z1DTmqez@inochi.infowork>
References: <20260709040027.958400-1-inochiama@gmail.com>
 <20260709040027.958400-7-inochiama@gmail.com>
 <ak9L7k-_aivk1_Uu@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak9L7k-_aivk1_Uu@ashevche-desk.local>

On Thu, Jul 09, 2026 at 10:21:18AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 09, 2026 at 12:00:26PM +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 is almost a standard Synopsys
> > DesignWare PCIe IP with extra link and reset control. Unlike
> > the PCIe controller on K1, this controller supports external MSI
> > interrupt controller and can use multiple PHYs at the same time.
> > 
> > Add driver to support PCIe controller on Spacemit K3 PCIe.
> 
> ...
> 
> > +	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
> > +	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
> > +			PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE | PCIE_PERSTN_OUT);
> > +	usleep_range(1000, 2000);
> 
> fsleep(1 * USEC_PER_MSEC)
> 
> > +	regmap_clear_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC, PCIE_PERSTN_OUT);
> > +
> > +	msleep(PCIE_T_PVPERL_MS);
> 
> If PCIE_T_PVPERL_MS is too small, msleep() maybe not a good choice,
> perhaps
> 
> fsleep(PCIE_T_PVPERL_MS * USEC_PER_MSEC)
> 
> ...
> 
> > +	val = u32_replace_bits(val, BIT(7),
> > +			       GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
> 
> It's perfectly a single line.
> 
> ...
> 
> >  static const struct of_device_id k1_pcie_of_match_table[] = {
> >  	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data},
> > +	{ .compatible = "spacemit,k3-pcie", .data = &k3_pcie_device_data},
> 
> Missed space.
> 
> >  	{ }
> >  };
> 
> I don't see (and haven't checked) the context, do you have
> MODULE_DEVICE_TABLE() for this?
> 

IIRC there is already a patch for adding this, so I won't add
MODULE_DEVICE_TABLE there.

I will take other advice, thanks.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Regards,
Inochi
