Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46FF35C1AC
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524456; cv=none; b=PTkfjUeOlH9Zg4dZyIuLmBIpOC/5bfQLjlZys6qEXTsvdq2duS0zcl8GYbzhiYxd+xBTinx9W3h8KB8v9jdtaDee9ykoVABXbxoqJ7af5hv0lGTNtSNN9lZirVKEbEyknZTzSmYFVKRX4QWIkGEV8dMvAM/ILoX9CrzpHX9DPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524456; c=relaxed/simple;
	bh=nLP5WPSJ4MT6lYx0a9IOsqeVgLkh+TkHWnXIWRvaeXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL5MzeJkT5tNw1KSfkSHx6oTG6Y1/s6Vidv4V2drzh+aiUnAaVwsChGMXFd9wBsGbFsRbIJMU7Kc9BeBfBqShWaqzs+UL6F17C/HFWhYcbo9Oyw8Gr8lO0zBQSsS95NBvmZGJXkTj5eo2awSSt6b7+ggLsL254dRCj5lCW56bUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFQ8eKyp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFQ8eKyp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7C9C2BCB4
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769524456;
	bh=nLP5WPSJ4MT6lYx0a9IOsqeVgLkh+TkHWnXIWRvaeXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cFQ8eKypCxJneIg4jM9c7+W0y87mV9/GiLxNnhaswgztLBP78Vz/06/PbHJdEzzEY
	 aHF4Z9GTm3cTSjU/wQbAeKE6rQWSexI5MfvM78RJ0ot1doS6Db9RBwS/xxGuGpOBju
	 yPeL8c4QTVuKxU7VsBz1cmo3NX9+1zle0SN969vtt/Gb0zid/QrFxhBwb6B4Dsq4du
	 ME69Q+CuXcxq+PHoKzNBiNW3uGRf9wF7mgTbK+bGWKPyhCPeGj5dPDSMuHQI0Z+Jl0
	 0UZinsUPOrdT+E8ETs5KgZZaXT7POvxYtjjLi3QYSPO81xkQ3YJBcENqVtpM9UGJwf
	 Y7nzhsgWCmJAg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-662f485e58aso107239eaf.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 06:34:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMPlrgRMexJuEK9DzD1hDeDM3QxHl4r/D7KPxAzlwGhIufMbIjdZtrfX+KYiUgfmfk7dPeS+IVG5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cGbrRwsoOBE20pLfYqozbMdvgPoSDDeomCPmWvpeYETyTVYP
	PptFE0IuNtYM3G5PEznpmUoTdyGgmEzzhur2669tz4vPjrjmhjcg/MnMDsKmB9bA6m95fhu++WQ
	UUJCx1nxDlMSUyQmV1qczrMj02ehpgn4=
X-Received: by 2002:a05:6820:498c:b0:65f:564f:34b1 with SMTP id
 006d021491bc7-662f2021f39mr972139eaf.16.1769524455545; Tue, 27 Jan 2026
 06:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi> <87sec30yhk.ffs@tglx> <aW3pALPxn4i9fiDO@lpieralisi>
 <87pl751zeh.ffs@tglx> <aW9V4A7lTGZWTO9e@lpieralisi> <aXM0dVthp33yUqj8@lpieralisi>
 <CAJZ5v0hOVO7N77nnyWsh_vhGcm-TzavrGBgci=a+o_-LKhkuXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hOVO7N77nnyWsh_vhGcm-TzavrGBgci=a+o_-LKhkuXg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 15:34:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jotTEm87Ks70_EHUs68T_3fPvG04GAxoC3gueiS-askw@mail.gmail.com>
X-Gm-Features: AZwV_QgMPgceilNqa1ohd2X40nvwnD9QGS8uSFdUczKAi0SenvBlTvAaDiWKd9M
Message-ID: <CAJZ5v0jotTEm87Ks70_EHUs68T_3fPvG04GAxoC3gueiS-askw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Len Brown <lenb@kernel.org>, 
	Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 9:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> Hi Lorenzo,
>
> On Fri, Jan 23, 2026 at 9:42=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@ker=
nel.org> wrote:
> >
> > On Tue, Jan 20, 2026 at 11:16:00AM +0100, Lorenzo Pieralisi wrote:
> > > On Mon, Jan 19, 2026 at 02:54:14PM +0100, Thomas Gleixner wrote:
> > > > On Mon, Jan 19 2026 at 09:19, Lorenzo Pieralisi wrote:
> > > > > On Sun, Jan 18, 2026 at 03:47:03PM +0100, Thomas Gleixner wrote:
> > > > > I think the simplest way to sort this out is for this series to g=
o via
> > > > > the ACPI tree if that's OK for Thomas, given that the ACPICA code=
 will
> > > > > go via the ACPI tree anyway and there are other dependencies on i=
t there
> > > > > I assume (this series is fairly self-contained).
> > > >
> > > > I'm fine with that
> > > >
> > > > Acked-by: Thomas Gleixner <tglx@kernel.org>
> > >
> > > Thank you Thomas, Rafael I hope that works for you too, please let me=
 know
> > > if there is anything I can/should do.
> >
> > Hi Rafael,
> >
> > forgive me for another ping, can you please let me know whether you can=
 pull
> > this series on top of acpica changes for v7.0 or it needs to take a dif=
ferent
> > route ?
>
> Sure, I can queue it up.

Applied as 6.20/7.0 material now, thanks!
