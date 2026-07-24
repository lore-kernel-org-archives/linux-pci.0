Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC33ACF11
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 07:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878789; cv=none; b=gAaQc61iXW1j1aMW4IKridWWKNv+t0lp+reBk0m4ls2DOhjIg35P8UsXTh87fevhgrml+gadfCtq/C+14S8WQFd+z1kYuxkSEkMBJavCbXqfS0fxsEbi0//ORhPgSeF1V15oiynuhI08rNhb4r09wAbXwOrX8C8DcZzk7YR8jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878789; c=relaxed/simple;
	bh=LbE7q4H35PewJJSHAE0ANnvATUxdn8GQZ3PbtjFXs3s=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZFn5x+B4t6MAKS3WFUozuBdQitgOD4c2OhKxXe2Pmx8hBZA0AS4HZaVObYlbaPE/7gkji7v3fQdICEa2YCbuGtLrPmyZuD1OvX/8HvpkMxFCKsYBQCojQgu74QuxpkP9KYc7ih+AP8sMW3rc0i+6dhP/9i++/UvEAm5YmYHS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfi4Cdnn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfi4Cdnn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709471F00A3A
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 07:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784878788;
	bh=VYguqbpDvSlIqI0hJfOO+KOvbUDc3j8E+Zo9hd9jUCE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Bfi4CdnnqxwWRMdWuLhLZGKEu3cxXU7omtnh3DEHkw6RR3Q0cv6XC/rx1VnwzLkmL
	 DCpkIJcZn7I8Z3HCxsB+nBBzC9+d0nume0a/LPithvk06oN3byltt0Qve0ddjWrpQO
	 hfumxNp8MgOUc/wcdCl+RAxRbg2K+dTIQCs8DKBHkm7/7uwECIv08cTtcN+P9s/m3z
	 ccL7bLbetZDGVAHp3kyfIzdkXTMOYIDFUcekGhPKA79wsLDpDADS5qoxQmUJlySwAP
	 3ZckyhVpNkoPlFOH2qqDrx77t+FrmGlTByXfGI3O40vDY80+GKGaBQzRg6+jS8/mTf
	 RLB5NktInvpwg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb98460c6so132952e87.2
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 00:39:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqI7C1GT4ZCvypaeLW+HMDSjDOql1ikTud4ZBd6FYFybrjE9z8OoqVCOrFDiLRw9d9I0Iej+UGiJ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVToJHD2SrBi3Q7YW4EjWCc5CXMvKct+y3sAA2IXduQyQoNJ2
	p0Yzwr+LDlguUk+RKQ+/6evD5DYONpvixzoi7fOuSShhbScNI0sUOlM5YxE+IrdUPHCAxr6epXl
	2E8l5HPGdybHqXCoO56sSqUh/tRpwDHwXDbLiT8/SBw==
X-Received: by 2002:ac2:5333:0:b0:5ae:bf45:e3be with SMTP id
 2adb3069b0e04-5b2b2e55892mr773986e87.21.1784878787207; Fri, 24 Jul 2026
 00:39:47 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:39:45 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 00:39:45 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723193525.319826-2-krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 00:39:45 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc=4BkXsv2efKipwTq_qXx8m0tH2RPTF6vtZjpE_maaCg@mail.gmail.com>
X-Gm-Features: AUfX_mwOEp66O8ug6OfHZfMwMZy1Fnr4FAEYBQ3jGvuHnhz0hqwS76VvgvGZhQo
Message-ID: <CAMRc=Mc=4BkXsv2efKipwTq_qXx8m0tH2RPTF6vtZjpE_maaCg@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pwrseq-pcie-m2: Drop undocumented
 QCC2072 compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Jul 2026 21:35:26 +0200, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> said:
> There is no such compatible documented (thus allowed) as
> qcom,qcc2072-bt, thus it should not be added even in driver match data,
> which later is used for compatible matching.
>
> Revert commit 162ea02941a9 ("power: sequencing: pwrseq-pcie-m2: Add
> QCC2072 BT PCI device ID").
>
> Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 83fe6a1396bc..168e915f2c89 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -195,8 +195,6 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
> -	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
>  	{ } /* Sentinel */
>  };
>
> --
> 2.53.0
>
>

This is the top commit in my queue so I just dropped it entirely, otherwise it
would be an addition followed by a revert which could raise Linus' eyebrow.

Bart
