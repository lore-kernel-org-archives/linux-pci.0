Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761291;
	b=fxaqNfZLBKQxapCGfViSxa2POYtUK8tT4wk+mqMuVOyGI3r3DDy7RuaP6yp1LerhyimV
	 9lE/wdfBF7idRRWnMNVmW5e6uenHO3TmLjOndMNLMJX+M3ciaxq+kOa2L7UMDb16WSz+x
	 Bi+6arASwdN4696lJgnFqI49V0MFA3lS/4/rYZl9ZZhWO4r4PRmDBPvVVJXRkh8FDcMLn
	 fBkn5w80OzkieuKJkvXioeXU6txYSqKZNUk6MT7dv4QXhGOGGWHvxbzKucpZyTGxEoOhG
	 z7XfschSdLM/eB0GcJVg2Q869I2DjqNXZ2D+bii9IB++LyJ3gvxKjcIWYZ81iIETgOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761291;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pY2ISYcYmWFNpTE435F+SG20s6XWgNHJkpxUX2gD2rk=;
	b=DA5ESqrjKBde3lMW+xnf8GS7lsbw34Or6670TCG2UT9ySTimqW9Mk4tjPJGCVuZT4DGN
	 pn0NqiZgDxSLqrsKpPnDhbf3rC+j5bYzk3DSX3YbuFNVox6q32yU4DUjODRT+2REqEIg3
	 yZFGS7aGvHunrm/CD9hfRERs40oIrYLmS/miHKbqhToIYwA+9cpuYZuXiXgzAo+Ydvimj
	 DJimndu4dtHaW4k+lk14GInfTOfAXwi2R/nXrT+yaMsjc81ZQhL4ZvgvoA9SeBkOl7EUS
	 PH7/awG1HOEHDpXybhJF7Oympsf2tqCX/2PoTTaewuafgkgmRX0iaVK8gIdz4GNUi7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+ONAvop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37584606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+ONAvop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB3C1F00A02;
	Wed,  4 Nov 2026 03:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761291;
	bh=pY2ISYcYmWFNpTE435F+SG20s6XWgNHJkpxUX2gD2rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+ONAvopX4nGm+UkKkMt6/pe9m4Yh3ye6a0REqNkBFDFsMhA/V61Q17rKQKcTx9Rk
	 zOdhz/Yvycos1czyxEvs6AxJxA2qYrjQlS4aWbq+biJt2ZtrGqpLFsZnMSELKn3i0e
	 mDSFxQPX5irudPXEoeAzdEOD2BZWkdZ4GVgsv5Q7MCy5L193T3mgoSHeb6kVXMvNuP
	 MWpCAnvXLXr6EmPvUG0e9uPE298L7dpCcIfqMofpsXwKmPSyswvaU7VlL0olWck1jf
	 Axk+m6O0H5J5ePbeJuAhxwjjqb6cFrCd99+EwzsfR2oC3OyvDiTw7O4s8TEKB97oGg
	 heZQiVCw0Qbqg==
Message-ID: <sashiko-outbox-196560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/25] dmaengine: sdxi: Add context submission helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-18-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-18-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:01:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Add sdxi_cxt_submit() to consolidate optional fence and completion-status
> block setup, valid-bit publication, and doorbell ringing. An optional
> struct sdxi_completion input identifies storage already claimed and
> initialized by the caller.
>=20
> Introduce generic descriptor helpers for attaching completion storage,
> setting completion-status mode, fencing, and publishing the valid bit.
> Publishing orders prior descriptor writes before transferring ownership
> to hardware; the helpers warn if a caller attempts to modify an already
> valid descriptor.
>=20
> Provide sdxi_cxt_attach_cst() for attaching completion storage without
> publishing the descriptor, and sdxi_cxt_kick() for ringing a context
> doorbell.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D18

