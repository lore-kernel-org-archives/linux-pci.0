Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731B36CE03;
	Thu, 11 Jun 2026 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781215590; cv=none; b=E12NbXUnichnsfRlQnom2Gf2SEbRxU7n/ml25kYF4qqAC73CDkRR0bcHDRWsgUeBffQuO7JHQOiWv0WcUr5pDMRlA2x3bxxUnIzB+AuSvKH1Cvb49FhiIs2msb/K7kfgU2yJgcceZdbsChD32YxupRi1bgKVYNYxExEbdLigKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781215590; c=relaxed/simple;
	bh=1+Fu6xQqAZjFPg10nIgV2EIBK+Epez+QhHFubi5pCBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFwHhczRAj5EEd49K63NOX3IZqAziBX97F6HXQDZ/GAU69N840kLEazJHt8+AiOH5GzRdAjVvow9glNhvQMy6I/Lo1SNO2AScg+gzG1U1ERl3FsnNSSvvXk5QZScCzlxlhfLKlVAQRoQuqY/a7H9avBtJmSe8rRWH+7bExtCk4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMR4rJFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMR4rJFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB441F000E9;
	Thu, 11 Jun 2026 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781215589;
	bh=d4jkEdHNeRbnxD+sRfLfqYzsT1pyKMAHjLP9pToS+iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KMR4rJFge8VszC/VcUQkowiFhOLgrbrkp7kUgMbFdjFWQROXLFj4jpsKxDHfCKPL3
	 G4G9r/O4TaPDnzqq7bg1TzrMtSCjy3yVXmZ2+CmrkZvpDndAeIL+99x7agr9qFMVPL
	 2oeRpCyVOrFT1PpXpuBUBOxgBKD3HHWuRLTbQqkZwMJloYx/E3JwRPfzF+sVAx/jaX
	 Ziu0whO2ajBgoCMd5R5xOczSMXnzQUIwSoQFytHJyNIuQpY3TmdQSAX58KC/mushVz
	 S+RH9e17z++iy5IAbpluc5licSLoeig+MxTQ4mc9TK0VebWwL+3iKvpJ59VgUqwwls
	 8MEkVbX+zFZBg==
Date: Fri, 12 Jun 2026 07:06:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: mani@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: PCI: endpoint: Add Frank Li as reviewer
Message-ID: <20260611220302.GA395823@rocinante>
References: <20260611210007.529205-1-Frank.Li@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611210007.529205-1-Frank.Li@oss.nxp.com>

Hello,

> Add myself as a reviewer to ensure he is notified when related patches are
> posted.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5cea10654fd4..8a9144e9206ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20749,6 +20749,7 @@ PCI ENDPOINT SUBSYSTEM
>  M:	Manivannan Sadhasivam <mani@kernel.org>
>  M:	Krzysztof Wilczyński <kwilczynski@kernel.org>
>  R:	Kishon Vijay Abraham I <kishon@kernel.org>
> +R:	Frank Li <Frank.Li@kernel.org>

Sounds good!

Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Thank you!

	Krzysztof
