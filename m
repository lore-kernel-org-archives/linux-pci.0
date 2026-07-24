Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523F3B101C
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878737; cv=none; b=OXFM3nMZjaWm2WnLM2xm7RRVi5vOoLJTteKvOduRuFhEvsazDVjJ7B+rqRK5oGVRNzTrfvzSFwAzJ/44wUA04oBOhlzbPaiBte0sfAdBoFQcf6hOUeJaOg3M2TJswogjyXlqyivXNCHeyqjIoJ1cE3NngxPVJMl10Hu2Wfx7VRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878737; c=relaxed/simple;
	bh=dwm84/SYi4rjp20Lcu/VCM0Z7zxbc7/3oYQtjSiW4uU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ComuP8j7NxMNGGcRAyBho+6/mdyQmmnympCYWAJO883eUkdeDuUUUj61MTSxUmR9cMAyWE1+L3s7QBk6+XOSXHZtRs7x6+qf+52cVS73pBYEUk3KwFjqTpqUZegeBY7ptbB1+0XCEqvAO6wpd2mbfWhze2nioVk/z5jUr50xgzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3ANXHN/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3ANXHN/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4471F00ACA
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 07:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784878735;
	bh=ftWP9saioUia+KgaPooZI0PI5Yq7lJPf8F0MvvRDa4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B3ANXHN/tfgxCrA9Ehd/WbPNigx8L8PN4Fh3uayl8w2CZHUJ63un7UrbCBS207gsn
	 SkLhtylnO/I8cFtZiYvvRLs7w44btRYQDSPRAQTxReOU33zln9H6xII8IEKYUzbJWC
	 Huqwd0ZmMWlgGVBtLmaCJBI3QckFV58jK8ofKhVndhrCXRxv6yfdhaUJG5VwjFRTI/
	 l2pgKR39oPKBiLrZf0HAYFcy2uv+nVNvjEVAVeaaFgxfwJCGjfkVjbbfF0UmeraQh6
	 F2U+8ao0KNZ/HT0WEhY8VKLJO0OPGe3XEwbyodngx2JRd8C3mPY2hQH0HvBNmgNexb
	 mkQjPhaM6N3fg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so1178801fa.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 00:38:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqUhfV1FA3OGksGzQJ+yF6hEDLhKTJrPRGkuE8RCPcWNecjrkT2bfkf/GcOUFcyaXd+lzL7fyiAYZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3tr/sd3rqOGTJpkO7tc1tiSdXeeR4t6u9SVPu3miLCVa4Ltz
	2E65R6QeVgYRjO7sF1Kgjeb+s3OhMPLJPeN8VFO6Moi2/PlTy0dVcvPPSVxI/ezG4qNTTUX37DM
	oE9HSGRSwW9KjUtp6ryqNp+1R/ak7LqQxVCUeu0uX/A==
X-Received: by 2002:a2e:be8c:0:b0:39b:15b4:79ef with SMTP id
 38308e7fff4ca-39f07c274camr11837191fa.17.1784878734609; Fri, 24 Jul 2026
 00:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
 <20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com> <9cc5af16-d95e-4f10-8b4a-5e29c136079c@kernel.org>
In-Reply-To: <9cc5af16-d95e-4f10-8b4a-5e29c136079c@kernel.org>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 24 Jul 2026 09:38:43 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdoFB4H6u2hXJ81Wn+aOauS67yVS3TSUizTGD4DKvyuPA@mail.gmail.com>
X-Gm-Features: AUfX_mxBqgF5Le9eKDik_3cSBDJSKKeK_0eibWW07zyi-I4VA4_6o-qnnzr1Yx8
Message-ID: <CAMRc=MdoFB4H6u2hXJ81Wn+aOauS67yVS3TSUizTGD4DKvyuPA@mail.gmail.com>
Subject: Re: [PATCH 3/3] power: sequencing: pwrseq-pcie-m2: Add QCC2072 BT PCI
 device ID
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:22=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 03/07/2026 14:38, Krishna Chaitanya Chundru wrote:
> > Add the Qualcomm QCC2072 Bluetooth device (PCI ID 0x1112) to the
> > pwrseq_m2_pci_ids table so the M.2 power sequencer can create the
> > serdev node for its BT interface on enumeration.
> >
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.=
com>
> > ---
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/=
sequencing/pwrseq-pcie-m2.c
> > index b5ed80d03953..4aac52062fae 100644
> > --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -190,6 +190,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids=
[] =3D {
> >         .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
> >       { PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
> >         .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
> > +     { PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
> > +       .driver_data =3D (kernel_ulong_t)"qcom,qcc2072-bt" },
>
>
> Bartosz,
> Please push back on this. This is undocumented (indirect) compatible.
> This cannot get accepted to kernel in such form.
>

Hi!

Sorry and thanks for bringing this up to my attention. I was not aware
these PCI entries count as DT ABI. I'll queue your revert and will
keep it in mind next time.

Bart
