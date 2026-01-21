Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57FC30F52D;
	Wed, 21 Jan 2026 17:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015538; cv=none; b=Z6n+hh6Orb3x+uPwpbM37VWo+ThVhs7Ni/UZrPUYUk0YKDCt0ryIj6HxdXp6yt2TrQhqxPaUFHepUPot5IAe/SyqSB89PRVl4pm6zwn7Hl+DrJo03Ei3Uxx1pFeEstmytl/u/YCI9f8/RvgMEN/LF1MNgEneRamjJUetiHa9BAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015538; c=relaxed/simple;
	bh=Kq66lYhUFSGSwCbe4MOAfZi2HhiK08qOzc50vvo+Fic=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=KOJzElqyKlCBVxqwjyeCM8fsIo0W8fa73Usog+silhHwzJpJowOS4iiR4som2tQVUQN5XB3/OmlccRgAeCxtnCgg5/c56mOhMm7JEfogbC0knrBOz/Jko5w3z0eGNQ+OGDezEsbJDXilrFhuVJw06kR3RMXsbgYXe5FUxqWQmlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzimOC7b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzimOC7b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075A1C19424;
	Wed, 21 Jan 2026 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769015538;
	bh=Kq66lYhUFSGSwCbe4MOAfZi2HhiK08qOzc50vvo+Fic=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=RzimOC7btz0QxSV2ApZBMsKQ7VptAg4qCCU2StCDcTaibEuwjCdbFRKo8gdD92ak0
	 MZOVzYeW+1tVGHz0bBRd4gMlwdlSUiHj+PbjHVFjcUNv+Kv/w5Cgcyq0rIb/5JqetS
	 DeC8kBSf1T6LOw0jsyW4/ZZ3hWTge+5BScEV7osKZGXk960QWaOtRmC2Jtu6o7Oczs
	 ZfWhyzb8nvjk/COZKaTaYBB6hvA9Cl4aaTz6aCCEGVC+VXZ1fhd8vp61SdVJJcKM5J
	 qXDtYHyovI0c4ZgTormZsH3O9zpouAfqxelXWE59Cld/Yvf8GsFcosgk9AiF3lWMgs
	 9jGac/sBcJTcA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 18:12:11 +0100
Message-Id: <DFUFO3WUQL1K.3JH3SS0J1Y0CQ@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 4/5] rust: pci: add config space read/write support
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <aliceryhl@google.com>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <daniel.almeida@collabora.com>
References: <20260121142355.4761-1-zhiw@nvidia.com>
 <20260121142355.4761-5-zhiw@nvidia.com>
 <DFUDN05YDH4W.1VXNXWWZST0C6@garyguo.net>
In-Reply-To: <DFUDN05YDH4W.1VXNXWWZST0C6@garyguo.net>

On Wed Jan 21, 2026 at 4:36 PM CET, Gary Guo wrote:
>> +/// The PCI configuration space of a device.
>> +///
>> +/// Provides typed read and write accessors for configuration registers
>> +/// using the standard `pci_read_config_*` and `pci_write_config_*` hel=
pers.
>> +///
>> +/// The generic const parameter `SIZE` can be used to indicate the
>> +/// maximum size of the configuration space (e.g. `ConfigSpaceSize::Nor=
mal`
>> +/// or `ConfigSpaceSize::Extended`).
>> +pub struct ConfigSpace<'a, const SIZE: usize =3D { ConfigSpaceSize::Ext=
ended as usize }> {
>
> This is quite long to write. Given that it'll either be normal or extende=
d, can
> we just have two marker types instead? So you have
>
>     ConfigSpace<Normal> and ConfigSpace<Extended>

I think in practice users don't have the need to write it anyways. You'd ac=
cess
the config space with either

	let config =3D pdev.config_space()?;

or

	let config =3D pdev.config_space_extended()?;

i.e. there is no need to store an instance of the struct anywhere.

Should it turn out that we do need it for some reason in the future we can =
do
this as follow-up, I think.
