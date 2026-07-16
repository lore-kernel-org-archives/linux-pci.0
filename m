Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857393B42FC
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210200; cv=none; b=lXG/iGOP3+QvhgZHTYD780TlbYG0zPfZmPZNhHL3o5mfvwwuaUJGxlHA3PvXA9r0p01mNai+XaR2vkwvp25Hx7+7mPh4wrxQK6pOMIwie3MnQixR+FNE2R4lFNF+Qd83g8p4Ij2u4tbpQayoZ5a0gne3p1WQ9cbNKhg65QA+5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210200; c=relaxed/simple;
	bh=0DmqgbykD9XUoj6tr6kuvFA55tWPg05MCrVhBbT8GsE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hjbg3X9o3MvoROaEsGacI+5Gc1dVu6+EMWxeXhxBScgPkwQmUzbjfk0AFMS3FZy64gruzZdwArdxSWijfEaNup8a4tkd9BF810ZQYyWZ6tYZriEyKiXpC+VaGrj4PXWVuEz0AWvoCEFszLwA2ztVfPaHKtZJWtzyn0C3r0SrZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POV7mxJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POV7mxJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B831F00ADF
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210199;
	bh=mwOeiH6TQ8hwAzWbwmnJz/CIz4T49YDiQFjUY/QfsyQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=POV7mxJaOIibLP31szhb/xovSeQID8SQf5snSkkCOXVX3axwodvxoYOtwNoKUAhMg
	 vki32sAf9pnnnH59Y7Kg+T+eaPSfi7BYj6Gp+gY261B+eHPTIWc75mCVn1fNlVwm6d
	 u4KyNCjKVFNotIrP+gcxSd4MDc1riEEKEYXOexKTu0O/bh+Eb227QwKziHH7FOqxXE
	 LKpCJfD1ldDGWJQerYBZwLIKOZVcY1mNATcFgTVjECxhaf+2lCShwcpRq0hh6kXIRj
	 C6QsC/p3b8jgElwuGW7pL31W0tdUrlSFtIIPENdJy1fXyKece86c8ghkWf9gJCkwrP
	 8uIJBKVl4T1lw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39d560a1dd4so16869701fa.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 06:56:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rptl2fIG/t853eKFOhXMUodCkg7cfCRxhXtQ8xfr7JARpgf9zcw9haDlv3aq0IJtSDF3d9FXkWzuss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGG830tMIsl4JDVNMqBjiORvOnVdUpSP5vrEeEp/UEqTcQLtHH
	BR0Wfp9++pxfu7f7GtBlQOrT/OtGOdO7yU3ykthJJhpHFtIr4g/0FTvsAovSoetpi97H3n8+Hhs
	uPAQ1djK2MFdhmOKyd6Vcl8/m0ZuAKV3Jg69Z4w6DaQ==
X-Received: by 2002:a2e:a541:0:b0:39c:6e84:99b6 with SMTP id
 38308e7fff4ca-39db6c29ecemr15216291fa.23.1784210197958; Thu, 16 Jul 2026
 06:56:37 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 06:56:36 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jul 2026 06:56:36 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 06:56:36 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeowD++93_eaYSBp0mKoY0nRROLFncLP6Ec_TdJn3jJEg@mail.gmail.com>
X-Gm-Features: AUfX_mzmx9GeLm3op_lLrefZoDCe5e4VmjadrLm9lyfOJ48w2ivaJ_TPEAAX-dk
Message-ID: <CAMRc=MeowD++93_eaYSBp0mKoY0nRROLFncLP6Ec_TdJn3jJEg@mail.gmail.com>
Subject: Re: [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and WCN7851
 UART BT variants by subdevice ID
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, mengshi.wu@oss.qualcomm.com, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jul 2026 09:29:41 +0200, Wei Deng <wei.deng@oss.qualcomm.com> sai=
d:
> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
>
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong =E2=80=94 there is no UART BT interface on=
 such
> a card, and the serdev probe will fail.
>
> Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
> their respective sub-system IDs. USB variants no longer match the table
> and will be handled separately to deassert W_DISABLE2# for USB BT
> enumeration.
>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 83fe6a1396bc..cf51122d54fd 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -191,9 +191,11 @@ static const struct pci_device_id pwrseq_m2_pci_ids[=
] =3D {
>  	  .driver_data =3D (kernel_ulong_t)"nxp,88w8987-bt" },
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108=
),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,qca2066-bt" },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe=
105),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e=
),
> +	  .driver_data =3D (kernel_ulong_t)"qcom,wcn6855-bt" },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c=
),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,wcn7850-bt" },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
>  	  .driver_data =3D (kernel_ulong_t)"qcom,qcc2072-bt" },
>
> --
> 2.34.1
>
>

Do you want me to queue this independently from patch 3/3?

Bart
