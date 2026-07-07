Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46E34404F;
	Tue,  7 Jul 2026 14:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433538; cv=none; b=pdxoTcLYIbnz9cRXfJ4sUyTvU2ZBZpSC5Sf/L1GNhBYvUeygeL84i5t8KirqR2AfDZbyRd5/akeLxQ7NydCmQFRy7rcs9k5I3IScxoVuMI6mcROI7zneJO5RLa6zj+b1hLO/qCLs9jcCGVPjbESTa2IHhZJ8/WPjLIOr8P+3kPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433538; c=relaxed/simple;
	bh=jxZ+J2bI5Ac4cUZdA4D/jzlc5dbPxutHkJwdTQl7aXY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mb71owKCrhbIjF+tdNE5vF1WsmuxGtedf19z2A+O7GKpe/f/3IETsBrrK2VjDFHgZeBNIo3sm7Tk9fFW/0sFnUyFYPCZL5CNc8Vt4MIcIDzh6el0dfCUxKXw8yph3rVheIk7eGA3jOvuaeti2mvZ2gWCOoSYXuspyEcWiOYY+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czO8W1yp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czO8W1yp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CF21F000E9;
	Tue,  7 Jul 2026 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783433533;
	bh=jxZ+J2bI5Ac4cUZdA4D/jzlc5dbPxutHkJwdTQl7aXY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=czO8W1ypu9X+Zd7xxu5QLBuCikwoZcc5Lv/pZVVlkxCp7aQDgyd09JvCqR/+m39Gn
	 3WG0Kf35rFrhCUeJdMLqpvc+qhR0Az7ILmpUmFSUWqTkEA7jXduwQxO2O/qClUoruN
	 XSMpBnVLWKo4KNm6DRP8U903Ydpit2bifozWAMkYvQo8lboPIwc+qq27FGuBuQeUMr
	 XTM+CEwQ1Kg+hNl13EFENnMBi9y67NpO8Fo1zBmgFMq31xij7P0Np50dtueheSjx/Z
	 3+gO5rCtf9Z0B0+QwX7lWN6AmhLSmKQ1aAKOskJtpjieOIO4WXLzeL26fxN+P/oXDW
	 fjBK/zEr+5ZRA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Jul 2026 16:12:07 +0200
Message-Id: <DJSEF840P5ZP.10CNUQ0UHDLW8@kernel.org>
Subject: Re: [PATCH] rust: irq: make Registration compatible with
 lifetime-bound drivers
Cc: <daniel.almeida@collabora.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <mhi@mailbox.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260703210936.1128698-1-dakr@kernel.org>
 <ak0FAGpJtUH7VvHQ@google.com>
In-Reply-To: <ak0FAGpJtUH7VvHQ@google.com>

On Tue Jul 7, 2026 at 3:54 PM CEST, Alice Ryhl wrote:
> Why are the implementations for Arc/Box being removed?

The lifetime design enables us to just store references for shared ownershi=
p,
rather the needing a reference count, so it seems reasonable to remove thos=
e
blanket impls.

We could keep them a little longer until pin-init has self-referencial supp=
ort,
but on the other hand they don't enable anything and are just for covinienc=
e, so
I'd rather drop them.
