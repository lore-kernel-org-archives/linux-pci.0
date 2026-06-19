Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3B3B19D6;
	Fri, 19 Jun 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888709; cv=none; b=gzOedq917MjPNxG2hDBuzFI09KAN3IErZmmI/YBoR8oWUle9E+/WyS6IcjpPQMGBWUCBU+zd7qykbchnlZ5EvSou8tQaTgnnamAcXBYLa5o3mvxIywD1GLL5SS26nLNweXu+ShcKUnJpWHS0HxHtefQO4UkIZz6MCF5xDB6iPGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888709; c=relaxed/simple;
	bh=Hj/ZXpvdzv+03lGtx43cYavr8FbG7nggy5+aEmqkaeU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XshDqfdmcLMcKyW4FINundLIxaWi5L3FFYtQgLB0AqfIE5Ex0qlVZoNiPfydFLlCB18kzpqYU2R3yqpzqBHgVcswEpfCx8teSZDTL/tW6unZGImco3HZ6VajpWx4akPoRmTmtyMupACouJjfaZ7C9VN3eNyfS0T1GKmdez9F30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5t9GqxG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5t9GqxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44141F00A3D;
	Fri, 19 Jun 2026 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888707;
	bh=Hj/ZXpvdzv+03lGtx43cYavr8FbG7nggy5+aEmqkaeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a5t9GqxGtQkgti+GBubCXRYnOyzoq34zgUD3QCC5OUEOyXVwEco4TcAqM5ew3Bd/K
	 G1+7uFLdlxi+LyvJ2pZ0KFrpOXurB2cf4hYPDxVgayIlEqbTVjimOwK4okwspjHhis
	 WyIKCBbNhMUDVDzOkMZkvZ+4ij9Silv6vDA80YQ+uNQyP4A16PKbzueds3TvDhZgou
	 nNZU7i8seFiiz5LzfZMh0g+J6hB0dkI83BIN2Iwj8vF9ulLXUqmF954NqPGuDRr6a8
	 d9Vi0tiQn29dHu8Vm3CrYLLOWrfcIJMgJnOP0PXZTZi5UR+C8HrPQXvQi0HKcPR29z
	 AxCXND31NJNzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] rust: net/phy: remove expansion from doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: robh@kernel.org, devicetree@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260618-id_info-v1-4-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-4-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:06 +0000
Message-Id: <20260619170506.A44141F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The expansion serves little purpose and it can easily diverge.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D4

