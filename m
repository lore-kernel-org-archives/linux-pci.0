Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50488366DC5
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038647; cv=pass; b=KXaGWxYVCyVquWVmRcAACth1w44bZtanfvAiR3eFoAmeaNYLBG0QoGGNkLEU6/M0SsfsrEfD5oDTCA4/zXwThKsAqW06+BWv2e/Q/Nn86XqN2MrTz+ZN1o5usDBzmo+Xa3ILx5oRbnn3R48lfLBs3/ZinMCIjCADGshgTAAxuMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038647; c=relaxed/simple;
	bh=1PzvdSmqiv5nImJmLBJnBya6OWd7xbFfZC00CtOaCx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm333Lz/FaZBZOUupwLV4X6MelYOQXfdSvWh97lmLg5bGkS0JnGs2stQCkmiEPFsvD4q3HqrfQ9MWpRAMocxWvJnsh2CteiTOEIYQfbtWrCDkqde1+pjdHGAgYkY1oBqLnTd14WLqesAhYMu5hZLFj/ybCpuJr6bcfVJXNqn9O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L/mab+yh; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/mab+yh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so6639363a12.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 05:24:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770038645; cv=none;
        d=google.com; s=arc-20240605;
        b=WxM4JUPTtkKi6vTNa/k30Ci/pVkw1g/fFcSvWfIcbZqNPacTssui1fN+8tEKubO3mQ
         rsXxYPiynHZpcfa9BaafJdnSS+KXEOzVEbOMJN3wJ2/vjulZMal1u/QcXF7wUB9+vuUn
         LLJNKVWdM/FJe1F3bpINgOI6MDRE2yocShh3UTdnQSP8Uo9s1CwYdmkBv5O3CM56LFxR
         UkKhMxqKuTc+F53BoDSeyHWi/RtG8oLvsTg939v8GP+MlgBbpZqKPtVmEnJmb/F07oQU
         uPzcnsORJ5zBMmQrgVjmL0V7cSaDXc9V/8fl8sIfzIvJ328E6PRdlDJ0CRFBG3mop6Uj
         DBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZtqsNVxYmUM7kVhobNJef7ZiyW1KuqLxzJ4BO5lzl8=;
        fh=WTc9OI/7B2XHxqE109R0IKLGBQ69c+0YjBoiRLaaJ48=;
        b=fHxfmEkk6a8ZUUMnlKdLpKUfuS3Mgb/xUlcALM7oz5l1BGc8Ik4n9bfixhhN+egRG3
         Dlbd7ORaVthS7Y+pzoDRx+2CHryPVWAho53oF+0ReTg/B9eOliXfU4n4MAyXQNkYMNMq
         hfEBEeKZb/FIYVY7AwggDiridvSEfUO8KKgrbPlMC4PpD5ekXpklGLFQH6e6vEI45RhE
         P8uZg7KoNbFEBcRVg+brpIXby9zQK/jPKOrYjpG7Gi5pQEE/A7mrQCK5zubBlX1kWuKG
         sASoO2D29bgM2g+xrAIsQhL8ERttTbVY0wtbvFPt6yBmGV/WM19RtU44ABncu0GKRaub
         ueew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770038645; x=1770643445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZtqsNVxYmUM7kVhobNJef7ZiyW1KuqLxzJ4BO5lzl8=;
        b=L/mab+yhOsYphV9Yl1wOkyaAV/GDDEf5wC/Pt1CsnYwxVEwsJQ1yoXshmPnv0HsWPK
         S09hzMOgZ8z6ASDhywNH8g58QMUYhMa2LH7ZXGYDBIgI1LQTSh4Jrqy2IAIUicqPPuqP
         BocSuW+JFBbHtIBTwgVE1saw1EtRL4a5vOP1AM2iJ2ovMS5yvpMFzUwgKusIvCGCumgf
         ZqCkzJcHH12BsLSWTC0BdnF8KWKA9Y2lKlsYPAFfXS2Hd8Hw6vEAKwZAPxlA2qMe4AmZ
         fk4+G8nr/xO7TpbsnG0xhty/WZ6TkrlBnScWzh72+nxUPcGQN+4kkX7ldzY4b95rzYoj
         BgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770038645; x=1770643445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZtqsNVxYmUM7kVhobNJef7ZiyW1KuqLxzJ4BO5lzl8=;
        b=whFYEqNS5aPGIH2iSqDassD638YrAUjBjv3CjGzKd9kt6XF/89vOWtxmhw43/qIsej
         9K6UT4p4216dr6NHd2kloyt9WBPJT0lvCpATjBtyu5jHJPxdkUmzE0OmpeIQWDEN8wtS
         RU3lt06wxubz0TpMg0mkCY2zsXFoUj2vZd9AxB/4C6j1a3AeIfhit0gpgKyKbPNmHJSf
         WxIqadc+riFrSELY0nNmMSRG71zdSEyc8aP2p8GcbdZaQjQk5C11MODsUMFFuWREaYE6
         zLeoyy03xytQIAzwl1y9aVn7YyR7ObB0WdRNMIVnB45RYdu278mZ8In1yZO4ezGT6Qq4
         /XLA==
