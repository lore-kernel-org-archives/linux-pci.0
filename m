Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9F349CC4;
	Thu,  3 Sep 2026 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449424; cv=none; b=hRBaK7RFPbsrBNjg7XRu5+iVt2uWFG6Du/TJ8fR23qtnGWiRWLDUJpfiKA4RigmtrGQW8QpxhWZGOUh/MUR+4cYkkwt2xs0tgTAAJMaBNIdqwtnH8BUvaDOxU/sxxXXu5rkLiHTIe3FvGzw6D682wVGhZJV0FseBZDQ1i2ZKgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449424; c=relaxed/simple;
	bh=igK2Lbyd0R2qypC3ipHfU3Ogcj7yNt62I8Ee/RUj+ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA/+IbcEj/58LXIY/7snqe1ndLw+sY2QEk/zu1MzBPVQ2hm+sTufmlpSPYNP3BOmFq+XekolRof/GEZtLSaJnSQlUrXQ8OZShi7sWOrfkk6JSJGSUXXpeB1Kf/OSOH6GCcTUoLTKevxYkwcJKtZSrYiN/vYWhNree66yeWbw5Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V92bK3R7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V92bK3R7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5681F000E9;
	Thu,  3 Sep 2026 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788449422;
	bh=0ixQOJk67cBcJbThkafmo3RCGMIWaXaMC6Fp5HtEZNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V92bK3R7qq3PiksGb5nn60rPlDZFJ7nTkCbV6qn6Ad5XdVk/hvPe4/pdPjD0NeUPU
	 qdasZvZnzjlB2/BySMvfrJEErmvFGDzVvPk1CfDO54erX6oJZ1XKO7Gs0KZBaS6nUt
	 hvcdRRZ1z5oUnlZ3t0Ly2rD+UVQVM4jV7wgsXTyEptXJt/P5GX93e3VnR6qNkZPdF3
	 j7Az9XPTSDJYrLjvu3NlGjvP36vlms0L38pEvXXUNYNmSWneIw7kP/LdTohru9HYZI
	 X8GQ4MfTgy2UO2MkelKzzjDYuWmFMlb9wuRMlWhbH+LetvBkLd4izBVxnnOjoJONYe
	 xERDXMqGfcJJg==
Date: Thu, 3 Sep 2026 17:30:18 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	wangjia@ultrarisc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU
 setup
Message-ID: <apmSiooxKzb9l-TB@ryzen>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
 <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
 <apmPeZEdanf80HVB@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmPeZEdanf80HVB@ryzen>

On Thu, Sep 03, 2026 at 05:17:13PM +0200, Niklas Cassel wrote:
> 
> To consider allowing this, at the bare minimum you would have to:
> 
> if pp->bypass_ob_mem_iatu is set:
> 
> 1) Verify that the glue driver has no .cpu_addr_fixup callback defined.

Looking at dw_pcie_parent_bus_offset(), I can see that it already computes
pci->parent_bus_offset correctly, regardless of pci->ops->cpu_addr_fixup and
pci->use_parent_dt_ranges, so atu.parent_bus_addr will be set correctly.

Thus, you can ignore 1).

But 2) would still be very much needed.


Kind regards,
Niklas
