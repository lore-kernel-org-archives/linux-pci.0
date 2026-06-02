Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A93ED125;
	Tue,  2 Jun 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780414810; cv=none; b=TwXeP5D5Hhbom8b5/xhz9z0JjNa71CXG+ihQhbzdPPqXYdhcyWF5yRy/srAN9vclTC3ar6bPkWZt3l73uQsLNFBDLh6wHyeHNQDrQrowf3OyDRcqMOh6b57uSHc1jc5YRAdLX33PHnjX7S/Uac004R4XDCUqRBxIGsstF23TM/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780414810; c=relaxed/simple;
	bh=/W4kUxk/d+9cy5oz4vpcI68h1R9vlRc/o4AtfkrLvMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYqGhTpHWi/Uv2lVnJe6HkBXeqoA0oNh/EawJfndyTK6MHV17j9A3DPt7bMOwHzFMB0tQmarcqrbuESrQVwtDJabjk+cVAx9hUGClFik/bsbHB/D+Xlmz8eCq5nzz0qMCKWNGvZL/TaMEicLBnh5baLPmygMBsW0l9qhxiNytTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE6GfdYw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE6GfdYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDC91F00893;
	Tue,  2 Jun 2026 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414809;
	bh=XwIHfh84CVCmmZSgMIfKRu78vSsVBQrQxj9tsie8akg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FE6GfdYwE5QtQPOD68lh1a4gGQbnW5I+zpJ/VY0+MmKcFBKBnXrNVNDU0f7sV+VIx
	 SFMd3uddjTFAxhxyJ9wiSuH1Y4F3rh9afJM9Db5Iq4Kj7q4e2FzPo807ytrtIs51qr
	 6A+EzjjBVcM0NVqe/ZY7Nlns5+Q2QlD62yTQKSpKR0XO8I3Mula7JNpRyhrnho/TOr
	 amSdfDCrEc4SS7QMd/izMj40+ORlC9cx+ZXulrUzgWJ2ZShCQHmok8JsbLX8/OWRLm
	 XS3wTDcUPPFoMQzvP3ZZ0lfDFEeR5Dupk8MVWzNVNM3nKBDJH1D/crwZCVMgmem7l+
	 HR4fL3wTdAOOw==
Date: Tue, 2 Jun 2026 10:40:08 -0500
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5
Message-ID: <20260602154008.GA362770-robh@kernel.org>
References: <20260602-tegra264-pcie-v6-0-edbcfa7a78fe@nvidia.com>
 <20260602-tegra264-pcie-v6-1-edbcfa7a78fe@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-tegra264-pcie-v6-1-edbcfa7a78fe@nvidia.com>

On Tue, Jun 02, 2026 at 01:33:23PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v6:
> - add maxItems as suggested by Sashiko

Sashiko was wrong here. While the analysis was correct for json schema, 
it didn't account for DT schema's processing of the schemas to the final 
json schema. In this case, this:

items:
 - {}
 - {}

is transformed to:

type: array
additionalItems: false
minItems: 2
maxItems: 2
items:
 - {}
 - {}

The reason is a fixed, defined length list is the rule, not the 
exception for DT.

Rob
