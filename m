Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982403;
	b=x8qCJzmrSpCGzwZIkJ4gpB1kOz5EaxRqIZbPOdNOC4M7r/Q709ZTyYMVZ4pJnU6SKXkE
	 NUz3WN+poIyxcG92yfSsPCSW/yv+FNi00gThLVuumbOCD5HTHxE7gLSQ68ME5tXYnxfvW
	 /jNoIVU3O+GNcH12OxX0/pd50k7MfGPVbOR5wORye50hB6p/0GPjcbNIceOvBFkfbsHQd
	 1Q1eusp352WMpjAC1BEUDga/7CW6tjcWKiMfFF7gcLgevbe3No666PZkQzGgYgwj2QGHt
	 cxPbciWFeGwwH5DupOLlFswmn7b6D83YQzWQWburHBDqexYKFgyuBw8a5RaV1qYEcLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bpoJjJT8YQ07zjChIIdrQQHrlHS07d5S3GpxvWnjQhg=;
	b=pHjiYsldJBPKud1Dz1BQ1j3M+N4sqjde8DzxiJirFW0mY9L2kH8NiAghhAQ/cdGvpCVr
	 qWH5DEuANIOXbEeHCBLPudIIwSnFYzWsEt3zlKCO77nZlzR7qk5S6FGzfFjZuUWp8S/d1
	 xdtzcE4BOTaFRd1dBT0r2z98jmbVjWG0EB8931ZbE/FOGTlEUEt/v/+drDxn3s4usXJC2
	 2/oLlG6VyYgOzpLp7LZH/qRdW57rZaMVOgzRRjS30HU9KTFjkScK2dUQckgCf52+zidKm
	 Gq3i/h7vhLnQUp2gflwig05hw6A73nRmAUE8SN5g0sEjQgwaGUjEc8W+39nlRzlCn+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQ6Sp1EQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17443606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQ6Sp1EQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF0A1F0089F;
	Fri,  6 Nov 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982402;
	bh=bpoJjJT8YQ07zjChIIdrQQHrlHS07d5S3GpxvWnjQhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQ6Sp1EQcVA3NlwVbpZuh444h+zSbt5Po1jSIGpL8zksFtFVh6kxWzYwHK/NlSBrQ
	 QnPOCaYKW3TkPvJkXbwYX1nT1rq39nqjhp3K9eZLufqJ5+pNcW58dYQcBiOTW2xkv4
	 nzSgDjvIzHwb0YCAfkQcOBzhuie8rzc6eJxISiI2gDSrmlOynLzB3vW0TjRzuiMSG8
	 cWGehvIN9/QN356BEfZscoVY+0S4KqoggTzvDHiHa3DA5tkNZwmd835DaWYgElcmDg
	 uOXnp8T/oajlJXu5bTQuArqj5WvD8LmWUeMsq+TrcjHxjsiL6Z3s31e97M/GAumRtW
	 0YdcNUZucSVIg==
Message-ID: <sashiko-outbox-201805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/7] PCI: vmd: Add vmd_bus_enumeration() helper
 function
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-2-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-2-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:26:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the vmd bus enumeration code to a new helper vmd_bus_enumeration().
> No functional changes.
>=20
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Asutosh Pathak <asutosh.pathak@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D1

