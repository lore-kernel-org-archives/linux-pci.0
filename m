Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8B1FD4;
	Sun,  6 Sep 2026 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700739; cv=none; b=JuqNbU5zlQ+7KSR/3tji3U8jNkuvmopLXGA6FkqXwcbNS+io6RaRMu1f2diNMFYfhDO7LMmQk4HrlF+RZmz1z4wAU7g4TG0NnES3+mTYLwa2bEPgC4ymkJ8Tkz+Piel6r3nnEkmiwz5IqPGsA3vCvT/Xxyeo8hyM3DzznukDJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700739; c=relaxed/simple;
	bh=lWPvpfMXPlnWiQN7mEAn4MklTWgtGgN38qTBOTGjkvQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=B+v0HlIVH7SPDAcCU/GiF6g1iBGB5TCHqwYjZVelV7O+AALfmuKB9rS2+FeGdt92Pa6AsRP+b36Kj9PWKidCc+fsDpZ4l9aQgoDUyX2l8oxfBQamEc3KZ2dCAXbwtmvYIEp7ZfsgAamTqpR+0OzwPJuN9cET1O4cd5q1elVG9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW1SB1Jl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW1SB1Jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5931F00A3A;
	Sun,  6 Sep 2026 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788700737;
	bh=lWPvpfMXPlnWiQN7mEAn4MklTWgtGgN38qTBOTGjkvQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=YW1SB1JllKEEzyM0SlwESPqi4536t1MUL33b3RoJOjeMXf6fI3Kpt3q6XmLAic2wu
	 qITPAlU0cplNNnOgFolC5uXIAmx8RLY3fh7fmJVpR6EGJ72LmT8FB5lUD+bwAqMAqg
	 qu64u+mKk6+kBDSjFMVH3vnkXbHc4rcIPLuj6PwPgUqOB/uXWMs94DTvCk8ijJvkds
	 beSbMP8iV6gYHcz/tV81WZlC6V9ViYZMQ9ghdWUOEa6nDkupg4QKQZHIN1DK/6guZQ
	 RUeRnvgBeh2bAwCTEVAiGQJW8lqUDVDJaFftYH1ZkpXXiRfbXS6jCLRT/5iXFK1+Qz
	 Hz+teHfDBo+mg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 15:18:51 +0200
Message-Id: <DL89HO2ZTM44.1UR1ISN11D32I@kernel.org>
Subject: Re: [PATCH v4 00/16] rust: io: support register projections and
 remove relative registers
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260903192248.2248560-1-dakr@kernel.org>
 <DL5XG1N71CVV.TOAF6XQY0SW5@kernel.org>
 <CANiq72m1ZxFtQjm4fUAt6Y1MFE=ww6jx+dEg3F4Bqbki=ndO=g@mail.gmail.com>
In-Reply-To: <CANiq72m1ZxFtQjm4fUAt6Y1MFE=ww6jx+dEg3F4Bqbki=ndO=g@mail.gmail.com>

On Sat Sep 5, 2026 at 9:24 PM CEST, Miguel Ojeda wrote:
> I see you fixed a few nits -- I pointed a few others in a couple replies.

All fixed up, thanks!
