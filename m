Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38730390235
	for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397819; cv=none; b=eq9fT9Cr3ksd6t8U3paNjLSW90Y/gehbzzaDG+jzzDu+5rOUIFZz4Ub2dx8VfZ1MHyf4b1+T90PyGpXDAHQlzOm4+tHjsgPJzngcatrEtHDgYDoKE17QfiVFOrQ1Tns7Q/1W1iHhu5eTpxuY/4P85u6zEuEBvSNUPA554Z+Sfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397819; c=relaxed/simple;
	bh=FaHB592fqkC3vWzDpeqzNvvx97RXvXIqNaaiEoMiv1w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G9lu079YTgjufO2Sb4w4V/SktdSbLOysqzqKPZhwtWjIwcOkv7HV3MOy18E9sTH5RO5hQ1628bilUqQX6CQwvH/CslaTDl10keLEBFrYOEI11MrH0aIwEL3xjnQj6AKP66Y9FUNEw80HjRGjdnNCPegHW6cZG7I0dSzSxBjtGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InVRK18Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InVRK18Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD836C2BCAF;
	Tue, 28 Apr 2026 17:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777397818;
	bh=FaHB592fqkC3vWzDpeqzNvvx97RXvXIqNaaiEoMiv1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=InVRK18QahfSHbNnC/8rJyl3PMStL4xAq8viXVWTeFVLUXjkrE8Er/gRclri9qlOo
	 /Px+3s/JQD9ZclCEZTfnOtsTmp9Re8dFCMA4kcItQH7yS6G6Or9p0rRglUrroIwdF5
	 dwWS6AT5eJFlmg7CHVRJIic5yYCK70IVOS+Em4bx+mHVSF52X5npvdnabsopCZaBqg
	 2WEj8ol/OOpCJv1R+h9wlMbXC9BpI2Q3b02osRHHxOpgSZkaK+xEh6FMg7k07S5m16
	 AShnylwnsJfLMQD7q+82VAwg5njDXXoyFFdyHdvcLnHa1jjpVK9IgFUse//b4IT9+o
	 ObkwqyCzI/J9g==
Date: Tue, 28 Apr 2026 12:36:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] PCI: rcar: Fix up MAINTAINERS entry
Message-ID: <20260428173657.GA237110@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428052030.51101-1-marek.vasut+renesas@mailbox.org>

On Tue, Apr 28, 2026 at 07:19:54AM +0200, Marek Vasut wrote:
> Use up to date address. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I'd be happy to apply this, but am wondering if you want to update
other similar addresses at the same time?

  DH ELECTRONICS DHSOM SOM AND BOARD SUPPORT
  M:      Marek Vasut <marex@denx.de>

  MXSFB DRM DRIVER
  M:      Marek Vasut <marex@denx.de>

  RENESAS R-CAR GYROADC DRIVER
  M:      Marek Vasut <marek.vasut@gmail.com>

  ROHM MULTIFUNCTION BD9571MWV-M PMIC DEVICE DRIVERS
  M:      Marek Vasut <marek.vasut+renesas@gmail.com>

If so, I think it'd make sense to do a single patch that updates all
of them at once.

> ---
> Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Koichiro Den <den@valinux.co.jp>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c871acf2179ce..1c87fb5b2f66d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20440,7 +20440,7 @@ F:	drivers/pci/controller/plda/pcie-plda-host.c
>  F:	drivers/pci/controller/plda/pcie-plda.h
>  
>  PCI DRIVER FOR RENESAS R-CAR
> -M:	Marek Vasut <marek.vasut+renesas@gmail.com>
> +M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
>  M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>  L:	linux-pci@vger.kernel.org
>  L:	linux-renesas-soc@vger.kernel.org
> -- 
> 2.53.0
> 
