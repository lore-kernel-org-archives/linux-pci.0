Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442824;
	b=KAiWkFYrtxSDWM8TVEz5OfP6CrZGwr+cGOQQSIfcQQsAUApVkxOUFXUkFzOu1A8aOAxK
	 gPkjb9yKtTXJfFGZ95sJ+Z5HPkRlKbFctXKbO9aGWfUy5JG6CY2qYRrWVOkanFBqLrdum
	 RMjim5Yu8qb3ZZW+aqI0dOfBYitD7jnBD8NTfiZVI9111RHgbWLI6nC+O7HzNxXGZ46e7
	 C3Kog7UTF3XQr2TOZ7J2RbxXPk28Ss9RCaxCCuA00SRK9NB9kglugz7RPshEgi4hzjKJP
	 fa3QK+CedGlGtESYbfl699FdvNit1yD1UPrcP3nJ218agzTHzmqAGQNzNWagq0+qijQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CxTL/1xzQg9i5ndRFhy6VO/kcVQZCrHef5M/dG8Eff0=;
	b=kMrQSzi3ggfyp0ET9xawQ7cWR7JEkfPRewQZzZoI1q9TQE8ZAndKS5BctHITPEJ50QYr
	 1j99auDYRw/bnyvcbTN8oQBz0JhTkOfNXCpK1RQFmErWGoeXjPKLq6jZU1ilce3MaCrp4
	 U7pjmoCIaWLpWNCdPTuw6/a27lPvwrroEJ8q9ZCvgDhggSSyC7GC4ABml4lhQZNtXq9+Q
	 h2dkkRqmq/LYR5Mlvq6gJi+k18Df6YLFgBWW2x0v/MHYfwACpAYoIyIbLEU0cDX9pF08H
	 Wc257F8he6YR4WGTycu63achhntrxpcjpa3NyitXnz0XDeakddnl7X39lBo2SZTTS4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+IcUbZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D94606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+IcUbZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD1A1F00A05;
	Thu, 12 Nov 2026 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442824;
	bh=CxTL/1xzQg9i5ndRFhy6VO/kcVQZCrHef5M/dG8Eff0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+IcUbZQ81a+1cIDHkmxIaKx6dCxf46NkbsNoIhKLUFQ7zVrPrHwtOh+FgiSDh1qv
	 nvY6A3BrBr8aw/9uY/wHofyIAL8pD6qR4XpPqtRJ21Ac7I4YIizTaA+Rz63CoYsHRL
	 sMP+5IA6Fx085iiWPjfTtJ4l6qcfigp6Fi/B/eFRIXOZ3h+4lJw7uxQv/66mCAFI8X
	 g9c6VDGivPtGW10e0aToFLjsbuI00AzwhRD/vMjqSJ+dcz+6qdxTq6E1drni9BFof4
	 joW4NhiMPoPqrQQ0ZsCs2IVQ6S5XTqpqZq1l9Np7n1IQAI8v486IzDgc005ZYBNUW4
	 VNTppsX+0Qcyw==
Message-ID: <sashiko-outbox-209902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] drm/amdgpu: Include <asm/cpu_device_id.h>
 unconditionally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-4-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-4-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:20:23 +0000
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
> <asm/intel-family.h> is included by <asm/cpu_device_id.h>.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D3

