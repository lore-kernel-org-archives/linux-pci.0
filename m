Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C62750FB;
	Mon, 13 Jul 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918619; cv=none; b=olXsU4+51/XJIcMlh2VfWKrmVzjXzGB2s/8W8eWrz/4nJy4LGkRMGV4QOZ/y/XXYBap9z2HE9E52Bjk+i6e58m9dtzSNuc9C8QcL80kU7zO/FblB1rhX6SVUpFBhSDvegGi/yGbV6tK1YjgV2r5abOMjjN9h6sH4CELB7tnzcoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918619; c=relaxed/simple;
	bh=/94lvdcimq2Roxo5Vqv88vv9tLT99AmeMn/ihS83wuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qP9Zhlgk16+hS3otkqA638WAAEopzfmhcJh1BriZ2I2zEQEh4u3LDC0hbbHCn5kEtvMArl/n+y228rbr5giKruniF9MT9T2pdhftNbCmQdB6fpD15TdfF/So9Ikee2gTzgk17B71WQzTBI38cQ1rqUjHvmJSaJki6blyhoBoc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBY+E11j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBY+E11j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520441F000E9;
	Mon, 13 Jul 2026 04:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783918617;
	bh=jJKBYEa9rmr3kvyqLbAs5Ywz97Hji7oACJ4jFgIyWhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PBY+E11jlqgQQIDZUU5NB9ily54ng2B7A0IQ+x0NPi3w7IQmtXvMM+0UwvlBndEZ0
	 U7IRy2Zmfp/d2Q01FJuhFhlk7q3eKOffl+0iWGSaalhP7lyaepNkO9/1ZUe8AMBs01
	 Vousxc+DyINtJgVKHFZaNoUyJ1oLHWxyP4zFF6peyuFyNBCnG9Nk33Z8ol3Xj+pqQ8
	 eAPwklqg/O4gC5VAprHX1ofLAAOR8m5bLsHOBNy4x6wmkoLqpwm9IyI9Lbft7CvNAU
	 GKgANzx6p3Rfs+aFcYreUOj5Q7vVvsF7Kl4NOLXaGCd5KNvG3zJguTMvNgiFx+fP0F
	 Jb0+zqqfMSSiw==
Date: Mon, 13 Jul 2026 06:56:45 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, 
	marcel@holtmann.org, luiz.dentz@gmail.com, hongxing.zhu@nxp.com, 
	l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, sherry.sun@nxp.com
Subject: Re: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Message-ID: <mow4vuf6zf6c7uzb7zbvwuw3b5p5q5rfghw266f2eiesvhssle@7jzavek52rt7>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
 <20260713023435.235765-4-sherry.sun@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713023435.235765-4-sherry.sun@oss.nxp.com>

On Mon, Jul 13, 2026 at 10:34:34AM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support
> for getting the pwrseq device if the OF graph link is present.
> 
> Once obtained, pwrseq_power_on() is called to power up the M.2 Bluetooth
> card. The power sequencer descriptor is obtained via pwrseq_get() with
> the UART controller device (serdev->ctrl->dev), since the OF graph
> link is defined on the UART controller node.
> 
> Also add the explicit pwrseq_put() call in all exit paths, pwrseq_put()
> already calls pwrseq_power_off() internally, so no separate
> pwrseq_power_off() call is needed.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> Hi Frank and Bartosz, this V6 patch using pwrseq_put() in all exit paths to
> fix the power sequencer reference leak issue during BT driver unload and
> reload as reported by sashiko. I'm keeping your Reviewed-by tag. I can
> remove it if you think it's inappropriate.
> ---
>  drivers/bluetooth/btnxpuart.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 0bb300eef157..81a11ac05114 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -9,6 +9,8 @@
>  
>  #include <linux/serdev.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
> +#include <linux/pwrseq/consumer.h>
>  #include <linux/skbuff.h>
>  #include <linux/unaligned.h>
>  #include <linux/firmware.h>
> @@ -211,6 +213,7 @@ struct btnxpuart_dev {
>  
>  	struct ps_data psdata;
>  	struct btnxpuart_data *nxp_data;
> +	struct pwrseq_desc *pwrseq;
>  	struct reset_control *pdn;
>  	struct hci_uart hu;
>  };
> @@ -1872,11 +1875,26 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  		return err;
>  	}
>  
> +	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +		struct pwrseq_desc *pwrseq;
> +
> +		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
> +		if (IS_ERR(pwrseq))
> +			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
> +					     "failed to get pwrseq\n");
> +
> +		nxpdev->pwrseq = pwrseq;
> +		err = pwrseq_power_on(pwrseq);
> +		if (err)
> +			goto err_pwrseq_put;
> +	}
> +
>  	/* Initialize and register HCI device */
>  	hdev = hci_alloc_dev();
>  	if (!hdev) {
>  		dev_err(&serdev->dev, "Can't allocate HCI device\n");
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto err_pwrseq_put;
>  	}
>  
>  	reset_control_deassert(nxpdev->pdn);
> @@ -1907,13 +1925,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  	if (bacmp(&ba, BDADDR_ANY))
>  		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
>  
> -	if (hci_register_dev(hdev) < 0) {
> +	err = hci_register_dev(hdev);
> +	if (err < 0) {
>  		dev_err(&serdev->dev, "Can't register HCI device\n");
>  		goto probe_fail;
>  	}
>  
> -	if (ps_setup(hdev))
> +	if (ps_setup(hdev)) {
> +		err = -ENODEV;
>  		goto probe_fail_unregister;
> +	}
>  
>  	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
>  			   nxp_coredump_notify);
> @@ -1925,7 +1946,10 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
>  probe_fail:
>  	reset_control_assert(nxpdev->pdn);
>  	hci_free_dev(hdev);
> -	return -ENODEV;
> +err_pwrseq_put:
> +	if (nxpdev->pwrseq)
> +		pwrseq_put(nxpdev->pwrseq);
> +	return err;
>  }
>  
>  static void nxp_serdev_remove(struct serdev_device *serdev)
> @@ -1952,6 +1976,8 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
>  	ps_cleanup(nxpdev);
>  	hci_unregister_dev(hdev);
>  	reset_control_assert(nxpdev->pdn);
> +	if (nxpdev->pwrseq)
> +		pwrseq_put(nxpdev->pwrseq);
>  	hci_free_dev(hdev);
>  }
>  
> -- 
> 2.50.1
> 

-- 
மணிவண்ணன் சதாசிவம்
