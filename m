Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0F494835;
	Fri, 18 Sep 2026 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727571; cv=none; b=lJo8Y7P2I9QwxfZsZKb+qp35i2MWmUqBkgHH7Rns8tLUwpmLNRUfzJS0rdbuLGnzH1BFNMg+Yjg5gIdG9KUZaCjCVfV1/wEZzS/uDTrIPM/FKwZuIue7kyWoyXdgFRQkHIds80bNkHlQGnmPUyrHu6ixkg4TlBtfgiOm7ql7ejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727571; c=relaxed/simple;
	bh=3r/G3nZbxIlAf90geD9CVrqAzd5pqcJmEMRNdzeR1SM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AhjQebU5RwhW8AFa0SKTA5HECj0lprQnJ5q3waxdUb0FrVy3ExvEOOPYo7j33Zms/yw5r/+CDAvOaGA1azEzQ7VZRBJqJNvrrocL1Z5sECPP57ZKLQ+2qdKsnoaSHnu9TKkjyZeR8ff0OGqsCI3lHSkRwBm9dAlHHOSY513iBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dFvURW/J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyBzL8Hm; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dFvURW/J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyBzL8Hm"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBA507A00F2;
	Fri, 18 Sep 2026 06:32:45 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 18 Sep 2026 06:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789727565;
	 x=1789813965; bh=cJlPJ6KrwzaPtZRHGm72iMAfPMKAwd2u1wBguAbnglk=; b=
	dFvURW/J1SQZAu0mUwTYAC8lxjZsdsK3kzB8b4zNOBTxRBKp9yCLCsbJMNSfwLjc
	QXsV5DtzA4gAVpQWRegAHW2JOoNVnloVGZ7wFX0pm5RWgVEAkX9xlLBPjgTSzMWN
	f4JWZ8XfWFZXqNdJBun3Y3mF6disUH0g7A86htzKdWhZLXvemCnwX36w7lbvFvD4
	IqaGq1n2HLz6nbEaDtDgXhF1hGkIKSLyQEGBQPTYS6UPTKfVFg4AoS8GNu/2XgVA
	ZsZ2u8dPnklpIitb5FlisouG2Rift1/SpoPyXuukCx1xj7SstAX7b68l4PVGmcP6
	Ocz99nNdHnJkPlay3JB+3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789727565; x=
	1789813965; bh=cJlPJ6KrwzaPtZRHGm72iMAfPMKAwd2u1wBguAbnglk=; b=T
	yBzL8HmNLcB4gacab2fwsDqevHG41Eea7u0dsn+T7Deg5s/eIUODwGy1FTXT3pji
	X1EStDHwMjbFdtEwBbhGc/KI+WkL10QK59PDR0dGtkdlkpgMD3o3aUdFT13GnZFw
	oeAJDFkpexXOuvnP9DiNVLhD7+4hH6lyLVvSGBwMo+gY2CVYFdAd4aH6uKCOJD+O
	kSP3NPNqwRfYphnWwjxDxWvY7MLZLy59QuI/psVZrWppX1dxesJJ0yDm2/GmTKY8
	fUSgFYl/LGSkM59xeI5ZSWv0WEGGt2Wrhzk7m4/OhUSJ0mTbpo81KC7XH8gDfuxb
	LhTK1p55s/dRb8LwJsKJw==
X-ME-Sender: <xms:SBOtamZCGAGaaQSZa4Lu85u4Gc0johHUqPtR1QTS66s2s_KT0aOgJQ>
    <xme:SBOtakO9kshPefeRgkgOllQ3PmFYrPb4Bz4UQPFyTlHFEy-GfT5b8nhKh-asIOtC9
    xrxkMwPDvpnCBClWo_qwBICS0jwoVAoO9z0So-j6LtOTtvd2PxuVlg7IA>
X-ME-Proxy-Cause: dmFkZTF5VEATVaMYyKFJSRUSQdUBNm2t11Xfp3YCiJoB0OBrOzg5c/hUGdi4k2O0WTLDO/
    mZZQH7joCc/ok/6bLRnUiKydUYRV0MrUpZS317vfpcDk99C5OW8krUIfr5LYaC7moreYJi
    pqL8zXo3BeiZXDJIWaor8FXuShpbw7Z//hwAuoYM3IYkQ99NJ+7Nludjrsns5Iajr5mH4s
    GlZGPytp6Xx54QBDrRThFQ/SpnIcX6JvukKQdEVhOaxlvsHD4ePmPTYDyLvsB/6cwD8Csz
    BvM5xrqdztQPBwpVx2IHKkedVbDvJGaJQQsfLeX7yPlXJdjBCNRDOj0MuOK1sLZshUdUnn
    l82RJz14zbSswblwf/TrHlD/eCT0JjwIleMqrx4Z6/oD8HlnpePPBDT2i1PCUrW+/mtGGS
    m5rj12PzD1tIcEKdTZiwoS3yFocHPXClCxfmtN4kFZQC1+uJllgvPLrq0ZU5ESwuPbfROl
    2YeqGL+IPXem+coSi8F05UaAqbM8wJaN6xcOGxS/8z8weVxRCMKg1fWa30yojLJWP1xBxW
    /HDTt+VwKuBjEdCXWgdQpCNj4Mv4S8S/Ji9r+qSHBN6EVXR4yfwKRFpvNKOfUMb6zOPH3D
    Um/j//xJdvXm4zJhztkAWQbyfGlTt8/BuINPQiBHqe9+hJHgCLCFYC5DDu/w
