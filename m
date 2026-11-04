Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809425;
	b=ZQRHg+aM0/kDqufE7tECyN0XKiy50Mpik3fbqYKwJVi9DDSwBdcX7jW/E9mw+ZY495sH
	 lnxqjL/i0BN0VoqC9PmKLrLw1yaarqtgPxbs4OTAE5g6NrWWZModQpGft/+BHJ6gODvip
	 rr1RZmWD/L61lsFc4Wo90HKfgDk4evpVdCX02BtCDrpBwbvmoPF9EFf5agjzQcUi8mx1h
	 GFM1m5XHQFZkBOoN5lw6Mbyvu9VHuInZRaoGSvC+UQmdhAVG+58qjkymO5qQECWuIabrT
	 HOCT1Q6bkPDDFVV2aPDbKuXGqBHcV4Cdt4RI/z+jqakqhg2kJVGlb9x01APSQ1Ta0Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809425;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Se2aZoIdaNBQp0NYvCjePwsVdbT8VCgkjulY79UkjQY=;
	b=sIoVVmToAC9hDUkBbAfxQjOOrixQCo6IvXexewehFbhxeOviKp0iDm5iim4q/+tTzWY5
	 W3nM+LFiN1pihPis+8HgZr/QISeOSikRs1X1JRT/JtbT6Zk3iQfJeuqyWldkg2psLFzzj
	 msDl2UetkoJyMY9FzVpdj7rgf6pjTJ0oDfX+k1yV3GPDoAXoUnL6qyV8H9NPu0Z6XNpcQ
	 e2n57ONeUjAkqoPa8HluWgX22hpoa+8lxPPo4v3LFVUBTL2r7aU56+hpPAVd6SC2IVzrL
	 t9TjlhMIcgoBOQ9qHIGZz3m1X3GyFBEYis3MmVHUNZxTp6BdJKd5Y8/pAfzktmtVMoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2roblhf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7961606AADE
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2roblhf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6362B1F000C1;
	Wed,  4 Nov 2026 16:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809424;
	bh=Se2aZoIdaNBQp0NYvCjePwsVdbT8VCgkjulY79UkjQY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W2roblhf9unGWISudp3bypQoGI4bZW5VqdkdZSc/hg//WEYyRPmdjM7a390RvZbJT
	 CZG/bv0Tj6xECTsSvrTJm6/x3FHbEg6r0glCbVYVs6qiPwoSkeivHZiO7OvFWEeq6v
	 EqC4B+pHH5AUnLxoVnsYid0Vvtn7b4gTqhtFcIqXFLfXXRNxAJOi9qFKYVr+o9hG+s
	 kW7YirTcrdWsTM/MJoO2hUjZn5/RhY9N+6PP/UOtGK0PXHN8JuiltN3igMpksrv4XV
	 wZzePRefbv96sVwIMjcRl/qeQDHySzY9OOjPJOJVms6JYolmUSU3jpcDjPRe1letDW
	 wpsfMLNUJfGcg==
Message-ID: <sashiko-outbox-197601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/15] PCI/TSM: Move core code into its own directory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-2-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:23:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Multiple patch series modify drivers/pci/tsm.c, and some add new files
> to the PCI/TSM subsystem. Move tsm.c to tsm/core.c so these series can
> share the directory layout and reduce merge conflicts.
>=20
> Update the build rules, local header include, and MAINTAINERS entry for
> the new location.
>=20
> No functional change.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D1

