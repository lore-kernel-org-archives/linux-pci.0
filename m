Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF0430CDC;
	Fri, 14 Aug 2026 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786722298; cv=none; b=mc+Rf+WrjDbNmAisXjzdcLRdzPzB+Gb2+kjyPZAEBuKXriiXVeWnNRTK+ril3l7d96Pgw/ZY3limlFsV1LlzOisFwkJdQohPQ7AQKGCsC57YAp1jVyCVaSu794ToWlyUgz1/APCAxsDbdMJTJro81PK5QSe7+g2sqGzMm8TfPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786722298; c=relaxed/simple;
	bh=wE9jL++XKPODixG/P7j+h3Uf9gGdUQlwsrywExXay9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dI6tCIBJablIYI8CGKXop89M9LKo2jMbJC1PtI3u8NHs5/M6lPJO4J5DL7drWK39smlNNqLdo7227ispQ3/pvpwDMUu/MePS2nTnaAAClKxn/aR8jcc3Jg7PPSdAe2+x9buJ7G/DbJ2tr1ISe0J7DeMRIcHULs5qXttJ65/56cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efwUOk3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efwUOk3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF71F000E9;
	Fri, 14 Aug 2026 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786722297;
	bh=wE9jL++XKPODixG/P7j+h3Uf9gGdUQlwsrywExXay9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efwUOk3AwRUaMd+tVh8tyTrF1Xxu/xtwE9M5dNj1VjgNlRicdIzheJJToR/V8rtsl
	 2IuQSFpILR3/Cxc2o2ZcCu7YXbpHQPT/VH9SHGx7yZdbs8FNWWVxrPtncIO3ebyKHB
	 Vxq0gWWU/Z5rGZze+qC+O5uSO9bD/0FsA2oWopxghZa3HLSXUaAqZSTsd3NWWbd+mS
	 tYw6znyskyPJci3yKGZ2EID+oSoI/t+bs5lGJtlOxwk9ogXQ+IkDv+iwvehWduZ09c
	 jB+t0+6HgEhl3B+lNZwTTw7qrT9oWCfREXkooDVWfb6PclDkEY7KiIbAkPosPTggWz
	 EYSI327oC8ziA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 5/5] arm64: tegra: Add PCIe root ports on Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260814-tegra264-pcie-v10-5-05d08c592b05@nvidia.com>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-5-05d08c592b05@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:44:56 +0000
Message-Id: <20260814154457.54CF71F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra264-p=
cie-v10-0-05d08c592b05@nvidia.com?part=3D5

