Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC34825CB;
	Thu, 10 Sep 2026 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042647; cv=pass; b=mTLruf3mN+XRUzJLheSpdvI7pgGna6g74MuXJ3EWknA4Yoq1wXZpoJ4F4tKCayey+XdwOEg8WqZCEd+ooQ7CHK0f12uiWU8oWmvbQGeevxuh9GbfWEw99xCNGSgNPy4y7jjbN+7HPw3Nyjp/ohuPB6MG7iFoDPgiuDaRb1kKv1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042647; c=relaxed/simple;
	bh=XqfBBi0ToHqfQuSFWAUDnRXWEzzIcqz+Wi0omWRavS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cY/qfTRHh/bw5Vw4ZmPF1MYELOc6IdBdi9u1eFb/H6k6Bsz3xWq6V4juTn8XlBoXIdeMcV3a6lMoIsHqnSB6kfr0RcDJd9mEtMNXrVvInOVcFHcDBgJ28F4ztOPETR1Y068V1tbB3U0U4jeJ5WmowqTG3r6RAyD+mvZOaZpE+vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=E5SFTABp; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="E5SFTABp"
ARC-Seal: i=1; a=rsa-sha256; t=1789042561; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eiFmGZSkzZnvdcn2Yd4jasR4zJjj/F3mE8Zk084P5wgyf1KLSWejb1wGED5LCfCSESZbB583Lflwg6+lsAz2UzTS4PO6OGjOHhbvaVaJEA0QdyhZSXPnhhEPpFPypsWsWdhQ2eKWvP0FGXktp8yyX5xy3Fxzbn85nUmNfsZlZjo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1789042561; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0rFMiU8kFEuo55R90X9kb89jBCP9eUdAYLBLr3iWUq0=; 
	b=Zj3b8x0gzciX6Vq74QXuL7uFWmnaqeU+KkQZTAorb0IjLhPyKLqJMVP+A+/7HsX3vBRKrvE+GEA4LKqd63QBUkRodwcEwhvWc3nMtgM9Hi7xw85EDdV2LnT60KaPQrb6AzJyrHh4fcnl0S3d5ABpY/xQEHlMANrgHzxdx4IGESM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789042561;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=0rFMiU8kFEuo55R90X9kb89jBCP9eUdAYLBLr3iWUq0=;
	b=E5SFTABpWoUMa04sEEBesqi8SptYqwobUdF1WVfyP+/hd3zcf6yjL/2JAi2leF0z
	lNnSIk3c91rFkUWNH83saTh5TqyDrQjstRV7Pmw4cprofqm1RreJzX77NhmKmst8rcI
	khTHOC+QkyQoSpPGqXHaKWXl+mV2IcIvxICBSxyM=
Received: by mx.zohomail.com with SMTPS id 1789042559214896.8848926233107;
	Thu, 10 Sep 2026 05:15:59 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:15:39 +0000
From: Yao Zi <me@ziyao.cc>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yao Zi <me@ziyao.cc>
Cc: Inochi Amaoto <inochiama@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v5 1/6] PCI: spacemit-k1: Add device data support
Message-ID: <aqKfa8KAh2JJwivA@pie>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-2-inochiama@gmail.com>
 <ap_i5Pw4nVB4LZ-7@ashevche-desk.local>
 <aqESGs3_BxOd4PYg@inochi.infowork>
 <aqJDvogeo3avWWQ3@pie>
 <aqJRbzZhROtXncZu@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqJRbzZhROtXncZu@ashevche-desk.local>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/289.29.40
X-ZohoMailClient: External

On Thu, Sep 10, 2026 at 09:42:55AM +0300, Andy Shevchenko wrote:
> On Thu, Sep 10, 2026 at 05:44:50AM +0000, Yao Zi wrote:
> > On Wed, Sep 09, 2026 at 04:00:33PM +0800, Inochi Amaoto wrote:
> > > On Tue, Sep 08, 2026 at 01:26:44PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Sep 07, 2026 at 07:26:00PM +0800, Inochi Amaoto wrote:
> 
> ...
> 
> > > > > +	data = device_get_match_data(dev);
> > > > > +	if (!data)
> > > > > +		return -ENODEV;
> > > > 
> > > > It's better to use -ENODATA which will help to distinguish from other ENODEV
> > > > cases (which are more often to happen).
> > > 
> > > OK, thanks
> > 
> > Honestly, I don't think this should even happen, since every compatible
> > supported by the driver carries its own of_match_data, and failing to
> > do so is obviously a driver bug, so I think this branch could be
> > dropped.
> 
> Does this driver do not support driver_override? How comes?

Oops, it's my fault not to come up with this case. Sorry for the noise.

> (Note, Sashiko is full of the issues of not checking for NULL the matching data
>  and hence it describes a scenario in which this leads to NULL pointer
>  dereference.)
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thanks,
Yao Zi
