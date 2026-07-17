Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CD73F823F
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292093; cv=none; b=QzOX5UDWgG3bYckpyVPMkGOoK72NdEO2Q5D4Hq09Vyb24/+NfizTvuL5f2kNQ0GNpQmoVJgukL5hk1GRUQL9EK+fkm5EimQK5sXEjcZaxB+IC2qcjhAc7q/mgX2E0Yu4Ia0plbOA7P7uhOzT7fzoJb1x9rggNw5gS3FhHz/jNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292093; c=relaxed/simple;
	bh=ad7ujwsfWBYlBrp+APexI3QPW2pYIsMMi5ey2r7FrDs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJaQN+bg41uoek4NRVtzmisnJSm/ri7VgmqS0K29JFrLLIR5KLKV2gy6/jCmH5tBn3FbT9mhde6xQTKrQDQJtdpppJ5Ui8WhStfY6IsJm4yaL9ZmXb5hfJYwpBn4TNAOcIen1sNeINkv02xRZxBkijET3I2u+0e7aEPtItUDgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5JKUawp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5JKUawp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0389C1F00AC4
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784292092;
	bh=m+axLXnaKJEGHNFMBEGT4Zy3Q/EEwboTj2mFiNNj1t8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=P5JKUawpVnBajyTslMgPIqsB/u9snuQGu2uU9xp9L1kK0MokZuGgHazXGGk2u22HN
	 hbzS7ZPx3cFkxH39c8lmdGIcnZ7q79Po9KVHDqhzLweRthuAR9d6ql13EJVIEnNQtG
	 33rPY5Xujv3b8Kho68WWv0SKksWxvSdaWJDEdXx2gvP3RGM+6DaTGMOmSPbg9/6iKp
	 0yVKKk9lbwnZhNdDN44W4Fib8dQD68EBxT65AylDkDTc/2Swf2EciT+Z1LuSgpbAuw
	 iioiWhtafNswud8HZDEJkDVrOHEuMpbYUP1tZdfa0RgMZsohhGCMdgg8aXIZMr/Dwt
	 /xsNyWE/dWo+A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so7189167e87.0
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:41:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqgNlEwOv0ZjrxS87EBAA/ze1ey+DOTcH8K8mkWTMiAWGtkMdqTvXX3/IZLtkMww/S1u67sPJx0qDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwx/HGdEw4/rTNkmTMHwHPhjQNg+n22ND+EC2jwEWGLsUe0kRw
	/LQ0c/CSjIVX4OdtgK0U4z11+Z0SVjEADpEdtFrN0V8KVUlwyqCs2JojJXBH2hC1j1h5LJqSTXv
	gyCql3P17XGzgN4osYypU9ygh7JpO8m9SoVQgKdzamA==
X-Received: by 2002:a05:6512:8054:b0:5b0:f9d:f7af with SMTP id
 2adb3069b0e04-5b28f85e66emr449360e87.4.1784292090707; Fri, 17 Jul 2026
 05:41:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 05:41:29 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 05:41:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAFEp6-0HnYOboVWc3GUG5qMN_phP4ryJp=T=LgZs2ujyX1isMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
 <20260716-monza-wireless-v4-8-9b02e6f549d7@oss.qualcomm.com>
 <CAMRc=Mc3gt_uruVmUmqsOsvKX=52V4TBVC0hbo69KgjEGhch3A@mail.gmail.com> <CAFEp6-0HnYOboVWc3GUG5qMN_phP4ryJp=T=LgZs2ujyX1isMg@mail.gmail.com>
Date: Fri, 17 Jul 2026 05:41:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdhNJEkSOCnz9tnT=wYgseZdFkUs-7VbLgBJhWWjU_cig@mail.gmail.com>
X-Gm-Features: AUfX_mxPH67iV8-drcRF8TjP1xX1r4zX-SMyz8sadg86rCJAZgfpcbCWPTxNlVQ
Message-ID: <CAMRc=MdhNJEkSOCnz9tnT=wYgseZdFkUs-7VbLgBJhWWjU_cig@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jul 2026 14:32:27 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Hi Bartosz,
>
> On Fri, Jul 17, 2026 at 11:35=E2=80=AFAM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
>>
>> On Thu, 16 Jul 2026 18:18:25 +0200, Loic Poulain
>> <loic.poulain@oss.qualcomm.com> said:
>> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable i=
s
>> > controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequ=
encer
>> > rather than a dedicated BT enable GPIO.
>> >
>> > When the serdev controller has an OF graph (indicating it is connected=
 to
>> > an M.2 connector), acquire the 'uart' pwrseq target from the connector=
's
>> > power sequencer and use it to control BT power instead of the bt-enabl=
e
>> > GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
>> >
>> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>> > ---
>> >  drivers/bluetooth/hci_qca.c | 41 +++++++++++++++++++++++++++++++-----=
-----
>> >  1 file changed, 31 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> > index 25c4387136245fca25e375951f960d7240116781..22f6185a946ef04c45e41b=
2b34126e3f58d603ca 100644
>> > --- a/drivers/bluetooth/hci_qca.c
>> > +++ b/drivers/bluetooth/hci_qca.c
>> > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>> >                       /* Controller needs time to bootup. */
>> >                       msleep(150);
>> >               }
>> > +
>> > +             if (qcadev->bt_power.pwrseq)
>> > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
>> >       }
>> >
>> >       clear_bit(QCA_BT_OFF, &qca->flags);
>> > @@ -2387,6 +2390,28 @@ static int qca_init_regulators(struct qca_power=
 *qca,
>> >       return 0;
>> >  }
>> >
>> > +static void qca_serdev_put_pwrseq(void *data)
>> > +{
>> > +     pwrseq_put(data);
>> > +}
>> > +
>> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
>> > +{
>> > +     struct serdev_device *serdev =3D qcadev->serdev_hu.serdev;
>> > +     struct pwrseq_desc *pwrseq;
>> > +
>> > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
>> > +             return 0;
>> > +
>> > +     pwrseq =3D pwrseq_get(&serdev->ctrl->dev, "uart");
>>
>> There's devm_pwrseq_get() you can use instead of scheduling your own act=
ion.
>
> The reason is discussed here:
> https://lore.kernel.org/all/20260716083141.GA4101439@google.com/
>
> We want the lifetime of the pwrseq descriptor to be tied to the serdev
> consumer device rather than the underlying serdev controller.
> Maybe a short comment explaining this relationship would be helpful.
>

Ah, subtle. Yeah a comment would be helpful.

Bart
