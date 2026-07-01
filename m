Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631FB3F4137
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899481; cv=none; b=vCRTyqDANHUyVrnwA1zm1s6bRKEH5S2Eus2fin94Z6XxbEtVW3pEw6nokodNfP4uiDsRNs8mzZNzJJDT4CXv6r6nus62OqRvjwA4Ek8b7OTAGKXVXJaLbHfqvT1K2+KpFAN2P9s1spSixJy87XYjJzlfsupz7j5B6bFwbt6u0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899481; c=relaxed/simple;
	bh=tbugZwh8oSW3Rx3tk9D6PDyspG9yCZ/BZYVqALg3Xvo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+fLxhA/2Q6X5RM+ZVkVlk8ZV+WeJTqCG83me/qHYN4tBivMs14oMF+M6vfqYMnsct8a456Q8lf8FxAUm+qzUCddY4mpJ4jbUmDHd9CvtaKsFNmxik79Gia1/DDWCR7VGB2/IVoxlLzVMBJyoS89X5rUOFRRig26vwPzwEE57Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdVObgKr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdVObgKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C12D1F00ADB
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782899479;
	bh=ShGWDXttH5/Ho+7oUrait9j1SNVndDs13zI0h4c4YmQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=AdVObgKrM+PoufyZXyhVAsgOOYwZakJfmCDNeuqGAjgsZyzlmt3aY6OgrEyxETmYb
	 gIzH9DBIfHTLWqqCB7ii4mgd5Baa9tJ0j/ijIDOzmYfoXET/GR54AVFGwde5OQ8h4B
	 0ZFsBkOWN85yRKgTApUYVptBhHGdkfOTD64JefqqcHG3ma6Uydd0IwapVRONw2JYEe
	 udw+vIIjzwMYyX0u8kOGrfVOlLdZ2FfRnLgsbJdj5wsnAIBAF/ze2wiHH9j+YWsm6m
	 UATxmlniD01vqYMVplB40UjniY+sY2InGx8O/NQXMXKBFN30nd/KElYytgjH6ihAIY
	 iX44KLSqQJsMg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b3027009fso3829361fa.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Jul 2026 02:51:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpZyhYSSMPH5cwPw503k4z9iFUADk60Jt9ozDLn/WcekHxQ4iH/PfMGZM6s8TjgLAteOSM7+PAOJO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRLK4eBe3uS9ak9LU2ReylPnxrnuz8sdBT56bOSfDB54ax9ha
	5/OkFH0iv1WIPqCodNgY4VfEOxLHrS8nyYbtbDABMVQLJYg3e0b56tFJBlFQciyce4QuA+7qTxA
	n7kH+noRF01F0rFyHDHBu2EqJIvjuLY/KPR4NuoZDdw==
X-Received: by 2002:a2e:a988:0:b0:39b:be5:6d95 with SMTP id
 38308e7fff4ca-39b341228fbmr2172921fa.29.1782899477765; Wed, 01 Jul 2026
 02:51:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:51:15 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Jul 2026 04:51:15 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260701-shikra-upstream-v1-4-e1a721eb8943@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-shikra-upstream-v1-0-e1a721eb8943@oss.qualcomm.com> <20260701-shikra-upstream-v1-4-e1a721eb8943@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 04:51:15 -0500
X-Gmail-Original-Message-ID: <CAMRc=McsmvR5SaBcr3FNjQLvp46MdG-mj8bgYnjvWn2yG-oSEg@mail.gmail.com>
X-Gm-Features: AVVi8Cc_rp-y3aP8VcLiH5YFSe4JsqHhLKXDLZf5g-tl8E57HeVVA8iw88E74Ag
Message-ID: <CAMRc=McsmvR5SaBcr3FNjQLvp46MdG-mj8bgYnjvWn2yG-oSEg@mail.gmail.com>
Subject: Re: [PATCH 4/9] PCI: qcom: Add support for Shikra
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 21:02:46 +0200, Sushrut Shree Trivedi
<sushrut.trivedi@oss.qualcomm.com> said:
> Add support for the single PCIe controller on Shikra platform
> which is capable of Gen2x1 operation.
>
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index d8eb52857f69..19daadee65f7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2309,6 +2309,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
> +	{ .compatible = "qcom,shikra-pcie", .data = &cfg_1_9_0 },
>  	{ }
>  };
>
>
> --
> 2.43.0
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
