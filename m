Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25511348445;
	Fri, 27 Feb 2026 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216683; cv=pass; b=izlILMXO/9KTzMIroIfAye+a/WBmUl5vnq4NEYeHgp/MSUybPgRksQ35nC8pRG6DKvd1QqPG88r0GIU4LatFEGEyVxcjAhjsQT+pGmDZkiQ22CId1ixbd0gCYh4KMdp1q8BHzIKoW70meQI9VRwjaXVZDGFTRRssYmEXcgiSg38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216683; c=relaxed/simple;
	bh=Ii3WkfOxQ6JChecRZKEDyLtaWP3XvgTOInRY7W3jkHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apBAfIa1qj/Svr+7vT8VA5Pie3tqxFbybMY97snrvaTOpLyurB85BoGKY7z1pO5LDWsu0gPKLH7tbcFVfL1VtGz0gPICoP0OL8dzXX7n1khr1GIK+12GHXCZDPrajOv6/HPBrXVqZkKVJvDzicMPrivBW96q474vhZVX6692Jac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=Aqv6z4XH; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Aqv6z4XH"
ARC-Seal: i=1; a=rsa-sha256; t=1772216664; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Gah7o/1uWwo3IF2458yscMfz1xOlXVnJVRBa1xwaaFGJWZVZRhXsjs1UTgYy6kQEC3i8uW/1yxxh5GPlHo260Evl1+XoIHNOV75/vbBgQZhf2ORCM/nRaqDttgSO4GCGeVgTvC+5wKYFXf2OcKA5zjn2yhIeymd1I4T4A/z5YBA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772216664; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mI8yeyHAyhIcdue3vlH9m104I7N5rePgew2fh6OCLaw=; 
	b=hQe+oUB3qGpra/qEQ4g6xDM0YAW8S9+Ej7w1YjhhPMkdgaSAY0R8+r2YCyeb55pShYK5XfEKSoMd4OkxlXN3FH6v2L8WvG+5FNDbbnIYP09KYILVn6onUtbm4crTXFCuC5eI7yssr5+2+bVnzflk8IiIf+pLyChdpdTDkS66qTk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772216664;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=mI8yeyHAyhIcdue3vlH9m104I7N5rePgew2fh6OCLaw=;
	b=Aqv6z4XHIjAYCP8xhwZpX9K4FnKem93HCPTtJGxwGwQGc6ovnlV3VzrAvHm6uHnI
	pVyBMVhpX+sA7krGlw1yCv1VIM5oetDJcyJH1n47494R7cCL+SeZ5ZJ9L6Ue1DoOQbK
	aTtF2qC4u0Xpprf73nVYZoUhxjrYNInuGd9+4L+c=
Received: by mx.zohomail.com with SMTPS id 1772216662000130.63085640564987;
	Fri, 27 Feb 2026 10:24:22 -0800 (PST)
Date: Fri, 27 Feb 2026 18:24:12 +0000
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Hans Zhang <18255117159@163.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Manikandan K Pillai <mpillai@cadence.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
Message-ID: <aaHhTNEhY4ytMvAw@pie>
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-3-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227181925.52475-3-me@ziyao.cc>
X-ZohoMailClient: External

On Fri, Feb 27, 2026 at 06:19:25PM +0000, Yao Zi wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms") force enable ASPM on all device tree
> platform, the SG2042 root port breaks as it advertises L0s and L1
> capabilities without supporting it.
> 
> Provide a platform-specific initialization hook to override the L0s and
> L1 support advertised in LNKCAP register of SG2042 Root Ports, so it
> doesn't try to enable those states.
> 
> Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> Co-authored-by: Inochi Amaoto <inochiama@gmail.com>

Oops, this should be Co-developed-by instead of Co-authored-by, sorry
for the silly mistake...

> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>

Regards,
Yao Zi
