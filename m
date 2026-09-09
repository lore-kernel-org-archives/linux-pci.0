Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4284D45DF69
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940867; cv=none; b=emxJGdugaV9QJ6IjmI9Dk51NpZvX+s/DnJYTdQPxwiNd3hu+KW6IAZk5aoTthCjuh5B8kaOK9kOxFosfnBgmDFh57N0posCzVjAp0PayaxyOFV2qd+qxvLgY2yX0fususWdtBJMRjNjeVMswCEzgD9350+rSkK+5KyYg3uD3srk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940867; c=relaxed/simple;
	bh=DOagFB3gfTzdfAu4ufX/3C2X1fRMpO74SBtnAgKij6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBryt4BgS7e8103NYcjgmYsmPJWfpRkWPQVPGu3Ex3A5FgG61R3rBs4aLBAngzdDetNKw1Lr5Mo1yUfKFEhzES5TIoI5bQroyPUAIJjvwrXhzN98+XoHn+MaAaRoKDfA0o3QWhhzNBos858LSuUNSHLg3qrb62xHhBIpzxj0ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExxMnNXw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExxMnNXw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2dd020a2e44so2164975ad.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 01:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788940865; x=1789545665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qknjfqhsbIT0khBlZrKXrrNMX6l5W5qybKPm+PV6LpA=;
        b=ExxMnNXwbM6zPhVxYNIkZtCLNsdzbRzc1O7Qryuop+PGmHGVFjKkxW6X0i1hhHDrXU
         D50azv0O+1uHF4pVuJtMweL09vGXQsEkNfuC/es6Mdaz8aHWXeWp9Nxzn+NpyTuopVMr
         /QX1uyin0hGCQQIxi86WWfAMeN+/1wAWjNducqN+lJW6p+GkRUKcQYkd2kH44RgxDPM/
         MdTcw3G+PClIfnimcMHXDTLZAMaBZfVRnOXJ8tJ/g6qXPVXqPUzB7RCehhPm3CgK2crD
         0QWIB48MZao/aCKXGvtPsAg+3oy0x+PbXrEq8d9cOCQejLOYP62TPFJJZoWxobbuoy9J
         nQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788940865; x=1789545665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qknjfqhsbIT0khBlZrKXrrNMX6l5W5qybKPm+PV6LpA=;
        b=VyASk53cuUul5brjBU/BZVd9rtWNUcoAHFJjoKy9JDAOZwTOY6wSoYzX5D85N34OeS
         GBGg+T70m6MfXkRScWutZl8JcIe3pCaP6CbzlFQ0Hp/9rS2aG+IKN6hcI88F1m3VGghW
         lU+lxDobhfHMYiaVH/ESZbhQjL5pqDQwzWsezvf87mzb7j+uNGYd20TUpy8qbKHGL/Cw
         kig1Ef9bUB748dV+hF65uwb6XOowTeSBG+yGCGUEdwJgyHnuz9NVDekhov3VoCsWwKVF
         7nSegfKCXjlipDGUmstTAfgxsazfkXX6SIirU56uRNUmwYpYoT6SFPDfItT1TGI8futU
         cSKQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/DJQPtUzOLPU6nNeX1Ul3F6TCHb5iqfwHy27z2R/Ica8KiuWZR8+4RRSb3VB0D4RKyLaDt03DaTU=@vger.kernel.org
X-Gm-Message-State: AFuF++km6MSn0/rONW7kY3X4NOQ+VC+rC3dGiPq3mO7SYDTckF7oIy+7
	QT3+UuHXRMdekq5Sowuo16ku+9eX36CKuq+JME2GjrqubRPf4x+GfA/X
X-Gm-Gg: AYBFou0xixw1d83O1OnNXjVNG43KYNBG5mFJNARhXfhPe2qdSmDUYg8SyjLYYOYlIrw
	Bm+RyqMvgNLnF0f3AtRiDSM3mctRFMyBjZvGFFPnlrUaxVImmJ/cO+6rmX7+MDP5azz4Np2SzeL
	xnqCdGHKGED9vf+N0GLbiq7+dHRZAiCvgHYY29+Mk9VB6KhDDZ59Hi3+iPQBSXYZICmswOrOQJI
	3rO2Jg4+FJ8yBTCsi4S3aHL7y/Fa01aRAyXGJGwo/9pTmoTYbN/RoxQ6eeyxrn0K/aVHxXYttZg
	tf2NUvJwYnxu7IwAQiEW/b3jsZPFFIhJKZ9LbLwhJFJ0TmxvkFw1yMbdh8LJ2Q+6H30xaiHIfjR
	TVL30bBT/Ha1yVpaRrmxSORGggdR+pl8JnVYu3UpfgQCs4na7cU/JC32QpjWbEn+ygXlJP0SlEG
	e5idN6RKXuFhDgX8C3LMPWZnxKSfeiibn4lRJa+Ga40PwPmlBSuGyLkjJGCr5WaqiBfeefrA==
X-Received: by 2002:a17:902:ed8b:b0:2c8:2808:3ec9 with SMTP id d9443c01a7336-2db126d8fc2mr319851615ad.12.1788940865429;
        Wed, 09 Sep 2026 01:01:05 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14aec084sm66832155ad.84.2026.09.09.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:01:05 -0700 (PDT)
Date: Wed, 9 Sep 2026 16:00:33 +0800
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
Subject: Re: [PATCH v5 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <aqESGs3_BxOd4PYg@inochi.infowork>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-2-inochiama@gmail.com>
 <ap_i5Pw4nVB4LZ-7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_i5Pw4nVB4LZ-7@ashevche-desk.local>

On Tue, Sep 08, 2026 at 01:26:44PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 07, 2026 at 07:26:00PM +0800, Inochi Amaoto wrote:
> > To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> > data to handle the K1 specific logic and make room for the incoming
> > logic for K3.
> 
> ...
> 
> >  static int k1_pcie_probe(struct platform_device *pdev)
> >  {
> > +	const struct k1_pcie_device_data *data;
> >  	struct device *dev = &pdev->dev;
> >  	struct k1_pcie *k1;
> >  	int ret;
> >  
> > +	data = device_get_match_data(dev);
> > +	if (!data)
> > +		return -ENODEV;
> 
> It's better to use -ENODATA which will help to distinguish from other ENODEV
> cases (which are more often to happen).
> 

OK, thanks

> >  	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
> >  	if (!k1)
> >  		return -ENOMEM;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
