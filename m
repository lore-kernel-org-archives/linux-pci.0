Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D138E11A;
	Fri, 11 Sep 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154513; cv=none; b=UT9ZSx/5p3f+Yrc/lA6JXebtgBtVftclfgQsdvIARlRlkTlftdovoenJgrdp9se8hmrWJ2FV9XdMTsBDPaLZAdqMo49yvuSFVETPtYFVaOPc3760E1XEoVsV2URjOHGZksTfI9nyUkvG7EcCAMkbAT+4k1A8TkMGpqTlTKE3KdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154513; c=relaxed/simple;
	bh=lyW6FgFjeH5Q4GuDC7upWCOUbsrdjCmMBVD6ifBI9aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDS/7Do5028Wb5ncAWCVjuPLMC5T35cALkR1AGaHDhUcPze5SSofXhJrt3EWU34DofLHvsmk7500Kb/7eIGEJeIxncT9MDoiycs+dNPrIqbDBbb9c7enew3DrlYbq2+B7gr3UgXcT8nR8308rmoR3WbrjUyRvZ9bb1PVHFEQ5+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezQBjTN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezQBjTN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D786D1F000FF;
	Fri, 11 Sep 2026 19:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154499;
	bh=psJvjNPLL8kxV4HTNMcRAm2H3y6Gk207Ugmf49LqXSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ezQBjTN9eYDoj5thAWAq86w6j+eUASN0nFIRuX1bwtV8H0DZYVaOfPPpDUA1zVwu0
	 KG1pvolJ1xdKy5J8KTwoYECZwXqmkzHIAOBED7BUjPoWuwZpVE4ojMx/3Pn1etdnc2
	 ZBg0R+FRqmRnbaZVNWvklq0KoDMZ62eQRFbmIrXKE31qUd3rXCeIVQ2tHLbk9Clqzf
	 hl+Aq+oOXIzrsrO1+qLeu0VY6qe3RGm0W20LwCQBdKoaikbc4srQU17iN3/cnN95Z1
	 Px9XvCX0Ht+f50kcar0gIDOXaa1rGn35Lcz75hL817YaAp3JsoVSnZCzlfROs+1dk1
	 P1cbkcL3+Sfyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] hwmon: (k10temp): Add support for 1ah/80h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260911191803.1522358-2-mario.limonciello@amd.com>
References: <20260911191803.1522358-1-mario.limonciello@amd.com>
 <20260911191803.1522358-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:21:38 +0000
Message-Id: <20260911192138.D786D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> 1ah/80h uses same base as other programs.  It only supports Tctl.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911191803.1522=
358-1-mario.limonciello@amd.com?part=3D1

