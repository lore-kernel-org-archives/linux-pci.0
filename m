Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8011624C5;
	Tue, 17 Feb 2026 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771327030; cv=none; b=XiuZ4zO66URO1W+zCp+0Jdwn6BZ0T8RgNYM3uu4R+B0vqzSBeMgVKooJn3Y8y4lqQfl/JCZs3r6vJeumUqi4tajcfvg9vfIQJX3xQEJbztSuXf0jJtPl/XTzlJdqLl7pOI9JlAkKmH73X+FUGCyQJ++gc50Zq8VrCDohnt7SzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771327030; c=relaxed/simple;
	bh=pQndeUNi1RPWs3Ovo/nU1uCFM73MwnQAxzKGFPWN8uM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Uw0seyodw/cbuRFvtOZLeGpI4AbVTBUWH6DyGT4CtvzDGkSobtWzsqhJtIsS8RD2EAamAOnzgexGdwX1DKgv9cFdDZX1GpjFLJkel4W44cerIdTMom03YMFYAbMwpRj/EyF1tHhHbF0TJovO4bpYGNiy7AyekGy2mjYXI5ajrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRqNC8q8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRqNC8q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789F7C4CEF7;
	Tue, 17 Feb 2026 11:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771327029;
	bh=pQndeUNi1RPWs3Ovo/nU1uCFM73MwnQAxzKGFPWN8uM=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=mRqNC8q8KRMM3M526IOFFLIDo26icmJn8Fgr2iGjtzIHwlLJ5e24NU8YV2jotvJsL
	 8lcn/pe3ByAcvB05FuSw9BBjkpvh98LdCKQC4ufdhOWAvSMJSQ/9U/e9VfQjsJmeSK
	 fwQHmTPFpDDWlve6qLWcP1Ls+spyI2WZY1bzsInwWWjiEkHbyLpe3QPDaWXc+dKU9v
	 fhmIdtm+Mkxd380TTemJvrNv7oHilWB3wOvV/l5WGpYcZFvX06lNtL1BA2iPVcqWlo
	 uixA+OUd6My65epOLIs9gS+4Lj9apskowSDCwcZ/c3w1mhaYbFpTCy/X21ChUqzG7B
	 6a8nwxv1dPs6w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 12:17:05 +0100
Message-Id: <DGH70XNPF9FI.2BRM4I81T6XLQ@kernel.org>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
Cc: "Gary Guo" <gary@garyguo.net>, <lyude@redhat.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
 <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
 <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
 <DGGD4JTGJYXR.3THD2I3AA61PN@nvidia.com>
 <DGGDHY4582D1.1GZGZ7P98OKWO@kernel.org>
 <DGGF65JPF8S6.268LR7YDPTWMQ@nvidia.com>
 <DGGJSHVZB6U5.2V8OMF5N3KZNZ@kernel.org>
 <DGGUOQT5BJW2.14AK9GFZKC854@nvidia.com>
In-Reply-To: <DGGUOQT5BJW2.14AK9GFZKC854@nvidia.com>

On Tue Feb 17, 2026 at 2:36 AM CET, Alexandre Courbot wrote:
> Ah, I think I finally get it now. `Io` and `IoKnownSize` can piggyback
> on the `IoCapable` safety requirement, because all the unsafe code
> requires an `IoCapable` implementation anyway. I guess that's sound
> indeed.
>
> I don't think the same can apply to `io_read` and `io_write` though -
> `IoCapable` is public, and so anyone could call them with an arbitrary
> argument, e.g.
>
>    let mmio: &Mmio<0x100>;
>    ...
>    IoCapable::<u8>::io_read(mmio, usize::MAX);
>
> Here we have no way of making the callers enforce the internal safety
> requirement of these methods, thus we need to keep them unsafe.

Agreed.
