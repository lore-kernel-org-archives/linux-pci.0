Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516B3EDAC5
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389576; cv=none; b=bBHLQTkmJ+vxGuh6JFJMbV0xZLdmoEGUL5/Y6k3KjPWx6RVcZe9BFczlHHtSE8Z1IdJrDhueBXwHyZbiiWtlVA2Wt/0HNvHdO8F7ExBaMH8CdwrlNHqeHk92OJl2+L2qfLCOGg/Che+PimxAHatnXI90hh5MJK/K4XwEtXL/o8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389576; c=relaxed/simple;
	bh=xPT/PnF3ipMXdL5HZ2UKdG57rjeVd9R8W089sYF7aAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYBUaTv48UCtJWgAhj9P3bI2cuNVUUqHfWlVi2k/asXrq24Kd/1SHHc+OsVhqOgpXGEbtfJmDm8Be6K8zkFphFRpJlrUUMzzUED/5WTP6VZk3NJ+GmUBMwVZs2me12xTYHBiK+RrP8ErZH8znh1Yx07gpb2ZrzbnFxm5OwoB9iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kMuTvzoB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kMuTvzoB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8947e6ffd20so34440296d6.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 06:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770389575; x=1770994375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k4lWKDjYMmNvH5qtebOMTo91r7WdaMfGxrMq2YU34WE=;
        b=kMuTvzoBWnAtEBOwag3UlwLUmz68ceOGMATz5BkExynwKeWTSD6EhwXMstDhjzUBv3
         DopLRy/OQd6zQ5fxtzHbFEVoGTDIxOuGUKY79JoZvSG7NN9kQKC6uZgfRS+eo8Gs8q7H
         c5dHrBnPZR1F5/lHSGaoB70DZhVc+eqzhY2Y0eEW3CTd/b/GaLvLOjnZQ0BxaTnnnVxm
         bf1AL5tEfT5SGuDfGdz08lA1KtbiPdoUemZttlZb7G3J7hdvCHFy4ECPqAmknb2Q2sRL
         WDjrozpchy4YeVwVstGh9SYMSJzGbLlzEbh36/u5mh8SvTEQvkZIDOezVJ4qF8bQxbzj
         ES8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389575; x=1770994375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4lWKDjYMmNvH5qtebOMTo91r7WdaMfGxrMq2YU34WE=;
        b=HqhcDfN0AQ4A5cixj6nNcz+/jmHiTaQqwTWvTmbZdUqVnPEKzwUgULMBwdZR2Qizk+
         T9nj8wK3DbY8H9aqLG1/TB6y1EmpGTe7jp/r9fPvWFJ+WuuLcie5K7OnyupYAgRI6exM
         XJBuG1RR/HQhphPoVR5fi1W680zokjzWUclIYim7xvu3s8ocJsuz1Vv4B0WfO0xjrKds
         RXsa18QvTMGeV4GLrj+r4VpXKBgCyo86V/QppCI1JPrc0FGTxUnpV8l9rnB9jfo2ndJ+
         oFYOCLjdm6K8BT2eGD8sStFn27Fxe23IdgtQPnX1chp0nRj6G8DQV7OvjvvRal4l4dbl
         rD8w==
X-Forwarded-Encrypted: i=1; AJvYcCXpNwuo05JFSAYPY2vTg3pq2ULclRVPCYgjYSOctYaTH0LOhJdSa0UcvLjIqDmYEyWmJBpWKFN9J3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlKQCO/nxXKgMdHiWFPBFk6ynk85H1TN7uw2hRcwvpX27w7P0
	wTofWXh/kxiask8akB6dpp5WAiIKJiqfDkrCvu5YnbiPGAjmnyU83PwZWdIDvDPGF98=
X-Gm-Gg: AZuq6aKQUMdbP0578KHHcWRoMC92oA9KgviPPYnrBBlXmKcTMYF984oBP9j9pC2EKTb
	0fbSWoX0SI8h2ifqycIQrgx7oUbJKctMnB4P/9h6pIwPsNXm4DVBxSEilc92SHy/Zkcl+NNh7Jn
	jF6EW+HJbVfaNfceAbGy4LPJI34T8Fm4UdHXjYGpzMe36u8X28Jx1gF73vQY1/zoBMRoH5PF9rq
	KrGoB0e+Ux7rmRkJYVXJmCLW4/mMDbM7Ku/ZTYbNIV+FvSEgMSd8c50m6XgVY7mM9fOtUc7FEth
	DuNLuoH6Fjq2bPOzp9ayN1U2pPWgTsIs7HZFIaC5rpEWKXjQegN5URaeyYZTZhXHkb1Sm++LNhV
	r8JQtFxSLf35EJSXBzK7N1MK+JNGrcIAdAuTcaeFI6ulMRgI+PHKHtOudDuuQWxM6w5X+Ew6i3v
	N1+XH9Z5s77Xjdhpuam/Fv1368bGqOtDGERy2itm6J9YFCNtYAY0VIGV3cF/UlpFQeshI=
X-Received: by 2002:a05:6214:3004:b0:894:81db:af6d with SMTP id 6a1803df08f44-8953cb7e05dmr42467716d6.56.1770389575237;
        Fri, 06 Feb 2026 06:52:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50639e26b9fsm17413971cf.15.2026.02.06.06.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:52:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voNCY-00000008V9M-0Hb9;
	Fri, 06 Feb 2026 10:52:54 -0400
Date: Fri, 6 Feb 2026 10:52:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20260206145254.GK943673@ziepe.ca>
References: <20260206143014.GH943673@ziepe.ca>
 <20260206144651.GA57945@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206144651.GA57945@bhelgaas>

On Fri, Feb 06, 2026 at 08:46:51AM -0600, Bjorn Helgaas wrote:

> IIUC the current situation is that for these IDT switches, ACS SV is
> enabled when downstream devices are passed through to guests, but
> after these patches, it will no longer be enabled.

ACS SV is enabled at boot time if an IOMMU driver is present
regardless if guests or virtualization is in use.

Linux doesn't change ACS flags dynamically.

> So my question is whether users are giving up some isolation.  If so,
> should we even allow devices to be passed through to guests?  If we do
> allow that, do users have any indication that they're not getting what
> they expect?

iommu_groups will correctly describe the system limitations with the
ACS quirk path and so all of the above concerns are taken care
of. Robin is saying the Juno SMMU forces a large iommu_group covering
the switch anyhow today, so at least that platform is not affected.

Jason
