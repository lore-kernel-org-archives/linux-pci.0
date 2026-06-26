Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1C9288B8;
	Fri, 26 Jun 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465982; cv=none; b=lOHKj5kffpnn5xdq2pZj76dLTtp94YhoyFv28X4I5/8V1VZQ3fShtcGIx8BdTVUdEmdxIkHbBGwzF6UTMdT0d08Wz41Br5QdbZJm3iWwNuVzuOP/W55LgxzYkqPD0FVglGKAPmnRdeubWn6rsda5lEuBpd+7W4KBHImvTZD5o6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465982; c=relaxed/simple;
	bh=kJczjSgymTjyLlOVg//iCerVlQx0COxgwjgmTeJggg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOxe+cup5ZDK7knqiFtsSiAs0GrMxM7efQnQp0Blj/fkVjTqXgMGX/GTgLLucUJmcV/6pSIEItFyobxNbi2B8O1y4yWr16XOnhewAXr9mnTqGaCEUVjUCGA5IZIXIPan+7dB0UGMyCtDzpWty1ZsKYjg4dnUwCyTZNyqa52MA54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9AtRuJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9AtRuJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830091F000E9;
	Fri, 26 Jun 2026 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782465980;
	bh=kJczjSgymTjyLlOVg//iCerVlQx0COxgwjgmTeJggg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K9AtRuJzdJNj/6N8Y63xUVUaYRk3hq016cY97hHq0Buad0dJlweoUh1K5DkBCZ/g1
	 Tw8njRFpwLtveY96eAbVFDMmaonQgRK7eZyIBZlM0sBNvriXu+PUSv+yFk+QKeLOcB
	 doRV8Z7+Y/XC+vm59PdBvIe615SlZJ0aCwzVa38O1qLmCb1Qvyd19Sj2YS9Umm/KLD
	 qlWZexaE88MA9F8pradrzs8MhpjEvtC7PvdnZfKoAm2XlWHsh4R/6ul66nZh01mHoN
	 d1/PQ4VQCBBjKEpX3YleHZSCM+lGzy/vYOmkRcSIi9/YnN6LK8UrR4vIpGtovRw3el
	 j8+WUng5D7GsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: mediatek-gen3: Split Airoha
 schema and document 2-lanes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260626092029.3525264-4-ansuelsmth@gmail.com>
References: <20260626092029.3525264-1-ansuelsmth@gmail.com>
 <20260626092029.3525264-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:26:20 +0000
Message-Id: <20260626092620.830091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To permit proper documentation of required property to support PCIe
> configured for 2-lanes mode, split the Airoha schema part from the
> mediatek-gen3 schema to a dedicated schema.
>=20
> A PCIe configured for 2-lanes mode require an additional reg for the
> secondary PCIe to be configured and the airoha,scu phandle to correctly
> configure the PCIe MUX.
>=20
> Rework the mediatek-gen3 schema to drop any redundant constraint previsou=
ly
> introduced for Airoha PCIe properties.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626092029.3525=
264-1-ansuelsmth@gmail.com?part=3D3

