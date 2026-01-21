Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2025330655;
	Wed, 21 Jan 2026 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986850; cv=none; b=Aybv6WM83Q/s1AHzlE4Ow7mDWp5wxsCX9o91S5Vdgd7r9IaI1QoYkq/ra2dDHi0o9bf8v9SfrTthZamMIaLV1WbX3o+Wb7yTWByhNND/tt/OR33521sIoGpQ8PQiz+1bNWz4qua0rtTtMMndmwFYN/XAFGU3tzzhVchQ/EsTo8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986850; c=relaxed/simple;
	bh=Jgx9GYR/7vBF/PZ2AWe3gu8a3WOsnNtP5Vaklo0buTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY1Ms0wXP/lV/vf7yOCdeOlAiTF+XkEJgIr+M0LlYp5qAWFj2e6RMvmeVE96Zr7QiIBO6zdXGe7Ql00I8VvS9uJDmd/c0AXkgJLB4MS/+sXw3gjtpnW0g+xgrcgzEtG9fDTqQvGPNnpxsWvd/XLfgUMTcwVXwnIXpt9kaNEk1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aurUxANn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aurUxANn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CA4C116D0;
	Wed, 21 Jan 2026 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768986848;
	bh=Jgx9GYR/7vBF/PZ2AWe3gu8a3WOsnNtP5Vaklo0buTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aurUxANnJzOdhwtlJ8cmQGDA0xAYOQxVhqL0EjxbQ6uu4ItJbcCfhYx5BjnfSc5Cf
	 EwXj/iApUE0d1wfD3iVWUxv+eFwXGw+EAjhEjNuUT+w1MIQLiXt3dHX5OAN7KAAI2X
	 /2KVx6voqkFSjE0ICZIA7vKIHmEXBl+GlNUdpSKdVgRt4841nPnXiOzWgUcHw1BrTo
	 PU72CCfiZTSRdiKe+IhIkzV74FQm55AecAjnyh6D26+XlyfPTZMuZrQhOp5EtiOkjb
	 CWm8ZBkDQHPKIpdjbHbIFvQ/M+GDqHWS9BY1ePfA7jzSHwoRyKur3aK9CzrK5KmwYZ
	 Drw0NWroRVW8w==
Date: Wed, 21 Jan 2026 14:43:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 4/5] PCI: dwc: Rework the error print of
 dw_pcie_wait_for_link()
Message-ID: <swpcfwykjzktuijaln2vzghjg35zppfyeiuarvrcpftf66hd6d@cfsznto43sqx>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-4-2f32d5082549@oss.qualcomm.com>
 <aXCNHnuvXJJZPU3y@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXCNHnuvXJJZPU3y@ryzen>

On Wed, Jan 21, 2026 at 09:23:58AM +0100, Niklas Cassel wrote:
> On Tue, Jan 20, 2026 at 11:17:43PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > If the link fails to come up even after detecting the device on the bus
> > i.e., if the LTSSM is not in Detect.Quiet and Detect.Active states, then
> > dw_pcie_wait_for_link() should log it as an error.
> 
> Nit: maybe you should mention Poll.Active and Poll.Compliance here too?
> 

Sure, I missed it. Will ammend it while applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
