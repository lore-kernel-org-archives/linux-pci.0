Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0848FF8D
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399421; cv=none; b=uebVLtFQAqtgdwNVvjuxMNlj3y6Wz5exwojzlqj2SC2mHIVr9a2qorC8l1mdISbA4D1NepHSM7oYeqlljaTkILdRUjtCi4ld4QdUk1RCzN5BKOmRdeWXtlQ/9JceF7Ki4m9f53/ZXbW8ssFljH1djKIYUpvW4CN1lsy0qfMFGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399421; c=relaxed/simple;
	bh=HZlu4i21J5B6slHvtVDXCxx3cDEAz7ZEd/SBGG3ubjQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=UkQQuDtqIcccT1FPR5MNEEqVWSbberm1E1wqo+WjphwtrLsbkBw6IdfbOSDf5nkpL93odnbp4V2DB68JvCBzp4nemUHVdQXJUv/wgMZ9fU/pxYmc1HLfPuKv0sf38NQAnqzRraulwLGyUDWt11rLNmE76rb2D9SZ20vSfZxUQd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHpTJC7H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHpTJC7H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8CA1F000C6;
	Mon, 19 Oct 2026 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399419;
	bh=HZlu4i21J5B6slHvtVDXCxx3cDEAz7ZEd/SBGG3ubjQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZHpTJC7HIQTAQknXk1wd777nNaKN4RGQyKKIEl2WibgQfNeu4Ly6B8iab3QVcauLB
	 aapnujjBB52ExVg3LfkUjDBzz8gwoUW+UIg0V1/xnh3WQUgbUkd0U0eeLQALF9JoLX
	 RH/9Rhsm3MF82pFPiUwQLm28Gn1bn/kxPnN+N6Pm9dBOhI+1suNYWEFs8gwx9pTbo6
	 HE7USJSEHvDhk9wJ6DzrtGvaXFdPDfGhG0GR2LhjXKnf0Io9oKcHOqZynaThrH7ldv
	 i/P/j0MhIWSnZY7dFW7d8kVuOtE+1g+Vezy+C8g1lUMowrNr+A7G9W0UxoS87qpTfl
	 lOAY94+aLINZw==
Message-ID: <sashiko-outbox-176828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/13] PCI/IOV: Introduce pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-2-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-2-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:43:39 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add pci_iov_get_virtfn() to look up a VF of a PF by its VF ID. It
> returns the matching pci_dev with a reference held, or NULL if no device
> is present. The caller must drop the reference with pci_dev_put().
>=20
> Assisted-by: LLM
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D1

