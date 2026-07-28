Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E23A83B1
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276767; cv=none; b=MyGJh3cHcbDC3FE5DdUFBO3xzIqwVkO/ybXGe1gukZWg58kypzX5cskk6q+poI6KytkykIg2nahn2UaJSJvXWF1jCCs49FDMunDQYK1MjHfO12uMekDENjO2S+tHtaWhHQDchw12i5CCE09IAkJU/Hh+06mOtP/NxJd60/08NqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276767; c=relaxed/simple;
	bh=bWLsKgtTCO3JlJdetmSrXCBor7cBFKOntziv2gB3TQo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPKQsrsp/+eSSOC3poWeyfMoAebsDg/gRQq7LIDvrpLptcuylxVfE85p+x0is7qdi+oA5+XEpx0alK4ntZWo5c14n+vtBu9SL03oBV5JhFuPFVcY5T9A7epkhk6D0Agzzo5K1Rmcwl6N12zVtlCOfbLfMx1VgY31vs1uahLPRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNqV3ewO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNqV3ewO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8173B1F000E9;
	Tue, 28 Jul 2026 22:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785276766;
	bh=bWLsKgtTCO3JlJdetmSrXCBor7cBFKOntziv2gB3TQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNqV3ewOvAe35fXhKpEiJDabDy8Dca5b+eWgcTUf6Yr//KYut2MlOfSEC9AcnuSTJ
	 W7FtSPdrn6d4QSy8whJ+Xc65DnhT+10fLddD7PQJbkBRUP80tmneIlsCzOMXpCeyG7
	 5445jULAH0n8m5YA3kaZiBXdGHPtay0URaa7kUTK9jGS0FeXKOACdCojvDulzBmeE/
	 zNExiJ6zOenygzlc8aMfDkDEQUd4KUybo1BcqbkZSHBGbL13c3AnlI20E6sJ0gY4Zw
	 b9EhEAiITHGgWaZD+2gNL20YNwGRAgc0NyOHfvJV+geujtdSqCT75iujAaZPY+Heoz
	 xOd9YYfDuXMxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-5-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-5-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:12:44 +0000
Message-Id: <20260728221245.8173B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
>=20
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D4

