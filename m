Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086333F36E;
	Tue, 20 Jan 2026 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914510; cv=none; b=ikhzh1riXMdDFpiRJ+Squs8/zXfo/nkFpU6mQa8Q/Fu7FgPzcgF/YBPTO/pUGOxXEEwDoIMBxrr13m4harBLagiKizlGPMffsr5ZRhKrLC5vxkFMC/6z65tvC0F3uqMIVzmZH07g8MuIf/XyVb+eipCzVxadwSBlc7SAl8KrEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914510; c=relaxed/simple;
	bh=1voSzNi/sgowwBmNiUwpn1p+vvbvmDmpWo7ffuxvSfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjvaZb/89Yw04gAZDAyVNyDo468ypeAxa2IWQuw1Ir1YRFtTC2OsgjnThXztXVU+Bp/N5EDrWLF8WJ0ti7xjFqcGQqI3chIzRI/Os/qoQTroaWp4vAMxboszqa7ERTNOn9I+k/AmM3Wq7FNpi0sJmv8lMppcar8e910IZfxKWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOgqUope; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOgqUope"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F2FC16AAE;
	Tue, 20 Jan 2026 13:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914510;
	bh=1voSzNi/sgowwBmNiUwpn1p+vvbvmDmpWo7ffuxvSfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOgqUopekznGcb06M7umaOl2jMWf0Yk0CuBQTuaGdaLTOA3+scK/anZh8ps5vQM+H
	 sN3z6WF7vXKswT+RFOTGZI/pxLoTFxFInmjbhKL9pwcukB6CGNgz1elO9/075DS5u3
	 aNhvVrjGU2SyYjuP4o7a1ldfcDUrxRa+oLZd6VIhbvq4l9Da1dk2yCs5a5+NngcKCI
	 SCu+1MeWwAH3k/EqyiFwKyEmoj6ngFZoU4UygL2HoIuZh3FamyIe+2w5AaIkHhOua9
	 r65/FBD14jU5HGBE811O6t6mGtMvOgg3sDf+k3BXNDSkX0lLLZJQXIkn3UIZcJMIl1
	 Ys2wlLM3XHmgw==
Date: Tue, 20 Jan 2026 13:08:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, tiwai@suse.de, bhelgaas@google.com,
	linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev, linux-kernel@vger.kernel.org,
	kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/4] ASoC: SOF: Intel: add support for Nova Lake NVL
Message-ID: <a17f45c1-8342-41cb-a6e2-8d572ccd85d1@sirena.org.uk>
References: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
 <20260120083148.12063-3-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3KkW5HlfoYxxlbeu"
Content-Disposition: inline
In-Reply-To: <20260120083148.12063-3-peter.ujfalusi@linux.intel.com>
X-Cookie: Slippery when wet.


--3KkW5HlfoYxxlbeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 20, 2026 at 10:31:46AM +0200, Peter Ujfalusi wrote:
> Add support for Nova Lake (NVL).
> The core count for NVL is different compared to NVL-S (4 vs 2)

Acked-by: Mark Brown <broonie@kernel.org>

--3KkW5HlfoYxxlbeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlvfkgACgkQJNaLcl1U
h9ANFgf/YBzN8ANa5uFvRFAHKJwDgQpOBK08/wiA8VpxNkSvtlWiWvxtIVmQ0N7z
+oQcDL4pk/X2igc4fbxJs05I7LBj0a2zJwRtnCjIH0s+KGgZQq48HQDSzdkfLwkz
ibQ7JeUa7iAIKj0v3o1xtOP5FKG7UqooU8Z8Ypo7YDmVQo3UEpyPVWevSWk8Rn37
M61S3w6LYyJAmh8l50wwIRse3V7SnJqk+PznKpgLdEr63ahX/Ehlud2OfTgVjAnO
roxis8anzs8Q7FZ/6ioSld81xsnSNwEl+6rJhQZSanu+BdU3Psw+/L955+qdaveQ
RAAnCTlWykke+upJEiiwFfDA0aNWhw==
=fkV8
-----END PGP SIGNATURE-----

--3KkW5HlfoYxxlbeu--
