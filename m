Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043D35975
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256616; cv=pass; b=NP40icZ2cnJlj3UrHlP1vaG1hYt79NAaHq2fcFie9gPoPvpr3oV8/4E8oacreM+JsmNP259vRpfWveHxSTQ5B1BANu7rMvnWlBtxM/XfzkNlsuhr6EvxQcKP3OEdDg5VAY+ozrZOU5rUepByi5ZlIGS2KVJEaKl8RvuJdYd/lJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256616; c=relaxed/simple;
	bh=AVRlE0G99BC+L7y0nye1ZxQzkDfQkyMJSbR7r+WemrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAIT2yEK9Nwu9Q15VGzQFsKQX0JOxspIIJJ+T/cGh6ZwxCuza8SyRA9S+4wjnN0JwAOrQ8QB5B8WdGqk5Bw7s91aC2kpFKEOGta5uJFPwIZNQEi5DYHSzlVmfdfVQsc+EvBz86XZ7aSHmjSDqtIMb9fI4KtqrF5KX0CSbWF86nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PC3cpC6b; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PC3cpC6b"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so809667466b.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 22:56:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779256614; cv=none;
        d=google.com; s=arc-20240605;
        b=dwNApSAM3wEFJbHjbXOK4KNz/RsDZxC3QuZGSY8fx5AwtNTIOd2O2Q/BgJcS1fCGQm
         SRw/f0QMZjnOSLfs3KKouvVReQY0f1K3OxQbpT49j9UyfI2TLsFNASmIotRTNbtZ4cB4
         eDHOqaDJXTrtTNdO1CfS7KcrF9HjqfmxCN9RQ7K8eHRXNvryjsD/QIw9Epua2JSM+CbT
         rLLECNmPWgPd2nOAkzKgpXWPtqvo8oIIEsTFweOi9AjTpRR65KV4mzUdPViezexLL0wA
         VYgBfWXxpfBWSjNCz00bpKkqCvs06G+zm9QacVg3ExRiQCLDnwRdkxTUF4Nz/PJCm8ow
         I3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etsMGOIVq2kJS1rwImtVQ8IDqskkHwe2NYV85OoKq3M=;
        fh=h/mQfnkGpXcZVqhjkuZak8UBM0IW3/9wnUlD56ZRg1w=;
        b=eyMpJBdQZOG9FpbV9hSt51NQxdDjknakqqMXlagcbjDZ84IsMenMWeiE+WSlOyptse
         F3Dq6/wxvKypn+CHdaT420yKDEyXz1HfBuLAtvTaxEqihncqK54ov73SSHC0D7gh3o6y
         vIWb1hrRauKoCCepEZhWxv75U6eyGkDvrD+F0wHhnxFdlhacpTNznZtNG26bQpG5nOnS
         GyxqI1erjnbwKQtwiIEITEEDJ0IPDb+51u6Z1T05uKKmYqPTOnsfe8n13LNOnbzgOTLr
         5k7DOyAWb3qwaiYDBfex22t8tA0Y8vL+u6qM58NFZ2RN/VP+m7XDd+BkWL63mZ+v0InO
         jFmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779256614; x=1779861414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etsMGOIVq2kJS1rwImtVQ8IDqskkHwe2NYV85OoKq3M=;
        b=PC3cpC6bLm5EWnctfQW1snECzgyoJjl5STmtJ8D6JiCz/UzJRAUALv0ho6Wu6HKRBw
         VZNuXMT4gZArwE+Q61ckzLgIrlyumrXcE5H9J0HyG7cZKCwn9L5L8S6kKz3ileYERbsc
         2euVZuYp9h6SAn3J19A6G0YrfQjAO8Est0EZRKVXNEv+B+Qk9iKH0+WEK0t9fZ4GtnAZ
         li0F2d2/nXPNQpXRLma/8ERnNuWm8cgT40vFNftYf3JEjSxH3Wzw/zeaat6e5xug83Hj
         KwdlhN7yvB4tvaSmpdvcBdprrhUrUZEYOpV0v3ozt8FeQw8EX9Rjbc91+uvilotbdBHX
         JfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256614; x=1779861414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etsMGOIVq2kJS1rwImtVQ8IDqskkHwe2NYV85OoKq3M=;
        b=SaGO46r2wXrG4W+/M17Pz006BQJel8jvg4CnIyZ1jOSHkIuBOgcthZRWFZhX1I0PO3
         /UZBvtVRqD4QTTRlx3bx2LN5Q5vSjRxl+yK/LPvMqIO0Lr+S/dA0VKphG2Yk3PP7+4wt
         Q/7z64K71J0YJ+x3ct9p1wAReecW/qA6TR+k2VtmGpgiiDUqK+d9+mTZ6A2bBA3xbVfG
         yY/ybActc34dyYAVSzhUkrvE4RqAHcyGY2DHeArY4rECq3TGsJ3Us+vn89dA7QW5jwrj
         S5yo2xZ5wGvMVkF1CZ61WLTVOD7p/W1anN7GPc8LGzPrl6n9MPDtjlA1aRMDfSr9/rHf
         attw==
