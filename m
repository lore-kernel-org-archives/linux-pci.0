Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED43BC670;
	Fri,  3 Apr 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217394; cv=none; b=CiCqEXpelk2Z9MPCPydpkZ02E18pKImDvMk4Zl4CWkQRtFvfEsCqWgLBdQ4x1A6CcU4/tCIEJpjsKpMrRre2g70O5mOjIga20WxuY0h+NamJxqB0PX0DbS4WnVeFIXirbLXMbVDGcMX3HBNdG6ww5BRc8SHZzBlXj2+QELMWC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217394; c=relaxed/simple;
	bh=9l7YRnXiJeaUSputbifksPPi0XaXtllvN3GOhiFO6oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg7/uRao3z49jGQ4yyvZCYtmTLUnIJfj7gug1FVM+ceuL2rKXOvkk4j+ekE0Zaz+7zdc4XBy0f+UFQnMOlBDyaJbSaYvsPWUyxEZXOcF/2ngPZ0ZI35vWaWrMWZPM0/dfAM/CDuax6muNAuxcD9YByyLC7sfEGYY9SYs0d9xr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLufVd3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLufVd3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A6C4CEF7;
	Fri,  3 Apr 2026 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775217393;
	bh=9l7YRnXiJeaUSputbifksPPi0XaXtllvN3GOhiFO6oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLufVd3zXy9jubkTC9dwkw2QYzwtvaWjru+m4ZdRkawSNi9+nrDNC6gUO4mGVS6/R
	 gkBybMRFcG6wp9frSh1UrnRTFmFAIWeWQ6JjhxrMtKfvi/L8jlqp4jSjvl7EXEDDzs
	 ZtNPjIHE0ChL+R5ThH0m0bg+INk64ahwnxdcJwFR/q6vQTBSBkwaCRWtjZT24m2vTQ
	 7MxtkfclOy/wmKMdP417H2f+HSQV3sLIh5VH4IlCqqK1iv9HKmpZHIBbN8ejL1uHof
	 f/augOwXmiWn/yGSuidAzKcnlp7ywm1cPXBOrcNHhnI6tgb8ARqohzJKj7eqgaBFB+
	 mw/4aiwR3j/hQ==
Date: Fri, 3 Apr 2026 12:56:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Robin Murphy <robin.murphy@arm.com>,
	Leon Romanovsky <leon@kernel.org>,
	Paul Burton <paul.burton@mips.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Toshi Kani <toshi.kani@hp.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	Johan Hovold <johan@kernel.org>, alexander.stein@ew.tq-group.com,
	andrew@codeconstruct.com.au, andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com, astewart@tektelic.com,
	bhelgaas@google.com, brgl@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, driver-core@lists.linux.dev,
	hkallweit1@gmail.com, jirislaby@kernel.org, joel@jms.id.au,
	kees@kernel.org, kuba@kernel.org, lgirdwood@gmail.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
	linux@armlinux.org.uk, mani@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v3 8/9] driver core: Replace dev->of_node_reused with
 DEV_FLAG_OF_NODE_REUSED
Message-ID: <fdbe1d8b-d323-414d-a705-cf2dbafe2fcc@sirena.org.uk>
References: <20260403005005.30424-1-dianders@chromium.org>
 <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7NZIk4CoO0re4Kx0"
Content-Disposition: inline
In-Reply-To: <20260402174925.v3.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
X-Cookie: The Korean War must have been fun.


--7NZIk4CoO0re4Kx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2026 at 05:49:54PM -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.

Acked-by: Mark Brown <broonie@kernel.org>

--7NZIk4CoO0re4Kx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPqucACgkQJNaLcl1U
h9BRKQf+LiK4wJzBJvOcF8tPspBBv5slh1Rv07RAYfhsMajrfvb91fBup9erBnC7
uop2lhbeef3E4GYUNM3af2BFUVTr6Q2yQsCgV5p3nED9j4EZmCsCSp3X0Hbcc+S1
RmxEf3FESw5jl5dAifyRzEtHhqMmQoiJiWHstiX08tmRvb230IM4SoMj9/XTx/hJ
qZLOPBhvbwfqLgqtzR6YbvKHy+eG/muzoWEC6sNgi5JBsNQEeCY0Dp4nSfxbN1i6
VGMAgiL64FDOsOQ3BG7hFoQ0OFAsOB2CiaPDKh4qopTzS+avykiGQvxzCn4XfBfo
8ZM+Nrnu/VYKm5P6K3uIcHF11UpYhg==
=Rocu
-----END PGP SIGNATURE-----

--7NZIk4CoO0re4Kx0--
