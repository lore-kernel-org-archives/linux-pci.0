Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A0C511E8A;
	Wed, 23 Sep 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790173960; cv=none; b=R2tBHVzbH++Ub3rKT1Dm+hhRy4P4duuWBYk3kqMrIe36riEDJRPCX3K3VzqScv62+6l1D0pdaZw9NXAfr67IABMwFmeAPL6CVeJKyuNaITroUR1ZsCcGHOiPSXxSL6edkf2lkwMTlAZY8rCh2apXwfBInLr2dz4IARjtyjFXkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790173960; c=relaxed/simple;
	bh=lbYV1LSybyMNBPEhgM4YVhUd3BoeQAweKneYDrc6bXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKI53ajoiHvmvXtzaeLQg91tLdV62ezFPLX/1Vsg1J1jzjU2QHXxrdqo4X2AJW4nBJQ/t8lfcDV8Z5JKBCdRWbuTtmTm5H4jq1vQGfTIciHnyJHB+RUMUe6ch6PibnoLDo07Cd9f0DpjlcohV6dfddrVsc8CwujzWQsmw7lTsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO6eOMs5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO6eOMs5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B361A1F000FF;
	Wed, 23 Sep 2026 14:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790173959;
	bh=nszf8PUF4EQzPBEcCjZZ0KgFF4eI3s+mniEiPsNVXR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fO6eOMs56OPjiajrTw8h9zElAg5bsvjL3NdV0Lj3D+elgi0B10cQK/wFJf+VT7suo
	 PttohCYnc4gvkNCaSmInmQ5DMYL3LFRmjbfrpSrTvvKbRkWxIUjIC0e2k8CB3R68nm
	 ptBmaJYKoNbP7DFT9sEvrW2aISPaujLyRgLlgqk5RxOfgGZgIh6DO5nY/V9Nem7mPn
	 sLoVxHwnbfTB1WHMzMwV3+CwdcGtXhGjp4B6CSMF5mijVcrvS0e6WrnU3SprFKTQLY
	 oYd2caHTiQHgOHbwj9M8xeWWtT4yPPw17E1I7TSfgNgd/z/OawhaUqyPVjFm/0ggTN
	 lmW6WHkxmwxYA==
Date: Wed, 23 Sep 2026 16:32:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] PCI: endpoint: test: Do not relocate fixed MSI-X
 tables
Message-ID: <arPjAeYzVbe5_qo8@ryzen>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-12-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923072237.1139013-12-mmaddireddy@nvidia.com>

On Wed, Sep 23, 2026 at 12:52:37PM +0530, Manikanta Maddireddy wrote:
> Some endpoint controllers expose MSI-X table/PBA storage at fixed,
> hardware-owned BARs. Such BARs are described to endpoint functions as
> BAR_RESERVED with PCI_EPC_BAR_RSVD_MSIX_TBL_RAM, so the function driver
> must not reprogram the MSI-X Table/PBA capability to point into ordinary
> function BAR memory.
> 
> pci_epf_test always allocates MSI-X storage after its test registers and
> calls pci_epc_set_msix(). On controllers with fixed MSI-X storage, this
> overwrites the controller-defined MSI-X layout. For example, the generic
> DesignWare path derives the PBA offset from the number of vectors, which
> can make the host program the wrong MSI-X storage and prevent MSI-X
> delivery.
> 
> Detect fixed MSI-X table BARs and leave the controller-owned MSI-X
> capability layout unchanged. Keep allocating and programming MSI-X
> storage in the test BAR only for controllers that do not advertise fixed
> MSI-X table storage.
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 27 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index d4905aa8e4c0..82d4714e998c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -83,6 +83,7 @@ struct pci_epf_test {
>  	struct config_group	group;
>  	enum pci_barno		test_reg_bar;
>  	size_t			msix_table_offset;
> +	bool			msix_table_fixed;
>  	struct delayed_work	cmd_handler;
>  	struct dma_chan		*dma_chan_tx;
>  	struct dma_chan		*dma_chan_rx;
> @@ -98,6 +99,26 @@ struct pci_epf_test {
>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>  
> +static bool pci_epf_test_msix_table_fixed(const struct pci_epc_features *features)
> +{
> +	enum pci_barno bar;
> +	int i;
> +
> +	for (bar = BAR_0; bar < PCI_STD_NUM_BARS; bar++) {
> +		const struct pci_epc_bar_desc *desc = &features->bar[bar];
> +
> +		if (desc->type != BAR_RESERVED)
> +			continue;
> +
> +		for (i = 0; i < desc->nr_rsvd_regions; i++) {
> +			if (desc->rsvd_regions[i].type == PCI_EPC_BAR_RSVD_MSIX_TBL_RAM)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  struct pci_epf_test_reg {
>  	__le32 magic;
>  	__le32 command;
> @@ -1214,7 +1235,7 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  		}
>  	}
>  
> -	if (epc_features->msix_capable) {
> +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
>  		ret = pci_epc_set_msix(epc, epf->func_no, epf->vfunc_no,
>  				       epf->msix_interrupts,
>  				       epf_test->test_reg_bar,
> @@ -1282,7 +1303,9 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  
>  	test_reg_bar_size = ALIGN(sizeof(struct pci_epf_test_reg), 128);
>  
> -	if (epc_features->msix_capable) {
> +	epf_test->msix_table_fixed = pci_epf_test_msix_table_fixed(epc_features);
> +
> +	if (epc_features->msix_capable && !epf_test->msix_table_fixed) {
>  		msix_table_size = PCI_MSIX_ENTRY_SIZE * epf->msix_interrupts;
>  		epf_test->msix_table_offset = test_reg_bar_size;
>  		/* Align to QWORD or 8 Bytes */

Here you are only updating pci-epf-test. What about the other EPF drivers?


Also, if you run then pci_endpoint kselftest, with the default 2048 MSI-X
interrupts. Are really all 2048 MSI-X successful?

It seems that often the "hardware owned" MSI-X table is much smaller than
that. See e.g. Koichiro's series which tries to use "hardware owned" MSI-X
table, but if the "hardware owned" MSI-X table is too small to hold all
2048 MSI-X IRQs, then "hardware owned" MSI-X table would not be used:

https://lore.kernel.org/linux-pci/20260830151948.3547577-2-den@valinux.co.jp/

+	if (layout->table_size < table_size || layout->pba_size < pba_size)
+		return -ENOSPC;



Apparently NTB EPF needs to read the MSI-X table from RAM:
https://lore.kernel.org/linux-pci/pj5vpwwd5tr5tuvhdq3bcpefnq27r6ljvwoysguz2o4tglcqx5@l7zmb6wjnhla/

Which is why he also decided to let an EPF driver choose if it should
use "hardware owned" MSI-X table or not.


Kind regards,
Niklas
