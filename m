Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D1352C4F
	for <linux-pci@vger.kernel.org>; Wed, 29 Apr 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487425; cv=none; b=TzNY4P+DRubfqeNmMnq1JxEN1FK6uztlqSfi5WXmkb9qePn8JXkRZPIfUJdB8vzdt2oGiDr0tw7d0KBHtxAd1djDmhqBFIxo4lfZF36rRCHWrrEJzEsroM89FYQ1AwQ7Q5pjEahZXSBstYsosTkM9bgyxS+5EU5lJi0sV84ui2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487425; c=relaxed/simple;
	bh=L/s0KTqbdiMe+GhIQ8M5gESkQTQPyuPi1Iy456+CxkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EavY4mYa6UjDEr5vkJIWuL7763WFGAGiqkYIFAUE36z+NydxvZp0el67+W9aFLTjXacAeM47siTSjCI1C6EloNW6E4eQjFFdidcNiBXMhvxRHT9yWJLyYX8qa4cCDD6DSW4hnd5SDR4E2smeJETI0b36svQxUkBotXy8fqxcjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZktssWEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZktssWEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81A2C19425;
	Wed, 29 Apr 2026 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777487424;
	bh=L/s0KTqbdiMe+GhIQ8M5gESkQTQPyuPi1Iy456+CxkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZktssWEIbgRt6QI8hw71PHizoj8deE/6gE1NVYRJmUqyNAwnedcFBY19X4jlO0+Y+
	 gw77OhXSMjJzov4Todu/RTx0Hlnsy7zQFJfJSkahYRgqR8EkRIsoF9/lc2Gz00bVAH
	 7L/9hfDgLLA0oxg9V2ajOFDqu5rdWGSBoMApc69Zx6iWZT4R46Z0SfHp6KjImj8RX0
	 2JAE0bEarES6nU4gWXAdY3QiGaC39Vv1Z1g90+iy9pwTpeHGHcdb1hI0MamNwzBd9d
	 kEl/2bRd2KTjH5EWsnkw6hUlcIecxeWW1LmQebaKWOPPloBPLuil8Usnps5e4Q3MLV
	 uPNQpZH6LBmbg==
Date: Wed, 29 Apr 2026 13:30:23 -0500
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
Message-ID: <20260429183023.GA305888@bhelgaas>
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

Applied to pci/for-linus for v7.1, thanks!

I made the subject line "MAINTAINERS: Update Marek Vasut email for
PCIe R-Car" to make it more specific.

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
