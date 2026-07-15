Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5596480327
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784129385; cv=none; b=UN57LgNSApDg0qZe25dESj5GCmRljAIMrpFS4C7d0s+IsPhGmvhMA290uX56VS8VfGDQajy6xglnWXB3xHFvuFZVwzAdLmw5iWmIQbWmYIkVSOpWgn90UtS5eroCnPNyvhsgMBaIKs/Gqo2yJdzgaYl+EgNTz7YcavjHRh4p6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784129385; c=relaxed/simple;
	bh=Na+Dh5+jBow+nBNj04kU1IXUL8YiUJ+jDU4l+80WbOU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RZLMQ6jwPO4bzwZqvNxENth9Es8d7P+cUkBJJo94QSrI+4UDa2bRn3wnQY1JKAmyEmBxRcPuWfazZLyUaCbw2AFlY3lLPNQlbX7mI+P1N6m3dOZ7AQ8OUKkREsgk1O2HTlqLbH28Y3vxlQByfQ40MtD/OVaXPt7XEh/ILhHmc24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otzl2xEz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otzl2xEz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC41F00A3A;
	Wed, 15 Jul 2026 15:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784129383;
	bh=Na+Dh5+jBow+nBNj04kU1IXUL8YiUJ+jDU4l+80WbOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=otzl2xEzd7m/ZAwAB3FHuGEwi2xGAmvnNWhU71Q2xEbiWnuq84JvKMNPDveDMSMul
	 5l5HkEqne2aHlsSvYycJr9Rxb3WXB6rwRgVzRnxPrnvcvPYEzkN7YKF2wpI6hkw3Ts
	 U/huSIF9qu4ldsaw6rv1xSOoD5BycQSqC4e+ZtdHrxcK8N46UvqrSXRhTjbgL9Bfy2
	 +6/ZFAN0eAAdZFiO8TxZTyOOj3A/OtB/JMuVuAlrne6Z2/XCudlOOrBVQg4yB8VE4s
	 3xRT5CjV0jvku8sAY+zCmlia59Izs+VVg2P94urNhcSYbtOxrhN0mI69f7bum/GzuR
	 SfsTUt3XIvRDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] ACPI: video: Drop backlight parent device
 reference later
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3052896.e9J7NaK4W3@rafael.j.wysocki>
References: <5115219.31r3eYUQgx@rafael.j.wysocki>
 <3052896.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 15:29:42 +0000
Message-Id: <20260715152943.5FEC41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Update acpi_video_dev_register_backlight() to put the parent device after
> registering the backlight class device under it instead of attempting to
> register the backlight class device under a parent that (theoretically)
> may be gone at that point.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5115219.31r3eYUQgx@=
rafael.j.wysocki?part=3D3

