Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33440D566;
	Sat, 20 Jun 2026 08:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945989; cv=none; b=OSErytMl+35oYNhIzpt9q1eR5LJu415imKhZ6U1A5woRW49dIExhtShMRrLqDMMx2DWVa4jcXkC5LDbVbS/wgbl22Y6LRX8tLjROFlr7tqud9w9+C9ffXMgHAcSQm1FFCDnY6LHslQPe/HdlEzKifWpt6YzsY35sWe0AYzy3rRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945989; c=relaxed/simple;
	bh=vsdEdpjf7YSZOGITRSdWA0LYI4GjLDa0j2gKjaAg18s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c8LSb5ImmPrGdB3Eo3pp3WKQos2Cien6BstEqXwco7+vytcyplb5nA6N2R2/pSTKvR+CMLrW1/HwZxpZm3DUoU4hgiYrfrkwDH17Xv4uBtW0PwaGlM9W/buoyYwbhCErEUIOExXZ2y8FOEcgWearEDRyYMvkPdS2z+kKQPDcd6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=peso1UTW; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="peso1UTW"
Message-ID: <88a57a54-ef19-43f0-8164-a1cb21974918@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1781945978;
	bh=vsdEdpjf7YSZOGITRSdWA0LYI4GjLDa0j2gKjaAg18s=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=peso1UTWFh/XtQ4tcvTy0JntRl8cFTKlJAeEZajMasRzihq0EHxnYv2jJYykxgRFB
	 3CikronWW1Wt24Cey2SIZy+gWuSK2xmoZW3RUUlOdqoQZ8IZ1ReHtD2WepSPqfewZ1
	 +7Fb2KtgALnUhEcLE/JnYUYJsttQNPmtinIc1BWo=
Date: Sat, 20 Jun 2026 10:59:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH] PCI: meson: Fix PERST# timing by asserting reset before
 LTSSM enable
To: gowtham <gowtham@ferryfair.com>
Cc: robh@kernel.org, bhelgaas@google.com, khilman@baylibre.com,
 jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
 linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 yue.wang@Amlogic.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, neil.armstrong@linaro.org
References: <20260614015620.20432-1-gowtham@ferryfair.com>
 <84cc8b0c-da06-4d01-a076-9743c29c91f6@aliel.fr>
 <b2d8cb85-5529-4a4c-a233-64ca7a436f0b@linaro.org>
 <20260617050627.4d01ed54@slick.ferryfair.com>
 <20260618020025.2739cb96@slick.ferryfair.com>
Content-Language: en-US
In-Reply-To: <20260618020025.2739cb96@slick.ferryfair.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 10:30 PM, gowtham wrote:
> Hi Ronald,
> I see you submitted the patch. Last couple of days I've been fixing the
> etherenet of my BPiCM4+Waveshare-io-base-b due to which I couldn't test
> your patch any sooner. Now I got my ethernet working but now I couldn't
> reproduce the issue *without* either of our patches!!!
> 
> Anyway it's proper to initialize PCIe with RESET Active but I think
> meson_pcie_assert_reset(mp) will give sufficient time to PCIe devices
> to complete the reset cycle.
> 

Hi Gowtham,

No worries and no rush to me.
I think it's due to how uboot set the gpio before the linux boot for my
issue, and that does not seem to be relevant for yours.
Thank you for testing the patch.

> ---
>  drivers/pci/controller/dwc/pci-meson.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c
> b/drivers/pci/controller/dwc/pci-meson.c index 0694084f612..c28ab40c9ff
> 100644 --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -308,8 +308,8 @@ static int meson_pcie_start_link(struct dw_pcie
> *pci) {
>  	struct meson_pcie *mp = to_meson_pcie(pci);
>  
> -	meson_pcie_ltssm_enable(mp);
>  	meson_pcie_assert_reset(mp);
> +	meson_pcie_ltssm_enable(mp);
>  
>  	return 0;
>  }


-- 
Best regards,
Ronald
