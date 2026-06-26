Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A842D5C7A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485816; cv=none; b=TCnh3RsvpFSbUTlvwH7UnJ6LuBP20dhqBq8mKxHMcT1CKkPxeHE+FiOd1zu8RyxYS0QMoTCNvkYpcheioOBGF4M6lta3cgYJNK7T5zNqV6RMH3a+KgF8pSG4rEyQ2hpqFEGev8lGLulZALRKKt+2eU+VPuf/DTRcXgTNqGjzSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485816; c=relaxed/simple;
	bh=XJ0lsQql4atkNgytuLa1UK+zMgT0gow2d0m8x5D8KTI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nj5wjrIFR0ZaPrPz0y5FxEYt3Ts1k9Em3uu2zNXquCmOisRg4daH63uc1Do40xi8+9BFwejeLAwfvdOdkv3s3ziZYs6p1pdOzplHM3oGLiqkobFi4ZrNfw3ci6VjIFCQVc+SJkAxKqWrKcp/9DpWCpUlB8HEv/Z1jstfrJ358+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7nJZh8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7nJZh8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC941F000E9;
	Fri, 26 Jun 2026 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782485815;
	bh=XJ0lsQql4atkNgytuLa1UK+zMgT0gow2d0m8x5D8KTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7nJZh8QpvuVA9wNci9KlauKmNtfcTkwKdsDFnnkz8yUyOZoDowg1Zon+g+LA14t3
	 izCPp4h1tU4hDm/aaa1rr5hf8kJ0/TBV68YT0HjhzFxhPDXma1nToH/gxLbHQeX/hQ
	 tb2OZDbCKaDVJUEJsnghoEt46OfnONv5gISCRIJmfc55/PsVauN29pfi0Y0wD8C0kO
	 N/SGxDVeTHPhQ82lWR3Y6UHM+LVZv1scFQYeQIHg9rVJy6th5sJj1u9O/iTXt0n97J
	 iK5Sa9/y/JR3qBKuo4OPRruX2Lrk4RgUZoXr9730AovgJK46LlgU0wnL5ThA0fsfrD
	 VLeMwJxssHM2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/20] rust: io: move `Io` methods to extension trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:56:54 +0000
Message-Id: <20260626145654.BFC941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Io` trait now has a single required methods with many more provided
> methods. Provided methods may want to rely on their implementations to not
> be arbitrarily overridden by implementers for correctness or soundness.
>=20
> Thus, extract these methods to a new trait and provide a blanket
> implementation. This pattern is used extensively in userspace Rust
> libraries e.g. `tokio` where `AsyncRead` has minimum methods and
> `AsyncReadExt` is what users mostly interact with.
>=20
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>=20
> A `size` method is added as an example of methods that users should not
> override.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D12

