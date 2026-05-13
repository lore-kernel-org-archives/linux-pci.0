Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1383F2D12ED;
	Wed, 13 May 2026 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655667; cv=none; b=uuEsWhZ5e+ZiYAEc+3ciPKGL3xQJF8bcGcVKQtbOiAWcwhZa227lmYzfG8Y6diFfa0wRX6m5YhHkSP4LvPAkGl0jgwrPWQN/aNZy9oo+LzyM64mRNdLva22aZb4SOM13BpIr3WChHGGKZ98T83h3b59p/LO/qdu35KCqy2JfiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655667; c=relaxed/simple;
	bh=c/6nC5w5T/aAJxpIk6wRl+kP7ERq5HuXfNpn+R4tDh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo4v9uyFfvoogSx/aA946GVLPfrpxo6V/9A+imrEzLfnY2L6gY61teH/lMELOVgxQ3wH4FYe/C1+A37TD9EswL+G4XNpJTSOLQF0mov0xMUI+RpNl0TVTz1ndqa6d/t4TLRep6MORcdrM/s9jM/nEhP4szB+GavhhJOM8b9vaTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4ZsjtHj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4ZsjtHj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309E6C2BCB7;
	Wed, 13 May 2026 07:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778655666;
	bh=c/6nC5w5T/aAJxpIk6wRl+kP7ERq5HuXfNpn+R4tDh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4ZsjtHjeWw2XgOumoWuIaDjGj3qSxoIo4VMFbMJvElG8ASRzn07TEmFQ2/78jNN5
	 kEK+BUz/EfpDPW6qLnPbYJlmrohqqrril+AG0dQUXlYDUlLUqDazGadOaklQG9raH+
	 iCpY9A4Lz7zRjlUHOClwUu0HIwM/u1O4+Wks5Y1Dj0OD8eHPTiVJdEYGVcsp+xirAS
	 UjK0b1hD+y8hXdhBjVlvFM/+TR52WNgakcNPRCY/Vw8wHnoHSDvKqvuhJp4WdRfAsC
	 7WZWEEyoB2qgBUImFOy5QxVGnRfX9ImGVl2Zxmz7Grlosatn5as6m5N06z+mNoGDSw
	 30BYyf0ChPmWQ==
Date: Wed, 13 May 2026 10:01:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chengwen Feng <fengchengwen@huawei.com>, alex@shazbot.org, jgg@ziepe.ca,
	wathsala.vithanage@arm.com, wei.huang2@amd.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Message-ID: <20260513070101.GD15586@unreal>
References: <20260506094623.29327-2-fengchengwen@huawei.com>
 <20260506155418.GA790442@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506155418.GA790442@bhelgaas>

On Wed, May 06, 2026 at 10:54:18AM -0500, Bjorn Helgaas wrote:
> On Wed, May 06, 2026 at 05:46:18PM +0800, Chengwen Feng wrote:
> > pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> > field value to bit 0. But the function is designed to return raw
> > PCI_TPH_LOC_* values as defined in the function comment.
> > 
> > This causes incorrect ST table location detection. Fix it by using bitwise
> > AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> > the function specification.
> > 
> > While this change appears to be a no-op within tph.c, the external caller
> > mlx5_st_create() relies on the documented function behavior, making this
> > fix necessary.
> 
> Previously, pcie_tph_get_st_table_loc() returned 0x0 (for
> PCI_TPH_LOC_NONE), 0x2 (for PCI_TPH_LOC_CAP), or 0x4 (for
> PCI_TPH_LOC_MSIX).
> 
> mlx5_st_create() is currently the only external caller.  It only
> checks for PCI_TPH_LOC_NONE, which is 0 regardless of the FIELD_GET(),
> so I don't think this actually fixes mlx5_st_create().
> 
> Probably still worth a stable backport because other drivers may call
> pcie_tph_get_st_table_loc() in the future, and if they depend on
> PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX, and are backported to stable
> kernels, they will need this.
> 
> I might reword that last paragraph to avoid the implication that this
> actually fixes something in mlx5:
> 
>   This doesn't make a difference to mlx5_st_create(), the lone
>   external caller, because it only checks for PCI_TPH_LOC_NONE (0),
>   but will be needed for callers that check for PCI_TPH_LOC_CAP or
>   PCI_TPH_LOC_MSIX.

Right, we are running TPH in mlx5 regression and it works perfectly
without "the fix".

Thanks
