Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76623002AB
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035389; cv=none; b=fsDSyYGveXUm2w6MVsMllSmcg2Iw+rMrD6+UaDRLu6sG1WKXt5VFqtLY9ynkMn4V53QWK5P/75HRz/W+L/RGOOuGogO81JShL1u7ClfTdJwzrfNnGzLa0thK8ff3gf8ri7lR/O/dx0l/nyKH7Jfpfm6t4LzFKYaqui4Ao26/M3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035389; c=relaxed/simple;
	bh=xXnVXIdTifQ/v2hKCsOH97UyIs3S0Wp7UcsKH24rUYE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=eBlLCyNioDKP66ZVr4y8IQjRJusydyqGchlkdVxMOLRtsv9/4RZjgB/nD0jLb9qMI/m0YUQ4QTMN7Yv7+eb2avM70+QuIAOJf4Rf4tNsmlAOKfXouJ0UvvOqyIPj6bKHb0y0pSQfdfOGrtelT8j6XFFXtHQbop/TuqAdUoTLF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvIaEH+Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvIaEH+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E50C1F000C4;
	Thu, 15 Oct 2026 03:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035388;
	bh=xXnVXIdTifQ/v2hKCsOH97UyIs3S0Wp7UcsKH24rUYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RvIaEH+YvG14BigKywlMTCV2B4QjcXforENuY/w1LVulOAb3nheHqOr/sf8bJUjEE
	 lSVm2TPO0Sfg5RwZIJAPmRK7IhAsASoI7bJHlFX1Lk1J3qyNnALbhXYrHxKGinOhDh
	 mOjzKDX7Y2EB+1i9znCy9OcX1/+Ytm6mmO0zp7z92oVr8OLU0RpooBTNA5pyTZnH/v
	 5ZFDts0HnDx7MFFpl93ngjcoOq3ru/8NcGwIWp4U5pNy4OE9TvML1UZuR+ioJMboLj
	 /NvETs4WLKSptE8Ybqo96GjP2bLuYffKPuwWlVWUXxpaKYsO7KhgOsJS5B4AEDcLjm
	 jcGE4vW/m+2gQ==
Message-ID: <sashiko-outbox-172201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/18] PCI: dwc: Add Renesas to the RAS DES VSEC list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-2-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:36:27 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capabili=
ty
> with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
> not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D1

