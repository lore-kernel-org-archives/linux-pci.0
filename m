Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E149BB7C
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399454; cv=none; b=m5aD0rxCmwQ5EFb8Y/s7jFfwFX8XRnPuFlRgxBBFI8Lvi8ogpEz5p+GhaeBs7X/SendzuK+JoUmH1NlS0pA9gCaxGafl9orMGrvQsQAqhBATAywQUE1EsWQak3BAgWWMtH7bILM9gQR5m+OvfZUFixaGy1Lcdr4VtxIh5x+CyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399454; c=relaxed/simple;
	bh=FStUe+rCWgQWWMCGKc0uKtqxSFNFzS7Go2+tYEjZ2ZY=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=c3jqxGIYmf73zzsWV2dPCTz3Ki2iIqh7VzvawOIozLHqWtzNCIf0sLHW9a+aKMpAxGC7s+HmCQxBi8YhXllIx1nCzL35Bpdne5tZZ432EzEdDoxMK8IJ/PZ4lSKUeUdJtMx4m3nAzEVykjQG3xcnxIz1ZmK6XvXQ8HBJRa19E28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1ESwj28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1ESwj28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1671F000C4;
	Mon, 19 Oct 2026 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399452;
	bh=FStUe+rCWgQWWMCGKc0uKtqxSFNFzS7Go2+tYEjZ2ZY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Y1ESwj28vTTdFT4+FUmjuDg53NY6ZxNxufEtpbmIVxfk1QZPQfei+DfLvWe7r6hSe
	 F8IjgqosMB4gA6N7U3Be42ocPNkPphv4u4H23OhwCLWy69CesY79/yWz4V6ZPxoiII
	 GmZylDcrBLZol5s6uxvhmnK0i6TYrbBdqIv6ybj3P1dXXMW8JeBtKtMJ2f6jOpJD4I
	 +PtGmta0pld6zWqGiJi6XPyDvPBpSb2okYVVuJHzKR77TeXqhNGpsB0XIlDdKy3G8O
	 O42Xj5uDM6st4TqYjonCoielRTsQC0PwB7w/iiyBeGHKuZR1FsZ/Q4J1F8cLgz4XCq
	 lNruCX4puDt0Q==
Message-ID: <sashiko-outbox-176831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/13] pds_core: Lock VFs around
 pci_reset_function_locked()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-7-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-7-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:44:11 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_reset_function_locked() now requires PF callers to hold the device
> locks for all enabled VFs as well. Lock VFs around the reset in
> pdsc_pci_error_resume().
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D6

