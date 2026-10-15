Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1AA361DAB
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035463; cv=none; b=EBz2KoytkDISTaZU9HrG+1dShUYkXnPQ7G2nFB5qDDf+hfXglXQq3wRK29f/BvtLnxbCUP+OVI0+w4hKkkVLXERIuhd6H7RWbRrCJwTt8EWox9yj+yC4BdB8+M5EtlZ8I2RoSygK0Zn4xS8blQu/0xQlFfB0YsvEUJ49rkwJQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035463; c=relaxed/simple;
	bh=CXpr0r3AOoMYV50tPrJ0Xk5wEF31eNjlZflNgq2qUtA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=EN2anKjqeRStNxuRKgnLWGGdQ5l3Kxy0FHkfMD++0sXHGvhChwvd/YYxNNrW85zZKNiVT6wAmmWJSPOgg2GEnypFcNw8ZIULKXUThPz9nCnBqrEYO8jKjp7VonH3QsGASpSij7Ypt8ALKt3Qp2yAcy3S8Knes0DbJ9hjjOg85+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0ugw1Ip; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0ugw1Ip"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992051F000C4;
	Thu, 15 Oct 2026 03:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035462;
	bh=CXpr0r3AOoMYV50tPrJ0Xk5wEF31eNjlZflNgq2qUtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T0ugw1IpO5B3sWLGYByJ5LN6RD5motZkC7SB4eIvOfTp5ftpIqRL8srFM5ekTqtzN
	 kANpiy/sMdiXi5ofDT2C7V2ENEcxtxgYfObZ2HbsddQi9OCpteGPC+73PTNpgfuEuC
	 RXmeh8h18xMOCPg3OPHXXgssbXTYzig6YLlGd6aIrojCqS85SviIYYmA30vf6ILvyv
	 osfd8GTZO1DsL+8vhfhEUVKgdfcPKnNVXn2GvSE8o935TgmUw8PHbS8c3nbYXBvgCv
	 oiywtHJBqAQkRrLDpoQqj+PvxNAtqb+Gz8HR72WUUMEBkgKUNsozyUe3/+saUp4hfj
	 zojGAZSzFxUIA==
Message-ID: <sashiko-outbox-172207@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/18] dt-bindings: PCI: rcar-gen4: Add optional
 "aer" interrupt for R-Car Gen4 SoCs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-5-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:37:42 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
>=20
> Keep the fifth interrupt optional on R-Car Gen4 SoCs so existing device
> trees remain valid. Extend the example accordingly.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D4