X-Forwarded-Encrypted: i=1; AJvYcCV+DCbh5Cw6jZbkDLazmbkS0siTziWTVFcK1C+q4XjgIoD3t4b7E1kqZy/FKC/KgRnXP+SXXwdBDs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy62gvhRpppCpkeyEY4DBRiWhU0cIs8xoAXo5kq3/P/6rI2ZsD2
	3SC6WETZkfqWI71LWjx57Tn6MdezjTAFWT7HVUYy+2jC5dJDJNKiJmjDrMRsfyu+1UyHvbJEHHs
	5dJuzc2NPfYAaVhuoj0t3XrlHCUqG+EGi8jGw/4Md0Q==
X-Gm-Gg: AZuq6aJiV7hO3dw26jp0StbBppJNors2b7E8FDl6tzvmKvYENC/wawW5OOWnbHJd5Fj
	JhLmxZqkSvXKHkN+vSaP1UYkozpAPgMYIMD9hB78N9KCG75P80hRcN+WGelfsiV/QqyJc74/g+q
	iTwyf3gp69T1Cf+3LmG+I9IN4CR6PQw82NEG6sc1zT/EJwzf4WyzWevX9eKBzZ9vIJAjhiev3go
	4idQgMycwYef19ShIa5rczgPmzLTDbVix1TcW2/UCj5HkMovumtsSAcQUycBqOFhCQefiGEaksW
	aEZH+2sjHd083/rEIO7BoXyX
X-Received: by 2002:a17:907:2d28:b0:b87:8172:257 with SMTP id
 a640c23a62f3a-b8dff89af6bmr705882066b.64.1770038644604; Mon, 02 Feb 2026
 05:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202130756.1421488-1-vincent.guittot@linaro.org> <scnf5gh3h5pwvnbe4bwtztdlgcpvvtse4fg64bto2jgyotfpwl@sle4k4ky3gtu>
In-Reply-To: <scnf5gh3h5pwvnbe4bwtztdlgcpvvtse4fg64bto2jgyotfpwl@sle4k4ky3gtu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 2 Feb 2026 14:23:52 +0100
X-Gm-Features: AZwV_QiL5Qef1fZxaIymfSBX4W3u5vzi7FPx445SS4vhFERac0glqVKsoUgJdeE
Message-ID: <CAKfTPtBZCLiq0E-a2QA5X_Bix2PxXiCyuCira1V_wBWZORUS6A@mail.gmail.com>
Subject: Re: [PATCH] PCI: s32g: Fix ports parsing
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: ciprianmarian.costea@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Feb 2026 at 14:18, Manivannan Sadhasivam <mani@kernel.org> wrote:
>
> On Mon, Feb 02, 2026 at 02:07:56PM +0100, Vincent Guittot wrote:
> > No error return is missing after the loop resulting in removing the
> > ports from the list.
> >
> > Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (R=
C)")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-nxp-s32g.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/c=
ontroller/dwc/pcie-nxp-s32g.c
> > index 47745749f75c..767f5a622441 100644
> > --- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > +++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
> > @@ -285,6 +285,8 @@ static int s32g_pcie_parse_ports(struct device *dev=
, struct s32g_pcie *s32g_pp)
> >                       goto err_port;
> >       }
> >
> > +     return 0;
> > +
>
> Hmm. So the initial 'ret =3D -ENOENT' will become redundant and you'll re=
turn
> success even if there are no Root Ports in DT.

good point.

>
> You should do:
>
>         if (!of_get_available_child_count(dev->of_node))
>                 return -ENOENT;

or maybe

+       if (!ret)
+               return 0;

>
> at the start and remove the 'ret' initialization.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
