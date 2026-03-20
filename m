Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F236F41F
	for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046860; cv=none; b=ISXaoo1zvQHUl6av/dcCcPFE//Mbk3OEKI3cNjQ8bJUaqJ853jFuKhlbxXLwQhrzL7wkJB7QxK7Lvdcv62a/dWoC9bixkzjvyEPnsNTee6f+CG56EvSSsT+UGBtvifa/HWDcMawdoDRWhV80D71L9VLH91zLXA3bBCQzhLaF4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046860; c=relaxed/simple;
	bh=c00SICWmy/LUZrs/yAj4KsROrSXRFJ9Ui1Z8E0oQIeQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpQsIPmxDvL5+cj1ZmsPkghCcM5KZS+lolfKtFudP8+l3DsQlA2A6RmFW/tinfor4aNJ8p6Q4o/R625S96f45HixP2I8Uk1FGYgfEVKD9D8lRMdGEgCQJtpXevD36oJ7RO+1CHsN0xVe482edr5zmQYd4iCbn3VW6IKhJoz3g7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1MCKPQI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1MCKPQI"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so17862185e9.0
        for <linux-pci@vger.kernel.org>; Fri, 20 Mar 2026 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774046856; x=1774651656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhXjvOlJzVCQXB1hGh0TRvS0gm8A0W89SC6783LGupU=;
        b=B1MCKPQI2P0Nf1pddwrT7XgZnAugF5cs9o4tktZ+3FIp7BORMQtX4eba+Xw7OQjjSf
         0E/xxVUMOkLV1/ULgPrs8PwBfl1QnAq1KECQsk5ILAKdZQ5kG4oT8VK/dSl1ItwFtK/2
         FkYvPN4znj15FLrJCEspKKj0204LjaTCBtTfWXMaVRzICu9+uoycXpZhsSDZ0f9F9wtZ
         jnmhxtGgscXxdcRU5U952Ta7pu02UXdo8BcIc2PEX8k+Mh+ZjQ4aCvQbrGgNdr/51ei9
         U1YSRAkXZerVc9OTxIU8iHS0NudA4gde+6i4pAqaoqSOXmuZUQgUPOSfuQsnQp4dCPIx
         PuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046856; x=1774651656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhXjvOlJzVCQXB1hGh0TRvS0gm8A0W89SC6783LGupU=;
        b=FylMHii3/pNLLjtn1X+HPgzajMwLhATCsx5J2pchOJy6XK6VPUwUhq3A6tXqDxBojR
         VNi5ik2Z1gnkwxYum0BEljiqJwiDT6s1f/Clq8g2ldVO4PodhohLox5oUe6RpmvXzge0
         U+t8259lIV55LhC/R9GRmRqSYbxRodbnZV4O5zRz7ETnWf4uClOr6Jp7m0WQNQ9GTp82
         uFfqxAjMCGbOU3O3lcf8JpBXKFOhPStXZ42vVTqXY8Iynu4ScK1Bxtaih3JpDz+kE832
         nKQMymqt12RxMzWVxaxda84grdDwmDENKBvOlmy8Y0dCHzXWYtjHHodEzDLVQE5Mw86O
         EXOw==
X-Forwarded-Encrypted: i=1; AJvYcCUqGb5DiRZkXNK/10YTa24DeYzx+b3R64/4fth0a2YvcmMUM3AwEkegl3u39nFIcqEM/Zl5ip48f3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3eIwxtuPiWX9+kKZGd/PlpGKNLvAYMKeA6iiVuI6I63eBCX9
	kXn5PFNhRJ92YOG6yYsSXvBcUJQ1K77JFAKpO0pucTSVwwop0N9rGFus
X-Gm-Gg: ATEYQzxalCj9CLy83iLcnYckOwJLcoxxOUmSvFnIV4Lfr7J1nOevd+rBqI5d8KNPj7a
	tbxU4RSXmHU5nS0orOHarDwnJ3uckqEd/ehc0t7U9q6qg8DEAJbNSH/UUy9oHq/SYTCKRG8uTmW
	CF9ujCw2k7Y+O/YG/kifOTjl+SFauedhISHNncOcwxC4SRgUH31n8DosR1M1PHVZjAkUe7yLHTD
	6gjAIPzq3xrv9u5kzxIJVTpwhckUS4Ab8LJ/u8e00NgIgwx3OG0posw7NIlghj5E8lORyC60fg6
	k+HZbfakUnleQTItvxhBjYi5pliZWtT/Mah53N9yAa6VRMFGgV06/LTgTDkIevnNBHKj96Bvk1k
	TFr4ZmqE/a7QuGsQrxlszk9aJkFl0UYUJsefyJxocH+jGf4UL/rMJQw0vCqRIJAAvDi0OCK+J05
	b3oblWKFSOunnobivzxdfV09eNsYzbn2Xp4w2hygWwcKAZpp2B1d9IDvFK37Kh0MBIFmKTONJjq
	MV0VZ5i7sM9+XM=
