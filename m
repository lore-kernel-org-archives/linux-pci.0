Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8223D649C;
	Tue, 29 Sep 2026 17:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703939; cv=none; b=lE1FGiBBtn8bpn1MhH874oQczYVwWhG3OQ1/VsD29GwvlgkCgxS9CZOSSteV6UYYLtUnWCqiIZ3iMThMt4UljcNMTlQZjcXYgGMHt6MKFKECr/mPj5Bz6cSEFhC7ZwjOIz/46HSHXwpDKouZbrpDjnpjRAzDiYVnZ/m6dRWo8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703939; c=relaxed/simple;
	bh=ezWyc8c45psm+cWZSQduI4tjnWeIdALl65tkAoWVJRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q3Fj6ysVWBF+BIfCyzttqIVMGzJImmAa7Fw/aB/uK3xhlev/8NSPvwLy0VteQdZFtejlk7JpBa4DX0w5dpwwE9GRtOtu62itUJ/QNROTSdYMe9jCIhuo5I+VwVhBH7LfF4Z8i2sU0D5tGwqEOvqpzgbJRxMt980KfCt3qL/N8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXtzEzUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXtzEzUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE631F000FF;
	Tue, 29 Sep 2026 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703938;
	bh=ezWyc8c45psm+cWZSQduI4tjnWeIdALl65tkAoWVJRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NXtzEzUdcRvEbPNi90XywnjwU4ASMee0gQAncZOdKJbnHnJgnse6S2xUSnP6YZY2R
	 fjxG0jd6kE2ubtb8V2iFJsjNw9/AS15yjhbx8zZ6qEKqwG4bcwRWrMIJQe4qXhHpbT
	 f4HLr3f7X8focb10BSbZOTNiVtOJtrNpmJ3lGJNZnMMOcqklSycOsOCESELMnVcvmJ
	 lpbIcczlLufHV7UIirZWgcsCA1kDf/hDNMICr6JKB9buYXkxHjhd2I2kSb6IFWnUm0
	 b9irytO59hpo+W5Ciox4fneJEHGIMV5mDijIq7vwxlue4Zc548pLw+x2D3oJGSWrQx
	 1lT13Id6x6BZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 05/16] vfio/pci: Fail BAR faults while access is
 blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929173305.204856-6-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
 <20260929173305.204856-6-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 17:45:37 +0000
Message-Id: <20260929174538.0BE631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Hold access_srcu across PFN insertion in the BAR fault handler. This
> ensures recovery waits for an insertion before revoking the mapping.
>=20
> Return VM_FAULT_SIGBUS rather than wait for recovery in the fault
> handler when access is blocked. Whether userspace can handle the
> resulting failure depends on the architecture and KVM fault-reporting
> path.
>=20
> Assisted-by: LLM
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929173305.2048=
56-1-skolothumtho@nvidia.com?part=3D5

