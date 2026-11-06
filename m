Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965422;
	b=QsnRe5uN+8KqFlJyGUiUmdjLNiNm9G5vjzTDukMoYzkM/LpcEPAFrU0oaeDaejsxbwVv
	 R9+hG9S2ppFh0BIh3oArnc7gACMKwLLH7Z4ijE4q4NTDIg5TMIc905WVyZcoI+WVjos6+
	 soJv8WReLG+dKzN2b1CyKR/AklfrcGpR0MbXMbeVhW2UY43o8h55SHe+BEMyLbTEVZbOV
	 8MCgRSeuh9Jssw/QPAiBO4hjGAJqAzutZ4TnS29gS1nkZnlZJzX9TiDY73jQxr4fMlfwO
	 nla0hjGq6O48CByqK3lQ9JKUXD7zdJEoTJxTKKAeDMqGGUdMNnu4GNhwiJs2T1jokaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965422;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I6m7O+iJAcBZ54oHJYH7prm5dUdphwiF267dZ5JBzks=;
	b=HWI50HL6nti7NBTOcHHwpTXiK6CuFP9AAbUVrPXS0SGobcvBpvyQSf2jSBikHXD0rwmn
	 EPPGvbudYcnTqL5vp82W5FgibJmRn5ickT1KhMwqrGEHZFdaqnGA+/L5LmgU+5DP7qAWN
	 EVeO5+aS5eGfrznASk/bZ0IyywFBr/FdkUQmIOIkmJnomqUpND2XkvsqqfN5GNv6KAwv+
	 NcaLB3O7kDADdQeUlMUuIZYM1t6DcCEp1XP2HfPdiW1LGh5b/IhQqPcZvrxhUv4PAgUIn
	 WlywFZD2bwDkrb25RN16anI+foNuiJDc/P+X+LCP1XSLiDh+j0sFz0tYUzfHr+173lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxVN7Suc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859AD606D814;
	Fri,  6 Nov 2026 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxVN7Suc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A1A1F0089F;
	Fri,  6 Nov 2026 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965422;
	bh=I6m7O+iJAcBZ54oHJYH7prm5dUdphwiF267dZ5JBzks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fxVN7SucknJCWVrz0nzfT0zkb2qQ6aPhPDuB0VJObKpUP/tdo4TTZhDGlScBag4Jy
	 F2GDbB8T9zfvZni1GArfTRsvqJNg370yZEKFBWT7FHVZ3hWRRTxPzZdQHDdtdxYQWQ
	 myqfhR6sG7BKmCbhgbqowCw78X3+vJteXwa7L3QkRiGckG6ye1FqniaB3qKKs+UEI0
	 VrXH9QuWQfpmKgmc9Kb9MNaJg7nv8mpq22SE54BOpZgM5mYqXvSXscGPlHHU6QGmQA
	 A6sSKIIf8+OKI7s4hEajLBsUym6Qlxlu8C/sFrVnmw9frSkR+53bPCOseXAvBrTBjB
	 3UpesACpS7kEw==
Message-ID: <sashiko-outbox-201339@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/17] PNP: Attach card devices through the driver core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-6-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-6-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:41 +0000
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
> Card device requests probe the selected link driver before driver core can
> perform admission and setup.
>=20
> Use device_driver_attach() for the normal binding transaction. Keep the
> card link owned by the enclosing card probe until the device is bound, so
> probe cleanup and debug removal cannot free a link still in use by that
> transaction.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D6

