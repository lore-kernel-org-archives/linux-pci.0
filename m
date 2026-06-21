Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF683D994;
	Sun, 21 Jun 2026 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782058553; cv=none; b=Q/h3ldyGEtQ5ev7QylYCfeJGd6+2k+Ly6e6g6KYhi3+8Va9Klboz6qplWpqzW5I6d9s1wHiNWScTNaq5e1d+V2ZevkGHQ24GxDDQgfwVk8qLGs9iJAg5zfLmO4tMiwT6+10XOCixphVoe0eCGpletkq65OVPW51r3XisHtMbmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782058553; c=relaxed/simple;
	bh=FnccYtdEdPQjx5ZnmFW2ZFJKkZGpf+bLt65KbDy9AMc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NWKghwkh0YhWhy66/Dp5AWlRgg+l7Mcvr+gyx3Id6XUbdWDjpJqXMqBRJQ/nmB8EKbWh78C4my6WtnfXpi4HCZ6dSDy5YC2H05D5Z1BwAUpQCTn38jfNnRvmMjT09MacDu9GDp7oOq6eK5JFlGrzuq6mio6wx3ys8H8p9VPuHUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7c334XW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7c334XW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4211F000E9;
	Sun, 21 Jun 2026 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782058551;
	bh=FnccYtdEdPQjx5ZnmFW2ZFJKkZGpf+bLt65KbDy9AMc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=J7c334XWQR3fL9pKYutLwMDh/LxIKZUTPcjnj4ixACmnr98zz7XIx5jmoEUOwp6yG
	 EKmPb8aj8WQ6/l9vaCaeMdhwhN2u9jf/EZw4rqZz/ZMTGTWi2lwjCRcnafDWFQI3KZ
	 Hj9vRZXTJVcaJG19oFNeai0ITnRyQ50fUv3R9F4wxX8u/sI2czmcRW5IppgcxVTTY1
	 uDUYJeelioFvN6Zbu1c/shqSCZ6IG2/QTp89Ixor0ZQZvRuGf0tHx2t6TlJGcyYWuc
	 XadNxx0EBN70AHDH32eLKaIM7F29LqAgg4xx6OgmPWuIOEvacS9H5Ffwx0PkkCBKGN
	 Xp3NRaxwBNrNA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 18:15:45 +0200
Message-Id: <DJEV166T78O2.22Q1ANXGBZNU7@kernel.org>
Subject: Re: [PATCH v4 09/20] rust: io: use view types instead of addresses
 for `Io`
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-9-1f7224b02dcb@garyguo.net>
 <DJAJ51781EOF.1Q2VTH6CQVXYD@nvidia.com>
 <DJAK39S4J6EP.2VY3R7CIBAPOL@garyguo.net>
 <DJEM4MAO7RON.1EC4OJM72BCNB@nvidia.com>
 <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>
In-Reply-To: <DJEUAKFVCM0M.3VV7G8AQRXAGU@garyguo.net>

On Sun Jun 21, 2026 at 5:41 PM CEST, Gary Guo wrote:
> On Sun Jun 21, 2026 at 10:17 AM BST, Alexandre Courbot wrote:
>> As you can see, this lets a 32-bit access be done on the upper half of a
>> 64-bit register, which sounds like it should not be allowed? Similarly o=
ne
>> could change register types, and so on. This might not be "unsafe" in th=
e
>> sense that it is still aligned and in bounds, but it lets the structure =
set
>> by the type system be bypassed. It could also potentially be a violation=
 of
>> the hardware contract if the access width is relevant for this particula=
r
>> address.
>
> I see no reason to prevent any of the case, this can be done by `try_cast=
()`
> API as well. If we need to take access width restriction and other
> restrictions into consideration, then a lot of API cannot be exposed at a=
ll.
> E.g. it is not okay to add `copy_read`/`copy_write` like the patch 19, be=
cause
> it uses memcpy_from/toio which is possibility doing byte-width access.
>
> in my opinion think people should be able to type casting without reachin=
g out
> to `unsafe` if it's not UB. Similar to the logic on why we have `zerocopy=
`
> that allows casting between to types, these are "bypassing the typesystem=
" as
> well!

I think this is fine as-is. The natural, ergonomic path through the API
(io_read!/io_write!/io_project! macros, IoLoc-based accessors, etc.) leads =
users
toward correct access widths.

Whether through io_addr() or a custom IoLoc implementation, reinterpreting =
the
access type requires explicit, deliberate choices: picking a different type=
 and
computing a byte offset. This is not something anyone would do by accident.

So, as long as the API doesn't provide a subtle way to do the wrong thing b=
y
accident, I don't think we need to add restrictions here.
