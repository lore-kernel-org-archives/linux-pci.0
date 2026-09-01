Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AF823EAB4;
	Tue,  1 Sep 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252750; cv=none; b=ZLZ+Y+h1oMU0yTa7EaFg7nmsYalmcIaYISxFj7xKRE4XHoOOE6UpSHuiHPv+XkKxx0HynCZluC64sW+ck6IcvJyiBe4L+WZI19JCEFy3yzB+TxA5gkrsaHJRTIG7Z8RPcmSDBvs/IerjP6CqwQkAyr65LzCjpk6Yo+PY0ZmVnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252750; c=relaxed/simple;
	bh=0qUADuyYfWc5hfxXFgbA/wqGqLqYo6kqKOfvczFuS3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k/6e58/NVI9qmV5X6+RcvRepmF8GVP+Ri7MjvmFCC/iguwiqd3qub1YEYtVtOr+V9YpeK+jY1NfpAgcZ0bW9ff9Gl/ItDCCCrbRNpTJEpzlRB0WW+NqqpQ9ECjhlz9iBcWcY1rFF/Lks+pFuCpfbAz5tRHUOenx364C09N8q/b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSTEdYk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSTEdYk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25731F000E9;
	Tue,  1 Sep 2026 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252749;
	bh=0qUADuyYfWc5hfxXFgbA/wqGqLqYo6kqKOfvczFuS3k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VSTEdYk0Nq1nev2m8Eru9JX9lWM6ddJRMfoRugXlGW0DlhjsFzKNDaWdIgvYMwit/
	 qgEoTWkIB0L9VCbmLWUz0iPvo22nagL7csM/cQdtIXj7xHPSWWedRiItnQTWIHmI+2
	 VdFGvaQ8QKXjfKNvpA0OfGcremq1u6PQsnrcbVhBMIZlVWKB7FKi6cm23JuXw5ywAb
	 1Jwk6ybVIS23a9vOnEU2gPY61f5Ghx4j6198vTyBnELCoDXCzOKscTg3cxEu/YvFam
	 gkp6OdGXzpnwyDssKMX0VESirnXPf4WaByyhQnXzhBb7ECzhdqq7iH+LHPMlkGxBE3
	 f385Rr+0SChjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:52:28 +0000
Message-Id: <20260901085228.F25731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.
>=20
> The device contains an embedded microcontroller and on-chip flash. It
> automatically boots its firmware and requires no host-side configuration
> for the on-board use case, so it can be represented by the simple bridge
> binding.
>=20
> Document the chrontel,ch7218a compatible.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D2

