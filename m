Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21702DAFA9
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732726; cv=none; b=f1kudAdXM7i9BhSsavQYNdHyW+R67aA5ovsn/tzPFmIe8liegN20Kld1iP4GLY4gbZllVQxo5XjncQQkSvyoOtDVA/EOKw3coGa6bnDk2rHq6WOw1NSjg1P3dfzh0rx6WfvPxY8f5R3qpvu714W5kIplh/udL4zyMJNHxsKt8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732726; c=relaxed/simple;
	bh=uqVIrEWjamJ6CD6aOoULCNjO7H7WPOJCClW7mVWaNOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lltQtICvNDg/70jnaLCATh404U94FFy1qv2dII8hmI2fZ6qnnOXGxBuu8eT42LugyTHBvLpv/3ZlLghClFSUje8O11eJ49nsFqv0tRLOOjYehed4bE/e0/A0mKViQHT9stSQmPRvoFbbSPS/inncmVbqOgoc2Re0f948IQPBPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR1FJIXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR1FJIXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476321F000FF;
	Wed, 30 Sep 2026 01:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732725;
	bh=TztuJjgk1OJNs6TG8sorUPLjyd/pS0B3ZTyVNtmNt/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nR1FJIXl6R5xYUBmGkymeaMGCh7KRTe8tDyDWIniYH99bCFBVJSSRmzvBkZQLvQix
	 IuUoTdcNQCFiBRhFBvO/yCRX7v2q+1i7y7XcquHNiZ8UIpXGxXfC+AGjBF3DBnKYYv
	 SjBtBPTEQZVy2bUvpfzCmHozxBK7T/t8Al0BqOARcb6uXPuTitC2qIqXY/Be5u7Y1I
	 ZI7wcpuFaNxf1fCjlCFUdK9Kji+Xqlx4jnOFg0Oj2L2Gue/+CaV8J4RMmTWYnaZkIY
	 oB6Ptk8HToKPOdPqpKXUI649961DsHAdvKZK81X57J7BqB4uYlL+bQDdMW/BWidpKC
	 duzzvocmZ39ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: Describe DWC PCIe fields with full masks and
 FIELD_PREP()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930013842.82476-1-18255117159@163.com>
References: <20260930013842.82476-1-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 01:45:24 +0000
Message-Id: <20260930014525.476321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Several DWC PCIe register fields are described with a shift macro next
> to their mask, or with only a shift and the field width implied by the
> value written.  Document the field position and width in a single full
> mask and use FIELD_PREP() to encode it.
>=20
> No functional change intended.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930013842.8247=
6-1-18255117159@163.com?part=3D1

