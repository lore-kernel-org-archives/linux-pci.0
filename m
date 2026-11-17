Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925382;
	b=1XX0audf3y7Jm24MY+UD7KKOB+7rDecau6f7ota2lHt8+MmiogCnC5kib5+yApKkTSjs
	 4csUApNvEfdZ+Mq8sAIFZrLu+HcqtWu5hCAgJOhnePT5ddIJhu/lNKV84/d78uzUOPjW3
	 rPhbkmH5DHMwyyYhz7tl250sWaipIDQX+enj9w5vv+lsLZ6JqXP/b0nVWxU+WifDO7gHj
	 JKp9iQ7b97zNKyGo2zYef2tPJiDvsVrhXAW7uPUmk3YmkaBPS6yKaHCas9i0k/2ZutrhW
	 C5Ra2STtD9LqpIaufXjE6qfZcV7ytpVNhi+LxRQXIOdGh7vaXkdjcOu7RRg3BTPqnAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oeur+0Vi+mo77Pv6jE2wIcipv0pUM1dghSZjw2PMYYw=;
	b=LeIp5a/1s8olEfyBEEc/bN68X+YA/rTkujBydzziv12IAK69hNhlrwA7q9VOXNau7SOc
	 E17Uv71KTObOaQ0Aw+Gauj4gHEEYL/a+FBsFyadl1GpqeYp6nAR5CkYzB0/a0aSF18Fjk
	 oaTxVTDliNQrA6FVr5G6CMfSd7MlsAvGtYCCsDDvJbA9VO47Cdg4+RWOwZtF2icl17cQu
	 TH264LW8HyKeOqc5HY8cztHYRpqKgR5DR2yEbhdY7HLJ2yYzylzWUex6BExVuJH7FYa6a
	 3v7/hMpH3hQElvCeqyDC3OyD/G6ZwIaJ7aWErLBF1Bc0APD+FlhDr9IGJOTP14WXnXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmSwMVes;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F4606A88D;
	Tue, 17 Nov 2026 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmSwMVes
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34361F000C7;
	Tue, 17 Nov 2026 14:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925382;
	bh=oeur+0Vi+mo77Pv6jE2wIcipv0pUM1dghSZjw2PMYYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PmSwMVesHqqUULCJj063PS8b7K2N/iXhJioaZ2RWsr0wP3yjWX6I/gjqdlVRgzI55
	 oocHUjzn/WRkbS4qBnOwclv/5NY+MvdEFM2B59ieZNVk1Xu+7KRW9OB67guy8EKN6b
	 w91LvUrcajvjhtimZLP01f4axTXpLemHlt60coNulGpbTGgN7pz0XFzPlu+gs4cewc
	 EJg88kDzZwGSpJBeNJxO4nxtQIjbTCSKQfBfRO3N4nk0sMBwTnGpFEJNrGh9ZGiere
	 ccRiBspM7oKh4DpBiMnc+dytalrnNqNPBIXD7NWAwvyTP0B2c3x3QEPNNO3F6DdGSm
	 Ix4N7nteV9j9Q==
Message-ID: <sashiko-outbox-218956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 4/5] rust: rename `AlwaysRefCounted` to `RefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261116-unique-ref-v22-4-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
 <20261116-unique-ref-v22-4-12029383206d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:23:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Oliver Mangold <oliver.mangold@pm.me>
>=20
> There are types where it may both be reference counted in some cases and
> owned in others. For such types, obtaining an `ARef<T>` from a `&T` may be
> unsound, as it allows creation of an `ARef<T>` from a `&Owned<T>`.
>=20
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the `&T` -> `ARef<T>`
> conversion is sound for the type. A type that implements `Ownable` may
> only implement the marker trait if it allows an `ARef<T>` to exist
> together with an `Owned<T>`.
>=20
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message, rebased on v7.4-rc2, converted new
>   implementers, relaxed the `ForeignOwnable` bound for `ARef<T>`, updated
>   safety comments. ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-unique-ref=
-v22-0-12029383206d@kernel.org?part=3D4

