Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD43CB8E6;
	Thu,  1 Oct 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865406; cv=none; b=r7ME5x/NLTcu9W9bA+xM437MhLae83j/3pS1Ob4sRaPilzz+kvxN3WjQ+GGfKSTn9uADU2i/3uVtCDAvLx6TytOC+HTYwDGc1yXqCaI+m2L0rZgwN0+gqhfvcpx3WUjbFVdWDJUyerWdDENFX5+Hs9LBVQ6pdlUl4TGnC+aiXIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865406; c=relaxed/simple;
	bh=DsT9jGtyXUN23nX5Fc+zKuwTHmOy8VSuBrdGl6ej58g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P5NNb5M8wXadaxvT6AVehZQDUUj9SLktd3pD/02SUSjxHfqAL85DErJzj3n66tNLmTYj4Vrreu0Jaldx/H+zsBTsKqudHiQ4eu1NB09u2CE8y2CxlFGgbv0zm/JbLgtBf9PGhLvLydIg0DRKlLEzK36ZhPtxdY2Wu4wZakFU2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5OM7LSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5OM7LSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBDD1F00898;
	Thu,  1 Oct 2026 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865401;
	bh=DsT9jGtyXUN23nX5Fc+zKuwTHmOy8VSuBrdGl6ej58g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5OM7LSH0+h7ZVUVC/l+s5cJ7+g5hAgUwFXf578csfLMFjyWu+81h2eG309c0ZpL0
	 GyYzDW+3Awxm8g8elIuJFRYX84keSEYFfR+rdpafMKYOaUv8r1m4ePy2219cMD8KQr
	 CrjjiUgyUCsa/DI0G7Ic4nlte4PkAcqnKyW/XfRy0seft3yEcWiG3GqDpQUa9uoFYj
	 d88BSafPUJvaiK6QzLNvmONsJsfbxLlJthtU+gUdkET1Cg+XOAMxfdJlMBFgq38Ri+
	 TFryUO5fNtuVHhdtBbluLM+xLog6f8cYRg/KpIaeba3AC5czKzxOsQ+4dK8uvT+VVe
	 PpcceJ44MRUZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001142815.277550-4-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:36:40 +0000
Message-Id: <20261001143641.5BBDD1F00898@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D3

