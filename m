Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C065C2E0925;
	Mon, 11 May 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540180; cv=none; b=p7fp379i8RcFdsltwLxqe9lyhoAHMv1V1gx8ZQPS3ttMam2hBqXCPAbniUOYtjm5m4yDjuq/OLBpGxhmxE0cZT2QX94lktAuqpHVg9itHMxa4Aonw4YQIvstSp6qfqvzYwohnYItre9EYD4tFuzbdPHTSPIUOFDldRC8Ewh6VoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540180; c=relaxed/simple;
	bh=QWVDVaeWXV4GbyWgoNQbtUfQbuZpi8pMwF5GmRCH69s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VsnW0vgQTR+Tw1EXp9HNztrj5vY7LjjJD93qdE3fi5NuIPWiwZzclAoP8ZlJ8eVtQuUJmi9ZQl1jNu/612dVut5p1C4K5UaK92NHDIFW2T9lq1yTvXSQhdwiYwvNhqsLzjXpiUkmzTO7G0qYOlWSn7nGAvu8h7aYMDQyrGBfk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTkUrt93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTkUrt93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33552C2BCB0;
	Mon, 11 May 2026 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778540180;
	bh=QWVDVaeWXV4GbyWgoNQbtUfQbuZpi8pMwF5GmRCH69s=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=aTkUrt93T4INKuz/JUkst2NoH/4WTrHZDn5J6NVFkO0Sjkv21Cnt18j1Q+2KOlFLA
	 HkueXpk/4xIJ8PsT6YeQ1Wq6Ge6Al36L+JoX1wjcDplLOtT67dYkISlPXGRwELUwZv
	 sAmSeWIPm5V/1bDyxMjQeUdiANWWWZZ8F/NWQMNYqRoPydnalHvLGnyg+viK1hMBDa
	 cwkIAHNtXdhP1jw5GjPkDTafDVJJPM6AyFFCsFKXbZU0xegQ15GL8sqYF8VBYfzTQu
	 3g/fpf+u9BtLBYNIpwtsRBCQy7pjqKvEq8x91V6w3iiuqUPCnBxnpoWng5fN3A0GRV
	 /utGGdamwtkvQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 May 2026 00:56:11 +0200
Message-Id: <DIG7VF8XA0KX.3GLHRET0SLOTN@kernel.org>
Subject: Re: [PATCH v2 00/25] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <2e1c9a71-46e7-4036-91ac-86453564b223@de.bosch.com>
In-Reply-To: <2e1c9a71-46e7-4036-91ac-86453564b223@de.bosch.com>

On Thu May 7, 2026 at 2:14 PM CEST, Dirk Behme wrote:
> I have applied this series together with [1] on top of 7.1.0-rc1. I made=
=20
> some adaptions to local changes (e.g. my ARM64 TMU interrupt test) and=20
> boot tested it. Several parts this patch series touches (e.g. PCI,=20
> auxiliary, gpu) I might not use or even don't have it enabled. So I=20
> don't know if this is worth mentioning
>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>
> Please feel free to ignore this, then.

Thanks Dirk! Any test coverage is valuable and much appreciated.
