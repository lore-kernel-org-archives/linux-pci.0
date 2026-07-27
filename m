Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089937D124
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162197; cv=none; b=ChtEbtqeoCpAP6k1sWTD1ZOx1G7LotBiDpXAJ4rRmXJ9QnB5597Q4g+q2DU3RKyXpDkm+L8Noyto8bvxsJ1PszY8oedMWyScXF8b5dzovci8XXys1koqPspitO1UGg7JtCNC6/iXV+q1vL2Fce/RLxtUKWrehrZlW1daaVPQwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162197; c=relaxed/simple;
	bh=6P/idD/u5+5aLL0eBT6apNdmGhC1sr56HrW0Lkf7rMc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsQPj/e9Z9nQDulLwPQCx/aLpKOU+K6G+3zYbab2GRFE4Hkvp6hXXLPXeyuACVlCSDvsu0fRYAg9EYwU0l8p6XpdTJikStzsR3zFAYuxxm2ZnIKo5s67NPnjQdasVXNZYazVKeZ59tSuGXWV+ELcRY0iT2XlpbKKu2Tjh56ruLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiWyPguC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiWyPguC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3476D1F00A3D
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162196;
	bh=bjOK0XtRpxPALkfktciaa1uDh1IKlwM07pMAIbBSeVU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=FiWyPguC+1J3dRXe2exNejsxrhwQ/z1A8zCzDbMjNFK3ctLSzoWm7XzTVdhl6ugwh
	 wdlq/+wix9KdH5DEnpXwON+1ljTcPs6xeBXig1TbQJTKM/fSp+G9wWakf7w6/O0l12
	 wC13zEZegjjP7NeMpoGyyvSQPIn1ZEj8kryURWz9Tass9Vl4OQ4HHs66N+G6Ana/5m
	 kgxd3nEUvQn9NQ4VzrAmPE/sBNfH+VbEHOY5ORqvkXetYkQPXJlestsOxbPgkdFC4J
	 kIHJRIOXAx7EaXN8zxW4uu1MC9kz+udLNx9b+sLsTToL8p7om9uum2inpkx9YxequY
	 kzDSB5M0eO3nA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso2553562e87.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:23:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp8TYbglcWEqtn00AH/QTnqlN5jROyB2U+s+LxssUsJg1ppaoyBvnOwpSe92my44NEE2gZkdrB6e5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxNev7EzXI5vk5o9fHc7RDvOTuKwJG8ECczzzarJ4mN4Pft0uH
	KXX98pqBRCWOqVYKTieeIePAUpZ6QrcZ4gHW6kE2+wVI7N//yFsNDetzJvEA1CM535VZ+2BFad2
	uE35EPPSz/acT8gybj+OUaZqu05k0jfPs67fw+wWDGQ==
X-Received: by 2002:a05:6512:3b85:b0:5aa:123d:b755 with SMTP id
 2adb3069b0e04-5b2c1b19b6fmr1558330e87.28.1785162194934; Mon, 27 Jul 2026
 07:23:14 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 14:23:13 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 14:23:13 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com> <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 14:23:13 +0000
X-Gmail-Original-Message-ID: <CAMRc=McvyiT4L0M9q0QAz66z1j-EoOSJsdQjJCNeBhcFTfquNg@mail.gmail.com>
X-Gm-Features: AUfX_myIRheBVw0gqJTZLF0MGc06eLaOJUqkAmywIWyvRAL_DxwW2s_2NLxk8pU
Message-ID: <CAMRc=McvyiT4L0M9q0QAz66z1j-EoOSJsdQjJCNeBhcFTfquNg@mail.gmail.com>
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning
 for DSP3
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

On Sat, 25 Jul 2026 10:59:16 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> DSP3 doesn't support tuning Tx amplitude and DFE settings. So just skip
> the setting if DT has passed the tuning properties. There is no need to
> error out the whole driver because of it.
>
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index ca19bf60d290..28e9ec3e172a 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -308,6 +308,7 @@ static int tc9563_pwrctrl_set_l0s_l1_entry_delay(struct tc9563_pwrctrl *tc9563,
>  static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>  					   enum tc9563_pwrctrl_ports port)
>  {
> +	struct device *dev = tc9563->pwrctrl.dev;
>  	u32 amp = tc9563->cfg[port].tx_amp;
>  	int port_access;
>
> @@ -327,6 +328,9 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>  	case TC9563_DSP2:
>  		port_access = 0x8;
>  		break;
> +	case TC9563_DSP3:
> +		dev_dbg(dev, "Tx amplitude tuning not supported for DSP3\n");
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -345,6 +349,7 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>  				      enum tc9563_pwrctrl_ports port)
>  {
>  	struct tc9563_pwrctrl_cfg *cfg = &tc9563->cfg[port];
> +	struct device *dev = tc9563->pwrctrl.dev;
>  	int port_access, lane_access = 0x3;
>  	u32 phy_rate = 0x21;
>
> @@ -363,6 +368,9 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>  		port_access = 0x8;
>  		lane_access = 0x1;
>  		break;
> +	case TC9563_DSP3:
> +		dev_dbg(dev, "DFE tuning not supported for DSP3\n");
> +		return 0;
>  	default:
>  		return -EINVAL;
>  	}
>
> --
> 2.43.0
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
