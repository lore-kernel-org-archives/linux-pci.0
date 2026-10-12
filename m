Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE048CD7B;
	Mon, 12 Oct 2026 14:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815630; cv=none; b=O8jJpaD68ZAl/KBqpye8z4HwWPReQQfGUO3uNwq4QfNRTdkTLqALYoKCoU32CG0NpTFK5JRvZAYxwejv1ufLtFB09LQum2qHqsWh+4tsom3u2oEWOXJHkKsAUDgU5h+vGtB8zvH9tKkdWbQLs6Afza4YTh51v5gAaYUr/icOgqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815630; c=relaxed/simple;
	bh=VJ3uo8kPFg7mXVbHk0DWoqi4U7GgHHSRYQkbkWSyhTo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V7+G0mY0oNUmRReyA4lHaIAWNCxuSLxwV5NqCwebOqLx3PGJIN5nKVnV1kvtPjP65CwerpPWVViduIoz/u/HdiucLdZ6GKbfwKBvEziRinDeNJ0rR0sqjw6AhS8dxLj7o6P3LlubzdsqgosRsqXgKCqFjLkC1wLtpGnUAZyzO6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDC0EL3I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDC0EL3I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500471F0089B;
	Mon, 12 Oct 2026 14:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815628;
	bh=VJ3uo8kPFg7mXVbHk0DWoqi4U7GgHHSRYQkbkWSyhTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDC0EL3IG75OLP9xfFn3a/XJLdHXe7UByYzQN+UNxP8ncYqgptoRuMh4l7OfKuGyo
	 Lr5aJ2TaWqVnFQuTscpL4/jkRIMmADne2NyAv+COvlT5tgy49V7sKDwuKaGij9/rQk
	 CZXcikX5oBtJCICgu58qD8kVYhSfoIw/3k9xMNfgAuL+Reei3cp1O7GxvPncJHcJ8X
	 YpMjmZGSS6a8NfOgKPjxs7M0h4Zg4dRl7VnrHajvOkrZzEbH2CkMtJ7yIR5JcwpMPB
	 XnZ0ivzeyyoHAmsCkW+6mZoedfsj4Lc76lbXi623OQ0jE0LwFwS50AW3dVKKZjzWSG
	 n8ky8j01qzwLw==
Message-ID: <sashiko-outbox-168268@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/10] drivers: core: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261012142826.159178-3-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:33:47 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D2

