Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493829;
	b=bN4ZYkSfgVLMxcX+QhIz41l2AzFMOnUzQM4mPjGKBqHgYb/mJpHXcfIG5YV9BcD454mE
	 2k+eKICh72jhsQopJCYR52tpky00yc45SB8Td/AsDeSN9ILja+wrEr3hMxq7OyLkB9Lui
	 /izkxkqneK6gXcRlfm2HNQQOU4x17mpazKOGX3ImewaqGg3iy+V8aigFP+9AssWr5zsbn
	 GaRxMsyxRk8yk5yWKI5GRAQC9T9LJ87HZhzSHWiB/0Tq9ocawlMFAVJvSorxFhGW4Jx26
	 ckgs9O4QusY76qFYZrtlSKBFWuB0uqJlN1Tjq0vvMk4L7qS6/N7mrlME0uhyapprKvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LNEogz3icJuWNdYJTarNjgPtaTnRS3Q6Jn15TKFiXg4=;
	b=kbTJJ5eQ6tCuHv0YsSNHoB01sK2hr2NBemZjEmRfibrVds8HD6Z5uo2i0u2cLVz2jcII
	 v2wh0Ls/32SYf8ZRCKQffXcO1bViW1XGw6ryWOTr5Jt0xekTb86/dB7XeKMcdI4qrpHj6
	 YHrx6HLhHpom8MG3sHVvrzcXO9lKtz7L1ry6edoUAMWq63lyiWmRpTjCOrUCTYSPAFgmp
	 GCZJM+j3dms/MoFyN/3NLJzLKnb4phgfpnnh5UATepDUTtHXlJiyqG4zxAiDSMdHCELvu
	 pojJOyRTm60qWJ7oj5TTciECfrqyHQlY8v+3Tc5+SaVini7YN5ml9UHKLwXn5XzN7QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnVRLrAk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDF606A337
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AnVRLrAk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756EE1F00A06;
	Thu, 12 Nov 2026 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493828;
	bh=LNEogz3icJuWNdYJTarNjgPtaTnRS3Q6Jn15TKFiXg4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AnVRLrAk9+vRvzGLGeBrQ20/+C9Y8HVeNVu4Qw2mliOYyIIYc+ikD+fWB3YpqtHri
	 unV+DX19VyBqTGmysGS6yHPfH83qretug/CL5CgTvuNz9W9KlFmv7cgUN7/gSfWfbm
	 wnb+fKkBB9cO1c7DsGp7Kl8XIzNna2s9+Sh66QqOAIfZA+ajb2skjvWLsQ3pWbczO7
	 /yCPAIoDRToBaZjr1FsK/S3EqJ1jS5DjS9f86rA4egyotN5CDJ1JbO5JZ6QRDvFp2o
	 sAGaFQtubujlUKV8DVGgoR/iGGCHW50a8jgeuoQD/SBWqsNSEoXSndZ09xF3c7AMmN
	 I0rP2ORLAeKIg==
Message-ID: <sashiko-outbox-211326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 08/20] vfio/pci: Use access ops for hardware IRQ
 operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-9-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-9-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:30:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> IRQ queries and configuration can access PCI registers while recovery
> resets the device or restores its configuration.
> Use access ops when reading hardware IRQ counts and applying IRQ
> configuration. Continue to hold igate for configuration changes.
>=20
> Use separate SRCU read-side sections for the count query and the
> configuration change so copies to and from userspace stay outside SRCU.
> ERR and REQ operations do not touch hardware and remain available while
> access is blocked.
>=20
> IRQ teardown flushes the global virqfd workqueue. Waiting for an IRQ
> operation to finish therefore also waits for that flush, including work
> for other devices.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D8

