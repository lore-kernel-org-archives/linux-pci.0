Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E78367F35
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773393944; cv=pass; b=akXF7fx/v5xw86GOEw8ijuv7bTjDZnBheEu8voM3P/Clr2a5QUByY0dPdAlo7mTnumznqrUtUKitOUKlPIkUjpnP1fuEcNHRpSaSVBV+WQYThZSeEe1vHmhXpzpqlGo1BQtre2UExEIHwAVqN6eVqaUpxIHtaF971FQgHuV9FmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773393944; c=relaxed/simple;
	bh=/uB/tPENyS//AaalGzBZqiwLhleo5hjikLnLUq4+/Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnKl5tWoufukiMBUN/3vre/AbzljV9cq2qUmTU00eaBT6/AWBOL/ckXAdGQHOGoX7WxxKsjNoORCVyPfFFf/Xp7h1+R4eAu0JS5A1/W8R+TNEPHCFgNZGdm4FQSfPF92/2ZknQ8+3+vt+Sf36L9+eqkkR7oiy3SsS4gIrccXgOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtNZsOSQ; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtNZsOSQ"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9358bc9c50so255441766b.1
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 02:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773393941; cv=none;
        d=google.com; s=arc-20240605;
        b=fOSWG6OKCslL8uUhm6NOTETRuDXyrNTaHsXBFc0bdLqB+la4N7XS+lgZt5MqDv3p4+
         NXa0UQAZxaOGhDQ3qKNG0cj6ENp7/icza9X1nOF3V+edbe/lQgY2oky0HsfO6DkZmnq0
         gtZewH7R/5l4N8owIbAmhm8VyVie1zR7hHEolPtjiHQr1rSz6CVAE3VoQSlnngedGszC
         xwaDMWD3U0kpsHboOkvyLoMFboYhk1MUOSGjniJdrXTVxSDegL0hrhsXxkIfb2Nn7VDq
         GhekuQu3vXL0LLa08OF6+t6nbI3PG5s7BfZ/ZFvqc+0CWIf9NfQXqnNqNszemHV7wI0w
         MDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=skapIsZV+2WP9UcczRrFkVT7zb1t6DskdiJBKEA1lOE=;
        fh=G+bb6i+x5FEavi/2HzAI17LWGWhhnepU/f/EY0nDSwY=;
        b=KgesdXyIF9f7ku5f3esTmEntChjWJ51E5SsJR7b7Cfe/HVLptKxLJ2JWXNK24k/bcY
         sfOnguRGhn9xVB01z0RlgKAI2wYC40yNgi5yTretAn5Z8SMejfDRMhxs/tGArRdEz8v0
         oUf4lpDQevr0WiKQATLAPZva5/1VH+HkHxv7X1AI1n1wghbTSO7y9e3DlLO5LHyzxdMU
         fC2RHad5wHm2a0RZIhB8ANiZSZbqhMl4vba/2d0EAkzSGxZQJbxedt5BQ1Kivxs7OVPS
         w2ADqIafQQeNnOifCovtHwHrMbwT5W895bvbcgcwCNCFnuUfwJGuH+tIogOAqwB6PF2a
         wjrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773393941; x=1773998741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=skapIsZV+2WP9UcczRrFkVT7zb1t6DskdiJBKEA1lOE=;
        b=RtNZsOSQd/dvP7DMbMpDy5j26WNS3ulslO2vS0reEGtaioF22e9807xNERbN7BmDzo
         BY0W5HNe0+CWMiIU0nvaIs4rIo/HAhBKrLesLtH8beBd98t40dtRfcuwu8/n9G2qeGGc
         HhTcmUihf9BLq9PKyGzFSM2owQ8p4z4LYaaZOVB0acBNOlBq2KRYsVApljuGgT7va/g5
         ygZVQ+WroPI/eoe5x52ffIB77Y3pKPVwEZ7yJO3TYD1NSjoRVfxy7lXFZBeK6NqaBGSC
         /MdALwgJLekQN97FEJm96PMmVTxuVDnpxgwlXqA7LhJLKDNFetb4BVwc9xotGeXRmPF9
         WjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773393941; x=1773998741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skapIsZV+2WP9UcczRrFkVT7zb1t6DskdiJBKEA1lOE=;
        b=baZDuhBEXixRWALKeLwD6C4vYsKQ8P6vEoOym9KcTvhc/gB5S7cAg0PC05VQCPHGSA
         4EV9LpYWfkX0VAygEO18UasHoHM8MII0J9zTWcSx+WJet8y1UFpN87WCLaveuL8Fm3lz
         tKGAwSz6sRZvm/8uZgLD2cO8ayx2tIyFDGKRR5eqklBDEIDWSO3pFn6n8iq9CLAqV9X6
         +npGrBrgMfb3PClsQ4WVuVdnb34c0JcjtJ9vXsQQlr9cXd0nrAlnp/ILPImzQX1b9bv6
         8+NoF9tyTmHlp5VAuMVmDw4+0dRacjF9Rir19BCE2een772sCY6U9fLysEZKdtFs8BDI
         vBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwRu8kHCTCzIK+N7SKcScf854Pr3pRMfGg4tpv7PZS7kqIUlMZ3f3vALdCAmJw15qG6j4eutkCioc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Lkxx7WxW8ffXSn4ijwdhk4w6gOQBB02fZZDq3kb7kG3HvSaS
	Z1fjXyYOdsz7pij0PTU7EsOwdDABUapHWlpypkikEWhwKH6kG+DfMX4QMK6g8ckZQCyxTfztb3N
	wbRQCzUVUmDjUjWi8FwhL/PD+LntxPLk=
