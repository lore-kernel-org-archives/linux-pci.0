Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B679378D87
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162209; cv=none; b=enF+u6CtU86m+NRdLOfbuoef2zdXUvFnlTShLqsm9CXFSg1CJqQTzrxDIeEVEqduFK4onPbLWh9wCY+LCq9Ijj9lGZDbvHdX/yJcUP2UdGtle1KSuHdxd6oI1qh8jUjQCmYuAHRvWXarJYeqxrq+VR5XCpB0K5IwEJ0oCqGeJ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162209; c=relaxed/simple;
	bh=fYPnLKjKeaALFLdLT6uykGVwcK1N+i8nNkuRXDf+yig=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuGnFYxGvBXbou6pOqTrG/xt87LZ8lGXVmAwCwuhXC+m8Jxx1N44zx9nFzmVWNcuUs43md+SxaOIbjImrryYo4l917awfmgz72YKi7/wCElmhe33HsUZq1+r4hU9132dy7Yd6LrppMmHpKA4oY0UUkeD+K7ZJ64dBJuvQYdujQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3deUq7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3deUq7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46391F00ADB
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162207;
	bh=2kAEs/wykU1b8bnx9SNr7DBrE1XwI2rU7+TG99KlTL0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=B3deUq7eXjNZQes5rTcygK7/BK/YAXCsAdgutukDiTiCeB3yY877a9OpJR8Lr8WlI
	 m7O2cuFyjloPCgL8ZSznQ4roZBT/7EvEfdmd7wAZhlag1lZ5DkxYpMIjHNum5dPtuy
	 9pyJwknKwelBvUG2qF6/h5mv8/Rzpg3cWnMLdWYAht3kTUy3IvrOBTFREmIFIvdMon
	 +c+aHGGizHz+NmGsDWqH9w46N/7T8oon9uG6FRE7nSXCUi5veR9LvoTINguXsQLm0N
	 D5JihPxy7xBUTE24Pa4ogUtvu20S23NGQwfa9dUDAmThfCazmpQ9qQFmObo+RexoOl
	 0vVX79u3+PkWA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c62764c7cso32392041fa.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 07:23:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoSq2IysOA4GHp3QW8sCXNMqfwPgBQOVNQOAEm1jvYmqA0fGESl+NEBZamhFHB3gsvt+PiMaAaPGQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBXyJjO3SXUyk04YBko4ydOCkrIxSq36siYSVCxIryKpdmgP+
	YCuzfX9lGRgP4fdghDRjrBO1T9dJc0PlU8Xuq7D7B55EwTGiZ+W8/1qD2zfDs6IxoE6OBjHS1/1
	DasGRPoO1OcVxGe6FbK73QE/D7HdMv+4Yg6VzYq2eFA==
X-Received: by 2002:a05:6512:64e8:b0:5ae:b7c7:5334 with SMTP id
 2adb3069b0e04-5b2bcc1353fmr1727593e87.17.1785162206599; Mon, 27 Jul 2026
 07:23:26 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 07:23:25 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 07:23:25 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com> <20260725-tc9563-fix-v1-5-ec4286e31331@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 07:23:25 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeSrzShyntsY7TU4f6eHo6sVggtgaPBxaOLc-ScR60Z6g@mail.gmail.com>
X-Gm-Features: AUfX_mxwPNanl8bgupOcRZrUMIsc4CnkQwolfd8-XxpgjWskO7e_qwUHFPKCg3g
Message-ID: <CAMRc=MeSrzShyntsY7TU4f6eHo6sVggtgaPBxaOLc-ScR60Z6g@mail.gmail.com>
Subject: Re: [PATCH 5/6] PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
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

On Sat, 25 Jul 2026 10:59:17 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> TC9563 Reference Manual calls DSP3 as VDSP (Virtual Downstream Port). Hence
> name it as such to avoid ambiguity.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> index 28e9ec3e172a..f1179737f221 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> @@ -80,7 +80,7 @@ enum tc9563_pwrctrl_ports {
>  	TC9563_USP,
>  	TC9563_DSP1,
>  	TC9563_DSP2,
> -	TC9563_DSP3,
> +	TC9563_VDSP,
>  	TC9563_ETHERNET,
>  	TC9563_MAX
>  };
> @@ -328,8 +328,8 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9563_pwrctrl *tc9563,
>  	case TC9563_DSP2:
>  		port_access = 0x8;
>  		break;
> -	case TC9563_DSP3:
> -		dev_dbg(dev, "Tx amplitude tuning not supported for DSP3\n");
> +	case TC9563_VDSP:
> +		dev_dbg(dev, "Tx amplitude tuning not supported for VDSP\n");
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -368,8 +368,8 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_pwrctrl *tc9563,
>  		port_access = 0x8;
>  		lane_access = 0x1;
>  		break;
> -	case TC9563_DSP3:
> -		dev_dbg(dev, "DFE tuning not supported for DSP3\n");
> +	case TC9563_VDSP:
> +		dev_dbg(dev, "DFE tuning not supported for VDSP\n");
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -612,10 +612,10 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
>  			break;
>
>  		/*
> -		 * The integrated Ethernet MAC Endpoint under DSP3 is a single
> +		 * The integrated Ethernet MAC Endpoint under VDSP is a single
>  		 * device whose functions share the same config registers.
>  		 */
> -		if (port == TC9563_DSP3) {
> +		if (port == TC9563_VDSP) {
>  			struct device_node *eth __free(device_node) =
>  					of_get_next_available_child(child, NULL);
>  			if (eth) {
>
> --
> 2.43.0
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
