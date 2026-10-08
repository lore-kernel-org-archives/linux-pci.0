Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564431716D;
	Thu,  8 Oct 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439869; cv=none; b=FCZ5pcAEAoSbaKDvjPD/qHlXk1+LQnw+zWXNYIueComm0VRsZ6x5FZH3NOkMPxPjBGgzKH88UaquxvHY7m9J7n4zQyyW2Ld+cPyE8jYtU/tcLoXTTlmqwM2t/8dmQO+MgFpgrHOc/9epJ+ZncXtd6PvcakAtGMFjqOO1x8ft/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439869; c=relaxed/simple;
	bh=pL5+/ZdOrN7zK/RQowbJ9/1HzihrLA/jdMdUfyNP1iE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z77BOW9HSdl21F2fFBkJRar0uw/gbX3TqiX2waCdGC+M8vI+Nyotme80yxUpmgfUUSpWImjcxSa6T46V5Yt8Bdv4sLAsxx4fYCfS/jrXdLLzUy5YPGeTAq37kM6UZmgQlZr0l2ABycj6/EldBiZj7aVeiLy4iGnZwoPCsPpk688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJB7Okdj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJB7Okdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935331F000FF;
	Thu,  8 Oct 2026 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439867;
	bh=pL5+/ZdOrN7zK/RQowbJ9/1HzihrLA/jdMdUfyNP1iE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LJB7OkdjgbcyxGKu0SdEHz/e2ViGrVRn3n4vybw0FmOZLpN7AZBltXcRO3Ac4chCf
	 +F5v4I3JzkHbR2nuzzgAjNQqxWWVSkM6yyOzXFYmVbv6lRys2HV9hvAMTcVGxC/Vus
	 Bsv1228zkVvVCv+uySM9rGytERTw1IpzK2beTPCx+yvxJ81c+8STD1rYSTp769C/SG
	 nNcW7n8K9pMEd7ks8L6sQwxgoRibxUfav2uXi85RKz0kOrhJOFtuJklGkrvWRdTLLR
	 uYXIlSy2eL16x41ZEIrMiMb/5tgMiBcmikF4fu6zhiSLDIOHkw8Za8INYazokTLJG1
	 KD/RlfkU/d0yw==
Message-ID: <sashiko-outbox-163667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/16] KVM: Introduce file_to_kvm_<arch>()
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-2-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:11:07 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Add a macro mechanism that generates an opt-in and arch-namespaced
> file_to_kvm_<arch>() to convert a file reference to a kvm object if the
> file handle represents a kvm handle.
>=20
> Activate for x86 and for s390 (native KVM only).
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D1

