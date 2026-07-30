Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12A435510;
	Thu, 30 Jul 2026 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418005; cv=none; b=Ah6cT3obizn7dlPyehD/fZTfCjjEcvUKHN5zw7Yi0P+5ZaMvaufMz5yOL4FXsI/Il2S6j5wCcC+v0mdLPRiAW2/tYcdELKyVCyjKKcDeoGnNOtHyOrG8/YOYm6oMzp9DwkRWGBGU5E7ZDlC1nmfsJACvNHekSSGOnKieZ3Se8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418005; c=relaxed/simple;
	bh=WhsfbxJNUJU+JpKff+AqhCVUkHGabT0rlsK7PyT+nMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryqQJn8t1G+b+5yK5dNVnRVuU1ZwYln+kNMvxpamZ5PxcgVZOj3U5AEQYpUT1/2lL8cMeDgEG2cAQdAZwktcgFx2EkpjZv4Dg1/HUzZIKKneNrQNNocqArnca/ibtBFTJgM1jmSAAAysZCM6ASzoZD/JXgaWGXOT6IvWekGL5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=C73xepXR; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MhZtO5xh; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="C73xepXR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MhZtO5xh"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h9qjQ6JxJzKw1t;
	Thu, 30 Jul 2026 15:26:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785417994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhsfbxJNUJU+JpKff+AqhCVUkHGabT0rlsK7PyT+nMs=;
	b=C73xepXRanIMcUY4yirDcK80BGvMW251Gf8gqtK8+l9hUiYXJa3+B6t7e140qAd1fm2iSE
	MpfgSkxUFSU0MeapYTPYWipNYRzBYJ8le52U3k+lhTEtQlKJgymdrC1Dc0YHvT2FoCHp1n
	gdks611XqeMZtV8O1wHvygRYSpFS9LvEq8zi9NW+c22vTp3WbH1JmsCvVsGf3Kz49FVSzc
	FiPB289W5lOsgexaIxxRxPMvwQYZ4PGxipC7OjqyOAnw/35VXsm2eGxy5vuKXRGe0azlFk
	hVAW9ZU4OelEjmx/ockYIfg9jH16JHr/rEBWRflSrtCfWpTVEFMTzVOZI01LUg==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=MhZtO5xh;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785417992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhsfbxJNUJU+JpKff+AqhCVUkHGabT0rlsK7PyT+nMs=;
	b=MhZtO5xhpjbC5YGyWpmkivFgwZGOsD4dwvYxjirMwm8A8EgBcy06dZSYesM+G4H6Cinsta
	9q23IJB6Lu/AJsiM7PRI4EcWGT+ih2DgK10gbZ2HYN+aIbEnHa3yb6ZEk1QVUaMvnk5Fme
	tY8oWQPXl54sLRBmblyxmmq8JmWX9FDssFaR1MPwfhsQ6jkiFqFC8XleHXMxYrdYFZShWt
	zmbNURbB7A73I55IdPUyW3yeceKLJrK4UjqBSirLnPlEGwy/ijg755cd32j+poizapFPEA
	qkj/YHLp912YZeAFWt2oWxmlidbUyZRNELfKKsvSwcB7KEh2SpUB6FkECHckig==
To: Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Maurice Hieronymus <mhi@mailbox.org>,
	Lukas Wunner <lukas@wunner.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	=?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Beata Michalska <beata.michalska@arm.com>,
	nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: pci: rework device enabling API
Date: Thu, 30 Jul 2026 15:25:58 +0200
Message-ID: <20260730132559.65566-1-mhi@mailbox.org>
In-Reply-To: <DJVUHS5VHP4Z.G2FV1QJQ8ZYH@mailbox.org>
References: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org> <DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org> <DJQXXV5KC973.1XAINGJFCKSWE@mailbox.org> <DJVUHS5VHP4Z.G2FV1QJQ8ZYH@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c8c216fc37f6dd43612
X-MBO-RS-META: jya1fohjaisgaipdd6cdz453njrmkyrz
X-Rspamd-Queue-Id: 4h9qjQ6JxJzKw1t

On Sat Jul 11, 2026 at 5:25 PM CEST, Maurice Hieronymus wrote:
> I went ahead and sent a series implementing the second option, a
> public flags bitmap with generated accessors following the driver
> core precedent, converting is_busmaster and broken_parity_status:
>
> https://lore.kernel.org/r/20260711-pci-dev-flags-v1-0-2fcf2811138c@mailbox.org

A status update on that, and two questions.

v2 [1] moved the bit into `priv_flags` instead, as Lukas preferred. He
then asked me to convert xen-pciback's two direct `dev->is_busmaster = 0`
assignments to `pci_clear_master()`, so that nothing outside drivers/pci
writes the flag [2].

That conversion is not behavior-preserving: the assignments clear the
software flag only, while `pci_clear_master()` also clears
PCI_COMMAND_MASTER in config space. Commit 7681f31ec9cd ("xen/pciback:
Don't disable PCI_COMMAND on PCI device reset.") deliberately removed a
PCI_COMMAND write from directly above the first assignment, so putting
one back at that spot looked wrong to me.

I said so in that thread on Jul 18 [3], and asked the xen maintainers
directly in a separate mail on Jul 23 [4]. Neither has had a reply, so
the C-side prerequisite has not moved since.

On proceeding on the Rust side in the meantime:

I would like to keep the enable/disable rework in the EDU series rather
than drop it. `enable_device_mem()` has no disable counterpart, so the
enable count is never dropped on unbind, and the sample does not come
back up after rmmod + modprobe.

The races the guard would expose are not introduced by this series.
`is_busmaster` shares one bitfield word in `struct pci_dev` with a
number of other flags, and those are written from unrelated contexts, so
several of them can be updated concurrently with it.
`broken_parity_status` is only the clearest example:
`broken_parity_status_store()` (drivers/pci/pci-sysfs.c) writes it from
sysfs without taking any lock at all, so userspace can already race an
`is_busmaster` update today.

So my first question: would you take the `DeviceEnableGuard` design
while that word is still a C bitfield, given that it can already be
raced from userspace today, and let the EDU sample land on top of it,
replacing `rust_driver_pci` as you asked? Or do you want the bitops
conversion merged first, in which case the series stays blocked on
linux-pci.

My second question is a behavioural one, since I do not have much
experience here: what is the accepted way forward when a list does not
respond? I do not want to resend the same question every week and turn
into noise, but I also do not want to guess at xen-pciback semantics and
break someone's setup.

[1] https://lore.kernel.org/linux-pci/20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org/
[2] https://lore.kernel.org/linux-pci/alcSjoypegNolW48@wunner.de/
[3] https://lore.kernel.org/linux-pci/DK1UXXRGW737.2IVTYCHPRM9ET@mailbox.org/
[4] https://lore.kernel.org/linux-pci/20260723161638.9838-1-mhi@mailbox.org/

Best,

Maurice
