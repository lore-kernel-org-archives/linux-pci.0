Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B503BADAA
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496975; cv=none; b=M9sQXBaDQsg+1a0bB/i+1n8oj+lsbAtOx+iZbkvLnv0peisW9VkA4l6bIHtps1PzLCobuVsqUuyiTrz2RnyZHJejrH/WliNPa7BfafiOpHHOXrokzYEa6VE3jVkVz3pSaR9fbe4pfEMLuXVsl8ZYa9Cvd9w7XqYZUckxnNPusyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496975; c=relaxed/simple;
	bh=B5rcVpLHsTmSGJPaJtBEOANpM73Tb/5UpXJ/220E+yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMgT+Zt+RCM5amIhNa7DIlnIVCPdR0l4iJqor48nPLwZ8bg0Z3C7iTS7SseyiNuDxjNCsvrNiLYrvFl3BtI6wDR9H0MlP0OnNXuHSMrfPUNs4IGZ1lenDZm2lzl6xRvdLyOYv5PSA7VwsJoDZDQlre7h2mlehujjGpNJS2X7FWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clqm0Ayt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clqm0Ayt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D647EC2BCFB
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 10:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778496974;
	bh=B5rcVpLHsTmSGJPaJtBEOANpM73Tb/5UpXJ/220E+yQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=clqm0AytuzJpd1iKtGlBKHNq3IdXsbIxOYdpXyo0asK9+DLp1sg+MyqNNI/+lQL7K
	 v/MzPGch73FBxQQz+kJU0wvmWuuLydCulESUlOluFn4TPvdzPJSC6Uhhq2OhD38i39
	 cnUiLFaFwisyAqy50RWeiejD+5+zp1KzR3C2DSnvM7TRA858kLpbcFbk0Urr9L36wA
	 ESlsa0VgqQ5gZp8K69FUNNWqrj/R1+FjrbN4o0KANsEn6f7y927bUqWAA703mUneeG
	 dmyzm2dDVxzFZjyDsO6K6tcQsT4RGWKxu8aFeE69e7L0chBBeO32NXMNfIGg7kJQhh
	 NCcj5Afv1Agfg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e8292423fso27786411fa.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 03:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+X42tyhjCvj6DLaHc4cAw6+c8M4cRR2QygOvLWLW4xpmFkJcmT3ZlEnmAMRuHOimECgaQ95NMMkfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2T/4DSIuJ4F4o2DSh+Xbaj1I15iwh79wRBeM+eQVh5sL2PwBn
	23qovgYPDoDCAzDUD0ara8lwdspPmSS5/kmHTcfmnVzB5Jjtjjm6oqfb7x8fd619KAFCWUQS29I
	CcMxpfthyLO05z026CzsiK/QG6gxn0/+yR/GbmUFi6A==
X-Received: by 2002:a2e:bc09:0:b0:393:cb61:17e9 with SMTP id
 38308e7fff4ca-393cb612598mr76212181fa.17.1778496973563; Mon, 11 May 2026
 03:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
In-Reply-To: <20260511-wakeirq_support-v10-0-c10af9c9eb8c@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 11 May 2026 12:56:01 +0200
X-Gmail-Original-Message-ID: <CAMRc=Me7SDOm5Fqr+_m2=5UoOmR24u5+KwabOtMN-BXtMK-kHg@mail.gmail.com>
X-Gm-Features: AVHnY4I4FS4H2jeAaumSTCasprwQaeZndX-NNiRoFaNF_xkiOWzjnDuMdOoXvtU
Message-ID: <CAMRc=Me7SDOm5Fqr+_m2=5UoOmR24u5+KwabOtMN-BXtMK-kHg@mail.gmail.com>
Subject: Re: [PATCH v10 0/2] PCI: Add support for PCIe WAKE# interrupt
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com, sherry.sun@nxp.com, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 9:26=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> PCIe WAKE# interrupt is needed for bringing back PCIe device state from
> D3cold to D0.
>
> This is pending from long time, there was two attempts done previously to
> add WAKE# support[1], [2]. Those series tried to add support for legacy
> interrupts along with WAKE#. Legacy interrupts are already available in
> the latest kernel and we can ignore them. For the wake IRQ the series is
> trying to use interrupts property define in the device tree.
>
> This series is using gpio property instead of interrupts, from
> gpio desc driver will allocate the dedicate IRQ.
>
> Bjorn,
> Can you take this series through PCI branch, once other subsystem
> maintainers give us ACK.
>

Actually, it's pretty early into the cycle, I would prefer to queue
patch 1/2 myself, I'll provide an immutable branch to Bjorn.

Bart
