Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E2C35D5F8
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211607; cv=none; b=K0t5Hn8PE9iNfWz3j3cCJ3P0+cSjU36a6zlr4C+tghAIQyc2vhZhkaK1giYLGXOWWxmcWArSHi3XUtIzWVUnqqx9o7bbZ4N4/Z+vVwSQIjCnbBEl7Gs05CKDWCMMahMBUDBjtwU9/RVN7Hfr1/kAjKbbUl4/cRAizrsLV8Wkmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211607; c=relaxed/simple;
	bh=oC2Zs14lpqc+KoWFpjTryVFAJSLb63H0KdFepDU/dvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mOtRXbzNWsklfYcMqIUiV8T/kvO6YcC16DKotUkQv8ppMA6f+4XXYDts6+MkMpajsYCuKmysxz3Vyp6f4TiyupimO3PIcYw2z7vICvpMJoHHGk35cSTELISY4p1s1QlCs5cH3IeDPwpMQ3gVf2N7MzuAZKfY9HSfnIrq4jNhdZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=T324cFJM; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="T324cFJM"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 6E9DC240103
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 18:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1772211604; bh=29xGwZx4QmtZUrfPtkG3nKCYS3+MgHmL/NsrLP4T1A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=T324cFJML0YvQ2TOys9nnjk9fwDx8Te/HibiDWHLIVeZ0VUjfkt+YB8F+fFttRp2c
	 hJWgtfhjqFYfUiIuPSztPeq0xx1frDojLy8adNOFaEXZoxC9qe4a+V7oH+UAqAQ6U9
	 egsD33xTLHanYHWn9NNnN5Ld/1U3NNRKnXLiw29iQMzF01db5TCyPRF8B8DRh8Uv8q
	 5DLDw2z3BofmiXHUCl3m75ZicYwHg7z+9vEiPZot+dMSbmnX43q11JNIvAV8pYERZF
	 /Ry2MkUIUwCBnF+708HAghE++wGnJQ2MmC93/RFOePv/sd1jONmlnMNr6tdWcfgbg6
	 UxLawYm9xfHvQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fMvhK3Zmfz9rxN;
	Fri, 27 Feb 2026 18:00:01 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
  Manivannan Sadhasivam <mani@kernel.org>,  Rob Herring <robh@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Heiko Stuebner <heiko@sntech.de>,
  Dragan Simic <dsimic@manjaro.org>,  linux-rockchip@lists.infradead.org,
  linux-pci@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: rockchip-ep: do not attempt 5.0 GT/s
 retraining
In-Reply-To: <c51c804bea56d772a59fd29fcb080541b7a367d2.1772169998.git.geraldogabriel@gmail.com>
References: <cover.1772169998.git.geraldogabriel@gmail.com>
	<c51c804bea56d772a59fd29fcb080541b7a367d2.1772169998.git.geraldogabriel@gmail.com>
Date: Fri, 27 Feb 2026 17:00:03 +0000
Message-ID: <87zf4ujf5b.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Geraldo Nascimento <geraldogabriel@gmail.com> writes:

> Drop the 5.0 GT/s Link Speed retraining code block from Rockchip PCIe
> header definitions. The reason is that Shawn Lin from Rockchip has
> reiterated that there may be danger of "catastrophic failure" in
> using their PCIe with 5.0 GT/s speeds.

Patch body says "header definitions" but the change is to the drivers'
source. Maybe you need to reword in a way that is clear as to what
happened?

Cheers!

>
> While Rockchip has done so informally without issuing a proper
> errata, and the particulars are thus unknown, this may cause data
> loss or worse.
>
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
>
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
>
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 799461335762..9ebc227a1ef8 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -553,19 +553,6 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
>  	if (ret)
>  		goto again;
>  
> -	/*
> -	 * Check the current speed: if gen2 speed was requested and we are not
> -	 * at gen2 speed yet, retrain again for gen2.
> -	 */
> -	val = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> -	if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen == 2) {
> -		/* Enable retrain for gen2 */
> -		rockchip_pcie_ep_retrain_link(rockchip);
> -		readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
> -				   val, PCIE_LINK_IS_GEN2(val), 50,
> -				   LINK_TRAIN_TIMEOUT);
> -	}
> -
>  	/* Check again that the link is up */
>  	if (!rockchip_pcie_ep_link_up(rockchip))
>  		goto again;
