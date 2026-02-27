Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CEE34DB6B
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211192; cv=none; b=ZZCGQPu+jxjxLTnrq1Q8e7N+h/JhiZRZdhmda2h8S6UI3P35ekDdl/cj/DZ0+eJeErGlDjy/2+qo5Jj4XLh3wMINcVfMpZOpHt8K2l4ZS38qGieE4X1Sp7eETLbToeMMKe9Pd8gEgH9mLelgG8Fq/JJlPMIKconL3tQe/h+oXU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211192; c=relaxed/simple;
	bh=qgoW/m3VehSpvyBCmTGvGiBf36On00lLIj90mXN3k+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J6xG34p7b1p90Y20lT9VRheTytopGYOWQIuj9AEkzbBKt2O0rqvXbkX0qMF92rXqtdECbWxexhAOekkjcQ0uzJNhorxrVqLqw4fH8EGwkZdG6wVQqKRIde8zQtVL5JXvFZax5Oa9eoTolLUxOsRPUsWeOjI3hO5TqTUr+4SGNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=iYv35PHX; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="iYv35PHX"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 1F1F9240101
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 17:53:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1772211181; bh=hg3ftxRVP2o0Fqsn83GKQdV8U57RiZh6rSnr3Ja80i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=iYv35PHXitvDLrydbkqRnuU71kNKDdIuRJq1NUqBWYwWJQ7Hc0nR4WON/ET8eZ/r0
	 +gWF/6fphL7evBjX5Sj4tRPGOGyiTVGaZjplx39iaVCF/7v3qDlt5rXw+5oTxgbkvJ
	 uvPS0wsOxuDMlva7/s1qp1y+4/DSzdJETVFRM6fwu5stvWWpcvb6MnooOMGdFCaIP9
	 2vdIiOipCDLFJQRU3ui4Q9QZwXkbWMSYehB+kMYe8Yggi+PEfADKczU5spZpeBBM/N
	 wAmDFB1/SOLdQMbTIug6QOVLKlieRGM774H50lxaSBvZaeC3SJc1As6NL8gTUUm7q/
	 rh0rc8KD1EILg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fMvX95LGlz6txq;
	Fri, 27 Feb 2026 17:52:57 +0100 (CET)
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
Subject: Re: [PATCH v4 1/4] PCI: rockchip: drop 2.5 GT/s defines
In-Reply-To: <5172389ba8d291fe05bc0887bc97fe73f110c5c0.1772169998.git.geraldogabriel@gmail.com>
References: <cover.1772169998.git.geraldogabriel@gmail.com>
	<5172389ba8d291fe05bc0887bc97fe73f110c5c0.1772169998.git.geraldogabriel@gmail.com>
Date: Fri, 27 Feb 2026 16:53:00 +0000
Message-ID: <878qceku1j.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Geraldo Nascimento <geraldogabriel@gmail.com> writes:

> Drop the 2.5 GT/s Link Speed defines from Rockchip PCIe header
> definitions. The reason is that Shawn Lin from Rockchip has
> reiterated that there may be danger of "catastrophic failure"
> in using their PCIe with 5.0 GT/s speeds.
>
> While Rockchip has done so informally without issuing a proper
> errata, and the particulars are thus unknown, this may cause
> data loss or worse.
>
> This change is corroborated by RK3399 official datasheet [1], which
> states maximum link speed for this platform is 2.5 GT/s.
>
> [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datasheet_V2.1-20200323.pdf
>
> Fixes: 956cd99b35a8 ("PCI: rockchip: Separate common code from RC driver")
> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 3e82a69b9c00..b5da15601b58 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -42,7 +42,6 @@
>  #define   PCIE_CLIENT_MODE_RC			HWORD_SET_BIT(0x0040)
>  #define   PCIE_CLIENT_MODE_EP			HWORD_CLR_BIT(0x0040)
>  #define   PCIE_CLIENT_GEN_SEL_1			HWORD_CLR_BIT(0x0080)
> -#define   PCIE_CLIENT_GEN_SEL_2			HWORD_SET_BIT(0x0080)

This commit alone won't compile right? PCIE_CLIENT_GEN_SEL_2 is still
referenced by rockchip_pcie_init_port():

         if (rockchip->link_gen == 2)
                 rockchip_pcie_write(rockchip, PCIE_CLIENT_GEN_SEL_2,
                                     PCIE_CLIENT_CONFIG);

This reference is removed by the next patch in the series but not sure
if we want to do it here instead.

>  #define PCIE_CLIENT_LEGACY_INT_CTRL	(PCIE_CLIENT_BASE + 0x0c)
>  #define   PCIE_CLIENT_INT_IN_ASSERT		HWORD_SET_BIT(0x0002)
>  #define   PCIE_CLIENT_INT_IN_DEASSERT		HWORD_CLR_BIT(0x0002)
> @@ -197,8 +196,6 @@
>  	(((x) & PCIE_CORE_PL_CONF_LS_MASK) == PCIE_CORE_PL_CONF_LS_READY)
>  #define PCIE_LINK_UP(x) \
>  	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
> -#define PCIE_LINK_IS_GEN2(x) \
> -	(((x) & PCIE_CORE_PL_CONF_SPEED_MASK) == PCIE_CORE_PL_CONF_SPEED_5G)

Same for this, references elsewhere tho.

>  
>  #define RC_REGION_0_ADDR_TRANS_H		0x00000000
>  #define RC_REGION_0_ADDR_TRANS_L		0x00000000
