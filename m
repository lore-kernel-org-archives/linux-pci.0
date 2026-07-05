Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA4B372B2F;
	Sun,  5 Jul 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783285480; cv=none; b=bjyP9QSTq44j9W4BoLJiNn+HO9shPM4u1cxkUfbk/6iOI//70tAJ3AnM993IdPZ65WPThcrEcdoSP3sdTtcGq4BLbCgGcnakuXC+b+OEDMRATOyo8HO/jrHNeF0RHEahdHtnjaAKD7nCYOKmpN1sWjk3Z/yyhSequ/Kkz8QHu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783285480; c=relaxed/simple;
	bh=M50I3n3w3B3Qw2Xt+aE8IvOIHTSsmNyn7SZOcezmrkY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dqUfpNqJDfgNhxPk84Of+OR0wlMSg09SEjJBy+Oxyqh56tzIkbqbb2DTT9IfKiEa6HJXIAx1AGerxnZxoNpOG7CpaQccyhQgxYF2TClhwF802sd5cZP6W66TvmgduyB+cIm1D/k9AvYEqAe7pP4rq5mQFs758ot4l+7GHd+EwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N1TOEk6r; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ox9UKedO; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N1TOEk6r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ox9UKedO"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gtg3T0LJKz9tMN;
	Sun,  5 Jul 2026 23:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783285477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHe1v9wyuo5Lk+X3GCHEgJYsvRIiV7EdK30xd6IgQy8=;
	b=N1TOEk6rE5CPnX4VmzhzAfqstKOhenaBXKr6jz1ygvvVfSaSyQgoLzLt94g6ZgRwg+AsM4
	1LiBQDXJFa+2URWuUknoU9UkftU6RjaAmw6k1nKPOG7YTvR0Sp53XTmubfd4TCkvj9pyr+
	7afTUhIXiEdjvuayS4rgY84cVTFTojU21+oygEKNgOWHvHgaZaayIcoRVPfHRxRXsZPMgv
	/TbwS07HY4vx2EAnvuGag8ljjvxIC+on60p+0rzDkrsS3KBhuPM4XXaiR5KiqATSmFIgl1
	nPjTL2sF3UgInyz4oXT3/3kB9/ByB4HpUh/IK6e+BN5xeUrnlEQ5H6ef2izskA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ox9UKedO;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mhi@mailbox.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783285475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHe1v9wyuo5Lk+X3GCHEgJYsvRIiV7EdK30xd6IgQy8=;
	b=ox9UKedOM2bzIq4O5zPltGLCJCbT7RoRlh58QTw4ms9I2vvnJKVqZ/D7qZWh5OPvX+6Dyg
	L/d66JKpl2UO+EDPkxA6Cs/0oecpl2KfJ9AxSTlqe5YgiTt7SxeouLHP/j3gRZc/PXj+PC
	cs3tJXa7YbWew3638RtT2s5nkg6suKqv23lcsalblNQCSDHaiwdP7Jhz3ZC5PjpV1hZ2Ed
	qkDt/FKwuczlv6nNMxXATrs2kaLvlkDmDmtRQbrAVok7seYufmbv9NZRQQm5A5Gx2rviEU
	0Ykxr+3SRN1ywG7vBGI9T/t0WLQLrfZ9+LXiUMLkPhB+Zhm3zkn9vLqlj2eRIg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 23:04:29 +0200
Message-Id: <DJQXXV5KC973.1XAINGJFCKSWE@mailbox.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "Beata Michalska"
 <beata.michalska@arm.com>
Subject: Re: [PATCH] rust: pci: rework device enabling API
From: "Maurice Hieronymus" <mhi@mailbox.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Maurice Hieronymus"
 <mhi@mailbox.org>, "Bjorn Helgaas" <bhelgaas@google.com>
References: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org> <DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org>
In-Reply-To: <DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org>
X-MBO-RS-META: hqsfhii54pcetpzmcwahhbn58s3iz4fg
X-MBO-RS-ID: 3cf13b6ab1d6585148c
X-Rspamd-Queue-Id: 4gtg3T0LJKz9tMN

On Thu Jul 2, 2026 at 11:47 PM CEST, Danilo Krummrich wrote:

> The concern pointed out by Sashiko that pcim_enable_device() silently als=
o sets
> pdev->is_managed =3D true, which also influences the behavior of other un=
manged
> PCI paths is valid.
>
> Of course, we could easily overcome this if we have to, but on second tho=
ught I
> think it would be nice to just not have the managed version at all.
>
> (Note that I also have a patch in my queue to convert IrqVectorRegistrati=
on to
> use lifetimes instead of Devres, which will also address the topic in [1]=
.)
>
> The advantage of not having to store another object in the bus device pri=
vate
> data is minor, and a lifetime annotated guard is the more idiomatic solut=
ion
> anyway.
>
> 	pub struct DeviceEnableGuard<'a> {
> 	    dev: &'a pci::Device<Bound>,
> 	}
>
I agree. I'll implement the guard once the bitfield question below is
resolved.

> For instance, struct pci_dev has a C bitfield that also includes the
> is_busmaster field, which can race with all the other bits being accessed=
 in the
> same bitfield.
>
> I think (most of) the fields should be in the same locking domain (the de=
vice
> lock, which is held in bus callbacks and in Rust represented by the Core =
device
> context state).
>
> But there might already be issues with this, e.g. it seems to me that
> block_cfg_access is protected through a different locking domain, the sam=
e goes
> for a few other fields I think.
>
broken_parity_status can be set via sysfs at any time
(broken_parity_status_store() in drivers/pci/pci-sysfs.c), without any
lock the other writers of that bitfield word take. Racing that against
e.g. pci_set_master() from a runtime PM callback (which runs without
the device lock, e.g. nouveau_pmops_runtime_resume()) is a data race
on the shared word - triggerable from userspace today.

> (We had a similar C bitfield in the driver core, which we recently replac=
ed by
> using bitops, as there were subtle race conditions.)
>
I looked at a7cc262a1135 ("driver core: Replace dev->offline +
->offline_disabled with accessors") and would offer to convert
pci_dev->is_busmaster as a first step, so the Rust device enabling
API can make progress; more bitfields could follow the same pattern
later.

The one question is where the bit should live. pci_dev already has
priv_flags, but its bit definitions and accessors are private to
drivers/pci, while is_busmaster is accessed directly from outside:
xen-pciback writes it, lpfc and sfc read it. So either priv_flags
grows public accessors for this bit, or struct pci_dev gets a public
flags bitmap with an accessor macro, like struct device.

Bjorn, would you take such a patch, and which of the two would you
prefer?

Best,

Maurice
