Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3392366810;
	Wed, 11 Mar 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773189801; cv=none; b=hi5HLlHE10AKYw/e5BKBtK0UBcbtz5yHSjM5dcljF8nuw6twfUwHXdLWL9Wp6p5DaYIswMca68g/i6qfopj0uLcORXjwMr4jRzyKubUHuRP/3bDVBKffcFd5MUVkK21LzhX5HBBoTlyW2okAOmE0/609hfDxFmF9arR5rITqVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773189801; c=relaxed/simple;
	bh=kH/Ie2aFI4K/lDnNQHmGKjIFS9FcKLj4P5iq92/ff4A=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lZX6llBpYP136wYCylVQYSbpJnPA8cE1t6Y0x2rfBvJATHixv83FUNjzLTfY1W8WC89GEuRyP9Y4wQbukRJode0H7nvtn1HuBPF0fJ39JgeQtDluxqBV8hfa6fOkF3y0cHAhY0P9qtcGb4pO89huxCeNth7E0ghesECaGlnbY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehjrxnRq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehjrxnRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFE8C19423;
	Wed, 11 Mar 2026 00:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773189801;
	bh=kH/Ie2aFI4K/lDnNQHmGKjIFS9FcKLj4P5iq92/ff4A=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ehjrxnRqe+S2eARDKmHB+T6s70Jt3cX86F+fjg7UoP9KeQpNc++YTPXyAwhtwIrtC
	 q+wwSkK/QiCZrhT3t4VHk0J2WoSlGLUkkGpwlzyZ6jokMDIQm0yfYlsUivEzvT3bMF
	 JgSpQf96bxTLa4D7k5pAKV6KtS++9ko/Db84UTLpbbpHn6dpFhfco15NtaOrsZdhsT
	 vp4VUUPWaEOXi+DT0ZGVDQh52RxlDZ08G2lq7Z3+Xt5hsbx4Li0T+2Y4YDJ+32VMgZ
	 DpWgLqCJ4KlHX1acNrBvV8OHzGz5t/OeAK2QzFST19HKtDhzq6VS1/mBLlA4Lu1IqI
	 VCQ0H/t/tXKqg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 01:43:15 +0100
Message-Id: <DGZJBMG2Y738.2MU5LXVGEDD47@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Cc: "Manivannan Sadhasivam" <mani@kernel.org>, "Manivannan Sadhasivam"
 <manivannan.sadhasivam@oss.qualcomm.com>, "Lorenzo Pieralisi"
 <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Rob Herring" <robh@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Heiko Stuebner" <heiko@sntech.de>, "Niklas Cassel"
 <cassel@kernel.org>, "Shawn Lin" <shawn.lin@rock-chips.com>, "Hans Zhang"
 <18255117159@163.com>, "Nicolas Frattaroli"
 <nicolas.frattaroli@collabora.com>, "Wilfred Mallawa"
 <wilfred.mallawa@wdc.com>, <linux-pci@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 "Anand Moon" <linux.amoon@gmail.com>, "Grimmauld" <grimmauld@grimmauld.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>, "Lukas Wunner"
 <lukas@wunner.de>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Robin Murphy" <robin.murphy@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260226101032.1042-1-linux.amoon@gmail.com>
 <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
In-Reply-To: <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>

(Cc: Dmitry)

On Tue Mar 10, 2026 at 10:03 PM CET, Robin Murphy wrote:
> [ +driver-core maintainers - async probe question below ]

<snip>

> I'm guessing it maybe wasn't anticipated to have bus drivers calling
> device_initial_probe() from within async in the first place?

I think this is not limited to device_initial_probe(), device_attach() or e=
ven
device_add() would have the same problem. I.e. the driver core simply does =
not
consider whether it is already running in an async handler when it is reque=
sted
to run probe() synchronously.

A simple workaround to this would be to check whether current_is_async() an=
d in
case it returns true just defer probing in an PROBE_FORCE_SYNCHRONOUS case.=
 This
would at least be compatible with the guarantees given by
PROBE_FORCE_SYNCHRONOUS, but it doesn't sound quite right to me -- guess I =
have
to think about it a bit more.

In any case, given that this is not a supported case, this commit seems to =
be
wrong and should probably be reverted.

I think a quick workaround in the driver core as mentioned above is not a g=
ood
idea, instead this should be properly thought through.

> It may not strictly be the fault of this patch - clearly 91703041697c=20
> ("PCI: Allow built-in drivers to use async initial probing") is=20
> implicated in this too - but the fact is that it *has* exposed a bug=20
> that needs fixing one way or another, it can't just be left hanging and=
=20
> impacting end users.

At a side note, I think device_initial_probe() was not meant to be exposed
outside of the driver core in the first place. As the name suggests it is o=
nly
meant to be called on the initial probe() path (i.e. the initial probe() pa=
th of
the driver core). It seems to me that it ended up in include/linux/device.h
instead of drivers/base/base.h by accident.

The original commit - commit 765230b5f084 ("driver-core: add asynchronous
probing support for drivers") - introducing the feature even mentions "manu=
al
binding is still synchronous" in its commit message and I think this has ne=
ver
been changed.

So, it seems commit 91703041697c ("PCI: Allow built-in drivers to use async
initial probing") relies on something that might work by accident. :)

So, I wouldn't rule out any unexpected side effects entirely.
