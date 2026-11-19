Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116589;
	b=w1LF2SP/6qw3LX77amK1IyhvHvRmNGveavfI9hQDmEGpr+eE0OZ/0QKV6t7aXwiYltq+
	 ZxS9YTGBH1L7cINaWkgWEQ2znCQUgnL62g7gKKnqs5sJlpsUGcRkWdJlcZgElUnBXmBrS
	 LAIEzFLjvGaQ1hnFOmCsfLSuTmuKn07n1YpqYocdW7WcQvLhS0MRcexOu2TZwhG37GZBS
	 rWo1kVSmMQlMdqmRCP0PCyulpHw4oxsEWQKSa3ED3EEtmBU2//K2jYyLyTg0ADNFlEJ2d
	 75cr5KjFID2xi1Q9Bm3/Ror/BI8DhFzpV82UNfS/FYMKAUUfxUsYEDWEmcX/LIJT4Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116589;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vY1XFR6Bnvhly5k0xRysu2RE51L7gKk5Hs6/xa+DjdM=;
	b=APSO5xhyyExyhFgIvnptYKQFTX5MEmigZYLq9aH+q7jG23AqkqnlN+AkL588C5cLYmr8
	 /e5clFclApXq+wj62C5UWlh4VejR3ZW2vXMQSLvbm81yRO6CfYAJ7G4wzCzcEM+G7xPrs
	 VUBYkNkJYWB3CZftlNp6EhCJrJC6w/JD4uMZ9UFH1yiJ8f6KJBWxwfiIcimAE+fV9Lbjr
	 toUXMXUcksPL+sTVnzQw3bT2+DPVNVLNrx/zH24SpoNMp+Pu3XkVwo0GOW6ypaReS9yus
	 X9RmczXQyIlKAdzJgJqp6cladx9TgSlwZQ2ecC7kx9oKDXczWCBMKt6gbDueKfDlrJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhtjbO+4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718960A3807;
	Thu, 19 Nov 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhtjbO+4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933F01F000C6;
	Thu, 19 Nov 2026 19:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116588;
	bh=vY1XFR6Bnvhly5k0xRysu2RE51L7gKk5Hs6/xa+DjdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EhtjbO+4DO22H7f20JFJbBJx/0CRtlcr5V8J2QARKwlFBEFHSqtAfkmnQxap8FazR
	 T3iRGmlhffRSA5AN+qunVGaNJsMEFNIJpt9lr8HkDYS7gAT9bW4jJPQR0n2etAAKnt
	 fTPgKGGiiKyf25FADhW/+lhE0lgeVvB4VYQYq6bfUAEJUJIYV2nA4nXOQx0Fp4mi9F
	 BT5cQ5lO79AmjTt6Dfm9FI/JjJX41v/oSE4xYumcQroaF1PbOROzSQgO0zFuX9PLyk
	 d+yq3j152t+g1vu3WEkPliKCF/Yw8omNJtW9+W6fFBw9mSkot49q7B4Fq5Lokw0hNA
	 miwu6JNP+V4VQ==
Message-ID: <sashiko-outbox-223915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 29/31] USB: Retain the result of configuration
 requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-29-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-29-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The generic USB device driver can bind successfully even when setting its
> configuration fails. Authorization that attaches this driver therefore
> cannot use the attachment result to report configuration errors or decide
> whether setup can be retried.
>=20
> Retain the last configuration result for callers holding the device lock.
> Keep driver binding successful so userspace can recover by selecting
> another configuration.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D29

