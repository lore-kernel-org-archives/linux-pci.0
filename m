Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400012BE7B6;
	Mon, 20 Jul 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560996; cv=none; b=Fgc2gtvGOdx+7EEazHzQX95r6k0jVFBVIa208I+GQyAlsvwApWUncHkR5/DvQTen5hzX4x2qCCjLuFDkL/SwX0GNIaBQPhNnM8k9RN9/rSLdmzdAFH+AiO2jEB9+3bMoV87GwFGtQxX7GzZjBwiWsVg8IZHlYPpzuYyu3qVJUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560996; c=relaxed/simple;
	bh=u/TzgPAs2za9gu29wuRvJUqQEDI0bNBGgGFMN+dtimk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cgVqijUW2fBvg3Ph0cjgiUR0+fMvbhstKRbvqwB2WiVntJoTCUQXaERuV9/hRrtxQ1NZ9pLyHyw59p8oj1b5rdeQOLbmc5bBLeVVigJ0oqzogZbtIZvgG/akVjR751k/P1G4YVEib9PZVPfE8NMBrFjUBm5wYZWUw0T3u5ft4qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sxc4libi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sxc4libi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD361F000E9;
	Mon, 20 Jul 2026 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784560995;
	bh=u/TzgPAs2za9gu29wuRvJUqQEDI0bNBGgGFMN+dtimk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sxc4libiZtfIzG7ljO3F1/ZwZBd16RLtLmKVBuwDu0zp6Dl2kqzFAMiv5nlaOzmFi
	 4BwO5iLImD5TI/Y29zjOXVy9y1BYf6RDEHsSh2dCVJqXLCn5aOmpAVRTLvtPhnTyMX
	 bVTtluCtLqzS/fYwsarP3coch7HZSj9VVggu90WCKAxOe4v/Q17oKukVKZC/WJFMR2
	 ojxL4MJ+oUw1s2uNzozCtPLOeT9hemblI+zR1ewF9d9zSWqIzj4mcriHfDKdnco4Gi
	 Okah8FeZU6iRoicSLkVzFCdG3sZs8ayb+2QMjh9q71r/lyku21LB2hKQWHXNNx1/jY
	 E0gvGnJ0T04hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/16] PCI: dwc: intel-gw: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-amlogic@lists.infradead.org, imx@lists.linux.dev, neil.armstrong@linaro.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260720150619.24733-10-18255117159@163.com>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-10-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 15:23:14 +0000
Message-Id: <20260720152314.AAD361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> dw_pcie_host_init() calls .init before caching the offset, so inside
> .init we must call dw_pcie_get_pcie_cap() to obtain the offset (hardware
> is already enabled). The helper will cache the result for later use.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720150619.2473=
3-1-18255117159@163.com?part=3D9

