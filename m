Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8049433E70;
	Thu,  2 Jul 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004948; cv=none; b=XCVaPpqAauurkDl/cdGARIlsmUgeByVlUnPB7ocZlfXMznNx8KSS6ueAH9E6GqVZN+7qld/QvsCPS2hShymPyM4w8hPbR2noXsrmakqx8U3m5/IRzmyoUOnO1A7Sg38efYRsJUfbaIiE2g/GPDNMxYuwijbvjasd5OFEwqddJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004948; c=relaxed/simple;
	bh=LLkHWrOMD63/9p70rDW1VrXtSZnGGOWJdRZK4hmTXHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpxySKPoSIWjWGsDXIPL7eDRmsg2LIxkI3I+kxi8WV7xglyD158G7aVODUzMbXOsT0lx/4biuXOreSDngJXLl0PVi4r7hijVrqLh2TryI8iuKbGFyXLEOW0EYoDQ+E1dxrDh3Ika28PHg9yd+ftqPPMKDRKbhPs6dHm4zgzgiqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AW05xYDs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AW05xYDs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70281F000E9;
	Thu,  2 Jul 2026 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004946;
	bh=QNIEFVldnfVEUV19RPlvKaoxSz33OpCUlGBniTtIzbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AW05xYDsdvfgnVzB8HRyv3z9EU8TK33a+ymYgDW8QSn3uNOObfBq314IjboD1w1AY
	 XrWxw7igHDiWZl/01h2Wn1NddXeuvoW/9LSafQbHZwIPrgSWIW95dlBHPD/AZ2iKeS
	 ZEF9yi1rXSmOe26iQbRyr1WVOVr/qzi3ptJ7i0go/BHSPQJUpsr78qeSnovbQbnHgq
	 yAFxD0Ll/hV1Xmrm8M0SqUhXnTr815ED+f0SvJ4GiowrTwUrIbW2o8QgZDdIbBPh14
	 krAmsetbWhygP0mzeWMmyjMQoDC88V9yP1ODhIfg5GtI4e0ibi7xSQTfBS04u+cr2j
	 7EUA5E2O57AUA==
Date: Thu, 2 Jul 2026 17:08:56 +0200
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
Message-ID: <zat6uuvh7jwfxajvqtif6d67osf6h5b2vxig3bmuch76btpdkj@bfxjj7kk5fjk>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
 <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
 <rxt4n6vuscu33mrw24af72lb3s6urqfpkhtia44yfo4j7wtu6o@3xp57owekrgj>
 <u5ieok3hgjcf74sxjdzv6xurmlbve46xa3imgfnom4hpjarmxa@fna5daqpyk3r>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <u5ieok3hgjcf74sxjdzv6xurmlbve46xa3imgfnom4hpjarmxa@fna5daqpyk3r>

On Thu, Jul 02, 2026 at 05:34:31PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jul 02, 2026 at 04:17:43PM +0200, Manivannan Sadhasivam wrote:
> > On Thu, Jul 02, 2026 at 03:14:49PM +0300, Dmitry Baryshkov wrote:
> > > On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> > > > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> > > > is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> > > > sequencer rather than a dedicated BT enable GPIO.
> > > > 
> > > > When the serdev controller has an OF graph (indicating it is connected
> > > > to an M.2 connector), acquire the 'uart' pwrseq target from the
> > > > connector's power sequencer and use it to control BT power instead of
> > > > the bt-enable GPIO.
> > > > 
> > > > Also allocate bt_power unconditionally for all SOC types since the
> > > 
> > > Can we just fold it into the main struct?
> > > 
> > > > pwrseq path is independent of the SOC type switch.
> > > > 
> > > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > > ---
> > > >  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
> > > >  1 file changed, 43 insertions(+), 38 deletions(-)
> > > > 
> > > > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > > > index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e87ae76fa00eda308e81dea25 100644
> > > > --- a/drivers/bluetooth/hci_qca.c
> > > > +++ b/drivers/bluetooth/hci_qca.c
> > > > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
> > > >  			/* Controller needs time to bootup. */
> > > >  			msleep(150);
> > > >  		}
> > > > +
> > > > +		if (qcadev->bt_power->pwrseq)
> > > > +			pwrseq_power_on(qcadev->bt_power->pwrseq);
> > > >  	}
> > > >  
> > > >  	clear_bit(QCA_BT_OFF, &qca->flags);
> > > > @@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
> > > >  		break;
> > > >  	}
> > > >  
> > > > -	if (power && power->pwrseq) {
> > > > +	if (power->pwrseq) {
> > > >  		pwrseq_power_off(power->pwrseq);
> > > >  		set_bit(QCA_BT_OFF, &qca->flags);
> > > >  		return;
> > > > @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Acquire the M.2 connector power sequencer.
> > > > + *
> > > > + * An OF graph link on the serdev controller is only present when the BT
> > > > + * device is attached through an M.2 Key E connector. In that case the UART
> > > > + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
> > > > + * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
> > > > + *
> > > > + * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
> > > > + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
> > > > + */
> > > > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
> > > > +{
> > > > +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> > > > +	struct device *dev;
> > > > +
> > > > +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > > > +		return 0;
> > > > +
> > > > +	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> > > > +	if (IS_ERR(qcadev->bt_power->pwrseq))
> > > > +		return PTR_ERR(qcadev->bt_power->pwrseq);
> > > > +
> > > > +	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> > > > +	*bt_en_available = device_property_present(dev, "w-disable2-gpios");
> > > 
> > > I think here you are looking into the exact details of the other of the
> > > graph. There might be other devices on that side, while the code now
> > > assumes M.2. Or, consider having an M.2 controller which handles
> > > W_DISABLE2# internally rather than through the GPIO.
> > > 
> > 
> > This code only deals with M.2 connector in specific, so I'm not sure why we need
> > to worry about *other* kind of devices. Let's worry about them when they show up
> > (with graph interface ofc).
> 
> I don't think we want to go through the drivers using M.2 connectors in
> such a case. In the end, the contract should be that there is a power
> sequencer on the other side of the graph, but the specifics of the
> connector should be abstracted out. Do you know, if in the x86 world the
> W_DISABLE2# is a GPIO or is controleed by the hub.
> 

I tried to abstract out, but Bartosz didn't want pwrctrl APIs to do that level
of abstraction as pwrctrl APIs should be generic and should not be bind to a
specific connector and exposing its internals.

That's why we ended up having pwrctrl core exposing the 'struct dev' using
pwrseq_to_device() and letting the consumer extracting whatever information it
needs.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
