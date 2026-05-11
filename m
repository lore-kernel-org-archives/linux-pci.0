Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71B372B4B
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499372; cv=none; b=MMga8M4CMCXIEBM52BzjcGZBe96Rl31kTSxJyCzP7YFaRjVKkYWUjqCEXpxozCrb9LSjacCApa3xlkaHXp69/QDvyIIgZ699TCrMurm6wfq5vw7edHSo/gyDOBU2+GrtOiYjir/jk399SOnlkEyWTjm+1GFvSdrJcy4OPV5YhzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499372; c=relaxed/simple;
	bh=UoHrRBhiVhtypnZWjEzks4nsFfinmujGkJZDbMS325o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAP0kvxCpbA+lEVJODd7V+HzI9jpa6pRgjWX0+cughpbpJlZPRYyOrt5dNCMotQZpiOrwk6vP4qwZuX8a+doR3bAFfe/hqnsJ+OgF6ND+ZO7SQISSU+3GXNSGZC7Nr1Uf+VQScmbQibchGHiZYYHt1CbZIKxVsjQQRYG+u47K1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyZg1UeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyZg1UeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F26C4AF0D
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778499371;
	bh=UoHrRBhiVhtypnZWjEzks4nsFfinmujGkJZDbMS325o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=kyZg1UeTVqp9JfmhFLdNIdCKfKpAiDKDdT77xunM5pr5xh6VxbZ0nxzYNSS4K1gy3
	 /IGjRw695W8TgjhbKpfS7HvV2YWNuCO/lzkmTw4G2sSiylCCkYwZd99e9CVnEyoIAP
	 hD6wtZnSALg7USgjWSFb/0QVBvOeNw9Rr45kL/EW562s1ZsvYS087PJ9n2B4kD4BDj
	 z+jk/pu+SdQREDzWqX2kay3Qv9QBmEO09md5NOxCRmDivAY9Krx9M6mgz4W/reJ8H/
	 hcWsJ/x6m5+PVmlwZM09HmHwmBEt6aNXGlvcefRsHce5IWwjbDQdasvViSovmyqqVM
	 GB/7AqHwHXqsg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-393800f638bso33408401fa.1
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 04:36:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9QlqsCgeEXr2T0up+TTeUjhMsWm/YbfGMIqupYVJxUIFr5GvrPvNA4eNC9TxDyYtKevLaR2eTVrRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBgYEx8uTHVA7fgKx8KG9d1dy8uViUd23vX7F9Glr5fosruOs5
	6TAL3yQha9wSl3eQ7jy8EVsCITWYrlxNNFNfwSfpDd/Np4BNjRNv26a8TDZXCoHDKpS/kUJlAW9
	p3LMNd8X7P8HcJvUY+Qm9bTQvJPwIrCG8gtFjwfX6vw==
X-Received: by 2002:a2e:beaa:0:b0:38e:49e6:a376 with SMTP id
 38308e7fff4ca-393c41dd93dmr80689701fa.22.1778499370441; Mon, 11 May 2026
 04:36:10 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 13:36:08 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 13:36:08 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260507-pwrseq-m2-bt-v2-9-1740bd478539@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com> <20260507-pwrseq-m2-bt-v2-9-1740bd478539@oss.qualcomm.com>
Date: Mon, 11 May 2026 13:36:08 +0200
X-Gmail-Original-Message-ID: <CAMRc=MctPMuxbdX5etjf7YAdRokFHzytJ2d_XLJ5sF_VQiebnQ@mail.gmail.com>
X-Gm-Features: AVHnY4KOYvtKbJK93XG_fcHF0tSVio3ofHekSu7kfAiAWf0UqYR7scUVWtjTLUQ
Message-ID: <CAMRc=MctPMuxbdX5etjf7YAdRokFHzytJ2d_XLJ5sF_VQiebnQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_qca: Set 'bt_en_available' based on
 W_DISABLE2# presence in M.2 connector
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Shuai Zhang <quic_shuaz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 18:06:17 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Check if the M.2 connector supports the W_DISABLE2# property or not by
> querying the pwrseq provider's DT node. If not available, then set
> 'bt_en_available' flag to 'false'. This flag is used to set the
> HCI_QUIRK_NON_PERSISTENT_SETUP HCI quirk, which informs the HCI layer
> whether the shutdown() callback for the device can be triggered or not.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 3e71a72ea7c7..b5439b9956cf 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2449,10 +2449,17 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		 * the M.2 Key E connector.
>  		 */
>  		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +			struct device *dev;
> +
>  			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
>  								   "uart");
>  			if (IS_ERR(qcadev->bt_power->pwrseq))
>  				return PTR_ERR(qcadev->bt_power->pwrseq);
> +
> +			dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> +			if (!device_property_present(dev, "w-disable2-gpios"))
> +				bt_en_available = false;
> +
>  			break;
>  		}
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Just one nit: I'd switch the order of patches 7 and 8 in this series so that
I can queue the pwrseq patches in an immutable branch and provide it to the
bluetooth tree for v7.2

Bart
