Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B32A3FE;
	Wed, 19 Aug 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161332; cv=none; b=NsUEa5P680R3P1f50f7Jn9D1YICdQps8mdfFAAPc8t5ipiYHZ2Fxz5p5/wZZHEtVHVfT+OhC5J8aVKG+fok7oWcCHgmII8H883vFaZD8Q9n9+SbovniF3ZxOL10yK/LNdHZwIf1VPoK65iRzDFK2kyIlVd6xPsk4+wZm/mmOKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161332; c=relaxed/simple;
	bh=D0696HPO7oeaMKZYUTdwkSRUiy9TX2iaDCeJuOtqlv4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jnW2klvD7S0CcoHdyOy4wcbeG5Qo0j4LXJP/D8GtfCVC5OPyBK6W+iE/KeeD9dkYPn5qHze7zxHlIC+jh9ByJ5RsD5VPK3k2PeeOG7FXX/iFOucnNjwU/2Z3JYBJMWsVCqfwunyFd76s/+YTTwIbxdENZ3oyUH5bxTer3iHekRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdU9iyaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdU9iyaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508DC1F000E9;
	Wed, 19 Aug 2026 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787161331;
	bh=fc+OItWOXgslCeSol53+sMcvxxRP8LkUA3SwuUUJLLs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=gdU9iyaBgnU0g6a6jGsZrMCJpF7UryUBPR4sfyDc9sQJrmoyBWDqk5nL+R8vycm4l
	 U8EtP/xPMwvK2EVf0+E44RbJM/ENDKgybRRb6PmYfL5BT42+udvQq2NsOumKfiE3gG
	 k8wlBSc5eNpD2+aHf2rG4MwN2UC0imGVNyZQjlwofDVBY6P+83J3M1vjje7jaPZWxH
	 Gk4lzpLPGDLlNe7qdKq9VHv+d+9ivDFnYKk1Rzg1LDhRngwYv/54l7HPVZ5N2mC6cj
	 MK0EGmesx2z+pV1VmEbQ8iE/G2praK/RX8kiZzAUmQP+m2vlqudsr19Tl/qI6fC2FB
	 5/3KfIYBZY/EQ==
Date: Wed, 19 Aug 2026 12:42:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <djbw@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Add VMD Device ID Support for Intel Nova
 Lake (NVL) and Dunlow (DNL)
Message-ID: <20260819174210.GA816985@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819130523.398493-1-szymon.durawa@linux.intel.com>

On Wed, Aug 19, 2026 at 01:05:22PM +0000, Szymon Durawa wrote:
> Add VMD Device ID Support for Intel NVL/DNL processors.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <djbw@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
> Cc: Jonathan Derrick <jonathan.derrick@linux.dev>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Applied to pci/controller/vmd for v7.3, thanks!

> ---
> v1 -> v2:
>  - Fixed duplicate text in subject line.
>  - Included missing VMD maintainers in CC.
> 
> v2 -> v3:
>  - Added patch description
> 
>  drivers/pci/controller/vmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6..f9d145932155 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -1132,6 +1132,10 @@ static const struct pci_device_id vmd_ids[] = {
>                  .driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0xb07f),
>                  .driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0xd70b),
> +		.driver_data = VMD_FEATS_CLIENT,},
> +	{PCI_VDEVICE(INTEL, 0xd73b),
> +		.driver_data = VMD_FEATS_CLIENT,},
>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 2.43.0
> 
