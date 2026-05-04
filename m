Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F51C35F5E2;
	Mon,  4 May 2026 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934999; cv=none; b=Y3MZSgakFMosaHr/5CHI9xcf/FDqKXcuYIzsSzp8rh78kkoVtD04yOMVrdnyVpdm2uiRuP5PLrfAqcU59tCAR1JiILgGczeDoZSW8VYRZLh8jzLbZf4eXyPz0XU/Bh1fnKbNLI2h7ZZVm8CQz3TB4ZZ+vGu8PrcGwtjfBivj24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934999; c=relaxed/simple;
	bh=CIMiT+a8mnCUitmVimzYzkH75QFn46DVenKLi+1avlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gfPICGHQc9/EzO0pVJb0axG2TKizGCUEbF8d+FmYWtwuHr6Bq0jW29akXni5/s9rvsQrPMyS+3wyCUIAMHtXnu+gUtQeQHjt99uVjAZNQba+KDmDGqrtRaaSKCyR2bgnbrO+pcE7HTI9Q9+vboLFz4mpIEPw6muRQh3NW70+t2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCgMS0KB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCgMS0KB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8605EC2BCB8;
	Mon,  4 May 2026 22:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777934998;
	bh=CIMiT+a8mnCUitmVimzYzkH75QFn46DVenKLi+1avlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MCgMS0KBcl46EspKOO230wLDaLJROSln+PT2/MCUp1W/TpcMEG5oK1s7EyRW6Rasn
	 lFn37ODBRHzLINyNT1DzHr0OSd5CMnqlZNTwxibc09xV/MFJCY/QndSRlV6USdbe7i
	 uWl/M0xh6oUwhG8m1LizKFbDAv+f+U765fxp5eEl4ZUkRnV0XEm/C2A6Cdbz3eI4Oh
	 x1FV7We6nKIqmmACW0CWsoiNoAEkhDR2PFBWf7rwoV/4pdHjai14RpdEhaYIQnk709
	 cmJOJS3tub27NsGicuKQLs+I22wEX2GW/OCC+Vrgr8nmE/O4Toe4Oat6gniNYvospb
	 9qfM8Bzrn6B/w==
Date: Mon, 4 May 2026 17:49:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, will@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, vidyas@nvidia.com
Subject: Re: [PATCH v2] PCI: host-common: Request bus reassignment when not
 probe-only
Message-ID: <20260504224955.GA669929@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414081730.3864372-1-rkannoth@marvell.com>

On Tue, Apr 14, 2026 at 01:47:30PM +0530, Ratheesh Kannoth wrote:
> pci_host_common_init() is used by several generic ECAM host drivers.
> After PCI core changes around pci_flags and preserve_config, these hosts
> no longer opted into full bus number reassignment the way they did
> before.
> 
> When PCI_PROBE_ONLY is not set, add PCI_REASSIGN_ALL_BUS so
> pci_scan_bridge_extend() takes the reassignment path: bus numbers can be
> assigned from firmware EA data (e.g. pci_ea_fixed_busnrs()). Skip the
> flag in probe-only mode so existing assignments are not overridden.
> 
> CC: Bjorn Helgaas <helgaas@kernel.org>
> CC: Vidya Sagar <vidyas@nvidia.com>
> CC: Manivannan Sadhasivam <mani@kernel.org>
> Fixes: 7246a4520b4b ("PCI: Use preserve_config in place of pci_flags")
> Link: https://lore.kernel.org/netdev/adcXzcz2wWJFw4d7@rkannoth-OptiPlex-7090/
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Thanks for the fix!  Was there a bug report associated with this?  Is
there a symptom we can mention so we can connect the problem to this
solution?
