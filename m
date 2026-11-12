Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494146;
	b=IhXnPCJbJRzQOLophgpF6xFn8fbTElMa1mDfMsV59ytvut7ARH/60Z0SwsPmtVS4iYpP
	 uhOBsK6JqJcEaWiHtUorK6TUfHnobCiFb1wB8s11YpBRRMVNEVWo9QkKiFmo77Glq2zLR
	 Rm7gbhOb9w6XYvInNYxZCSwSivY1RU0aiJK8qZ1Raa3WbzEUvRRfti/cAqDSTzRYnt/H2
	 XR2vhykHabNjsD+l1ef0J5c1ImtR1lr1G0R6vLAPDylKTp4nm3DWSkIM6N0uZl2wsI4tm
	 Bo8iop8xWe+t1nKG82AtMa3aJAK3LvTMGMCzplm6Wv84cVcNhBF56Tt3adWX+cdEO6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494146;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gNeCJvHueR42l1eiczFABuLhjkaap5Rsx+KOCU1psU0=;
	b=FfbOu0y6zwGveFM2isjsgS7sxF2m5HfyKF9t6ctYSiyQxr0o+ophgohTwfnjPy3cD2eR
	 RpFP9T+vPHAxQjIJ8QlPj3y4J6zFik7LPa+rNnEGz+DHhWGohWduP7NEi4IdT49z4XOPD
	 VL2ACal8MhiSpqMUUBsKlvvxwc6g0FfWTi9WI8RgTKX8FCvAs7NFIczQHgjuFXmOGtScu
	 Bjs5j0SDjFNNULr0pGu501D40sJRdBTANXMXncKa4CgF8jQHoNB36CPPeHYR+lYVV6/cr
	 HKQ3ayYOOzxFTua02tUBZVbJ9aB4wzUbtaIWimkcbRGMANtMjYOQYbBN18OJGLIhnzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beapWkwI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F84606A32A
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beapWkwI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755FF1F00A05;
	Thu, 12 Nov 2026 14:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794494146;
	bh=gNeCJvHueR42l1eiczFABuLhjkaap5Rsx+KOCU1psU0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=beapWkwI62GxLdFBKZOhNYqiw9wazFH6LEYmLurWivevRrQ4WvjQACYdB5zMn7+Dw
	 1RcXglT2KFb3ymusU+xS5NjHgyzNRSeIEkiVABiRV8TBPawqAnGDxakWOTzoEwXZxH
	 nbd39Wn5nmePw7cXaMYljF4DaJaNiKylsLHHw6vui8oNKidgUkD1XdOKDwWd1zepKL
	 KDTq3uZ293pQRtEErZa/U4lQoKkYbK419QpOGD/jxjJ5MHKh6WvOiukodNthr/LhNI
	 CaSmv75rmzjTJY/pvgd/344dGheQXqYPsBXPxI1rHjm2Cjp9KV8Kmfyuprh4iUsqvL
	 ofx0o9xlo0R+w==
Message-ID: <sashiko-outbox-211349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 13/20] vfio/pci: Track PCI recovery state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-14-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:35:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI error recovery spans several callbacks. Add state to track its
> progress so later patches can keep access blocked until recovery
> succeeds and leave it blocked if recovery fails.
>=20
> Add recovery flags, a sequence counter and saved PCI_COMMAND state.
> Initialize per-open state during open and clear it on close. Keep host
> recovery state separate so close does not lose an ongoing recovery that
> must prevent reopening.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D13

