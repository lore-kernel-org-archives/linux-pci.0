Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA535D603;
	Mon,  2 Feb 2026 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029856; cv=none; b=dGQWZY0Dk1qTMQC3fBt1730gBGq2Ak6qDbIuAXE/ozW4tlzcTlPwlrQCTq+ND0KtO3puodRrLLDxgY+PXXd4HrNhLV/2l+UpHHHHlQ9o6c5x2e6De8uM53SFhZZdVNmZeudWBPqgEHjeakVPVCe4USx3yTPKjU3wH/x3l7tE4gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029856; c=relaxed/simple;
	bh=v1nG6m4IXvpZK5lBkTIqj296BlgLhGZvc4GCeR9YPI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/Mq8vmLUD+Y4Ckrgd0Bd667RFwavgoKUqCibCTJ0DXeAiO/VGhJ4+taDR2wyY8EA81LLDC9BzPCJTvGE1DXvrueZVU78CMNaIWvwmSIavwtyJ8CYD+CHaHLfnYeAYLPUIOyEsF2b26P/GyUZIoZCdkux7L8vY72iO7CGAlAN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBalgowb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBalgowb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F187DC116D0;
	Mon,  2 Feb 2026 10:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770029855;
	bh=v1nG6m4IXvpZK5lBkTIqj296BlgLhGZvc4GCeR9YPI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBalgowbEnDJmkBDolYkcvGVzCpk+lsj56HS6WDLNUria80WxCkuIZBGsMsmFCltP
	 hPwnXQYeHVm7FZ1x64LGuECvl9AIgJCpy4s6U7OztKgqtTC9rNHxFx/g95GL/gdf0b
	 etF4j3kN4vHjvcGU0h67wdhBulxe+ORYBMUd8AgZc88cDO+o6UoSGpl2Kj/SKbBpHI
	 Y6E1yJ9Bb49R8N3vZJycauPhHdV8foXkqNBIXcSf5jZaGFwaNnko5Pi42riHJlY4sI
	 eXtlv0VEbUS3b0UKFnPXnStmxaDwK50M3RPnTr+MwxHlKX7T1cGb8Sq9DX5MkIYnLD
	 n9EUR2ng4A7rQ==
Date: Mon, 2 Feb 2026 16:27:26 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, 
	zhangsenchuan@eswincomputing.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v10 0/2] Add driver support for Eswin EIC7700 SoC PCIe
 controller
Message-ID: <wuchlwgfse5oubaqfchnxnpuzggbx6fl5pnnn5ouyfnllakwcz@xnllqqtg6rk2>
References: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
 <176994869472.79432.11245161336216033848.b4-ty@kernel.org>
 <20260201122810.GA34749@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201122810.GA34749@unreal>

On Sun, Feb 01, 2026 at 02:28:10PM +0200, Leon Romanovsky wrote:
> On Sun, Feb 01, 2026 at 07:24:54AM -0500, Leon Romanovsky wrote:
> > 
> > On Thu, 29 Jan 2026 17:26:28 +0800, zhangsenchuan@eswincomputing.com wrote:
> > > Changes in v10:
> > > - Updates: eswin,eic7700-pcie.yaml
> > >   - None
> > > 
> > > - Updates: pcie-eic7700.c
> > >   - Remove devm_clk_bulk_get_all_enabled API, use devm_clk_bulk_get_all
> > >     and clk_bulk_prepare_enable. Add resource release codes and add
> > >     eic7700_pcie_host_deinit API.
> > >   - Update PCI_DEVICE_ID_ESWIN_EIC7700.
> > >   - Add reset_control_put release resources in "goto err_port:".
> > >   - Delete trailing comma after a terminator in eic7700_pcie_of_match.
> > > - Link to V9: https://lore.kernel.org/all/20251229113021.1859-1-zhangsenchuan@eswincomputing.com/
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [1/2] dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
> >       (no commit info)
> > [2/2] PCI: eic7700: Add Eswin PCIe host controller driver
> >       (no commit info)
> 
> 
> Sorry for the noise. The issue was caused by a mistake in my scripts.  
> Of course, it was never applied.
> 

I was about to scream, but glad that this didn't happen.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
