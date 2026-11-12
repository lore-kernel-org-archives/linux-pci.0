Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794445737;
	b=UumrypJ+Zd/7MVIewmHt5zb0VR7mslNaiKJ5FMY5iToNZhtxBV/xdJiD40nKjiKbtoWI
	 fUZHF8nWTU71jdzoDVG3Nhigf0ZlUyHVu96mTj/thpN/nK8bPNI2TFdrXDpH0jsncx9Vl
	 +9mTOFZmgzujePAZpgxp9/K3d9oIMIYWsnhLBfsAXLxcCyszllvV7zHyUEvFNaTcD3q3a
	 Bk9HdW3AhvzGXhdUXNZs3eC5yZC9OBLmR/LRuY+aB3Ihp18wLdrfWed7MFqF+RP8x8m6t
	 x/LGe8o3IZnkSFNIc3m4O2j9bhhNLqDlmLVpy9G6mGd/sBTKShVYdpvHDT7pYsdjHBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794445737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XbyeFzSmyG38QykMDvbTqGgQBC4aNGfv12zQa7/Ahtc=;
	b=InNJywdqF1ee6LEUz1Yo4VlORo8GSorz1xKwY/rZpap+0O5oynYo5MWcqzkXo2USnYqr
	 Y6TTPpEzXAaoWS6GWEfBvXNa67y0RwJT9fzJL41LIAq7F2H8J914oJhO4WfjkQeZ6BriV
	 rsazbqO1GvVrMwcngNHt22bQIeYdBckgHWBDPLR54FkeXZifTOrw7jPLj+mSr1dH73E0T
	 SIBNuoT96Rj3Go3zTEruxoN8Sqh4Ff2MDkAHqamnwjXrOYlynDVXD5w+v3vPIhkHhOX3S
	 xtpfTYKETgvl+uE8BKOh6iQT5G6MzK0u8qMY8chWia26v2IpDfvV+MWMIBuUbaTgLMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD7g9w79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452FB606A321;
	Thu, 12 Nov 2026 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD7g9w79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14F61F00A05;
	Thu, 12 Nov 2026 01:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794445736;
	bh=XbyeFzSmyG38QykMDvbTqGgQBC4aNGfv12zQa7/Ahtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nD7g9w79dU5XlgY5UhaPhgN3VfRoq5DZZcjkt2lOrLf4O1184GsvMLPMbrsP6uDKU
	 BHckZllzLpldB9AUrJZ6e1eRWFKzSvzHG0vn4K4sNdywWwOfaq6lK7sWlicHUKKEcM
	 aFXO5rhmyNOa1qNQvhWXuJ5dabm5iBFm0vKsx41W6ZoMZQdRH6ZvcZbtb9oSFWxJ9c
	 Adn0t6VJcRbZGaRRhQxMRONSf4f3KlGFy3hNaaUdtOBwntKramwwTjTNwgHI54rdFT
	 htGUIc+RHiqZqhtftjld+5tVNxjt4mrw2tZUnNOLx/a6rom03PziMpb9TeXPPQ1m0C
	 uvai41XOF94Mg==
Message-ID: <sashiko-outbox-210041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] rust: driver: document teardown through destructors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261112005455.1224352-8-dakr@kernel.org>
References: <20261112005455.1224352-1-dakr@kernel.org>
 <20261112005455.1224352-8-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 01:08:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The bus driver traits no longer provide an unbind() callback. Remove it
> from the example driver trait and describe how the generic registration
> infrastructure drops driver data during unbind cleanup.
>=20
> Document that device teardown belongs in Drop or PinnedDrop, where the
> bound device reference and device resources remain accessible.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112005455.1224=
352-1-dakr@kernel.org?part=3D7

