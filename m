Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D53364E8F;
	Tue, 24 Feb 2026 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920827; cv=none; b=cKtUkHdsS40QwcM2AWSkBeXezo89SfHzynGAAvGlT5RR2QG7IP4XX8pWnSAXPfynvkrQAYZ2tgX9J99A1sSJN/PH4nGeed5Q4FYT77h4uwfohVzlFvmn0uggiBxdh0KVsMTH1h6Q/yWevutTTJfg2ViPoABG+tNbgpDqHibxkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920827; c=relaxed/simple;
	bh=Gg+RXtOcR0DYpMZ9ChetNvxgvGLU4ili+KJ+Dxx7nFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hb6oESfubT+N3KyA6UWHHGor7pYApP9S+JTJEz/Ih3LqLXu3MIXzzUpeTjRZBZ0SoD4lEdzRtdefGNO74j1nyAbzYObno4eJRYGI344mVTIOzrXAqjmZIMkf86F5Avs1jyzUJkRga5OPUfZi3V00pHg7BIyqKP84FN+vXuerW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvoQ/gME; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvoQ/gME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD28C116D0;
	Tue, 24 Feb 2026 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771920826;
	bh=Gg+RXtOcR0DYpMZ9ChetNvxgvGLU4ili+KJ+Dxx7nFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvoQ/gMEOxCf62Y3lZL83ldy7+xKDPw5aHxGgacDwD6aJw6gW+lCeh6nTO7zHmHy9
	 AF3ECTYr/LY6cHr1sb0SUo6kv9LSU87qFVl+qUCXBMuewv6WLJ48ylunfHG4h1hkXl
	 iOQIXU3aJmQP2mKC+2Nich1uN67XjGuoFEexJKaO0C7l3VA55uPK7LxzsesEH1Mh+r
	 BBUquYsybNh2/ApPz4MFmY9iA1D/09AsaQUxZW9s0KKW0HnljWbmJP7aEbuFb4wkTt
	 rjRCDB8omTb91xEKRpv7pEU+8rsP0ptqcWsW2ga4YNiv31IWZvVWRXmHz1nY4RvMDy
	 CV9Cpibrr/sMQ==
Received: by wens.tw (Postfix, from userid 1000)
	id C59095FAAF; Tue, 24 Feb 2026 16:13:43 +0800 (CST)
Date: Tue, 24 Feb 2026 16:13:43 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linusw@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, sherry.sun@nxp.com,
	driver-core@lists.linux.dev
Subject: Re: [PATCH v7 0/3] PCI: Add support for PCIe WAKE# interrupt
Message-ID: <aZ1dt626iivieo5r@wens.tw>
References: <20260218-wakeirq_support-v7-0-0d4689830207@oss.qualcomm.com>
 <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdF92kriuT_-Fbk3pj6YeJiNv6RSiDE7aB0AKL9oFZg5w@mail.gmail.com>

On Wed, Feb 18, 2026 at 11:01:23AM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 18, 2026 at 9:12 AM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
> >
> > PCIe WAKE# interrupt is needed for bringing back PCIe device state from
> > D3cold to D0.
> >
> > This is pending from long time, there was two attempts done previously to
> > add WAKE# support[1], [2]. Those series tried to add support for legacy
> > interrupts along with WAKE#. Legacy interrupts are already available in
> > the latest kernel and we can ignore them. For the wake IRQ the series is
> > trying to use interrupts property define in the device tree.
> >
> > This series is using gpio property instead of interrupts, from
> > gpio desc driver will allocate the dedicate IRQ.
> >
> > WAKE# is added in dts schema and merged based on this patch.
> > https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/
> >
> > [1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
> > [2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/
> >
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> 
> This spans three subsystems, how do you want to get it upstream?

FWIW, I'm interested in using fwnode_gpiod_get() in the net subsystem
for the same reasons as the author. I could just use
fwnode_gpiod_get_index() and convert later though.


ChenYu


> Bartosz
