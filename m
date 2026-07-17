Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C7C246BD5;
	Fri, 17 Jul 2026 22:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327879; cv=none; b=qbH4FczEusmfpAPHbinbbTj0zFJcjQx1fo38EEjqj/XjAnoefkkTWsWVVtUwKRXbTrS/Ac3gMUb/2JkkqgY+W1o/URY6jnNt5bAxmngcy7ZzrDZGRG6428oMi6RnFKofZ0T7DlSPPmcpRux2cIL6DagYJZfGsW1We4vUg+kT7gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327879; c=relaxed/simple;
	bh=UIGC5v8NavuHilC8uqdbmB2biz2AyGKC9p+4Iu2e/ZI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7XD6zQvM+2TQ0f77YQcPHGyBVz4vlVts5Lb7bS76setvB+LL/wEfRdD3pP6MuWQjj1L3fHhomfpsMJtooQw+xoHVICJgSr2wtt0W4/dF4fwCd2bz3dTA45ZBoKVs/fr3Jobuhz/AOtwkIrCTaBRNQ8Gz/FaocWnrinuMKo7w+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C94czIST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C94czIST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF98B1F000E9;
	Fri, 17 Jul 2026 22:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784327877;
	bh=UIGC5v8NavuHilC8uqdbmB2biz2AyGKC9p+4Iu2e/ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C94czISTpgCykccQpCuoZK4QfanFqGNSywrGCv2G8D5rb0DeqWKTZGe6ICAVIGN1W
	 kAq4b9rPRWof070DLKREWTg0JxA+QIWa1jlqxHhBQmVkDKA3yy6sorFF9zk1C2wuzA
	 Xd5jOJGZLyW8pRAIaZXwte2mDUYKDeesb4duIrL4Yv6skgoc4yL3lTnT2gyFojbGIm
	 AVPhK7D6M5rYatQF8uRG4Y7ZnEhjCLhGm0H2CBuQsyz2IbTxz2bW7PNAh1TgOqUvGW
	 FjIIE/72EmcRB1WKxlZgL0MYMaFGJLdsUnUvItPi6r3RySvCPtY7DWQdnYwDZ2ZN/B
	 gIkWhdPiS66ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 03/13] cxl: Tighten CPER kfifo registration API and
 symbol visibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-4-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:37:56 +0000
Message-Id: <20260717223757.AF98B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> Tighten the CPER protocol error kfifo registration API and symbol
> visibility.
>=20
> Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
> the CPER kfifo registration symbols. This names the consuming module
> explicitly and gives compile-time enforcement.
>=20
> Drop the work_struct argument from the unregister path. Change the
> WARN_ONCE condition to a NULL check since there is no caller pointer
> to compare against anymore.
>=20
> Change register/unregister return types to void. Flag double registration
> with WARN_ONCE() inside the lock instead of returning an error.
>=20
> Change cxl_ras_init() to void because there is one consumer and one produ=
cer
> so the error return was unnecessary. Remove the now-dead error check in
> cxl_core_init().
>=20
> Add a diagnostic log when the driver is not bound in
> cxl_cper_handle_prot_err().
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D3

