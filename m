Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354C292B54;
	Sun, 24 May 2026 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593329; cv=none; b=PSQDOOVWFQRf9U6L7Qnw4Ohs0El/8DRmSkFHpOHIf1f5ju1y+eeEKXG1gu4gfcWskx/qo+IgkDRO63lnIKD1el7gqKR039cdJXp2BqOdqlFuz4R942G9ClwwBiogmUeQ7jfKRUNr9QwcQJ2tlkuOM884cxWkxc5s6MtsZf9V0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593329; c=relaxed/simple;
	bh=RLsETKWw95WEHyyAEeBcA6Ru2Kex/bj6KhVWNBzQ4hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGd8CgK4BF9ObUobo78M6yewnZqnjlrgOPGTHQ7b19AkAK1H663pbwgaGZKRPiWnsGTKSHJ3Goqk3Gw0yboXKjHLVOeEWDAZcJe4VqEaJUclVNfzuaiXlIb/2z6xWkKef80lrM6KvdE0x9MyxBS00TTOdmt7GPtSH4QD6JKb+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nt55thlk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nt55thlk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33BD1F00A3C;
	Sun, 24 May 2026 03:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593327;
	bh=jUgjJhjCBK6OaQ0sI8P03LGKeOD/5c9/tWnLusPWxIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nt55thlkYA92ySsbMiDaAVIsQYyuer5sk1jTSWVb4phS5kisEfnNlgqUVdEbKi+vo
	 s6wITb5MO1yB2eMjeRIC2nnwPHP4r1+Q/1T0t5PF2YY+dGDnMCbRLgRZ5/dGrzGXa0
	 mq4OeJMVUB+Z0SakpLE5HxBHPmvEI2tikM97US5z/8tsVB4r6hQs3EP/YMRXQIkm9q
	 iMilZljphw8K+xXtV9bU7ckbinRnY+/lMzgVDqNp9xA9sr0PZmIOD9FGOosklqjSof
	 tm+AjTEMIRTEcyNDrULizmGg8tghEcXV3vdBhebuCWkuLHRrQLkTzMVbl3/9E1wd8V
	 Nt6tnhmrYNRDg==
Date: Sun, 24 May 2026 08:58:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
Message-ID: <zgi4xxhxgqjg4uyjxibyuex6yxizlam6osxnur6i2myjhae6lr@4m77uwnjdhdo>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
 <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>

On Wed, May 20, 2026 at 01:01:43PM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> sequencer rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected
> to an M.2 connector), acquire the 'uart' pwrseq target from the
> connector's power sequencer and use it to control BT power instead of
> the bt-enable GPIO.
> 
> Also allocate bt_power unconditionally for all SOC types since the
> pwrseq path is independent of the SOC type switch.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5d670fa2758d3268d0 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power && qcadev->bt_power->pwrseq)
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	else
>  		qcadev->btsoc_type = QCA_ROME;
>  
> -	switch (qcadev->btsoc_type) {
> -	case QCA_QCA6390:
> -	case QCA_WCN3950:
> -	case QCA_WCN3988:
> -	case QCA_WCN3990:
> -	case QCA_WCN3991:
> -	case QCA_WCN3998:
> -	case QCA_WCN6750:
> -	case QCA_WCN6855:
> -	case QCA_WCN7850:
> -		qcadev->bt_power = devm_kzalloc(&serdev->dev,
> -						sizeof(struct qca_power),
> -						GFP_KERNEL);
> -		if (!qcadev->bt_power)
> -			return -ENOMEM;
> -		break;
> -	default:
> -		break;
> -	}
> +	qcadev->bt_power = devm_kzalloc(&serdev->dev, sizeof(struct qca_power), GFP_KERNEL);
> +	if (!qcadev->bt_power)
> +		return -ENOMEM;
>  
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN3950:
> @@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  			return PTR_ERR(qcadev->bt_en);
>  		}
>  
> -		if (!qcadev->bt_en)
> +		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +		}
> +
> +		if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
>  			bt_en_available = false;

What about checking for W_DISABLE2# GPIO (BT_EN)? I think you can just create a
helper and move the whole M.2 pwrseq logic added for QCA_WCN7850 to it and call
it from places where required.

I'd also try to go a bit further by calling the helper outside of the switch
case, but that might be tricky.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
