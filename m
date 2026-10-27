Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793142936;
	b=1lOoH9sPB7FD+qYGHcd64k+tthTUOBWY0kyOB+lwnRVp4Q2QKrUa2TmKcE6hlIHrLIRR
	 C+CssXEEzWNxvXzP2fX88RRM+c05D7ZW/DfU7V0FfnDZ+HCeoX1EU6s3vw8BGd7Kp4lLe
	 fl+9ky3imaGWEI+UyvvAAdu72E7ZFFmZVJty106OEj55S54GEMaRPr3+LEtrKXS+UGRA6
	 MzYnp/wOx/FkNX17wGsu23JVzCz5bQbSAz08VGxKrdcs2b9+LOmkysC2AUiZ8nlnUMz+t
	 hNlHk4JwQtIOB/Sz9tJzaU4k1ipnF+QHQuP72GlgvanvQ/28WEd3iBosDq+146KoiRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793142936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CA/7Tox0t7EgvF7I3HnmzpFFxPiq5q1ElSMkzQot6VE=;
	b=lO7a6mDrxLkGYH6Ub5mzJy3NVFOOJCb+Fe8snqh5Bu5Tt1N7gDwVIFW+JLEVvVUtojhY
	 7aWHYogYKj9Vr/QKTBo6QHjCC1WVbPLHXXmPiPj1ZlHS6hvm5Fs5i3teBypXoBfR+1y0+
	 I2K/wbbMeIYhCnsalbBiFkZ+0rigz+CPmBISKY0ZlKqk6FBl0SOFcnbboETfFC3mrjF+Y
	 3GwCdMscly7xM6I2l7L7VyxlOB62H0SgNlByDU1kag5kaD7pBRbLzKbe88r9/BsMSyVSl
	 bgz2EUBHkDhReHFMOQTktJo/jEA4ZUHHyszdx+Dd91Vcfw8xgbGzVAQjjWMdcSjXnrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVnQXRQw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4A606A32F;
	Tue, 27 Oct 2026 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVnQXRQw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875A81F01825;
	Tue, 27 Oct 2026 23:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793142935;
	bh=CA/7Tox0t7EgvF7I3HnmzpFFxPiq5q1ElSMkzQot6VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PVnQXRQwjWsHVoayiNThshV99xcymU/V/pIZswtKDDmYMDJnOaOF0e4WQ7NFLyn2U
	 hgbefSKUGrnKZ0wCwyAx6tS3q1iVEd2hqs5S1mvjxrh7pnqk7AkuDvh0wc0rFHGQZW
	 CCI0r4bHaPu9ujtyJPNsRSPmR/5zGCIWHZHLXZ5Wp8LZlMpqX2Pd+u+Ay/HTGI+req
	 r/99UDdROlN1XtaPaPQIWoAM1cKqtxREE8Szyk5HcNBzLT3i1yjFBRXX1sUwq8EkYr
	 wrMun3XHkKgkbcRXvN7v9s6BDe1OKuYAOrghVqQXkizpkbbFOoNsm+SD4JzlS8ufzX
	 6Z8j9YCxGv+ew==
Date: Tue, 27 Oct 2026 18:15:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, jingoohan1@gmail.com, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] PCI: dwc: Cache PCIe capability offset
Message-ID: <20261027231534.GA520774@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027122827.2725643-1-18255117159@163.com>

On Tue, Oct 27, 2026 at 08:28:11PM +0800, Hans Zhang wrote:
> Hi,
> 
> The DWC PCIe core and its platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure, including in paths that run more than
> once such as link polling, suspend/resume and interrupt handlers.
> 
> Add a cached pcie_cap field to struct dw_pcie and a
> dw_pcie_get_pcie_cap() helper that performs the lookup on first use and
> caches the result, then convert the core and the 14 platform drivers
> that use PCI_CAP_ID_EXP.
> 
> After this series, dw_pcie_find_capability(..., PCI_CAP_ID_EXP) no
> longer appears in drivers/pci/controller/dwc/ outside of the helper
> itself.
> ...

> base-commit: 4352b8aee98005853aa63f57d6377282de17a33f

This does indeed apply cleanly on 4352b8aee980 ("Merge tag
'i3c/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux"),
but that's pretty old and not really useful any more.

PCI topic branches are typically based on -rc1, but of course v7.4-rc1
hasn't been tagged.  Until it is, you can use pci/main as a good base.
It's currently 17bb0e2f6c80 ("Merge tag 'pci-v7.4-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci"), so
drivers/pci/ in v7.4-rc1 will be pretty close to that.
