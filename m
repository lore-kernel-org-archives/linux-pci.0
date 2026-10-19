Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E7481641
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399432; cv=none; b=BCdzytyRk72ZDHt3VxSdxriK6vwrrwE7s1KQ92K8iHfvH9vQeKms73ns42MRkFHl/yY62Ri6WzJ8oMguXRNPZrd2kOTcAA4QvhrsMZ5Km/eQkSdh1UsTiqibVs3dzl8geQbNDr0ctdohefWjlxJpigQ/3zayoRr6yBrhJPdhOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399432; c=relaxed/simple;
	bh=nawQtEZugCFH+H6/sqiD9NdI394DzafweqzBR9XK1i0=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=pdh+zY8gu5gy1g8IP/jltYzoWEyZKHDGNbumvy72/NC9vdvYzM+1I6OXdMuI2XiF4aaKTutFZH5i73HvcantoPqmeV4/ibBeEtEvmjjrTyotw4q7KmfILqkFtFl44eDPN2gFKDhlU2TpjFrM3BXb74/LYOU0G8bRsW+V+RDanqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spn7RfdN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spn7RfdN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105761F000C4;
	Mon, 19 Oct 2026 08:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399431;
	bh=nawQtEZugCFH+H6/sqiD9NdI394DzafweqzBR9XK1i0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Spn7RfdNCMN3tPY9n0BTNqN41MTQXByy43E0UmAHuOMioRwOd/cWSoezIudO6LdP3
	 p4r66mzoktppEtffBYCr/+gd3L7tl/aVhPHXxW9LGAOWXVTMt9lDw8s+TflPX0FFev
	 k3r40LkeWuxx80mmeHnpRKH2+mDW0T+HKzvC8ygzQ5wA92x5zbFgvQMnonuy1fL3NO
	 BvBylQJ4T1qad+9klQu9wrVxYvUGSv202g4aiM2C4wpVNssYWxb7baioRhCniEYlp4
	 /15uAnbmD5C4vQlLxB3YkXwOmw9G0iFah66lo0fXicRdcSCuplAYqCl5RPFmWgLT+X
	 gjQ5fy0Wf7gIw==
Message-ID: <sashiko-outbox-176830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 02/13] PCI/IOV: Introduce VF iterators
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-3-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-3-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:43:50 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce helpers to iterate over the enabled VFs of a PF. Add
> pci_get_vf() and pci_get_vf_reverse() to retrieve the next enabled VF
> of a PF in ascending or descending VF ID order, along with
> for_each_pci_vf(), for_each_pci_vf_reverse(), and
> for_each_pci_vf_continue_reverse() built on top of them. The helpers
> return each VF with a reference held, matching existing PCI device
> lookup APIs.
>=20
> This provides a common and convenient way to iterate over a PF's enabled
> VFs and avoids duplicating the iteration logic in drivers.
>=20
> Assisted-by: LLM
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D2