X-ME-Proxy: <xmx:ShOtau-h_mrJALDN1uhg9S1I4pAiddHedX0NHYvJJt9oyC2V0l3JIA>
    <xmx:ShOtandIZHuVs4AveSr8Ge1jJupVLYcC8esReVwlOwZ3qTH-oW9ZSg>
    <xmx:ShOtaivkIO2fX4T9cVotsuhFI97_rlcjL7Wkc2FO_jTZPhAzZuac9g>
    <xmx:ShOtao1fvoehWFnWlhotg4RTUf-GT2-RE4PqHNAvvmdgngvn-ibG4w>
    <xmx:TROtavBfFsvnDRdY0B5AyM6DmDmFa3PRTYdunkjNnAeDvXaEKcbH0SzL>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0F91B32A0085; Fri, 18 Sep 2026 06:32:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1v-knPnKEnN
Date: Fri, 18 Sep 2026 12:32:12 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Semih Baskan" <strst.gs@gmail.com>
Cc: "Bjorn Helgaas" <helgaas@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 bhelgaas@google.com, "Ray Jui" <rjui@broadcom.com>,
 "Scott Branden" <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
 =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, "Rosen Penev" <rosenp@gmail.com>,
 rani.hod@gmail.com
Message-Id: <dc370463-125e-48d2-af6b-c3b4783f57ea@app.fastmail.com>
In-Reply-To: 
 <CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com>
References: <20260917183602.GA1036092@bhelgaas>
 <7c2a8582-280e-471a-b4b0-037b2cda6ad8@app.fastmail.com>
 <CAAsRjRnV-RTddO6h2XCUz2N5pB0pS8i_-_2XRcD=WOTA7AAFZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2026, at 10:29, Semih Baskan wrote:
> On Thu, Sep 17, 2026 at 10:27:54PM +0200, Arnd Bergmann wrote:
>> Would it be help to change the probe order so the bcma driver
>> always comes before the platform driver?
>
> Only where the DT window matches the EROM one, because that is where
> the platform driver backs out.

I'm probably missing one of the steps here, sorry I'm not too
familiar with the platform.

If the DT window doesn't match, how does the bcma driver find
the device node that corresponds to the EROM entry to populate
the child nodes?

> With of_platform_default_populate() moved after
> bcma_register_devices() as a test, it boots. pcie-iproc-bcma takes the
> first controller and enumerates the BCM4360 as before. The platform
> driver then probes the same node and fails in
> devm_pci_alloc_host_bridge(), which it reports as -ENOMEM:
>
>   iproc-pcie 18012000.pcie: resource collision: [mem
> 0x08000000-0x0fffffff] conflicts with PCIe MEM space [mem
> 0x08000000-0x0fffffff]

The driver should probably check earlier if the device is
already bound to the bcma bus, rather than just trying to
request the bus windows. If anything, I would have expected
the conflict on the 18012000 address for the register
base.

I see an ioremap() of bdev->addr in drivers/bcma/scan.c but
don't see a corresponding request_resource() for it, so maybe
an easy fix is to add this to the bcma bus scan and
make sure that always happens before the pci driver probe?
That way, the platform driver would just not be able to
probe on a bcma based SoC regardless of the memory window
settings.

> On the second and third controllers the DT window is
> 0x20000000/0x28000000 and the EROM one 0x40000000/0x48000000, so the
> platform driver's request goes through and its probe carries on with
> the DT window until the link check, which fails because nothing is
> connected to those two on this board. That is as far as this board can
> show.

A few more questions, for my understanding:

If a board has nothing connected to one of the host bridges,
why is the pcie host bridge still marked as status="ok"?
Do you need a driver to put it into low-power mode, or
should this just be marked as disabled?

Does the platform driver reprogram the windows to match the DT
description, or does it rely on the boot loader to ensure they
ranges/dma-ranges properties match the register contents?

When using the bcma driver, does that update the ranges properties
in memory to match the EROM contents?

      Arnd
