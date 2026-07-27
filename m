Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1537A832
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161826; cv=none; b=HIPhkZhkFgrllB9EvFvACqrrBQiIAtmI1mrvvp74S1jaJscafg6vIYO2Wz03BNFp4a/s8qGISJNx5giC0syfbSwcAqXPVPvvb+aa6y5Wll86Sb423GsAtcXximVDzLLDPjb0s9ZSQ8S7obs9VSmlWt1U6DldgHg4DviHqD+n+WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161826; c=relaxed/simple;
	bh=lVd0/c1AVDoNxELiyEp16IgvbckOIpDBUP3OeUuR3CU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kh2czLIZr2WQ55RbapzpEusHG0r9HnNF2JmhGoOP+YmD97o71GwTr+oJtB8NWclqlNyW6UTBfe1GUwv1Uf+PdJIaH5UdWGu+0DXVAYKpAN/DvtJYvPHdctHkrGiVGVzfKUB8PZGjZ7gpqCmSoiQJuCd78U3lOe62y1V0d74FFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvWF537P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvWF537P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E49E1F00ADF
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161824;
	bh=yS5BGlr5mNqy19bcM+LPC+mHYRQ0wrLxkRA6YEVbclk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=GvWF537PMK/fw6+kZDqgJi5O6EpW+EONRSDi8HOvu4hWfJWjt/CAssTWr6i/hK7qU
	 3pbUprjI/LBW/rl9W8X1aIIb9OhVqdNyfa8lBiWjUQqaMzkv5XkkI0Oe7/DgC/Are8
	 DKUpP5neX5DJUXluHjIsftSfBJGUzFsoUGdcrp3jY6wpllaAPgi0MJsLnQr9bcaRaT
	 O5BH0PbqJ0RM3xKKuMagG876EQAUo5Z4KT95lfFj5EBjG9n5+zxhEY8t9cRFYdZdq+
	 aEa5XMp3OuANiGrPFmiCGgpbZrppGPdbRDbdFesyP268IKVoQNgGELqme0UGXGhKOJ
	 +DGD0COj3YOtg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b00d083818so2919164e87.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpIIHIFB71uprgj9uIADsdVLJsqgPkIFZUyKQECNp7XbWBqJnNlVLqhu+0hCf8CY0jZG534SZLt7sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBKrP6cj6b9jPUX+jeLkPoLGxljZmP9D1HcjR3Uodmr7gIv0YC
	fFtkmn+znB9+NiN959JxgoDEoSW2u1Fr5k/YuVxGEDgcoizbtBSnQBf0TjlOHQ0TL1ubk0/j9OB
	oIh+H8/P/rV2tqmCtv6TdOROfyY5fSnMBYLNk8U51ZQ==
X-Received: by 2002:ac2:568e:0:b0:5b1:4c14:9b3d with SMTP id
 2adb3069b0e04-5b2bcbede4bmr2119207e87.11.1785161823353; Mon, 27 Jul 2026
 07:17:03 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 07:17:01 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 07:17:01 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com> <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 07:17:01 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeL4-dm46pjfx0eL8XTTgMYkPT32F0OMNUw44ik2kTn2A@mail.gmail.com>
X-Gm-Features: AUfX_mzWn5ZZqlDx5zrAyauAxHxgXUd2zCbUSp8w7IX2TRrKSQZHfetUgSRvhk0
Message-ID: <CAMRc=MeL4-dm46pjfx0eL8XTTgMYkPT32F0OMNUw44ik2kTn2A@mail.gmail.com>
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Elder <elder@riscstar.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jul 2026 10:59:14 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> DSP3 has an integrated Ethernet MAC Endpoint which has its own set of
> config registers for configuring settings such as ASPM. The Endpoint
> device has 2 physical functions and those 2 functions share the same
> settings.
>
> Hence, parse the Endpoint node under DSP3 instead of parsing both the
> functions. The existing parsing logic also has one OOB issue as parsing
> both functions will result in accessing past the tc9563_pwrctrl->cfg array.
>
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 488e1ec34a7f..482e82e433dd 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -596,12 +596,17 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  		ret = tc9563_pwrctrl_parse_device_dt(tc9563, child, port);
>  		if (ret)
>  			break;
> -		/* Embedded ethernet device are under DSP3 */
> +
> +		/*
> +		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> +		 * device whose functions share the same config registers.
> +		 */
>  		if (port == TC9563_DSP3) {
> -			for_each_child_of_node_scoped(child, child1) {
> -				port++;
> +			struct device_node *eth __free(device_node) =
> +					of_get_next_available_child(child, NULL);
> +			if (eth) {
>  				ret = tc9563_pwrctrl_parse_device_dt(tc9563,
> -								child1, port);
> +								eth, TC9563_ETHERNET);
>  				if (ret)
>  					break;
>  			}
>
> --
> 2.43.0
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
