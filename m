Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230165;
	b=pLg7xzg239jC9zAMNyXxvIQqPz68WuKj+fd2wxkl2o+4p3RZUHJV0Re81nydv1VCT9xi
	 osJzzlcqFLF3F8w5vNIidwzU/SVzuPE1gUVMCmjB9YooeWvO45kojZOeHhlIayCOnpkJ1
	 wpFhhOvYQNtwenrLqJqFXiM+KMto5bOTq1etF+4uaS7qji0idqmaZnlWqo9sNHqeAKq7E
	 lQtrAnYJnNHDbqt0ifFIYtc0k6yHB9u0YQxtrpQGq3Q6dko8AKtZEgCHO4iuZjTba17mM
	 DnZfgPbgcPjK7RhTvfYehlKPzUfdAn9tjieUHWZjHVrsAxXMkoYHpNDH1aRDhsBPGCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=grRZn3KFq4sikzSa8kktItQB4OY5mg8WCv5LNb1K5IY=;
	b=RxTLvyFvlcS0ydiXAj7/qJEKGcMDPBYwm24sh6/PqmWofTC8qb30fvgXf63TyCsWE/8M
	 DFNCcdf36ElpIOw3f+fQmJP9bCdMdKdPF2H3KZFBmCYkvnzel77Nxvy+V+HJiqvBW3ABV
	 OAJ34Tt8M7blligKz2JcFr/0qY1vPKFOl2qWSJtV5oMgfTvwHVh0fUULAFwefentvllpF
	 kR7c5uiQjCKZOcff5T/Da/yi5dPlVf/JOkuH2dOfxZcH8JINhO3rV+6lL5OcI3tTUbgca
	 iQ+l3i+SMOlZ8MGh2y3fN6dECDCpmMSm9Si/BalofMl94qxD5YhOpvE+ZpC+9SgxU8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMxMCPYK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98C606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMxMCPYK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67191F0089F;
	Mon,  9 Nov 2026 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794230164;
	bh=grRZn3KFq4sikzSa8kktItQB4OY5mg8WCv5LNb1K5IY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QMxMCPYKK1fqEBMtl8KzOlQn2+oPRGUlOG3SyAI2Y3hmNKcRq6uGnU9KtlgO7USb5
	 rAwtK7LwBGBt1Wog/Bowh/rjAmH21DtutY4nqy4iSQgJZG/yYKHuJRPbMSE6KD7fVL
	 HBM8EJEHPwXEGSEllgB5MeBlgy5ULpCDyg2d4wd38SF21255FzU/hmI7eaRyJBZ+Bq
	 iPjbkp9ilfHwKfesnZImc34D2Y7YMS0pySm5h47/nhgiWPf6lM+cWI5ytB4NKCA0zF
	 6ijOuNf6EPb9oa62ZMvRppKwxzihJGuUgwUnt/b9hkWJ0L1oOJSKyQxEVcUwcdB8IP
	 KazE0EKkBVPgA==
Message-ID: <sashiko-outbox-204994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/i915: Remove driver side resource assignment
 after BAR resize
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
References: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
 <20261109131011.1815-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:16:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_resize_resource() assigns the resized BAR and the other BARs it
> released, or restores the original configuration on failure. Calling
> pci_assign_unassigned_bus_resources() after it is redundant. If that
> call manages to assign more resources in some scenario, the problem
> should be fixed inside pci_resize_resource() instead.
>=20
> Remove the pci_assign_unassigned_bus_resources() call from
> i915_resize_lmem_bar().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109131011.1815=
-1-ilpo.jarvinen@linux.intel.com?part=3D3

