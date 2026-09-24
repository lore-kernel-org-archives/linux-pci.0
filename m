Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8B33A9FE
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274609; cv=none; b=qJrIVPf0hq5MC1EIJyR2DKc+8oIAvePAII2lnU6921GBrsOQ2swlF9JDNCJV4QYXTaE/+KU2O/RB4967Q4ZUQFOLErilZEu/ySMN2vK6GujaL47ZMvQKC1KRg/Rp9dIIA46kiwboW5NjzAxkMekn+EnFVuHSgB3YAlSkFy5O26Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274609; c=relaxed/simple;
	bh=EmmlIT9U5S20/xblppYmuY/L90VatEwJDKsNpvjdq6I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pu5fUI5/B4zehs+uWKGsiozYiNT4uob7b9w7l0QH1RGFc2TUqF5szRnqIRK35vvb4rjJw1gz6WRiOA7fk62S3WXEe3hkK7vPWe0GJJKdK08aUcUC2SpEeEnfW3z4n48cF03Vcjldasn8AQmPNvoNbLy5ecXImIBDLJqUbXSABAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6N61WBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6N61WBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBE21F000FF;
	Thu, 24 Sep 2026 18:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274607;
	bh=EmmlIT9U5S20/xblppYmuY/L90VatEwJDKsNpvjdq6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e6N61WBZFbaMZ0XhEDK6haI5Ya1IIaQhus2OZvaVtDaJM3eGSLWyTcvGrMg9iANPg
	 qwQ0KSPDoUODtMzxX6dDOvjO5W1s36Hkwp/V00J8aLkFkpQdPQZZd7l+3o4iX8ouRq
	 aNH0Fs/B9/J54+nOZm5H+n24GtVhXkOZHpdVV8De3TJQzc7nOCcnb9rMgrcwfLPVg3
	 f/y710SDRSbFS0z+y8Bc0kmFuhzYmG8M1mw+DMJ4+BhpW8wMAj7Fjpyotf8Ngq9bCd
	 E71v2H9BMRURvj3iGry+CaZeo6XcVH0Iqmm4ynlbWkUY9XqUMOu4Y/qUfmpg9vDtP9
	 jGT+o+nfEb1Mw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/15] PCI/PTM: Save PTM state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-10-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:30:06 +0000
Message-Id: <20260924183006.EFBE21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the PTM Control register through the per-device saved
> capability store instead of a private pci_cap_saved_state buffer.
>=20
> Report a reservation failure. pci_ptm_init() ignored the return value of
> pci_add_ext_cap_save_buffer() entirely, so a failed allocation was only
> noticed later as silently missing PTM state.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D9

