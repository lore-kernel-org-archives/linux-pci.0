Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720685;
	b=FI7U8AkqE0bq5Ft21HzbpJIvxymmviY9nGNVy5Vhg4oHKBloZP+UwNXhZa/sjKHifrTk
	 mLpFOiIEk4H9ho5hbECIwZKq3mgsYPhSbThiQAvSjxJfiQPcaXVtA9zpiYhgYr4o80sC9
	 yLYFhtobc5jFQBg67ppFvCE4WAiZ2JwN3mawUWf1OMea1Xi06Z+EerS8q/Bne1x6FUZ2J
	 YE2CdUXjoOrkXfuCAUVLOs1u8rs1VQ92LlUmxgYSzgA7WSTi/FxriTx8YDcLTU7uXrojv
	 zypu4zHg2YpfR9y8tXHqRy1GeST/MGdt4xyAjAutX3IENGKtu9R/5a6Xxf/4LZFjZhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xnLsaFFd7DaXIqgQI5tpr1pHVZGrCvHyloCd0xXcLik=;
	b=qbTH1aVEfg0M4hr6M11+TuCWcmUhbBe8m1c8VbQ2YMLErgF1WWEemqpVRNS/A+uS3XGK
	 fw7k5fJ9r/wGP1hm5i6gBa+eak8ZNI+LSz1R/Uevff4CXY9IvgZia6VNePwNnu28SKiOa
	 SelUm/auWfI68Mdcne8Z9NJOsDOU6eu9tdvQS/bd0vJFUYYDRcnMg/3R6u4jmngeNIUIu
	 y6MqAU5RmdxF4SQ/6hh5flxC7TiBnoCRk6Kx3YklUNxAOTGN4P6rbOUFovLhRjHqAgWiq
	 WFHDsppYn2iXa2ZmNmSmNjuUthmICcHaB2m1Jw3y/Cl/DgKYbqJ511u0YuB7zr8e63A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Amg8hjhM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CCF606A323;
	Thu, 26 Nov 2026 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Amg8hjhM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134241F000D3;
	Thu, 26 Nov 2026 19:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795720684;
	bh=xnLsaFFd7DaXIqgQI5tpr1pHVZGrCvHyloCd0xXcLik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Amg8hjhMWKg2cthveCbNXTCSSzg7Pnkck01PpFSvWAeotfydb5Z0gjNieOdqFkiYw
	 dokAtJuA/DFagP2X31fp0qPF8wtsv/eaAheweA2psi8jA9hZX6RaTvcXgiE6I3W8tv
	 k7M9/ioMIBFZXUBdGkKd/k7BqSZ/S4hNw5rVqkNYUoOaDx7yMWCVylhizfXr/wVDfR
	 z+Q7IfiNs/diVXQYeWDmh3yHMesC1Un/9gap6tJFNlpGeqIhbdU32YiVP4v9iTLhtJ
	 QkurW74p3q0xACnBpoqEehdFnVxI/mJfIZsDu6p/vYCv+eOAONVmXDf7HxH7tMtBHx
	 te+VqKazZ7n1Q==
Message-ID: <sashiko-outbox-236076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] usb: dwc3: qcom: Add support to keep GDSC On during
 host mode bus suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jagadeesh Kona" <jagadeesh.kona@oss.qualcomm.com>
Cc: linux-clk@vger.kernel.org, linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261127-usb-pcie-gdsc-suspend-v1-5-485a08ffdc6f@oss.qualcomm.com>
References: <20261127-usb-pcie-gdsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com>
 <20261127-usb-pcie-gdsc-suspend-v1-5-485a08ffdc6f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 19:18:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] usb: dwc3: qcom: GenPD hwmode not reset in dwc3_qcom_resume()
  or remove
--

commit 497ba54c561a27a707fe8980a8ab1233948ec270
Author: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

usb: dwc3: qcom: Add support to keep GDSC On during host mode bus suspend

This commit toggles GenPD hardware mode in dwc3_qcom_suspend() so the USB
GDSC stays powered during host-mode wakeup suspend and turns off otherwise.

> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 5a68025ccea5e..99dce28dda065 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
[ ... ]
> @@ -391,6 +392,9 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, =
bool wakeup)
>  		for (i =3D 0; i < qcom->num_ports; i++)
>  			qcom->ports[i].usb2_speed =3D dwc3_qcom_read_usb2_speed(qcom, i);
>  		dwc3_qcom_enable_interrupts(qcom);
> +		dev_pm_genpd_set_hwmode(qcom->dev, true);
> +	} else {
> +		dev_pm_genpd_set_hwmode(qcom->dev, false);
>  	}
> =20
>  	qcom->is_suspended =3D true;

[Severity: Medium]
Should dwc3_qcom_resume() also reset dev_pm_genpd_set_hwmode(qcom->dev,
false)?

Once a host-mode suspend enables hwmode (setting sc->hw_stay_on =3D true in
the GDSC), dwc3_qcom_resume() leaves it enabled while the controller is
active.  If the driver is later unbound or unloaded, dwc3_qcom_remove()
resumes the device and detaches from GenPD without calling
dwc3_qcom_suspend(), so gdsc_disable() sees sc->hw_stay_on set and leaves
the GDSC powered on in hardware.  If the driver is then re-probed,
genpd_add_device() reinitializes dev_gpd_data(dev)->hw_mode to false while
sc->hw_stay_on remains true, causing future dev_pm_genpd_set_hwmode(dev,
false) calls to short-circuit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-usb-pcie-g=
dsc-suspend-v1-0-485a08ffdc6f@oss.qualcomm.com?part=3D5
