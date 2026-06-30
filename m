Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03040DFC7;
	Tue, 30 Jun 2026 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817794; cv=none; b=HQQr0gZyJ0lHJfM+quqmEPXGf4lWWjUnZSqYOe3re+FwCG9kZc+hu1G26QhzRJZlrBc6+PJT1aP7YqcTrArSXilIW5FMZkKapT2Dmar2WjgOei4A6mBFzKBSnTSx7XFlghXGi5hWdBXv1pnauP6zOzRLnrxSbIe4/5dr9hQAlt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817794; c=relaxed/simple;
	bh=f6MdsU5EP+0JABsi/KCtSxMUtSnQjHzbrqTmJpvd0/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lLZa7UW2FYwhyJb7xSldteUozIFvqS05JAmXGa6uRkFUYD5IV+62RBVRqlCAFyYfaxpfDWwJyFZRAB2p+gy6lTsBH4GTy/Uqcp3XexXHBEncyivNhzSvpK4mwh6TXllcIR5nQilL0AtnJdccrqxNasaNaALupk8YQ/G1+w38BdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZmzXtgbB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZmzXtgbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE59C1F000E9;
	Tue, 30 Jun 2026 11:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817793;
	bh=f6MdsU5EP+0JABsi/KCtSxMUtSnQjHzbrqTmJpvd0/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZmzXtgbBngWUpBC662k7+eu2GFzuQ3nupb8TcWJpqbUD+UfGLiuNrqCbifFz0xtlv
	 e0a2166qaJEjK8uQJm/SJjqdmoV4dBl1cyhN58D4sWv1ieXDshBl6Nx5taEeQ+L6lG
	 tAdMzVkpu6eyGy3V8h08dPN3b0UVBeCoIfb3TD1Nsb9R4byjk9GK+TIDbhlOS3Ly3+
	 hA6VQ7lCylKhr60ay8/oRkiNRm8Mn9AkM3E39C40nM1B6yZ2aJ27I+9niEV5PSjmJA
	 6MP6GCFkkmhCpbMhuzH6h70qo0SHLZ/gdMnUI7Fpwf34cUzaVqTo76ULN9THCOqqHJ
	 z3BYJ1g01BlsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/8] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260630102804.413563-7-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:09:52 +0000
Message-Id: <20260630110952.BE59C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D6

