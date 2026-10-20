Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483750;
	b=AvubzIEV+7N/vQ7sMte/KdLKlF0J9JDJd0USSMzULg+lO8h800SLWL8Iw/7WdsHu8FVo
	 Zwi/PHCNBjfCqxirPyVTWaYMEjTu83x93oM36IV58EGz4X05ON5kW4JQaF1IRrK0qUAcW
	 0jDZgfFt+bYrlCHz17Fzhxzb+U2ncNamh8PYiBzD0snPPqOI2L10LGF71apMbSze9vB6t
	 uylolrKd3WZAjyziLDhbuD0yD/F/BAxrdjYojP3+dstxljDQdabz8X6FxKcaickGL2EWN
	 rgd6XeptTLtOoULEqjJrdNqe299PIHf0EnnUpEe5mrAM9jAfJQe2m8G8tYkfaW6Q6Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dwum6lkR8/wXjd4WO/iP68/SPp0lpCutfz9hHR679FY=;
	b=Bobj3YhsdIWTVSdXeXKy6A0TI3KiPsa1gowlGCrhf2EM07KUgOOMndDjztjfLYB6aaCh
	 Ixi0KrOOmxvVlMuOEeJeSIyknwC/70yLNMHWf1SSrwB6D9gCo12lbms2sYnJHBsW+zVwP
	 uhLE7mNPKU21hVASinHOfG/TXrSNrEs4OyaGGVunpCq950jRV5TJyuaDHtYeuhoHXIMEw
	 BI4Di8kM9a6JJMw4nRo8w7d3htRuMULRKHZBB5IatP25D1+G3VZ/Psx4H04bphoIyMMo0
	 +10LfFSuY4xS/LPYvZ3l/Z6sodIukOrwg+Effy2g45nMGltUqN7gSZNVGjqxjXMzd8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VerUVgho;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A5606A31B
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VerUVgho
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455F1F000C4;
	Tue, 20 Oct 2026 08:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483749;
	bh=dwum6lkR8/wXjd4WO/iP68/SPp0lpCutfz9hHR679FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VerUVghoWP72J8LkFe+xHYWptItfmg/U8zHUHfADxeIVG36BBUivIEtyJ28KUzLLv
	 IhR0Ho91+ZtgnS1twiZe2EetQTNxTXayU+55PKry80J1Av02iGPeRt2EJ/XEmVy8wH
	 TJefgG6yLGVIE9D+EFYt1dKD2y7dI8UPONWbGB8L4BhDCbc+BO3RzJ/rO+KmvX2pyj
	 6j6OgK2GyRYgxHZlAwYNOMsUKfvfR0HMGrLaSiQSK8geeMBG6/jXzGOOjRsXx2bYJi
	 /irvQCq9o7OEOXUwBeZkUqigVHjs4DjtyDZBnlR/8Qag+DIwFzcj6Wo3yJxeUBDv9G
	 SjTssfK/2xbdw==
Message-ID: <sashiko-outbox-178482@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Skip MEM outbound iATU setup for identity
 mappings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xincheng Ji" <jixincheng@ultrarisc.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
References: <20261020-dw-pci-fix-v2-1-32b6d62e0edf@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:09:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> No outbound iATU translation is required when the parent-bus address
> matches the PCI address. This is a DesignWare controller property, not
> an UltraRISC-specific behavior.
>=20
> Compare the addresses directly and skip MEM outbound iATU setup when
> they match. Remove bypass_ob_mem_iatu and the UltraRISC-specific setting.
> CFG and I/O accesses, as well as non-identity-mapped MEM ranges, still
> use outbound iATU windows.
>=20
> Fixes: 17b478b29cf1 ("PCI: dwc: Allow drivers to skip MEM outbound iATU s=
etup")
> Fixes: 8da2b970ed4c ("PCI: ultrarisc: Skip MEM outbound iATU setup on DP1=
000")
> Signed-off-by: Xincheng Ji <jixincheng@ultrarisc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-dw-pci-fix=
-v2-1-32b6d62e0edf@ultrarisc.com?part=3D1

