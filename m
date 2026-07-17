Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C23C6A41
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280910; cv=none; b=dgTODQGr5yoFXzJsMXu0JAVS38JR48rf7BvgRSTrtO4f8tjUEvlSjz59HXK40JR4DKHWc0N933nSD0L2sIpzYTyAaiStAD/LRZBxO3SF3NQy1VAZxTI3isjnxBGH6hMys/a/VQ+8NSZnyTygbv2CqsSJAB1tFou9e2QX+lvP+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280910; c=relaxed/simple;
	bh=8bXUNSJbbznLWihRmenUr5H9/NgzmpuUPUrz2ktMwHY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovqwT1dR9j+5kqdi0KfTNDdj/ry4Y04emmu/dnA2+ug5dxFUV/GXXa/4/hE3QXl4ZaHU788E8R/fORuRBmfMVrcEiDOKPia8F7Z3OVIq7CxxgqLGXNQbnMcs+wMdyotgFJosjYprPKEWyhNBfDNUQAfjVbVuajSP89XH1LJuiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGwNN8sH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGwNN8sH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BFD1F0155C
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280907;
	bh=1hTRNVqknymCeCEznv7yylqhodwXKwch8r9YrZ1PWdc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=SGwNN8sHbOr1IUcT+rI65vegLlyipGzdFrDAWeATwYTTiqBQTBzdRbkAqRR+4ctl6
	 T3ycw4HDZi00gnaSr7/QdY0lDZ2i0OUDFGHilyNrtBIwQFduVLqThuUriLG+LcKwE+
	 Tjj+BGuCcaZmG83TFwFxTJvwKnh9ybZvl0O7psVK75LkRUZsiyOA7is0SMZtBKM2Lg
	 huX7tdWm/NkNisP0fFdAZNUn7YH17HLKQ0pfZEE4+gt/6B9VAv1brrFUbGMRaATneG
	 C6JdQ5UDe6m6kYkpj+DJ3G4jI2oHAuQIk1iRG9qNqitINQBcTRVWQ5YNGYXY7hfUH3
	 itHAN6ftA9gZw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeba09900bso3271105e87.2
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 02:35:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YyUahOuNuBTyYQWBuWhCNNzDeGVxMSy1p7u4JmbnnGZHVzdu834
	+BMw+9sUdR1gqxsRQU2AlJb7srjDTjn9OhRt/A4RkW1cqrJyPikO6U0VWuWw5Uc7lMQhAcn5AdD
	hHnyauBR9OcNHMQImF+iv+Itx8Pvb0vXQR154aw/XbA==
X-Received: by 2002:a05:6512:1292:b0:5ae:c745:f39 with SMTP id
 2adb3069b0e04-5b28f9b63ddmr359035e87.44.1784280905637; Fri, 17 Jul 2026
 02:35:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:35:04 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:35:04 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 02:35:04 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com>
X-Gm-Features: AUfX_mwYix0SKFJrhnSfi2t34SSBz1xGfCSYL55Jk4eOHRiiAR31kNMM_woGXiM
Message-ID: <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
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

On Thu, 16 Jul 2026 18:18:25 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
> rather than a dedicated BT enable GPIO.
>
> When the serdev controller has an OF graph (indicating it is connected to
> an M.2 connector), acquire the 'uart' pwrseq target from the connector's
> power sequencer and use it to control BT power instead of the bt-enable
> GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 25c4387136245fca25e375951f960d7240116781..22f6185a946ef04c45e41b2b34126e3f58d603ca 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power.pwrseq)
> +			pwrseq_power_on(qcadev->bt_power.pwrseq);
>  	}
>
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2387,6 +2390,28 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>
> +static void qca_serdev_put_pwrseq(void *data)
> +{
> +	pwrseq_put(data);
> +}
> +
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +	struct pwrseq_desc *pwrseq;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");

There's devm_pwrseq_get() you can use instead of scheduling your own action.

> +	if (IS_ERR(pwrseq))
> +		return PTR_ERR(pwrseq);
> +
> +	qcadev->bt_power.pwrseq = pwrseq;
> +
> +	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
> +}
> +
>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev;
> @@ -2417,6 +2442,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	else
>  		qcadev->btsoc_type = QCA_ROME;
>
> +	err = qca_serdev_get_m2_pwrseq(qcadev);
> +	if (err)
> +		return err;
> +
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
> @@ -2426,17 +2455,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> -		/*
> -		 * OF graph link is only present for BT devices attached through
> -		 * the M.2 Key E connector.
> -		 */
> -		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> -			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
> -								  "uart");
> -			if (IS_ERR(qcadev->bt_power.pwrseq))
> -				return PTR_ERR(qcadev->bt_power.pwrseq);
> +		/* M.2 connector modules are powered by the pwrseq acquired above. */
> +		if (qcadev->bt_power.pwrseq)
>  			break;
> -		}
>
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>
> --
> 2.34.1
>
>

Bart
