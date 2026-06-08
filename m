Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEA397339;
	Mon,  8 Jun 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953768; cv=none; b=ACFzHmRgvNqMoGtrfzgoDeVXNnpc5wd1j8CWleVfPyqEXs64cPpq+VBz3rxwxpc4c4LQVeqxPd5LDfbPTMgghPxyRgcDPQ/QhdMrkNiIrUupyJncB/vpXRztbDc69P8I0iWg8PvMne/XYBumiSXw31qhpmh+dNpgf8pyjNTXTcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953768; c=relaxed/simple;
	bh=4RtwHfYlHeDhKbWi6x+AQkdXL77FhqQ4pcTeaQPie94=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=MMhPj3i82NS6keDDEobrWGBMC9hagsB107y+58+u/1k3almeu9vnC5fJ0jv9MdvkSn19sc7igRM4PI1fPkPr5buHbQFPgX58DHsUWqVoYDpWcaJBSaarNSaNgcu46ux/wIDRyqOqpTuyOeJR8Wr8iO3G56lBPtG6fNkVonh6qTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKRJp8b2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKRJp8b2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED631F00893;
	Mon,  8 Jun 2026 21:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780953767;
	bh=EfXp7JFa1R9BKRZHoQ67nu1SOmfqiextSFNLvVPjdPw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=fKRJp8b2lDPKEQ0P7arJaQthfdjff7/CLhBnyRYh7Mh7c8rfX/VweH0Ew0mGY1kIR
	 yt+70EIPgseJyASFq0Eb8GeOpuWh0DPbTWGBRPI8UxnHfULw3rvGVcsA/irV8A013G
	 IrberBpnJqnRCvp04DfjZSZ9LjkjMx+xd7L5Enpcd51dw5msdChsqU3ewzRlEAdNdk
	 a7doGJS8dZopmfYQoG8cPUgBbFxtd1GGnDvVMyhGWNu4L6YYdJUvFUR06PNYXelahw
	 KP5MOmSH+vMC96ZcOX8u3IK75RS7Nst26rCwGmVW3dNTUhc3G5eBdv1e/om9KTd2b+
	 9UAgvbNxSt+cg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 23:22:40 +0200
Message-Id: <DJ3ZF2YU9HRH.1X00QSPYJOA8G@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "Laura Nao"
 <laura.nao@collabora.com>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 00/19] rust: I/O type generalization and projection
References: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>
In-Reply-To: <20260608-io_projection-v3-0-c5cde13a5ec4@garyguo.net>

On Mon Jun 8, 2026 at 9:58 PM CEST, Gary Guo wrote:
> This series present a major rework of I/O types, as a summary:
>
> - Make I/O regions typed. The existing untyped region still exists
>   with a dynamically sized `Region` type.
>
> - Create I/O view types to represent subregion of a full I/O region mappe=
d.
>   A projection macro is added to allow safely create such subviews.
>
> - Split I/O traits, make I/O views play a central role, avoid
>   duplicate monomorphization and less `unsafe` code.
>
> - Add a `SysMem` backend, and make `Coherent` implement `Io`.
>
> - Add copying methods (memcpy_{from,to}io and friends).

Great work, Gary! I very much like how the implementation turns out overall
(will go over the details in the next days).

FYI, once ready I will merge this with a "Merge patch series" merge commit =
to
retain the cover letter as I did with the driver lifetime series previously=
.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/288089-General/t=
opic/Generic.20I.2FO.20backends/near/571198078

(Either on the relevant patches or just the cover letter, both is fine with=
 me.)
