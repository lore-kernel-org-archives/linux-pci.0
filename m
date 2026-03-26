Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6E341B345;
	Thu, 26 Mar 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543530; cv=none; b=Pqr3a+bX4vCCxGZ3tYhiI8SJZi1AzJDken8vRcXVY0dSJnbEHPXVmBjwyUahb14YkmRg906P5V8e5FE18PvJvyrfYvF6NsDxrTPKTy7E+HLwE9OVoZCydQIeKUt6bagVLRtuzoL6RzxB2hGSndguInCx1Z+488PzE3YWWmauphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543530; c=relaxed/simple;
	bh=k91ea8X8MxOVxB7Me/pup7ILr7wRbfc0csNI4BuuvCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhOjTk2sm+3U86OX7YlponfKkXlkq1Om4aB31OfN3UNLQC5hCZ7pdc7wo96Rz5DnmljuLvV+1KYp+OSvjnXBaWY8Co1G8aDo5ofEeFphd+UX7saH8w+1Xl3tczH8uAJZkirXaLouHmMmLp4RUZ8z3T275TDkPl+ChPueqJKBwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cCsQntvm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cCsQntvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E76C116C6;
	Thu, 26 Mar 2026 16:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774543530;
	bh=k91ea8X8MxOVxB7Me/pup7ILr7wRbfc0csNI4BuuvCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cCsQntvmH65cJrMutqtF03fQ9+AJ1VjL3hqpGz7lf/z1yJMioPt8IFE0uG1lMD2E8
	 fcrwrgWVvTBAH0pKUzVsTMe9SmUq1jeRDw2IdE4uTqG7iCWaHGpIAs/DJE/kTUv2af
	 CLO14tNeX5tA5ZymZLcLT2RxpWhvy/y9vVZj7xWSyei6msxtnRKRX+AsTdYR705pLO
	 00CN7ald3BaLxw3hjd1FWm/6Q8njHFqxY6JJV5anT3xiRQJnakD77NIICWzqKwDrm0
	 0HN1OaGXV9e1N8o7FSFYGaJL0iqb1G3HS3HHAMfmibbA6/82j20zQbUKniXkl/uCnY
	 gAlHdhXL5SvDg==
Date: Thu, 26 Mar 2026 22:15:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yao Zi <me@ziyao.cc>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Hans Zhang <18255117159@163.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Manikandan K Pillai <mpillai@cadence.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Inochi Amaoto <inochiama@gmail.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
Message-ID: <wykv2qz7lt3v67n3hjjqlprjbhlv7eur5wiw2reagvu2sq3dhc@4y5x2yok4kho>
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-3-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227181925.52475-3-me@ziyao.cc>

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
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>  drivers/pci/controller/cadence/pcie-sg2042.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> index 0c50c74d03ee..3142f82bd393 100644
> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -32,6 +32,25 @@ static struct pci_ops sg2042_pcie_child_ops = {
>  	.write		= pci_generic_config_write,
>  };
>  
> +static int sg2042_pcie_disable_l0s_l1(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 pcie_lnkcap_off;
> +	u32 lnkcap;
> +
> +	pcie_lnkcap_off = CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP;
> +
> +	lnkcap = cdns_pcie_rp_readw(pcie, pcie_lnkcap_off);
> +	lnkcap &= ~PCI_EXP_LNKCAP_ASPMS;
> +	cdns_pcie_rp_writew(pcie, pcie_lnkcap_off, lnkcap);
> +

cadence-host driver already has cdns_pcie_host_init_root_port() to initialize
the Root Port. Since your intention is to modify the LNKCAP field, which belongs
to the Root Port, you should do that in cdns_pcie_host_init_root_port() instead.
I see no sg2042 specific registers used in this patch, so just set a flag in
this driver like 'broken_aspm' and clear PCI_EXP_LNKCAP_ASPMS if set in
cdns_pcie_host_init_root_port().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
