Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C8455624
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940850; cv=none; b=ZXPTwCFaG6HumeTty2hkP3XHqPvZygFV+g1mJ6Ho/+dLCndQIsqUwi3rN0g21T6Bj5DA0gJTHtvfJuaUulq3kyOXw28jegnMTcOB7MQbBzzzXjbiGhSymFzn97fywQiuWT8+8kbMtc2qqJ+J9ZOa8d5b/YD7pWDIh7+gfm7hKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940850; c=relaxed/simple;
	bh=aN1MVkOCjwtOucEg+oqql9Bc/Rq8wSbHbAKKZ6P53QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D55mBEHWGgEEijaO34w4BM0I5lXJMBBLigWAwL0upCxJB/g9xxRyZ5oAr4mr6eGlvkMxDfi9xav0QMVdBi8B2XMSKpU453kUABBS400FOBccUUbB2JgJAbRPYejsuHI8ZXc5MDzCGUOPnfckj75gzCspe4bvybeQ/XEdjODJSt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2eN8CAY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2eN8CAY"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2dcff8f44f2so5152815ad.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 01:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940848; x=1789545648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KTUPUjrKl8uCmmUdksk98ps3euLofcTsZvaXovInbao=;
        b=C2eN8CAYzMx4WTAcGWVcwXErM0jOxTQm/d9Dv3GFEbwR8VQGxz8MATAew1M4kPZkA4
         +2OX1NgIAIu6HM+c2Dvmflur/YREZcONrVjNHzgZFERXsKDXofpXs+IVu9Kzm6e3tpDX
         EPbp51rKc7PuPOvaL4e7orP808wu0AI0EAimfJGbDmb0IYiUTQD1G/ds4zaXQ8h+T1pJ
         LxsexshAxAkttyec5BYidKWvJFll9R2IsZLVhQmYfASYikwANWgb01fsWbgHw3soSmAD
         YuSThxA2VaZ9YYXElsmWmhZ4d+Hl02uaiWfYm/k3MogZB7cer9p/wmt9lLP4b0/omwR+
         IbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940848; x=1789545648;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KTUPUjrKl8uCmmUdksk98ps3euLofcTsZvaXovInbao=;
        b=lWJe+2JA+pmC/lie1ctBQsi+rnYVoVQo0/OCNQ7/QcGGrGgwPfaZeZHxY1SkH2BFYE
         mAr1DSGtGqQUa68fCBGDLsCLRf0RF3K12jiTXJiTL4kzW2eo0duBq58pB+EzKU9W+QNo
         ml5owXuWrkpyj4a4Y97oW4lz08WNiCcQtzWRX7AebB+Z53MUij23oP4ckl/wWDIe1hBq
         SKNJuvTxbtIoIPyHt28d5AcQnMSTq3lHsvFf/EfZzcIFOS08MMS3FkTPieyUCcyCKsZq
         0KSygc4wC9zTWM6fYXAWH4otBPwQJnENVSBqTLKwyjZkP40UsTjg8ineZtGg+nHmpoju
         OK+Q==
X-Forwarded-Encrypted: i=1; AKwUvBw2enMBJaakqCmqrlCFKhMOFDfU0mrxbeVU9DXenlx/CxvD5pvcX2iGkBMrdf2v3mF/yyYjbvNmhro=@vger.kernel.org
X-Gm-Message-State: AFuF++kNE3zDzFXK7kBnPJemEN9LapFCUbziD3V5uLFk+cjhRdNcQALP
	KugFZYF249Yole+FWqGtjYRnDNA0UtmXmcDeIABAL03TdFXTaQ28jZaX
X-Gm-Gg: AYBFou1PIg5YUq6BQxr1WxHyoIHgMfT5JcC2CnMpLfDUM1fN4uODt2PDC9tUPfy54ek
	Qt4r20Q8Wapy9wmoYFA0QgYyjAVEnk55DpeUAKggz76pIfepE5zHpCXC57/Ztv8Ngw65eOv2ccO
	eDL6S2T/xDk/mK+Dq2pzjhzrblZUSKOfPp3eALCN/domFpuRR/pNOLy7HMVMrSCxdIbg1HPDu+v
	x6f4Xoj3QCjY33CWZBFAyFdg440HzPNGNz/vc8/ua6dZiWt4r/fHlGES187ht/rzrR+p21Z2COH
	Qw7hEEjL29LVJ1XtYP8VXGvbqqZjc8iEd+C8+k4LamHUqoUJB9NRPWj0amP8wcNdfaWYzIV9BF2
	sqFknWj1Zt8Wz2Rrs1zys63QU5wma2MJZ6DNH/ynsRhvJgG34qKIpSA0s0AsIat2BZZjHwEjeMb
	zR+r8wjDfBuuLGWDa6Dw/ncJ27Z0XAwGActBaiyIYh2ycU3uJuzMGMWHiHuRZKJhyPBB4F6pMFy
	aXPK1is
X-Received: by 2002:a17:902:f70f:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2db1225b297mr497594465ad.0.1788940847987;
        Wed, 09 Sep 2026 01:00:47 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db56c2a1f1sm37775965ad.78.2026.09.09.01.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:00:47 -0700 (PDT)
Date: Wed, 9 Sep 2026 16:00:15 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, 
	Sherry Sun <sherry.sun@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Bruel <christian.bruel@foss.st.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Alex Elder <elder@riscstar.com>, 
	Xincheng Zhang <zhangxincheng@ultrarisc.com>, Randolph Lin <randolph@andestech.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, 
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: spacemit-k1: Add multiple PHY handles support
Message-ID: <aqEQnkrPSKB-3fam@inochi.infowork>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-3-inochiama@gmail.com>
 <ap_jh_NAqHnIlZeu@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_jh_NAqHnIlZeu@ashevche-desk.local>

On Tue, Sep 08, 2026 at 01:29:27PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 07, 2026 at 07:26:01PM +0800, Inochi Amaoto wrote:
> > The PCIe controller on Spacemit K3 may use multiple PHYs at the
> > same time. The feature is not supported by the current driver.
> > So extend the PHY definition to support multiple PHY handles.
> 
> ...
> 
> > +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node *node)
> > +{
> > +	const struct k1_pcie_device_data *data = k1->data;
> > +	struct device *dev = k1->pci.dev;
> > +	int count;
> > +
> > +	count = devm_of_phy_bulk_get_all(dev, node, &k1->phys);
> > +	if (count < 0)
> > +		return count;
> > +	if (count == 0 || count > data->max_phy_count)
> > +		return -EINVAL;
> 
> Elsewhere we distinguish count == 0 with -ENOENT.
> 

Is there is an example? I think it is suitable for its internal check 
to translate -ENOENT to count 0, because no phys property means no
phy. For a get helper with optional semantics. I think it is fine
to return 0.

Regards,
Inochi

> > +	k1->phy_count = count;
> > +
> > +	return 0;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
