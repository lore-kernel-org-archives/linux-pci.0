Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09DA34BA50;
	Fri, 12 Jun 2026 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297021; cv=none; b=t1qCqQP1QARQykiIMjAulPTkkTF/4BlYxy456BdX7ZZXpd5/ThpYiuMBjPBpX9vKvICA31Yrplkx/oWdnM0QI6mXIupcq84GtiTlKzLEwYCvTlXgqPGPM26P6c76b/tk/hSjhION6MKZG7IS0lWMAmQWheEtTkUPqRLdMBjSeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297021; c=relaxed/simple;
	bh=nPBCT5s/1lUmFAO4WOkCLiTt/L7wSCJHqDeNY7cPMCU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dORZiows+/ZgaQxH+BLQs2PquV/9KTu5ORfC0WNrQWYZKOEqP4Fq2Go4tMYPdcxNT8gPcolH59xUXqOYVTft2M0wHXw50fi5xBKwACx/wxQrKps4gdaTaD2FqNeYhgAhWaX2L1dFri9c20IMoDOqPOQginFPm4UJ3uLBgfroOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NV+RwiyC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NV+RwiyC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EE21F000E9;
	Fri, 12 Jun 2026 20:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781297020;
	bh=sEXeSWy7oSAAxJjdi3zTBCQCtA49xbZ1vV76OMoLgQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NV+RwiyCQs5KYxJWBScAzvQXGjaHOqyRyVA7ryO7n1VvhbCgnm9OOLUjH5pl5qbE1
	 DZW+H9YP6dLQLaW8Ye7XVOpv968CMqlqjwMG7evfSDEgJpuY34coBv9jeWnwL6UYRN
	 QcIcd3bPRfFWQp1tC/hvdlfMMcwx4hXulQBKpbbCJhrCJ3+Di/XjBnkj1g/oF2fuWj
	 4r4/x9Qp5xvgltv+6N/MbvPsZ6WbkrJV2uTLamUQNeXuqxhl98+ncUYQ5H8/SaGfkx
	 udfDeNpI+nNtYnJO8llSr3Q+dc4HH9eC7qVR+BK5bfyr7h4TdEUoVGxaJl4kbAIfw8
	 Y69BVvH/zSkdQ==
Date: Fri, 12 Jun 2026 15:43:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank.Li@oss.nxp.com
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: PCI: endpoint: Add Frank Li as reviewer
Message-ID: <20260612204339.GA637488@bhelgaas>
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

On Thu, Jun 11, 2026 at 05:00:05PM -0400, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> I has been working on the PCI endpoint subsystem for an extended period,
> including contributions such as the MSI doorbell implementation and vNTB
> function drivers. I have volunteered to review PCI endpoint-related
> changes.
> 
> Add myself as a reviewer to ensure he is notified when related patches are
> posted.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to pci/for-linus for v7.1, thank you!

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
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  Q:	https://patchwork.kernel.org/project/linux-pci/list/
> -- 
> 2.43.0
> 
