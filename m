Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3C3BB4A;
	Mon, 26 Jan 2026 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435021; cv=none; b=OWsgcFH1OYAfj7dXqa++TTp3XpNEjR7Itonqh6DzL891rZeY/arHwQA2Dggnou8cpCXLEdAyyAvBMIkyuAYvZMTK04JMvw8QquszMyO25uHJeNXwPi7uldCeVX73K9g2W86ROSzhSWUYfQcOWMHym74wBDME0s1Na0/fSqfK+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435021; c=relaxed/simple;
	bh=lWQElNLMbnSpXu/GCS7wpnW8HMWU51CpULph1VnYWWw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=AfBTX0sdwVX9ruutrgw/fM17unR8VqvoSiFJp0En/oK4LDyu8rfABCkuH6K0JGRElA0Cnyw+lSeZfb+FJsa3ZvRHxLNYLLJm6UOhUfpqJNmcv+B9r6S2gSaPDCYAIqMTt2xNBDNoBeUGJ+xwySbJFd2y8NZ2KKQa0oQhDOI23vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6EGmAoI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6EGmAoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2725C116C6;
	Mon, 26 Jan 2026 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769435020;
	bh=lWQElNLMbnSpXu/GCS7wpnW8HMWU51CpULph1VnYWWw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=b6EGmAoIlbllhhkHHx2kw1Gb2hw0NwQbOQTnnVq+IxVsEs5p+4vN2DP7rgcjPTDk8
	 UxRP39sUr0sRAulST4He8DRbsb5YqlJ041m51QyPKS9lpk93nTMw6pjMw15uML8vcl
	 lL5oykdnyxJXrZY+40G6BzZfH1az/fnR/FM8cEFfADfVRzJJgpuKHud0St+d/Ft9A+
	 +xBAq3ImC7Q+ZvRefseOu0Zwbwu6yF/tluF34B4OxIqpfgK0MLjApSqbc15XkoLeCw
	 OCCoHNAkI4QCvq373m01mpCEqxa56ID7q21Ug5QMwEAIn5JnnbP8PHCpV9Xgy8hmoB
	 p9Wh+AOorVh9Q==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 14:43:36 +0100
Message-Id: <DFYKD4MRY9BK.7O6YH0H3RHOO@kernel.org>
Subject: Re: [PATCH 4/4] gpu: tyr: remove redundant `.as_ref()` for `dev_*`
 print
Cc: "Gary Guo" <gary@garyguo.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260120181152.3640314-1-gary@kernel.org>
 <20260120181152.3640314-4-gary@kernel.org> <aXcxMShqvHzYMllD@google.com>
In-Reply-To: <aXcxMShqvHzYMllD@google.com>

On Mon Jan 26, 2026 at 10:17 AM CET, Alice Ryhl wrote:
> On Tue, Jan 20, 2026 at 06:11:09PM +0000, Gary Guo wrote:
>> From: Gary Guo <gary@garyguo.net>
>>=20
>> This is now handled by the macro itself.
>>=20
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Acked-by: Alice Ryhl <aliceryhl@google.com>

Given your ACK, do you want me to take this one through driver-core for thi=
s
cycle? For the nova-core one I will wait for -rc1 to be out and take it thr=
ough
the drm-rust tree to avoid conflicts, Tyr should be less prone to conflicts
though.
