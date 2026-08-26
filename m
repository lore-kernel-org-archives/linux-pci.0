Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D3242AFAC;
	Wed, 26 Aug 2026 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751383; cv=none; b=es1TJp6/xIWPB38Dr1Zw5OMDvO60vP0iq49qjBkPef9fvaoAImTUMIbOKcr8cwxWqK3RAgIS1IQNSGmWK1jD0sCU4VpiwFgn+DEllRPwOK4dAWwWxY5h4xNTqE7gaxq/4O1DpCxhXKEA9WSGWr1o6ZDPe5Zaul/l8DvtUS+FJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751383; c=relaxed/simple;
	bh=dvNvmpGh91YG/0NGubbounEexLPvFYBMCQHih7s4kYM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kMz34RMOMV7K2umGqxXLAKwvRUfzJGEm6Ur6qUeCRF3hs5c4tfa8Ent30I46GLFkgorMBjcShjuQitrLfoLT5NfYEEen3KVglPaTYFh3ahVlDfxp8X02te8LXgXa9sNZqO1hP7w+ABMV4U1kApYarJ7Rj2GQcdEI5xmj0xBLkLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7cMVaj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7cMVaj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3EF1F00A3A;
	Wed, 26 Aug 2026 13:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787751381;
	bh=dvNvmpGh91YG/0NGubbounEexLPvFYBMCQHih7s4kYM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=I7cMVaj9OIhVyzWkFJXOXaLWTpcBtBrj8BPHq36tpHX3CLA1lExLoPBHqRFEdiREh
	 3u8rkWd3yETg3HjA3iZPmunjwyTnTisJZS39yr9C7LphQY4B98eNL6SyhrV7/I8yyd
	 pNnjZHnrV0lIinDtpzzBBoqPK1whXCKlJW4yflaR9Iy/UKT0R8anKmS52xCZqvt97C
	 kkFgMXkt9csFuRmmQmuywOaaSW1DVFKoLPu/IK4iErGvo/Y1iYoe2I79aQCjYmRJNS
	 BRZtLY4Zd0nK8P1sZSXvZtsoCD8SwB6SuhYVzZz+vHvSQHOjpWWdDKROf/nWW16TiX
	 9FHS7jgmYFWAQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 15:36:14 +0200
Message-Id: <DKYWYZPPYZNU.32R4UV9WLNZ60@kernel.org>
Subject: Re: [PATCH v8 1/1] rust: pci: add extended capability and SR-IOV
 support
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260818084633.1673214-1-zhiw@nvidia.com>
 <20260818084633.1673214-2-zhiw@nvidia.com>
 <DKYU6ELNN060.154BHE2QG442C@nvidia.com>
 <DKYUBX3TU66J.1P5UZ908CCKBX@kernel.org>
 <CANiq72m3pGr+sywbZ=woVnpbHW616VN2sG+RKYZWbWHAehRvvA@mail.gmail.com>
In-Reply-To: <CANiq72m3pGr+sywbZ=woVnpbHW616VN2sG+RKYZWbWHAehRvvA@mail.gmail.com>

On Wed Aug 26, 2026 at 1:44 PM CEST, Miguel Ojeda wrote:
> On Wed, Aug 26, 2026 at 1:32=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> So either this should just be a regular as-cast, or we have a signed tag=
 to
>> share with other trees for [1] early in the cycle. Since -rc1 isn't even=
 out
>> yet, I'd prefer the latter.
>
> We can also just keep the "old" interface and remove it later.

Sure, that works as well. But in that case I think I'd rather have the regu=
lar
as-cast intermediately (unless your idea is to go for the full three cycle =
dance
of "introduce new API, convert users, remove old API").
