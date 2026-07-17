Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9234B3C3F55
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280653; cv=none; b=ulCKkEZlmav6Km9CTVbEzVN7cUj1EU+39FiHaNFdT89S4snqhYhZkf16u+0F5sh1Mhe8VIdaQOQFVE0CjvUvURjp9HUZQ4mjWg9ZB7rXiRkWJALCBnpdOlv85lng7ObRSX3zr8VK5cOgLohCJjl+Tk1EyHVxCwD7Am8kELCmuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280653; c=relaxed/simple;
	bh=tbCI00YSlwDRg6JIkFR/niiKWVVn+eRN2wiQbbOWrWU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8udN+e1PJQiNqrO0+Qk7+1+fjpXsFXybvcRh4IuzHX0nCZJEkR7LV6YZxTbXDXMTkaJuwWu0w2qtiKclRkeetdC9OwaMiDI4Yb/O1KUDOrW0DHF+mYQsBMyzFCR9K/8u1wJjsQP7ttZ4j/USAJLq/mDpv5z7m14+SX0w0i1lWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTfTZXMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTfTZXMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AC71F00ACA
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280652;
	bh=iyJ4B2wLQ9s15BrAYrM1DXNCJwAOqNuA61/FpLM63sE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=TTfTZXMbAPYTlaw0Apg12nkkjFAKZd8c8OsOaSFQzFpYgsh2ORh/KG5gyqelszTN8
	 BXhdphF3n+OXSnNsN9acPO+7ogLCuV6aJwvEDSyGw1gUrDfEYGvuVkHsiwXjjrNNmM
	 fDWIiyK4O8s15X4mz1vxrTH6D7qJTIlKTTYvMTCajLEWSGcy5q3lOSlel4Ax6+8K8o
	 OF6dlP4PPa8+F4A57hE2ci0nwnjx0cJvGj30LDTvGQwjbBv3DKulZe4OlP4eoQp/ZU
	 UUYpY3ZXIEfnYGxYqzbD2th6su/ry1aC5QOLtwThGyssBrSd7DPhKKTv8yfr1AFGP8
	 xtqfOyLjiFkWg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aea0fff535so4815578e87.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 02:30:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvuYj5ERTLkyLVFFaySeVqEUTfqIM0a31PFmDbsDAMKAoUw9qy
	SgsutdVrWOtB3twuwBuIAabdg4T2Q3HgR6U4E2vVNniSKoanzniujWjxateQLybs34wUx3NGB/8
	Kj35tRMqDbNcsyavCNhJoNj6WKblqhO5d8kTTG3qdzg==
X-Received: by 2002:ac2:550f:0:b0:5b0:163b:e2d6 with SMTP id
 2adb3069b0e04-5b28fabab20mr360225e87.62.1784280651204; Fri, 17 Jul 2026
 02:30:51 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:30:50 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:30:50 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-6-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-6-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 02:30:50 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcr8dCAeHe48LBOQ_Rg0iSQaHmL_HrC44ohqEUdjg12aA@mail.gmail.com>
X-Gm-Features: AUfX_mw7JByjcuNC_OA-Xwp9N1-sIdcb6nu73GcpC0DTViDxeC5IKKiUyNbwp_I
Message-ID: <CAMRc=Mcr8dCAeHe48LBOQ_Rg0iSQaHmL_HrC44ohqEUdjg12aA@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:23 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> A Bluetooth device only needs the non-persistent setup if the host can
> gate its power, so that it is actually reset on the next power-on. When the
> power is controlled by a power sequencer, whether the host can gate it
> depends on the hardware wiring, e.g. the presence of the BT_EN or
> W_DISABLE2# line.
>
> Query the generic pwrseq_is_controllable() helper whenever the BT power
> comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
> If the power is not controllable, clear 'bt_en_available' so that
> HCI_QUIRK_NON_PERSISTENT_SETUP is not set.
>
> This is based on Manivannan's original patch that keyed the decision off
> the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
> and handles the always-on case.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 17f436484e1e74d1dd690ada22134315abb767c4..41e8c302abc2a820022d1783f1fad76b358ae67c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2548,7 +2548,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  			return PTR_ERR(qcadev->susclk);
>  		}
>  	}
> -
> +
> +	if (qcadev->bt_power->pwrseq) {
> +		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
> +		if (!bt_en_available) {
> +			/* The host cannot gate the BT power individually.
> +			 * Treat it as always-on and drop the pwrseq handle.
> +			 */
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);
> +			qcadev->bt_power->pwrseq = NULL;

Maybe a little comment saying this will be released by devres? It looks like
a leak otherwise.

Bart

> +		}
> +	}
> +
>  	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
>  	if (err) {
>  		BT_ERR("serdev registration failed");
>
> --
> 2.34.1
>
>
