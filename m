Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3645D5CD;
	Wed,  5 Aug 2026 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931607; cv=none; b=fujljUruncID36BvNqKooNkcsrjPDoZzW8ZYkHhE3G4W7OdszAmCBqYDOU6nRmsg4yqIJGGQTph7/yuI6DwIK1qK/cUqYrDoTA4WDb2l39rZywIq0UHQN7Crz4Otgi+aMYfd+/0dqTDhSiUOOziB8J+1A4KoTqsvoRQebEpRLzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931607; c=relaxed/simple;
	bh=5mDmRkVGpZzsfeG24i1fKnu67/uBapjqil9rq4z9Vro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pBsqddoQ+l23/TdVm0PQPeiql0dmUZ5BkX7txhV+0Ar1TLfblZnjq707Fkl5oclf+9c9cUQVupXhQFoXPDsp6ztjW4EKpGytY2kg/IwaELMQm3fJEctLk8p159AiLOHyCYNt+4lSvo8sScdopCd9Ju/j0utb07VKhEEfCFtTT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw0CsAtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw0CsAtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74081F00A3F;
	Wed,  5 Aug 2026 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931606;
	bh=5mDmRkVGpZzsfeG24i1fKnu67/uBapjqil9rq4z9Vro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw0CsAtOXA3S+nVn9h7FPUnd9XQ5R1CATObxnlsJLc/PNfGcjLfw1mlSVVFmTgm9c
	 XgcR4U9PokK7wy4K521yvjlTSLt45ewZTs4D/oUP9kd2QfNadQK+d3poqyHOZ0j8Wy
	 Q1h1zprJV51NyDQHtYMBoV0azcMexsvPqbMTlVzKWodLpAnWrBFvPyrOqjupextG+A
	 ks3cXEV7v+AlRKUDTn7qwIZSK+6AkuFt5BchK81G1UGNdxUkLmbcc45QxC4cc9s0FV
	 qDAyWd2la1hWswhyhgg/x1seqjmIWcEi/zv03HpQHkmljq7au1fpEmQ7t35iZoHPr/
	 Nr8nQxqCeInuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/5] dt-bindings: pci: tegra264: Strictly distinguish
 C0 from C1-C5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260805-tegra264-pcie-v9-1-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
 <20260805-tegra264-pcie-v9-1-fa2ed7350ae1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 12:06:45 +0000
Message-Id: <20260805120645.C74081F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Thierry Reding <treding@nvidia.com>
>=20
> Instead of using the ECAM registers as the first entry, strictly make a
> distinction between C0 and C1-C5. This is needed because otherwise the
> unit address doesn't match the first "reg" entry. We also cannot change
> the ordering of these nodes to follow the ECAM addresses because that
> would put them outside of their "control bus" hierarchy since the ECAM
> address space is a global one outside of any of the control busses.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-tegra264-p=
cie-v9-0-fa2ed7350ae1@nvidia.com?part=3D1

