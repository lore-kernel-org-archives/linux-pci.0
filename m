Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F1463B72;
	Wed,  5 Aug 2026 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931561; cv=none; b=qMXpFKGg4IFwmMPHEuUHbS1OdvzDc23BF6ModjRhCOPn7EGknfFujCxtpuUZDbiUDhR+quqNCJp69mgCIs++zX2lJu5V8L3YQnZakE3PhZPQeJm9eZ149u4qvlLEFrwxdN7fEkR1OZRmho4QpMyUkVk2FbW64VUjNos8d8phKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931561; c=relaxed/simple;
	bh=crrD/fG7IiqesmqfNqgwkzUJAcD2abPGrAO9jTSyMnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L16A6+XHrWnDQSpsLLkeloH/cILpbgxJ2OGDfGwqGjs0sEvIkkWY0nWPgH9kRmbIqjOk0bXSWy5DGv8pzCrCGgMhkcMErTjjS7elN+acO8GZK1WUNDzwbbcKbeWVo3YHq7U0/YyXwIC8/nsAQaCMLTJE4jBtHI+jUfl91VXBHDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRZsvM8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRZsvM8h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716661F00A3F;
	Wed,  5 Aug 2026 12:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931560;
	bh=crrD/fG7IiqesmqfNqgwkzUJAcD2abPGrAO9jTSyMnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aRZsvM8hwzZdV5K5/k65QCyMqAzhKCsdYBBgKzjxRK0pb9A1/erSyldjiVQUlrd7k
	 Oboj8WeSjPRXtfPhkHfllw/RtoebTZgg3cLRe++8vB5hLYKV08nGVz7rPvUPCfa6HZ
	 kamt+fl5PM5m0cMJWTSk87sd1KNI2k68OJcH3bwxJcvFKbpLni5R8mZgwPwpj2xPJM
	 Nl1Cjq7Pg0l57tyYYMn6shkz7KINRufUBs38DZcqQCixWArOWPmJzSPG00/rWcUp4w
	 my0FoNO5o8JaKJPa2dy2ALiW6UXt0/6wX7ahNiEol1gjE9Vfp7KL3d0RBcdcijqbhN
	 k5wGpurnjT4fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/5] arm64: tegra: Add PCIe root ports on Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-tegra264-pcie-v9-5-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-5-fa2ed7350ae1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:05:58 +0000
Message-Id: <20260805120559.716661F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> The bindings have been updated to use the PCIe root port bindings, so
> the nodes for the root ports must be added.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tegra264-p=
cie-v9-0-fa2ed7350ae1@nvidia.com?part=3D5

