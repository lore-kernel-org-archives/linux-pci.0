Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182910;
	b=jUaAvxx7mrhBGn938H8s4vS1D25Xr55oEunV7IiixqnXjhzWm25jxVl0npqQ5W2MUk07
	 32wNxZhRnmNqIanJbhA5pJB0LYNuio56panJ9OLtuB/nOhmV2H2/jVghr2Mfb3DnHVMxM
	 JmpZcYA54WOl4L2ZxZ1S93xNaMkWK1Xyd9cIcC4JVsvru0Zgve8MpI0CwRe0pXgzKwQ7F
	 cPCIn+fB+iv0hNzdmXgHXP4//mXRjqY1fVsbOXC/0zps9+bcy5ZlTFad2fEH/RXiIoo+z
	 TPtGqm6IGo5qUd0mKi6RtRgTfOx/kfumWuC+jkekQlky4sk5QvpjtawUO9WI1CabX/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MB+7cLcJrwDQXNDeNK0mH4YvrElynI8PIZnXtwIEitg=;
	b=dTH88H6g0eRdL8uJCedUhl6JMQpBL5CKI8qpTjepwNK07fHwxp5JUTnGMpP9/yrEhe0c
	 z+hgDCgbXA3y9O2yjBw5VLnlN5heCl7c7SacoXYN96jAnM1ngOKmSaHELeWLqRgI+dTa+
	 Au29FrbW7FSfO2qBNYVXeyNFr+hnj4R3qptdkLdZtGRKLG+1h5H2izO2JVPRMFvCsUAnj
	 AYvuMmRO6ZM6LToFpM2iXwZWKkzeUk6vbSkiOpjFuh5KzKGA/1fMur1MY8QVjW52NgM0k
	 lRIpXvo1R1tC6RI9SFnLGcJ1KQJs9f4AIqo5Oip7Tik3bbtkFE/HQBj9tHTt+NLuLrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ag5+TvyY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F752606A320
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ag5+TvyY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C861F1F000CF;
	Fri, 20 Nov 2026 13:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182910;
	bh=MB+7cLcJrwDQXNDeNK0mH4YvrElynI8PIZnXtwIEitg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ag5+TvyYVqUGsQXnQJJ1NRGQveJX4FfXgYTbYZ6f6wLRsnCgJ1TlvPrT+m6V715DV
	 meEOrzJzI2pd+XZOaNg/rT93NTIqigC6Nvjyfn/7G9D71SbhELUjztXwnXVuwif1f+
	 R3TaiI2AtWfQbzA5wenLEC0ZlxwFG18UXw7zQP6A/6b2ZfUJsLGIyH+T3wHxB5T1xx
	 em5c12E4WMlSWEr8ik35ScFypOoc4cahJ/wJ/O3FIbYoDdoIHODDdFqG5XL3zrrFQr
	 ityw61mftUitgL14lmmWC5R+rqQU+JCbalxrQiS+h+28bFh/Fd0I5ysBZ+tHwlKAP2
	 TUjut105Jvfbw==
Message-ID: <sashiko-outbox-225296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/16] platform/x86: eeepc-laptop: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-12-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:55:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The eeepc-laptop driver scans a single device and then attempts to
> assign its resources using pci_bus_assign_resources(). That function
> makes bridge window sizing disjoint from the assignment phase and is
> going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources() which is likely a no-op in this
> case as it looks like bridges are not involved here.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D11

