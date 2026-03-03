Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E731A062;
	Tue,  3 Mar 2026 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571627; cv=none; b=XcgOipui1Ze018K0mAqhRj5AoCT5aDcXRT1mwZRJ1AAjuH0njIm2/jusn2ppS4u4T+ckFNFAAy5OAqdcdCfXDGLF+OBuoZHAlE5n/joZwuUNzKqmo4GBStmCSYjeD7E1l2AAs6lDrQG2uZqRF2tVLdchhQNJL/W22rOCztoYqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571627; c=relaxed/simple;
	bh=bYWqMgSj/zNIH7KRRZ+Uhfex6h/chwdYLVtH4gBQAOA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=E21GBY8ie+HN+maTgCO0+qL9pt1VB0CwWA3NtsHXZAaENHd6OvB4C62pjsYIlM8WM4dAjeMK2TEu2xO49C7T05ce2gV7FObtI4KQzwKCVx8rIUpYda9c6vpO3NFp4nVwhvRGvHXsXbr82vcFTpvNxej1bB3JymtppLmfJWVWgLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyp+L+nn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyp+L+nn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C94BC116C6;
	Tue,  3 Mar 2026 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772571627;
	bh=bYWqMgSj/zNIH7KRRZ+Uhfex6h/chwdYLVtH4gBQAOA=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=Xyp+L+nnlhrl+pAza4ZYINYQwehR6jNHtYAApkAagzQJqdQ0OU0/9fBnE/eAMygyn
	 aj6xwnlF1yzp9/V0+XsaLws5XyR4JfnSsBpabw/CrGmb9cNsyK2cMWwsWPvm3CCRup
	 AG0TUB2n/agbEeySoeCnopJsxq1eRzONWaQ55Usf/8+67Hx/A0lxbrgShSB2A2FbmP
	 jZxnPqAmQ69Q9+GVvAbXnE/LmGqSJrvSn8kS2DKGzSIXnnSs+giVtHaiAO0V8AY6jn
	 Pw22TWKWrLfaRGH0Y9AyJB1UWBI09pwmEs7DfneHUI4q2LgkaIjAfhIR36X7FoPLtY
	 Vnsmrp1HX0KRg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Mar 2026 22:00:19 +0100
Message-Id: <DGTG74JPNSF9.3W3FWVWCNH9M7@kernel.org>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <gary@garyguo.net>, <joelagnelf@nvidia.com>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
To: "Jason Gunthorpe" <jgg@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: introduce abstractions for fwctl
References: <20260217204909.211793-1-zhiw@nvidia.com>
 <20260217204909.211793-2-zhiw@nvidia.com>
 <20260303201552.GF972761@nvidia.com>
In-Reply-To: <20260303201552.GF972761@nvidia.com>

On Tue Mar 3, 2026 at 9:15 PM CET, Jason Gunthorpe wrote:
>>  rust/kernel/fwctl.rs            | 449 ++++++++++++++++++++++++++++++++
>
> The binding is larger than the subystem file:
>
> $ wc -l drivers/fwctl/main.c=20
> 421 drivers/fwctl/main.c

It's probably more a positve than a negative thing, as we should have a lot=
 of
code that is not only mindlessly forwarding things, but actually teaches th=
e
compiler how to prevent users from making mistakes.

But yes, usually the abstractions are smaller than the component they're wr=
itten
for.
