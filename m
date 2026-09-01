Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823631A55B;
	Tue,  1 Sep 2026 01:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225427; cv=none; b=oWYw8ZikRB8Bd0KQ9q1nSgPW9FkzyBUKr2RLiN41J0lUz115V7s+djPVlJW/9mqcV1cbqteurHb1RA0kt3qWoh7llSpil9nVDpD2XT60J5Vf8jIWbbnVGNMUmOh675NmiBMPsOhHMFpA9ercCGJUuK7btP83j0acRfdEelxp/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225427; c=relaxed/simple;
	bh=1Za2EepXS02o4HxxPK3rgCffUMfTJTDE3ESGki5NaPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DuM1sSl0g6Cvj/VVbHfOIj+WDSQArClGAUreaJbC7hCi+c2bnF1shIhBEdV5W1CnZHKY3fOyyvYqhxjDROz+7oP0R45StbZtPTYJO8HkKdKoyNN6ZyB8UzKOjqKwOMbiPXGJ3w/gurdw+aBOyvlviQU/+/A6MLIGgjqe78E970w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbCq8gMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbCq8gMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5EC1F00A3D;
	Tue,  1 Sep 2026 01:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225419;
	bh=1Za2EepXS02o4HxxPK3rgCffUMfTJTDE3ESGki5NaPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EbCq8gMWtA82ifX6GUHrxztax4EAU8M51JeITq855WDJoPfhDGh9rtGUvmNE4CiHg
	 WWyXW2cptcvIcneOXk5VPsIRM1hfdJjXsNk8tCN5wopIf+LeG3z+EI9lqX8LTiwTA9
	 AUnl1q9A/iPkYuEHE7O7Ru0cO65kGvXfYPGdMua2Bqh7CE2sX3eyoitI7vlxcvQufq
	 eXw6fVxLyJAuNaOCAYimJSYuSb52PY44BD7cWjoEHmaBgvgg4xhFl4uaQqBqLaM8zH
	 GHoPexYXfu0UgfGyhf0B/eHa5eDDgorRPNXmObWxdCHk7Myl3cZzsxHvnb6E2Yk9wD
	 8+Mu8FsKroqcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/21] PCI/TSM: Rename pf0 to host
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-11-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-11-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:16:58 +0000
Message-Id: <20260901011658.BD5EC1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
> names from pf0 to host) as part of converting pci_tsm_host
> to be any device that knows how to speak any of CMA, IDE, or
> TDISP.
>=20
> This commit just renames the functions and provides no functional
> change. That will happen in the next commit.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D10

