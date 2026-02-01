Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D83195EF;
	Sun,  1 Feb 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769948895; cv=none; b=o4pYcqSw3XityFml2vjOAV8AHng+brdIfh6e77kdZ5oqnQf9FtALWJ+lS5qH851sR4WERkjFbY2YDuRCI9KOx73y48CnMPjaQYZBxcf2+07XRijnGpDqskgPnx8PnNYO8gOr5R2CjknwOH4BjFxug99KvbiKldF188Anyu3HQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769948895; c=relaxed/simple;
	bh=x9TwMUy+wRDDN2yr7pxzvyLVYGWxpVW0zkafjCKEMcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osZjXeKxYMLhGwMy0hxJqVfOrRmqQEsYCX+Xxfflgnpa8sNmIJFbQX6AjD0pnNu4XpliSaNATJExHb6xXdtALAMGU8NBoauxbuKLPSa97Ift28VMDUxxjhqFjqBoNt79M1O1TPXquamtP9zjHcKvq098S02qsQcEFGo1XuikObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gs05jlRb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gs05jlRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A291C4CEF7;
	Sun,  1 Feb 2026 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769948895;
	bh=x9TwMUy+wRDDN2yr7pxzvyLVYGWxpVW0zkafjCKEMcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gs05jlRb07jjdH4O+O8f3ef82lbpXGPYtp+DCuoN00A1kLICm5Bf+TEwbz44DB7Vd
	 TeIehbToIFSpdHniVZ7bHxCNYeT2YvoxN/FokJKSCC7E5w0UpwlGJnkOpRlGpwPPxa
	 E50azS4THbOB9Jg4KJXzHjcXQVfZw+lxl0vPlPQEqcm77g9HEDfiy4nNQd3qjKSOGu
	 YXQRWBSG+6t3SDfrB/dsnR59bWe3YiIEH0AY8ffZg5Rv8bTA6r2N05vEtFf2WLXyw7
	 7o/L4F1oD1uk5WVOKaPk0vOfAocn45j7Yls5BJhm9aHV1O4UKrZJiynTMjBg7pIr80
	 4h8wWgmXN66Kg==
Date: Sun, 1 Feb 2026 14:28:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com,
	zhangsenchuan@eswincomputing.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v10 0/2] Add driver support for Eswin EIC7700 SoC PCIe
 controller
Message-ID: <20260201122810.GA34749@unreal>
References: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
 <176994869472.79432.11245161336216033848.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176994869472.79432.11245161336216033848.b4-ty@kernel.org>

On Sun, Feb 01, 2026 at 07:24:54AM -0500, Leon Romanovsky wrote:
> 
> On Thu, 29 Jan 2026 17:26:28 +0800, zhangsenchuan@eswincomputing.com wrote:
> > Changes in v10:
> > - Updates: eswin,eic7700-pcie.yaml
> >   - None
> > 
> > - Updates: pcie-eic7700.c
> >   - Remove devm_clk_bulk_get_all_enabled API, use devm_clk_bulk_get_all
> >     and clk_bulk_prepare_enable. Add resource release codes and add
> >     eic7700_pcie_host_deinit API.
> >   - Update PCI_DEVICE_ID_ESWIN_EIC7700.
> >   - Add reset_control_put release resources in "goto err_port:".
> >   - Delete trailing comma after a terminator in eic7700_pcie_of_match.
> > - Link to V9: https://lore.kernel.org/all/20251229113021.1859-1-zhangsenchuan@eswincomputing.com/
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/2] dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
>       (no commit info)
> [2/2] PCI: eic7700: Add Eswin PCIe host controller driver
>       (no commit info)


Sorry for the noise. The issue was caused by a mistake in my scripts.  
Of course, it was never applied.

Thanks

> 
> Best regards,
> -- 
> Leon Romanovsky <leon@kernel.org>
> 
> 
