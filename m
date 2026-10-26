Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020522;
	b=UFUFxH1Jm8Vk/TyVJWECAaop5moS8+NLEJONci6ehV3QMgnmihZTZUcFrRZiBZaTuv6t
	 2COGWGVP6WGtj2coHTjsTWc/CK1ggCejrJvaxbJz+w9VeRRJ1jjpUXVrafWeasuav6blk
	 iX5m9NICQMH+r8+vXFlDwGpc9Mittn0vV5SIs8WuHbGLeHTr/CY5G6kraLphTc3sQ2igD
	 NMKhLVErxDMFeopIZNdnjPYWo/skEYQerZwOKUWUwz0pDXf2DV70fXXEMehdJoCxZl5qA
	 pwHNHZ8G1jOQbsUvGlEfrZzwk1xTWge42C/x36I14WzPenmkaTnRKrrA03m/m5o+MwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020522;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UlRSh5ILEu98WP36IAmHnOFj2HwqzFDrzh4GjTaXLIA=;
	b=xNHweJQBEPYxmUnhEdN7GT2vHYv+5geuLEMV4qTxwdAZ5TcP2qPFWRSTFyW3JrBZSZeu
	 ROYui4AtuLABh7NszmTL22i3v+DQYMof03DJG0w8MIxKTRThJ9qnhlPAmo9Vp8VKYbdq5
	 rOHzK74LDq2ts4X6Vdzf0o0zVsw//p7jxTtAg9OA5W0a9XZqeABmOR9A2XR1yl/aK8n9U
	 96/HuIqHatRDbaNHyIXiE9BpPiwf78b8j8azG1SvWSgbxrx762CYeglcGXEg7VGBw2NjX
	 QZ5oqpyuAmEkRC/3sURsnNJXhyt1hVRqEcrEJ8x/rmoWRjj2Iz+BXhfXgeSi0WElcbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JINpV/Ym";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0656606A325;
	Mon, 26 Oct 2026 13:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JINpV/Ym
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E924C1F031E1;
	Mon, 26 Oct 2026 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020522;
	bh=UlRSh5ILEu98WP36IAmHnOFj2HwqzFDrzh4GjTaXLIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JINpV/YmZhJIlUbh/BP/89ImfonlX8v6KwLK/mjR+NdlPW2SpoLL6UtkTTBPN9lrR
	 o4Ea9/f6rbMn2Eh/w4ZBpcvm9vRxkc0MV7IE/d5Xdx368KUVswRh02/jZVrnofFEq9
	 lMOf43k4LjB8+8T1WNeu28gFOdRmB5kXGNgXQCKDNNeR1jfpWg3qMbYPRGb3stCOPf
	 a38JlMoToqe7IgWoC5k7YkQtv6eUItGDOWL2BhFRxaAe9uKgPKIEc5G8GFMZ5qENEB
	 3ApaBFJBCTa2Rkhh5bBUqEYHXXglpVK8vUNq4dPLS3637uDumNWxC58LmYrwYAlN70
	 BOj5ydY0nVyyw==
Message-ID: <sashiko-outbox-185294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/12] treewide: convert rdmsrq() from a macro to an
 inline function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>, linux-perf-users@vger.kernel.org, virtualization@lists.linux.dev, linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026130223.773129-12-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
 <20261026130223.773129-12-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:15:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Today rdmsrq() is a macro using its second parameter as the target for
> storing the read MSR value.
>=20
> Convert rdmsrq() to an inline function returning the MSR value.
>=20
> The users have been converted using the following semantic patch:
>=20
>   // Options: --include-headers
>=20
>   virtual patch
>   virtual report
>=20
>   @@
>   expression msr, val;
>   @@
>   (
>   - rdmsrq(msr,val)
>   + val =3D rdmsrq(msr)
>   )
>=20
> Signed-off-by: Juergen Gross <jgross@suse.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026130223.7731=
29-1-jgross@suse.com?part=3D11

