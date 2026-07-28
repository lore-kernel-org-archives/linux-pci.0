Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F3471CE1;
	Tue, 28 Jul 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785265001; cv=none; b=S8kJRWjSNACSbPN+daH3c2KjQZc/292M5v4UlrRa84QH+yqFdSgY/TDkzPlhqvkd0v98zGSKx2d07t5r+SF8mqeN0t4/C/EHHRbmL69NeSvM5Hsq1O3HsQnwYjgWUUoMNoX8sYZf61m5/PYq7UljmTTYz8Y2VOPoz8+A1qhH8oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785265001; c=relaxed/simple;
	bh=2WiJKDeK2Vzyu/WLkFFx9UUxHT2Nh9XVMNUlUceYbbg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=UGBU6c0XpC/HSJh7w8uff8LekrY2uZcu8mscQvONxml9/AkqOf1Tx/1ub7dj0uYoIUsJYXOeH+N4zPqBP2wbb2WRPMfHXIzsUfqkqto9EDobftallUmG9HbbkyE3XfRqF3ghvBS3zq14Jg/j+xp8dC7NBfBMLTn+QuR2kVlPKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuY3xn/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuY3xn/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ADD31F00A3A;
	Tue, 28 Jul 2026 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785264994;
	bh=2WiJKDeK2Vzyu/WLkFFx9UUxHT2Nh9XVMNUlUceYbbg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=TuY3xn/oFJ2MtFjSY8HTXL5wh5FePxvdq+RTUWR27pehxQi+tiQ7CjhjHtHHUViHb
	 1B+fGpY62mDuvKggftWi72MFev1JkfERHvTMdkrbo9IAYkRZV9IpsMTas9SQ+nKXw/
	 CnJQOziRclQxWJo0h3hiwwFb45ZrescgQ42Ln+XGup+qQlNByMoVMpnQk4Do2nXB59
	 yI44XzbG2jhwDh7ydLbq3VS+U1e94D+qLumLKwrtpzBTQp7InvUah/oXC+wLKvnKjH
	 TZy9HvuHMMESrWa1xwR90bX9a5gaPxBgabU5KuB6dFwxhbOU3mBJVwkX6f+z616Jq4
	 iQ5wLh2gh+ewA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Jul 2026 20:56:27 +0200
Message-Id: <DKAFMD8X5LFP.UPKPHK5FYZPH@kernel.org>
Subject: Re: [PATCH 08/10] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-8-452d72b60262@garyguo.net>
 <DKA02Y5RE1YJ.2FGI97Z60X96R@nvidia.com>
 <DKA4Q5QUBUXM.1K6QS2QPXT12H@garyguo.net>
 <DKAASRCK3M06.G9XODK0T5AAK@nvidia.com>
 <DKAD64Q7CEQD.Z15OS6MRHEKE@kernel.org>
 <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>
In-Reply-To: <DKAEZ4LDA10F.1RFA9JKBGY2CF@garyguo.net>

On Tue Jul 28, 2026 at 8:26 PM CEST, Gary Guo wrote:
> On Tue Jul 28, 2026 at 6:01 PM BST, Danilo Krummrich wrote:
>> I may have a slight preference for a separate subregion() variant for th=
e
>> purpose of working around generic_const_exprs, as it probably is a bit c=
loser to
>> the final solution, but trait methods are fine with me too.
>
> I am not sure that's the final solution that I want. I want arg-position
> const-generics which would syntactically look more similar to `build_asse=
rt!`.

arg-position const generics would be great, but that's just a syntax differ=
ence
and not related to supporting expressions involving const generics?

In any case, I think my point about being closer to the final solution hold=
s
regardless.

> Personally I think most issues with `build_assert!` can be fixed by havin=
g
> lints, which is on my radar.

I think it can be improved, but in the end it relies on compiler optimizati=
on
that may or may not happen as expected.
