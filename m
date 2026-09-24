Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E24A262D;
	Thu, 24 Sep 2026 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263754; cv=none; b=PvQRihRAz46u3VOk4xV+Woa2cXWxfih8wU5UvaKY6rQNDsZ6gcwe9gQNSMblYojGNZ+9Go84n/w4pQCFA1rkCTmJJE/CA51/6/PgApvH2YG7VdMLampfkXP4k6+9cQKD6K9opv0Z3LUWTpM14UYExbFjDAa8sugAoOYH49yyEVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263754; c=relaxed/simple;
	bh=6dB1XvpVZGZIlfTCt0YLDR6E/j/zO2XIZwuSGb9tGGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Av8kxnc15rYCpAoiVsznrw3B0AyxLPn/NKkoBf5HT7wAtqxyLqoHnGaMdtyxgcqmhPDBXFlNKov73zfHPWWNOTRloXjGDJjO1dQoBb8/DPPIfajLubNi/N9h4kOEesIcrgDgxhvvrdHrrBGnjOM22ETeON8VLV/LfqkaTzUOOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgXR2NiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgXR2NiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C751F000FF;
	Thu, 24 Sep 2026 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790263752;
	bh=AGFDYIYEQisoikw+fhq96SX8EJLCskHJldNScxTRxAw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgXR2NiVBVY261qR34oungGAb01AQ4QIxvBxzs4uEsJaU6PZZnjW2b3C2uufxEyqU
	 OlOg9jMJaNF6sQQqI/nBTzPNcy/5DjEBH7I7B2neosX86PRmWFyNUY+b9LUMQAn13T
	 kfaTzDq2lzAxZT45EcvQBRwZjy0zJwZrrcGrirqO9z+9EAaxAxF1chQs8GvTh86ti9
	 q8mDcIVZ3QdP/qKETcHeBetnHR4YhkZzKVld2BWq1Bvo0n9U5i6rxEde5cge9n5LQE
	 cLDe7RGkiNjaWHiKqA9nDSgKGhJ5lQRKFRlh/X73ZQlkaffCvrIBCqwPBv07p+EWTs
	 sKzDOKgM4Y2wQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/9] dma-buf: Provide dma_buf_set_name()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-4-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-4-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:29:12 +0000
Message-Id: <20260924152912.90C751F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Allow exporters to set the name of buffers, during export or for
> subsequent updates.  This is useful to express buffer-specific debug
> information, indicate state particular to the exporter's usage, etc.
> Only exporters and userspace are expected to set names; it isn't
> sensible for importers to do it.
>=20
> Originally, the static dma_buf_set_name() was used for
> DMA_BUF_SET_NAME ioctls, taking a __user string parameter.  Export
> this function as a generic set-name helper, taking a kernel-allocated
> string.  The SET_NAME ioctls now locally duplicate the __user string,
> and use the new function to set the name.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D3

