Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026C3C0613
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719173; cv=none; b=EPp8DMBwPs7Zd3fBVYtMLFfJDLJmAzF+7kcRkYC4eL+U6xD3cxLNqlzoEJBXHiwguseRo+ccuK6OquLMHdy/PfHQaS9OOOGr4zalpg5xjfjOSF1+o2nTpL2xEn24mCD8n/BalKW+LpQVmiXSBkAdZgaLY4ioL7lc09wTnl+vfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719173; c=relaxed/simple;
	bh=7QkVxz/1UrwJ5lJjtLvVAkER8lnDsP0VGdXx1Phg29I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgyGZLx85RIfDUYQe4vvexVa3nY5G5Bhph0/gkEAaE1mFRRZTgiWZsBV6tqSDilaEpJMFJlkO6Rw9MYw2gupMeici/n+qhyI7YpVvw6cT7kbyemJNIljfhXZuzLQDoDVZcoouvlDQ5a5lR9VOjj5h3HhqG0Ag7O5U3OUfUlx+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1DoJVLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1DoJVLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6751F000E9;
	Fri, 10 Jul 2026 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719170;
	bh=7QkVxz/1UrwJ5lJjtLvVAkER8lnDsP0VGdXx1Phg29I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1DoJVLc4bpXkBU9O8Zi/5FDaFZ2T3fO3NYqePn0vTdw5yBGdPsSBn9LcrKXHlM6N
	 osrPePPq0wIsN6LfYl7I3RGiyqGZ0EZl8Us31gdh/QpQ8rs7PD+bF5K7x8hdowRJ9t
	 YbYz0O5OQFBx6byTlKez8yTAdmXOBK891tvD/x6a0f4xyO0XIzjEbYPlVGQrieucuf
	 bJ5eJpIF/R3o5mBM19D++oj2WWy0sCu8l3xMvkK4BDdapOSIJWQQ+V6PQZBVADgLyl
	 Rhs/ODRQm3cwxVyfVRmZXiCLw4+9n2hzrz2J27qJ1gNundBTYKAGLtSQZ3JcyhlVTi
	 CzPJhyjjbrOfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-6-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:32:49 +0000
Message-Id: <20260710213250.3C6751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
>=20
> To keep bus numbers constant, always inherit the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices are being preserved. Note that
> the kernel inherits bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.
>=20
> If a bridge is scanned with a broken topology or has no bus numbers
> set during a Live Update, refuse to assign it new bus numbers and refuse
> to enumerate devices below it until the Live Update is finished. This is
> a safety measure to prevent topology conflicts.
>=20
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D5

