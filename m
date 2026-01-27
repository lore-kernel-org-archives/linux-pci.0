Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5402028489E;
	Tue, 27 Jan 2026 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544465; cv=none; b=p56g4SKM9IFwgnESWoOwVs9FCroEjYYSDepIORW0yyGy0U7khBPdwUI2IuU9TWKtoONKRYg0vv0j9kwNn1HYDlPuWaPEuKbDGVFeM7qmrvdUoIhjAnF+5gqYu6J53rtvDeAuj3DwXajIRt8XhpnACGZyeew75B2tY6HMke+Dtfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544465; c=relaxed/simple;
	bh=7I39B7v6bBEAU+4Xj3CQ9pEZcn+u64aQs9BmvUsFSAo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ADEv6oIjW23pmftESa7z19y1Hra5HsxwYUSmU3IRbs+sLG9dSlmKEim9R3+iorpUG4boHAU0SZzBf8KP7SB1fy7lhUrUpZEeBeLluWiKNeHb9m9xnDkc9wQONBdBuoGHs3adD/hNq5qjSLZtjgZlHZ7jMNC5bWywL9cJ6lg7Yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpBeUXxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpBeUXxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10465C116C6;
	Tue, 27 Jan 2026 20:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769544465;
	bh=7I39B7v6bBEAU+4Xj3CQ9pEZcn+u64aQs9BmvUsFSAo=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=gpBeUXxJwFBIWiYsOiqUmNLhrXxdpMM3KxZ745FQUL+D25dvLG1pAHVPi+UisovRF
	 dLCUbZM5qOAkDbLB50pGi4NkKLbrhnkgn1taOT1HYu/8IONe8ewA+9ptwiBtVLFK2+
	 DXQhgsUSQJx7rBkObtavHEpRh1DYgvesRdw6fSlaJuugxMfVKxrBq0OuwjRjZsNgOm
	 +fFOeuhQ1N2yrXj/HHYJKV25u0ZwrFH+mJfpyopA+uNOU/BYrY9ck5/q6gWr56Gndx
	 aCWW32fE8vA8W4X31z4oYGUmspeNThclPvNYLxZqYYFFX9U7Gdjca3NaQ3s6KFCh0H
	 fdoxGAIYcC2wA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 21:07:37 +0100
Message-Id: <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
Cc: "Jason Gunthorpe" <jgg@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
In-Reply-To: <20260127215744.332380fe.zhiw@nvidia.com>

On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
> The fwctl_alloc_device() helper allocates a raw struct fwctl_device
> without private driver data here. The Rust driver object should be
> already allocated and initialized separately before reaching this
> point.
>
> We rely on the standard dev->parent chain to access the rust driver
> object from the fwctl callbacks.

(I will go for a thorough review soon, but for now a quick drive-by comment=
.)

IIUC, you are saying that the user is supposed to use the private data of t=
he
parent device in fwctl callbacks. Let's not make this a design choice pleas=
e.
Instead, allow the user pass in separate private data for the fwctl device =
as
well.

This serves the purpose of clear ownership and lifetime of the data. E.g. t=
he
fwctl device does not necessarily exist as long as the parent device is bou=
nd.

It is a good thing if driver authors are forced to take a decision about wh=
ich
object owns the data and what's the scope of the data.
