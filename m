Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21BB36A34F
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162182; cv=none; b=KPfGliE32HESwG4DEW9nnJT8RnrpAb5i5CZgDE75pqsY2xviA0kc/5PNyXxrty2yNmnJstLmbiPtXK9e29gWS5RClpFQH9IFYtchV7ekrkp1MnVhgzn+IF+B2wje+kTBMWDxm6VoWD4L6kyAgl0cvyFIg3sKAL1GQ3d7KAD3fnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162182; c=relaxed/simple;
	bh=4JPbf0kDWA5uPW1ye+0Izs2pHCY82Rqy/QMURURYPaY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFehrL9724aqxYosb7LpkrCOKudN0prwOerCQjjzsg78tgHq4OXsaVLVMTbVRoGmQO0Tu5pSshXC3COWNkrtaOmT3erPrLuEgvyYEDfeQcj4WTzwQjn0i+FX7JIKWBKhvs12DDO5fc+KRBDZ8Mju+yiBpUUB/StU30bha4FZ+d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8nyff65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8nyff65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E1B1F00A3F
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162180;
	bh=eN52P4kYc3VwvJHjlaxZYp3C5xF1YB6inSUSX4U8+qg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=R8nyff65VH8zQYyJEYmAPCRiex4Uc6HRX6quVYLQF++t/25DTtR+JlDzC9ew61hnE
	 RzeTiXnt/VpMZAHT0UQU3rnQ3JzBZXNDmL1Fz0qPX6Bvtqoe+6Se9vTjp2PQUZ0LoP
	 8wQ0SqDBLXXU9T3BPh5pH4eqnFP2On7txlikQrXHznZGdt3fT47HwNq/P+X55dOx1O
	 fKnrewwuwtacqbJ1zBROFGUIrest7TQOXiByQgyHvNC5u6ziB2sZh1Qt76aFV4Dosg
	 v9iy5us0S6uP/425UP+B2qpQkoeETFy7TTqRgtU40O0DFoqua97TYyLs9WrInR8K71
	 6IxSPW3G0BI0g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c94fccf3eso24051401fa.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:23:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoCqUdu71im+HhJtpYm92UtGkxNVYkxvOGt8qmwtZ/6XO6gHnjvRvCmOf6q368+0OINw59Zdrb7b2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mgR/1keeoTuDUbGI+ckAJ3TWEQC2qPer+Gee7ZUvu+m4ZRDg
	ZkzLZOaLcsNGmMDISbZsle8Gl+XYXNIzvqZYA45W8bOBiDoVgwwVi825LhU/H/+nJcg9DLnWbB0
	PshMveb8gi/fI8DecmH3R479b2Wr4V6Le4exO/i2gUw==
X-Received: by 2002:a05:651c:1592:b0:39a:e29b:7926 with SMTP id
 38308e7fff4ca-39f2890076fmr15003161fa.41.1785162178919; Mon, 27 Jul 2026
 07:22:58 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 07:22:57 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 07:22:57 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260725-tc9563-fix-v1-3-ec4286e31331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com> <20260725-tc9563-fix-v1-3-ec4286e31331@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 07:22:57 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf_dA9GQFg72AeKmd3fUTNMNmoWHSqMDKxrqxDQKN-VGg@mail.gmail.com>
X-Gm-Features: AUfX_mxhtYfF-P2ZNB3abeKXJQ88LXUTbeyNrWHPfCcAjb4KgotGa9JGIW5uN9E
Message-ID: <CAMRc=Mf_dA9GQFg72AeKmd3fUTNMNmoWHSqMDKxrqxDQKN-VGg@mail.gmail.com>
Subject: Re: [PATCH 3/6] PCI/pwrctrl: tc9563: Power off only the external
 ports in tc9563_pwrctrl_disable_port()
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

On Sat, 25 Jul 2026 10:59:15 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> TC9563 supports powering off only the external facing ports like DSP1 and
> DSP2. It is not recommended to power off USP and DSP3 as they have fixed
> ports/endpoint connected.
>
> Hence, fix tc9563_pwrctrl_disable_port() to power off only DSP1 and DSP2.
>
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 482e82e433dd..ca19bf60d290 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -241,12 +241,18 @@ static int tc9563_pwrctrl_disable_port(struct tc9563_pwrctrl *tc9563,
>  	if (!cfg->disable_port)
>  		return 0;
>
> -	if (port == TC9563_DSP1) {
> +	switch (port) {
> +	case TC9563_DSP1:
>  		seq = dsp1_pwroff_seq;
>  		len = ARRAY_SIZE(dsp1_pwroff_seq);
> -	} else {
> +		break;
> +	case TC9563_DSP2:
>  		seq = dsp2_pwroff_seq;
>  		len = ARRAY_SIZE(dsp2_pwroff_seq);
> +		break;
> +	default:
> +		/* Only external downstream ports DSP1/DSP2 can be powered off */
> +		return 0;
>  	}
>
>  	ret = tc9563_pwrctrl_i2c_bulk_write(tc9563->client, seq, len);
>
> --
> 2.43.0
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
