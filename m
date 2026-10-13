Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5B4F96D4
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906899; cv=none; b=si4ibjdQVOeirePpla/VGv4d+vZVz/Xn+2IK9bEBxJdniP0S7/SDzBZ1eD4UYnHxpOvsIKJcUcDwCtH849wt76sL2ED1iOC/lw0L7oOnrb3qWr2im50tHIWpjF+/fn8f6SScckOPJTQbMgCi3d3IZml5HmuFmM4PNR7YIo88oBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906899; c=relaxed/simple;
	bh=apkosUvvTJmfvAu0GBn+fkczDrqVVKLgNevjeSsOqzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MvflpGdu3wrjFFD2duhvjSENpC4AA3FOcyJUNkNNNl994WsOExIh8MqSu4ziND/4ab8YlCQIO8ewSX1dj6u+5btJxanozBvdlWMQ6tbpr+AwPG2gfBt+GuwrfMI6nQiqnM4AOlEToSJLTSPD9ubRVPJ0C4ux5Vny/13MHahryTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl2IIWnr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl2IIWnr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622941F0089F
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906898;
	bh=do70+ThMmi8zvW/ofpqhfVynRuoDqqZOM3R5Y/uluW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jl2IIWnr7RuiVxDyN0+HnPytG0CD9XfDtuF26BPkEFDClDnYbD0tJEJccHLu0m2eZ
	 jiBafX5NtImaDzgAN+5HdFt+qde6SOANSdeTc0T4IYyoZPVJB1kTuiJvpyZvFdzztt
	 B7r6FSvvBszIfi5X5HR/HXpt7FAxDW+KnAYsKXgEoDVzkg1qdQj3yzL7ojCUKsKbVH
	 E23KDJfeC8iR17YA3uPQSqLb+sZRtUldBsD8+WUju9VyDQex7LHjZnDEirNTWAUQUZ
	 YCfiWDi5OrZjWVoIIvXlSLfs+txZVoA68Z3UYVsjypo8d5Pdbiljbtv/han8zeeIxr
	 EeKD3JQBP5rWQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso2703419e87.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 08:54:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxne4Ct8FPvUaKVlCmA5jResmpUqpOedOAdMeoZLTDp/ORAQHg4Gs4ftedycAF+1Wwxm4UUYedIa/Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXVw522xiPT1OfZVhGWf7DNS4JJrvtRiPIWbSjI07noNXv6zhq
	nYFGqyBBTr1/DBG76MZ2i6iMizfgkYOCzfy7LD440xutEGtqdnYWTUeNfwvgRXxpYvIxnDGLH1b
	aImR+NPJg4IZ5BZl9/eOaIu+JOG7Lk68=
X-Received: by 2002:a05:6512:110e:b0:5bc:c447:abe with SMTP id
 2adb3069b0e04-5bcde6c9f20mr4979588e87.25.1791906896732; Tue, 13 Oct 2026
 08:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012104645.975190-1-keng-yu.lin@hpe.com> <CAJZ5v0iGhqaF1m-Vc2xdXQXj_BxPFFWCBTP=Ypg_gWQEqWkNfg@mail.gmail.com>
 <642c49e1-7d47-44fd-b597-e5ff0877bb56@amd.com> <20261013060957.1023448-1-keng-yu.lin@hpe.com>
 <CAJZ5v0hndk_ck1hcgWXyGX=OHmbfbhKsrJQsNQF9DQrucRNMDw@mail.gmail.com> <d11aa70c-4753-4a28-9955-990c45649677@amd.com>
In-Reply-To: <d11aa70c-4753-4a28-9955-990c45649677@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 17:52:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com>
X-Gm-Features: AclHuK_WN7_HgPNv_i8_YPJeFY8TXXrOnMcbYGnqQ_3-JHN9aDZX8lKBUj99VLU
Message-ID: <CAJZ5v0h2-S=Yf84LveK=36AkeutJxj5qYzVXnjhAnawi097x0g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/PM: Restore BARs after powering up during enumeration
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keng-Yu Lin <keng-yu.lin@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Matthew Ruffell <matthew.ruffell@canonical.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andy.liang@hpe.com, david.chang@hpe.com, 
	s.collins@hpe.com, jenifer.golmitz@hpe.com, pravallika.kamma@hpe.com, 
	zhen-dong.lai@hpe.com, zachary.pabor-ext@hpe.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:41=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 10/13/26 10:23, Rafael J. Wysocki (Intel) wrote:
> > On Tue, Oct 13, 2026 at 8:10=E2=80=AFAM Keng-Yu Lin <keng-yu.lin@hpe.co=
m> wrote:
> >>
> >> Hi Rafael, Mario,
> >>
> >> The initial read is not needed to fix the reported D3hot-to-D0
> >> failure. I added it to avoid extra BAR writes on devices already
> >> in D0.
> >>
> >> pci_power_up() does update current_state, but need_restore is
> >> calculated before that update. The check includes:
> >>
> >>          dev->current_state >=3D PCI_D3hot
> >>
> >> For an initially unknown device with PMCSR reporting D0 and
> >> No_Soft_Reset clear, this still requests a BAR restore. Reading
> >> the state first avoids that request, although the final
> >> current_state is D0 either way.
> >
> > Fair enough, but if the device is in D0 already, it need not be
> > powered up, so if you make a point to update the power state upfront,
> > you may as well skip the power up if the outcome is D0.
>
> It actually does need to have all the ACPI calls that happen as part of
> the D0 transition though like _REG.

Good point.

This basically means that the upfront power state check belongs to the
logic to determine whether or not to restore the BARs which should be
part of pci_power_up().

So now the question is, if this upfront power state check is done, is
it still useful to read PMCSR after calling
platform_pci_set_power_state() in pci_power_up()?
