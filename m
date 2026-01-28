Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89129992A;
	Wed, 28 Jan 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600509; cv=none; b=nnlihH7Xg+6hQ7va0/66b4r/z4d1iw0Bfs8ZSyUnkVwsLEpAlwuJ/mxowC3L7Aqw9UgYsgoxRtWA3/5pUv77UFNa4c/50+sfSJNP0P+kGxWzun/N/cH45ftkNDk2xQnetRV1omRVAp5SHlWkREWQRICYh000d/oa1bV26bL8JI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600509; c=relaxed/simple;
	bh=tpxeUuSQJmueqc2DDLIRPHfdy6a387IoP/HUbm0qFtE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DxIRejZS0OeoR8KrmZjeC/NZTMisp14mNlU4V4B8XHspDRIb961GeyR4l6QM5iQokhErHSCW9TY/ODzVVhCFLWnn42JCpZENeTE5u8O97XYjSg0c6ifVSwQqgh7ttiXI/pHnR0o7x/1S6AKe2i3JGJpcO1kYA1UCgpkvKnxP1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cldl3cvw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cldl3cvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF7DC4CEF1;
	Wed, 28 Jan 2026 11:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769600508;
	bh=tpxeUuSQJmueqc2DDLIRPHfdy6a387IoP/HUbm0qFtE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cldl3cvw+V8htDT0EgasBpKh7lxmOENMhjDLxxh5b6dB0zq16t9HUs5dct/6zQD6/
	 eYKYJjgn3U2TGQSTYbGxXN2GlXhkcgYvvsIDGqCuvgcw0J2Iyg0NVHls8qX5OiKg7D
	 ARgPQZT6ChHlRN0QGeLsOCVVso1+byg21DBz0c3oNeiKnCiNanSOt07pCKI/R3q1zK
	 YXI95okP9+L/VxCz/GgsdP/yt+4uu5POFi5N7PP2+bgrqaZn/Qkcya/XqCAfLn6tHo
	 zyA0tzbSWXaswURka3qCR9ZT+Oax2u0Bw0cY1NW+aryuMoEPhptnBBEA9m3R6F5E7z
	 4RD5UIOl/nOTw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jan 2026 12:41:41 +0100
Message-Id: <DG070VH4Z7B1.26DSDJL3VQVYA@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
 <20260126181912.GA2131321@nvidia.com>
 <20260127215744.332380fe.zhiw@nvidia.com>
 <DFZN5P8G6MQG.2DYXNFSRIL450@kernel.org>
 <20260128133651.365d876a.zhiw@nvidia.com>
In-Reply-To: <20260128133651.365d876a.zhiw@nvidia.com>

On Wed Jan 28, 2026 at 12:36 PM CET, Zhi Wang wrote:
> On Tue, 27 Jan 2026 21:07:37 +0100
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> On Tue Jan 27, 2026 at 8:57 PM CET, Zhi Wang wrote:
>> > The fwctl_alloc_device() helper allocates a raw struct fwctl_device
>> > without private driver data here. The Rust driver object should be
>> > already allocated and initialized separately before reaching this
>> > point.
>> >
>> > We rely on the standard dev->parent chain to access the rust driver
>> > object from the fwctl callbacks.
>>=20
>> (I will go for a thorough review soon, but for now a quick drive-by
>> comment.)
>>=20
>> IIUC, you are saying that the user is supposed to use the private data
>> of the parent device in fwctl callbacks. Let's not make this a design
>> choice please. Instead, allow the user pass in separate private data for
>> the fwctl device as well.
>>=20
>> This serves the purpose of clear ownership and lifetime of the data.
>> E.g. the fwctl device does not necessarily exist as long as the parent
>> device is bound.
>>=20
>> It is a good thing if driver authors are forced to take a decision about
>> which object owns the data and what's the scope of the data.
>
> I wrote a version like this before. My initial concern of mixing Rust
> objects together with C objecs within C-allocated memory was about
> potential memory alignment issues when rust side doing CAST on the memory=
.
>
> I agree that providing a way to attach private data directly to the
> fwctl_device also has quite some benetifs.
>
> IMO, if we go this way, the private data from rust side needs to have
> #[repr(C)] to address the above issue all the time?

No that's not necessary. Please have a look at what I did in drm::Device::n=
ew()
[1], this should be the exact same case.

[1] https://rust.docs.kernel.org/src/kernel/drm/device.rs.html#98