X-Received: by 2002:a05:600c:8483:b0:485:531d:28b9 with SMTP id 5b1f17b1804b1-486fedc0070mr68488115e9.14.1774046855624;
        Fri, 20 Mar 2026 15:47:35 -0700 (PDT)
Received: from orome (p200300e41f249a00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f24:9a00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4baesm251389055e9.13.2026.03.20.15.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:47:33 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
X-Google-Original-From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 20 Mar 2026 23:47:31 +0100
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Use standard wait times for PCIe link monitoring
Message-ID: <ab3N-sNecpOV0WGi@orome>
References: <20260320224044.2569907-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="je5mzwlvfk7zrove"
Content-Disposition: inline
In-Reply-To: <20260320224044.2569907-1-thierry.reding@kernel.org>


--je5mzwlvfk7zrove
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] PCI: Use standard wait times for PCIe link monitoring
MIME-Version: 1.0

On Fri, Mar 20, 2026 at 11:40:44PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Instead of defining the wait values for each driver, use common values
> defined in the core pci.h header file. Note that most drivers don't use
> the millisecond waits, but rather usleep_range(), so add these commonly
> used values to the header so that all drivers can use them.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-host-common.c    | 4 ++--
>  drivers/pci/controller/cadence/pcie-cadence-lga-regs.h   | 5 -----
>  drivers/pci/controller/mobiveil/pcie-mobiveil.c          | 4 ++--
>  drivers/pci/controller/mobiveil/pcie-mobiveil.h          | 5 -----
>  drivers/pci/controller/pci-aardvark.c                    | 7 ++-----
>  drivers/pci/controller/pcie-xilinx-nwl.c                 | 9 ++-------
>  drivers/pci/controller/plda/pcie-starfive.c              | 9 ++-------
>  drivers/pci/pci.h                                        | 2 ++
>  8 files changed, 12 insertions(+), 33 deletions(-)

Ugh... sent this out and then noticed I hadn't committed the change
which adds the pci.h include for the Cadence driver I made after build
testing this.

I'll send out v2. Sorry for the noise.

Thierry

--je5mzwlvfk7zrove
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmm9zoMACgkQ3SOs138+
s6G5GRAAnMR9ohk9vZ50EjifyXDejaSkZv7ymXTi1JqrlciygVpz+rftlej1WN59
9KwSZoa1DybEOW1Goc1NaiUA1XpRhi/V4VT8fq5KKPfTW2odBXezv0V9z77gQoos
aEEHNnmuY+qx0Le4KGaWCV0TLVmOFl1VY6kXAd68DYlG5m4vIB1rB7ZD95gjgLyk
SJ4mMimmVU8J90afkGSgQFvgNzPeCMZ2W1n1+7O8voBiKMHd5km4bakQo8KPeAyn
X0luaAO5zKQcWeZlz9NT1au4jHFJoKMrhloGzzKWAyY+fGXfRSoCjMkIe4aeqOoM
nBmtNZzaSCjo1Rre7HqiJyequgCznwRbCShgqfB9Fjy2cBpgTXpWxZ18FjRA6b0p
GyJWP0gaUzX3i0hEXmeSVFVdk5ltGZ27ZKWqzhdWSfdVUKxymmMsPzrw35SeOpBa
l69q5m6EWz09fgLSR+2OFN+fyXH3ZXRgrRdo/h2ukdCJ2zOIRrPB3G4Pk80MmExx
EG7w8WaTcB9Xp1C146C6DHUx1MeG3XXWFVMK2f+NBKEnsCscbaQL1GX3ID/inzSZ
+ABAJIiB1jJkRtW/gvspaFk6YjEYUOUD2JLF16x8bYYo3JAYK1vMx5xAMfG+xC8H
QheqArpqCslcksQFji5HfEXzHyA5s+N91I9LZjfnve9ovqVlJA8=
=ebDC
-----END PGP SIGNATURE-----

--je5mzwlvfk7zrove--
