Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BB4DC53B;
	Thu,  2 Jul 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001883; cv=none; b=Vd4HwFpYKCX1msnLB5+qQRe5nR183CVWwm7GnXoAZKXk7hlXru/r5/ge9azAmiAqHTBdkRXV5c6zletKR8SBNK/nHDach+xUrBazlywFBB5yrA3Wq/BbYR6je6ukcxZijrzevrLvIA2lJNozBV6NOnhz27ia9MW0mFP8D/uHMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001883; c=relaxed/simple;
	bh=vaX40iTlWpoIvTiV2p21NL1CN9B3FT5oe1ygQwdLAZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p20MAyQ2dsL83p6O8+ZxIuI+5kTc0JMD+JwZVfjYyn2+wGA0kb0sSw8iVYPlkvjgb2cUUvOCS3ov4nYCazY3BTGNiC3kOxW1FG16IGqhl5TBy63Rx8gv2rzDvtfqzXgUJRKLn/KfBpExoU/iMJN4ZWjGveY3b+IV/nITdxYloT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx/a/TvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx/a/TvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE31F000E9;
	Thu,  2 Jul 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001873;
	bh=9vXrBgiWOPMTNv950Pl4j8goBiF+aNfJS5Xso/tb3CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xx/a/TvMnOJ5BBmDN86goiyNT2JmCjIi1oEHX4FLSC1IixpblA4xHYShHZiT7Adb1
	 7i61u/Oz88icbl/wdhf9YCJ0cMdyXWJFm9O/aJV5K0sS08LnW9E2e/xT9q1CIQTKKo
	 TtjMImB+evL9gUWK2DQb8QdOYsf2dxNjQsyt+D0lIk3TmlXoXFy/FdOAQ7xwGVdJuZ
	 xdHegE2Toa7/AOL7dC/fJ2WvOAzTnfsN6/JaEROqq5VGYSOlkYtO9jbSbuKoYEspni
	 Fo0cgNPx8liBmx8/AbRdCS06Ik/KPhOf2d3+XzTyl36r6ZkeQ2bRKjPwV0VaFopx4n
	 iGxx+9vJaFGjg==
Date: Thu, 2 Jul 2026 16:17:43 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <rxt4n6vuscu33mrw24af72lb3s6urqfpkhtia44yfo4j7wtu6o@3xp57owekrgj>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
 <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>

On Thu, Jul 02, 2026 at 03:14:49PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > sequencer rather than a dedicated BT enable GPIO.
> > 
> > When the serdev controller has an OF graph (indicating it is connected
> > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > connector's power sequencer and use it to control BT power instead of
> > the bt-enable GPIO.
> > 
> > Also allocate bt_power unconditionally for all SOC types since the
> 
> Can we just fold it into the main struct?
> 
> > pwrseq path is independent of the SOC type switch.
> > 
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
> >  1 file changed, 43 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e87ae76fa00eda308e81dea25 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >  			/* Controller needs time to bootup. */
> >  			msleep(150);
> >  		}
> > +
> > +		if (qcadev->bt_power->pwrseq)
> > +			pwrseq_power_on(qcadev->bt_power->pwrseq);
> >  	}
> >  
> >  	clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
> >  		break;
> >  	}
> >  
> > -	if (power && power->pwrseq) {
> > +	if (power->pwrseq) {
> >  		pwrseq_power_off(power->pwrseq);
> >  		set_bit(QCA_BT_OFF, &qca->flags);
> >  		return;
> > @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Acquire the M.2 connector power sequencer.
> > + *
> > + * An OF graph link on the serdev controller is only present when the BT
> > + * device is attached through an M.2 Key E connector. In that case the UART
> > + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
> > + * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
> > + *
> > + * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
> > + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
> > + */
> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
> > +{
> > +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> > +	struct device *dev;
> > +
> > +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > +		return 0;
> > +
> > +	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> > +	if (IS_ERR(qcadev->bt_power->pwrseq))
> > +		return PTR_ERR(qcadev->bt_power->pwrseq);
> > +
> > +	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> > +	*bt_en_available = device_property_present(dev, "w-disable2-gpios");
> 
> I think here you are looking into the exact details of the other of the
> graph. There might be other devices on that side, while the code now
> assumes M.2. Or, consider having an M.2 controller which handles
> W_DISABLE2# internally rather than through the GPIO.
> 

This code only deals with M.2 connector in specific, so I'm not sure why we need
to worry about *other* kind of devices. Let's worry about them when they show up
(with graph interface ofc).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
