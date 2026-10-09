Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534147F2C8;
	Fri,  9 Oct 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532700; cv=none; b=d9Tt7XqH11QxvhUAXurUlOkz7PB5tc3PQwKlZaGmYQHjFcAJIiTQYPUxZZZBL4lCaApBHkh73u5kKireqS2h7lTb6WcLU6ySt58dLH75IzCYiBov+6vxfekQFR8DRrKyf54qFxustrXMNao6YWtyYop9rPN49bV5rXoBVsB+HMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532700; c=relaxed/simple;
	bh=B77fDqZHTn3Qv92/KM5DHEl/rBqMN2XlVGStZIk489c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uZTsD3h2hH4b3BXkuLjm8i9zOZaSQfdoiqtJX2H7u2FnCEFgOGeJfG0toyD/hp6caZk/N6rL7gTtgExFoqlSa8WIFC2+CrxTEZcMj046SR54oKG58RysM8vEpfJ4yPOnoDHXr4NALBIyhL4WWpiykojJ3d4cMUv7lE9vbJ/LK0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei99OhWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei99OhWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5701F000FF;
	Fri,  9 Oct 2026 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532692;
	bh=B77fDqZHTn3Qv92/KM5DHEl/rBqMN2XlVGStZIk489c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ei99OhWiGFIVkC7z7IcOuRvQcSVivaeZOn1zw0nsrra8br/VRjdy8GWHWRnPhqKAc
	 61eG6fJXtE884Q96JZbSf+fTKBvaifyOtLgz8lIFRJkPWIOfTK5QOVEYxBkhTEBPZZ
	 C0LH6vqfE9yMNlygyunUkTtecymkGMy9nPsAW180ieiu3VBo+mB25G8/haF/3JYvAv
	 AnJmzXRFgesbdXK9X2SsVi++5FlrZXsdV1Bl8GKR3u53XXctH6tQXvRbvM2JWl9/e6
	 cja2ZbF+frEcXBNXn4UCMmv2fPFtCEz310jacC+eDkx/eOuUes/y+qoHz1w47CwXre
	 zXqpzTDqrYcRg==
Message-ID: <sashiko-outbox-165044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-gpio@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:58:11 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
>=20
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
>=20
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D2

