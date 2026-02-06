Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B291428847;
	Fri,  6 Feb 2026 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405151; cv=none; b=o+rMghUJLKFEuP8OUFB6gewLnSD7+A5Mt9BPR4UMnXQ9lka61oIB8El7UuZtx2lrWZt1A46I2DG0R+MXRJ0AFbWdxFHSwZ+y1FkcS7r9svUoMzx5RXfxHQp1A8llJSlOhFoB2peGC1c83BC4usg1V84/cjUtftjPgqb1rVjJdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405151; c=relaxed/simple;
	bh=P1TkKLjYrVeOCW4ifo90YRtpuovg0RxaxUBLJTxmVeU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=rDJvqlN1YoaXF2nO/UbhUIRJ2v7RwQGe/baydgOkpPPS0HRe/Ab7oRblyL2gVqNvCGSCKRkv9k+7sPROhCQQGYnCi9OPHvei6slGmkC7UqYzXbGbjTtunhJbOpm1/6sJKfnN4evRHOG69tR3MuNYFfBJd6RdnWMDurxCneH38n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLcsje0K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLcsje0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE5C116C6;
	Fri,  6 Feb 2026 19:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770405150;
	bh=P1TkKLjYrVeOCW4ifo90YRtpuovg0RxaxUBLJTxmVeU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bLcsje0Kh4jsGX32qGmVL6urmcAuztjxqgZ6xV+0J9hFvGBlLqT96yomw2/xBXhaq
	 Ok4w7HNgEaUGlVORM8kdSDRNdN5eZ+SYZdg7N46r0FCMuRrLRdExEmMsQP08m4huLE
	 4+Ccc51CBF+p35pZcmRQhfr07NrBM0snhDPj1B+RNutRJMH3u1G/Or41xh6lLmJOM7
	 sn1PCxfKFM4o7DsJiMLcemNjxRz++4L0Ks9M7bZehc0dwXd3TFIsRP4YhK6kgMeBAy
	 u/imgHMwzVLqZGgpZdELcY37por/zm8Ako8CkJEvJq1xeBXKzU4W3gUtSIWDrahP1D
	 ct3c8znhGsgSg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 20:12:23 +0100
Message-Id: <DG848V6RE1UW.PSGVUI0ZEDWL@kernel.org>
Subject: Re: [PATCH v2 0/6] rust: io: turn IoCapable into a functional trait
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Lyude Paul" <lyude@redhat.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
In-Reply-To: <20260206-io-v2-0-71dea20a06e6@nvidia.com>

On Fri Feb 6, 2026 at 7:00 AM CET, Alexandre Courbot wrote:
> Alexandre Courbot (6):
>       rust: io: turn IoCapable into a functional trait
>       rust: io: mem: use non-relaxed I/O ops in examples
>       rust: io: provide Mmio relaxed ops through a wrapper type
>       rust: io: remove legacy relaxed accessors of Mmio
>       rust: pci: io: remove overloaded Io methods of ConfigSpace
>       rust: io: remove overloaded Io methods of Mmio

I will queue this up once -rc1 is out.
