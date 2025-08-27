Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C01B4C6C;
	Wed, 27 Aug 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281338; cv=none; b=L8nrdAwdmICvQM/qOyxumv32GP+EvaFbXyLY0yrHMdFEhrKJs3E7cLUUkHSGSp6ZXjnDlbVGXFGLM5qezvCmaH6np1epgKjn5fFq1zO1J83MW/C2S4gRVLF1xm9uYoDoE0nib/AtQNqQQ5qptt5IhxchWNOaQBcpgNi3WfsMFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281338; c=relaxed/simple;
	bh=S5ES48XRkwpB74ejxYCgrfQGaAkor94Qfa1G7gy7vTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWJVLRnONjYu7Z+Bp8MSfpSFo2nge/ODeD1rCP9MWaNpCm4baKCporTDAnEum52LwqeBryAgzn3GHZUnBySCeatuywTGb6+PaQBdIQRVm6bxLZS1400t0XKhuG+SFA+wK34pc1i4Lai5nISJrfNm9vDiUMQcUuQFfPnMx6XNFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQoC+uIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQoC+uIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E95C4CEEB;
	Wed, 27 Aug 2025 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756281337;
	bh=S5ES48XRkwpB74ejxYCgrfQGaAkor94Qfa1G7gy7vTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JQoC+uIqPzlaO+KNrOOjvjFjdW1qCfyGTKcJAGSKB/epdwmpvWeoS/bmNn5Sa58tv
	 ef4j6CgizahE2x4LzFfLpTEJ4p6A7/zNNbGL5BmOE1lcQoX+iFEN+kH1qPuVa5dgat
	 bP010ZLKyPzCc9oM3EFY+3d7k9992aXgQYZppOD68nv++4Xq/XiArxog2NpIIWOTSh
	 0TQO8Qk9tXqNUbPqzUfCN8gKQtrHLYU2jOyxlcTlcsjLSeAa+jRAkwIhIsEmCvES5D
	 aK4w/Rk2b95zhJLwmMHiNCc++l+SxwtJ6wavydkT/12rgZU980M/iFb9omW0XCOOyT
	 QMPEV7D2PTSYQ==
Message-ID: <9e30442a-85eb-4577-b81f-89ea68d4ad97@kernel.org>
Date: Wed, 27 Aug 2025 09:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] rust: irq: add support for non-threaded IRQs and
 handlers
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <ZBiGWoEXSxAUvEwNj8vzyDa5L6KvqTuKBTKz3mzyhMGBAja6PJsMtIiSdAUKDmn_FumrmDYuOk4PKlXRW055Qw==@protonmail.internalid>
 <20250811-topics-tyr-request_irq2-v9-3-0485dcd9bcbf@collabora.com>
 <87wm71cahd.fsf@t14s.mail-host-address-is-not-set>
 <AEwfSACv6dV1KuKmY7ufNvpYacRoT4xbJRGQJP7zfeV2GfeKcNpXZqsOQJw_w4lqbjqIsMjt-NZqp4OqBeIFpA==@protonmail.internalid>
 <9A068CEC-E45F-44B1-9D16-D550835503F9@collabora.com>
 <87zfblurtj.fsf@t14s.mail-host-address-is-not-set>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <87zfblurtj.fsf@t14s.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/27/25 9:50 AM, Andreas Hindborg wrote:
> I would suggest (next time, since this is applied) not linking the
> symbol in this patch and then adding the link in the patch that adds the
> link target.

That's what I did on apply. :)
