Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442640;
	b=Cty4zyMASYPgH94zqYYL6QNuvClre7ss3SxWlyOd0LhWJ5hGEM2jnufyePX+2evPwXGG
	 +rnc7LCRHF1qCdSdag7gFYPitFjqD8wAz4ZvwNK7REXuumcHo7uAbGrk7NcgBiPFdVxS8
	 bIJOci3h5fJ0Wkr5/+7Id4wO4on6FVfXlk6SuFk9L1LBed9kKBRMUIs+RM0vIl6nnxC6q
	 sNQr2qCrRzxc4eCpNDq5Be8NWjWZdD6Ovc5vQLHZv2Pcx63huHGjNFj58kEcUMmvC1RIw
	 bGTg64PlgXWcnnAqBZfMivPUvPLKn8PrRXEaU3PTymtZGF8oKaFflChAjgPUegRJC0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YX7OBxwCmyvmPFvitPpWGopWqjqYb4Wtn4hxepp00sw=;
	b=yphjYoDAKqlnrltDtI8T/InW3GTboNe1ornCCqm9+cHcihQGarrtQMNo+SZXS1bXoAoy
	 tEysAo4dCG3WnB7CfaLpkHQ/Q+T5G4DFwuHv83rc0n/9mKWiCGy4MKZSbhLsIw3DB+pNL
	 uEk0u/8GvKJzJ7ExSNrLKLda/6vqVYevs4JU7iTM1PDZ21QH9NObMqDOuhZUVV22Tbgwk
	 Nyxj40nYw1K24Qde9Me3KdFShXSVofugs104nQ9hffh8RoWOVmXLDaU2bW9sryoZgdKvL
	 06C535Q5fsal1jOd8HiBYFw5ATTAcQnsFmLxjnRx/TIDnPQfj3W1w8ZJvlWq2/ci9Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fvex6H/M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F83606A330
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvex6H/M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F200D1F00A06;
	Thu, 12 Nov 2026 00:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442640;
	bh=YX7OBxwCmyvmPFvitPpWGopWqjqYb4Wtn4hxepp00sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fvex6H/MKbVoyzFxFTtrVtzeDAGI9pfztKO09TPmIepbvVBK+Zt0NnAJf/voyaVXE
	 JMebm7YG6P9u3tvpLPGQO98gP+Lr8gcUFJknvrth8ZeWTJG/MHmFe/XrJI4tplQgiZ
	 EA2bJvqRIdVvyAeMxVkrsHJvmUX8OXrQ9yP6T3HYGVFFuuAckpKD9lvnRP4Rvn9kpS
	 mtBLc0CO/x4h7FSWmVHx0P2IHK9SgJLE8lkfhHv2T91AlSAKIu/vUEqWBe6TJXgGPr
	 DCl3/gr2axKrpBxdi4NIWDss7GAjlt4iMU84iPHg+jFJeiY1CGtRlbB/drrDxuqOtR
	 zV4x7By5Y2Nvw==
Message-ID: <sashiko-outbox-209896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] drm/i915: Include <asm/cpu_device_id.h>
 unconditionally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-3-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-3-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:17:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
>=20
> <asm/intel-family.h> is included by <asm/cpu_device_id.h>. The CPU
> match table still needs CONFIG_X86 for the INTEL_* model defines.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D2