X-Gm-Gg: ATEYQzzUSPMIK5axrfl6prjjiElEeKVtYj405wM5g2eHvm9K3W0CsHpT/EMYeMCh94D
	FB/eKwxZrjyX5p25JynLVxv9lbMjzBLfPF3HZrOz10ZoCCbeUOLOFoOzP7iQd7+FwbyIH5sjvqH
	aDHnuKBO0RuIdakG12iZ9f9rAtcdZ98qHkIPsuxXVZ/hTKd0dmt6bq551jYydDQNa2tI/VEQCXR
	OKoHioF40AHuTT24yZ6E8n4t5hEg37lvuZZmkth1pd9adv/ky8hAHI6ePwfkFL/srvDdhkWMmoI
	ut5diQ==
X-Received: by 2002:a17:907:8dcd:b0:b93:81e7:845a with SMTP id
 a640c23a62f3a-b976507ad70mr126077666b.9.1773393940274; Fri, 13 Mar 2026
 02:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226101032.1042-1-linux.amoon@gmail.com> <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com> <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com> <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org> <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org> <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
In-Reply-To: <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 13 Mar 2026 14:55:23 +0530
X-Gm-Features: AaiRm52hlbsJk0-LJBm1qE_mVZnVv4Bhkj1fxNTd0yyF5TYOEj4LUpGTe5M1isE
Message-ID: <CANAwSgTxsDB0t1vj--uvYCCxf4NhnjhBEDLqdevLnGAiuU6_pw@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
To: Robin Murphy <robin.murphy@arm.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Grimmauld <grimmauld@grimmauld.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Thu, 12 Mar 2026 at 18:18, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
> > On Wed Mar 11, 2026 at 1:28 PM CET, Manivannan Sadhasivam wrote:
> >> On Wed, Mar 11, 2026 at 12:46:03PM +0100, Danilo Krummrich wrote:
> >>> On Wed Mar 11, 2026 at 6:24 AM CET, Manivannan Sadhasivam wrote:
> >>>> I have a contrary view here. If just a single driver or lib doesn't handle async
> >>>> probe, it cannot just force other drivers to not take the advantage of async
> >>>> probe. As I said above, enabling async probe easily saves a few hunderd ms or
> >>>> even more if there are more than one Root Port or Root Complex in an SoC.
> >>>
> >>> Then the driver or lib has to be fixed / improved first or the driver core has
> >>> to be enabled to deal with a case where PROBE_FORCE_SYNCHRONOUS is requested
> >>> from an async path, etc.
> >>>
> >>> In any case, applying the patch and breaking things (knowingly?) doesn't seem
> >>> like the correct approach.
> >>>
> >>>> I strongly agree with you here that the underlying issue should be fixed. But
> >>>> the real impact to end users is not this splat, but not having the boot time
> >>>> optimization that this patch brings in. As an end user, one would want their
> >>>> systems to boot quickly and they wouldn't bother much about a harmless warning
> >>>> splat appearing in the dmesg log.
> >>>
> >>> You mean quickly booting into a "harmless" potential deadlock condition the
> >>> warning splat tries to make people aware of? :)
> >>>
> >>
> >> Hmm, I overlooked the built-as-module part where the deadlock could be possible
> >> as indicated by the comment about the WARN_ON_ONCE().
> >>
> >> But what is the path forward here? Do you want the phylib to fix the
> >> request_module() call or fix the driver core instead?
> >
> > Here are a few thoughts.
> >
> > In general, I think the best would be to get rid of the (affected)
> > PROBE_FORCE_SYNCHRONOUS cases.
> >
> > Now, I guess this can be pretty hard for a PCI controller driver, as you can't
> > really predict what ends up being probed from you async context, i.e. it could
> > even be some other bus controller and things could even propagate further.
> >
> > Not sure how big of a deal it is in practice though, there are not a lot of
> > PROBE_FORCE_SYNCHRONOUS drivers (left), but note that specifying neither
> > PROBE_FORCE_SYNCHRONOUS nor PROBE_PREFER_ASYNCHRONOUS currently results in
> > synchronous by default.
> >
> > (Also, quite some other PCI controller drivers do set PROBE_PREFER_ASYNCHRONOUS
> > and apparently got lucky with it.)
> >
> >  From a driver-core perspective I think we're rather limited on what we can do;
> > we are already in async context at this point and can't magically go back to
> > initcall context.
> >
> > So, the only thing I can think of is to kick off work on a workqueue, which in
> > the end would be the same as the deferred probe handling.
>
> Hmm, in fact, isn't the deferred probe mechanism itself actually quite
> appropriate? A suitable calling context isn't the most obvious "resource
> provider" to wait for, but ultimately it's still a case of "we don't
> have everything we need right now, but it's worth trying again soon".
> I may have missed some subtleties, but my instinct is that it could
> perhaps be as simple as something like this (completely untested).
>
> Cheers,
> Robin.
>
> ----->8-----
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index bea8da5f8a3a..3c4a0207ae3f 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -954,6 +954,16 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>         if (data->check_async && async_allowed != data->want_async)
>                 return 0;
>
> +       /*
> +        * Bus drivers may probe asynchronously, but be adding a child device
> +        * whose driver still wants a synchronous probe. In this case, just
> +        * defer it, to be triggered by the parent driver probe succeeding.
> +        */
> +       if (!async_allowed && current_is_async()) {
> +               driver_deferred_probe_add(dev);
> +               return 0;
> +       }
> +
>         /*
>          * Ignore errors returned by ->probe so that the next driver can try
>          * its luck.
>

Thanks, these changes help fix the warning.
Please add my
Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
