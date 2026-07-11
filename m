Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DE92E11C7;
	Sat, 11 Jul 2026 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783558; cv=none; b=kSH4cqgAROosU8LLNcavdN2ewRsZRE9t6KmOmPBsP4ZBgSABaBMep1oLuTtmbs3THqHQxyvGSjPrcmVJKVS9vJXY8fAp25VxjDQaJRJI1c73pAIPuZdFK7WPw0jNXJWSzv+tautQVmk1h+fo3JzLY8EnaS6TVXWYoLPTOhH4KIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783558; c=relaxed/simple;
	bh=Nek5ZXdB0D0IztbJf7PZdn++vHjyXt3SZbRe3hbsYHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WsmykvBj9OqHqo+wGLfrn6bEAcTCon6BO7cAbdgfgUZ8qwCEaOXtLFuL/5JjZdDdpZQy5aFBFNWUXbV8OqhY/n3L27MdcqEsj8/9g6N7UDE65JJe1yzveh3YqnvLspnT/UlJCnm0Abrc+CQYKZQMGPSeprUF4F++zimWRjxiAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KMAcG9yW; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bpa/bxJ1; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KMAcG9yW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bpa/bxJ1"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gyCFs59c2zKv86;
	Sat, 11 Jul 2026 17:25:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783783553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nek5ZXdB0D0IztbJf7PZdn++vHjyXt3SZbRe3hbsYHY=;
	b=KMAcG9yWg9CKKonB0vGgRybLd0s3D3yGLE4S/8GwQSU4c99qGBpzYHlHbxpc/AGvfet1gf
	ngqHOVgcVddhtifMTglo3uLG0Odtk+NRN5mvE/FOZIjJubNlVHRortuU0Oxm+WYkAUEqeA
	OztR6QztfDIGUcguWy9n5B/Um8oEAwSUjD1Z/zKbfURkiRXGuJ3BljKOr3vg1cWBu2bffv
	Kc2szbjfoCRQcEdhHTsk/I3hy4rAUkCfkduxctZE060dACfV02K+ysjytFl9ShwXhLmbrH
	ApZqI8PTjZMkWZU0zIBfyihx8mshAxr0hbDE3xYdImfXNer1YvclVsg5hipRFA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="bpa/bxJ1";
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mhi@mailbox.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783783551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nek5ZXdB0D0IztbJf7PZdn++vHjyXt3SZbRe3hbsYHY=;
	b=bpa/bxJ1dnVX+D9YGJrza67flkA2OrXluM6lCrue/JCkP1e5HbjPNJqT0qVhoaGj2NrliU
	9Xvf4r3lr7cWhb7rhVPfK8Erpev7YpmhZLWkbC7WPTjHBflM4R7UqGinC6k7ZwoPOvGEIO
	7xcdBJeB1Vok6mrVb6Y+cWOVLpzF8748cKEqmlNntgsiFOhH8qc6Pv2L8rrVhPm4hAB3qv
	wJ9DJQEw/DBVIDS+lAfh/HCaJ98HDv0+qyHtxCPnJqmBJ5BX3S5TxcsKsa2OGCyP3/X9QI
	WrtwH7DpX/T1WyiQQ76VbtmsC4LO4zLI3hJmHVSyZFvFNUsaLZg9tKZaRyoi1Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Jul 2026 17:25:45 +0200
Message-Id: <DJVUHS5VHP4Z.G2FV1QJQ8ZYH@mailbox.org>
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
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>
References: <20260702-rust-pci-enable-device-managed-v1-1-75bc4ff2935c@mailbox.org> <DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org> <DJQXXV5KC973.1XAINGJFCKSWE@mailbox.org>
In-Reply-To: <DJQXXV5KC973.1XAINGJFCKSWE@mailbox.org>
X-MBO-RS-META: enmjie771wiyeac8q44io5gtiagfegew
X-MBO-RS-ID: 433528a3916b0c56860
X-Rspamd-Queue-Id: 4gyCFs59c2zKv86

On Sun Jul 5, 2026 at 11:04 PM CEST, Maurice Hieronymus wrote:
>
> The one question is where the bit should live. pci_dev already has
> priv_flags, but its bit definitions and accessors are private to
> drivers/pci, while is_busmaster is accessed directly from outside:
> xen-pciback writes it, lpfc and sfc read it. So either priv_flags
> grows public accessors for this bit, or struct pci_dev gets a public
> flags bitmap with an accessor macro, like struct device.
>
> Bjorn, would you take such a patch, and which of the two would you
> prefer?
>
I went ahead and sent a series implementing the second option, a
public flags bitmap with generated accessors following the driver
core precedent, converting is_busmaster and broken_parity_status:

https://lore.kernel.org/r/20260711-pci-dev-flags-v1-0-2fcf2811138c@mailbox.=
org

Happy to respin on top of priv_flags instead if that is preferred.

Best,

Maurice