X-Forwarded-Encrypted: i=1; AFNElJ8lvbNvNbOFaI/ymnXJRTPZEB+QMzTTvfX9M5uj7OV0iL3mpATlmD1eTP+dOU6ueHOx1xejDUPwklw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCYYzzrVZg9aHRA8LQakQ+o4sap3mFyxvRw3yq6SdS4GYQsBdM
	iWUW4l5yMNiM3HiTRAVLk7DVlVxo64e/19Fy3fbxg8006u8U1/Eo6oHMtN+1Ju/kHk5zm02gyhV
	nqcSMcnObPYj5ZBbckYZ8oOxsACbgF5Y=
X-Gm-Gg: Acq92OFwoR1r1J9+9TpaOd72ke5jev2lqdVFfgc5Eh058/AgYatsPOmp0e5M6uklzRQ
	0gb5XLON+EZPThk9kmPjEFPLoKxR74UqKz1qpjm4kpog74DyxNidTcSWM7uFQqTpj7IPoAIavrn
	04eM/KiO0w3AvQdBUhYBdA+C9VYAxQskGkJ+gVS/Uq/EGlM0da38cQspyfAyAjhWgR6QtIF/XUU
	5xKNG9acZejkRGwDzIY+VNZIQw/muMvO2mgHvWRg7VGo/Eh0I8KBU75ybyDmVYvm/xiwPNDSd9S
	uhP3ZTNCoHW/nX7fxm700x+uz40P4Ww5M+uL5A==
X-Received: by 2002:a17:907:c206:b0:bd8:f7f1:d31e with SMTP id
 a640c23a62f3a-bd8f7f1d8acmr470179866b.49.1779256613629; Tue, 19 May 2026
 22:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508031710.514574-1-alistair.francis@wdc.com> <20260508031710.514574-9-alistair.francis@wdc.com>
In-Reply-To: <20260508031710.514574-9-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 20 May 2026 15:56:27 +1000
X-Gm-Features: AVHnY4KniR3r_N3kxaUwuJ2NdVV3JVmbSqiPSHds9-OenhdEMA5je4KUw5NkTj4
Message-ID: <CAKmqyKO1L+sCHWMDJ-tH1WVc+=oMVidnVSMttr6ft0-ewSjMVA@mail.gmail.com>
Subject: Re: [PATCH 08/18] PCI/TSM: Support connecting to PCIe CMA devices
To: alistair@alistair23.me, linux-kernel@vger.kernel.org, lukas@wunner.de, 
	Jonathan.Cameron@huawei.com, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-cxl@vger.kernel.org, djbw@kernel.org, linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com, wilfred.mallawa@wdc.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, tmgross@umich.edu, 
	ojeda@kernel.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 1:18=E2=80=AFPM <alistair23@gmail.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> In the next patch we are going to add a PCIe CMA TSM driver, as such we
> need to ensure that is_pci_tsm_pf0() will allow us to connect to CMA
> capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
> support.
>
> As such for Root Complex Integrated Endpoint (PCI_EXP_TYPE_RC_END) we
> also check for the CMA DOE feature.

@Dan Williams this is the patch I really need your thoughts on.

The current upstream pci_tsm code only works if IDE or TDISP is
supported, which isn't true for CMA support.

This patch works around that, but the more I think about it the
hackier it is. I have a local change that reverts this and
updates`tsm.c` to work with a DSM (`->dsm_dev` is NULL), but that
doesn't feel right either. Do you have a better idea or how to enable
a CMA TSM driver?

Alistair

>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  include/linux/pci-tsm.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index a6435aba03f9..5059954e4853 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -3,6 +3,7 @@
>  #define __PCI_TSM_H
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/sockptr.h>
>
>  struct pci_tsm;
> @@ -129,6 +130,8 @@ struct pci_tsm_pf0 {
>  /* physical function0 and capable of 'connect' */
>  static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
>  {
> +       struct pci_doe_mb *doe;
> +
>         if (!pdev)
>                 return false;
>
> @@ -146,9 +149,15 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pd=
ev)
>          * switch.
>          */
>         switch (pci_pcie_type(pdev)) {
> +       case PCI_EXP_TYPE_RC_END:
> +               doe =3D pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +                                          PCI_DOE_FEATURE_CMA);
> +
> +               if (doe)
> +                       break;
> +               fallthrough;
>         case PCI_EXP_TYPE_ENDPOINT:
>         case PCI_EXP_TYPE_UPSTREAM:
> -       case PCI_EXP_TYPE_RC_END:
>                 if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
>                         break;
>                 fallthrough;
> --
> 2.52.0
>
