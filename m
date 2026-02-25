Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C28638E5CF
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012267; cv=none; b=gmuVzkymx3bbElWDRLn34pA/zFouHc+90+Y8qgoXyOmBFIE6iVRlsNrFK9s1rv3Qe5Xwhzrk7TIPnunVvb4OXMbV7oakrCeMIFAgy8msHayHrdE7M1b9NvOnA65j5axTwq3vcIaeeCx9K0dJGIkG1oElmw0AxrsoEPlbpmJQkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012267; c=relaxed/simple;
	bh=vxNxps+OuZ2xANrOCzteDxtEt2BxFwhyI1Ya+QPBeRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j86EZ8s9Un6dIZKOgjDtnHJvN+MOlFTQJOj3xvxKpq2dE8+JuLqs+Tl7lbwko66DqYeQIS8cnw+c1IJBElW1o8tkvV7xgx5Md8SJovhEtIqswtTaQ5y+wFDR2Dw2/dohrJLJwVDkNfzCjEm/eoWFrCZ0ewBpD51uYmh9HyBsbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chhl3YH9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chhl3YH9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F30C2BCB0
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 09:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772012266;
	bh=vxNxps+OuZ2xANrOCzteDxtEt2BxFwhyI1Ya+QPBeRo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Chhl3YH9kOiN/ftbHTBwHqPLakN+mnq3Wz8u/Ew7YxHGj+Rk1ZIWR2K89ecE8iAUP
	 K5Z9l2eymGUDOsoBt5T2/q/AJBWXINcjtLCSlgWwoS5TjGxU1Ufbd1D1ht0efSX6mT
	 LAAoRmLRjjte/GNPaUq1jJS1telxI+uZd2c6Y00MwjFBJTAL/UXWflBYdVrg49LpCK
	 07p+ZmNBwwuHjYnZiOdKL5FHketp0aA0aMNWvD6FnXz9flIHK0Of4t10/rniRRl1gY
	 w4DTkhtcZ05G55SFy/LP4rU3BQbvOBLayIkFTw3Xi5dcaG2450y8R4p55t83Sjc0vW
	 JUMOeoTa/BTNQ==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385d9fb297dso66482981fa.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 01:37:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfZbdXmAPaaNQi9xo6totC9tBaBUgtwAXsd1QvYnB1NTAVDBBYl5D1Janfk0EHVBP3P372mkBMVF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2ACVkghvqy3ixj81hcEzkffSY+we5yBg7k39Y8HIfDME7lX0
	hZ28t1LmX+tlAjWelwWd8Fl9agJxysmYdHub+saNy7TuAOURGwxGdNvQL1uzjzdlBLV6xpFJrRb
	ZdOgDJytKsqNR+EP5V4DRJpO1IWzXpG8=
X-Received: by 2002:a05:651c:2104:b0:37f:c5ca:a6d4 with SMTP id
 38308e7fff4ca-389a5c9276fmr48586841fa.6.1772012265107; Wed, 25 Feb 2026
 01:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225072225.3345307-1-wenst@chromium.org> <20260225072225.3345307-6-wenst@chromium.org>
 <CAMRc=MehRxdoip8++NfwU_WEJ+yYuC1=2BRv8Ry9VytU=YvR=Q@mail.gmail.com>
In-Reply-To: <CAMRc=MehRxdoip8++NfwU_WEJ+yYuC1=2BRv8Ry9VytU=YvR=Q@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 25 Feb 2026 17:37:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67MwbOA3oQp4NCDEzzsLP6-zzTTyXi_uENJVDbJi6RpCA@mail.gmail.com>
X-Gm-Features: AaiRm50YXFDVbK-wg2pjz5zqS_wWe0Q4kSUl0929RdQ8XNtoQPy9JMLS28sbKio
Message-ID: <CAGb2v67MwbOA3oQp4NCDEzzsLP6-zzTTyXi_uENJVDbJi6RpCA@mail.gmail.com>
Subject: Re: [PATCH 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 5:30=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Wed, 25 Feb 2026 08:22:22 +0100, Chen-Yu Tsai <wenst@chromium.org> sai=
d:
> > With the new PCI pwrctrl API and PCI slot binding and power drivers, we
> > now have a way to describe and power up WiFi/BT adapters connected
> > through a PCIe or M.2 slot, or exploded onto the mainboard itself.
> >
> > Integrate the PCI pwrctrl API into the PCIe driver, so that power is
> > properly enabled before PCIe link training is done, allowing the
> > card to successfully be detected.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
>
> Thanks, looks small and sweet.

Thanks! I originally had one large patch that was kind of ugly. I managed
to dissect it into this series.

> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
