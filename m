Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265E248EC8B
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256860; cv=none; b=pk9sv+QvScsNqYJsdQHwzUo6GOInZenc2vUKTTU9WWW/GxYEYn2awoGAxr1oU+s5Cpa+E2laOBvAN8QdgvD4twYva4iOa3jUnbW13mFweEAj7lO2pP534pMAUQ1b5WAIGvSg7L0eKyNknq7bkuHmEx9U15YYRDEiv5b9lW2vANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256860; c=relaxed/simple;
	bh=g7udU285IakwQ2OiOYc6tOMMuxRBdSrxQyEu1/e5tRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=afqaq2i82RvDoY7uNy+09SRFT6XIxhtnrkF6rjdMaeC2OL/ygVgmBpblpSODZ/r2xBxXyWKHlxj0Tg7+LMDChcbTRXdr6kX3An2SyzvfWWX9wAA1ikMVW3QVbhCv8fBQw1z6DHxIFyx1p/IA3VrbFixOI7GszvecRRIVKFEPoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BM7xY4ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BM7xY4ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD931F000FF;
	Thu, 24 Sep 2026 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256852;
	bh=SIfiaPrpzmmkF9kd8BG7jDrQorW5eC4cx0zlEtWDkWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BM7xY4ldb7Q4NcEPgudPKENxepoXQ9g2dQDyz5ANsdUcDNwLPlplPTYEdnPPOvUNC
	 fuB//+wwIKREieLic29LWR8+di8c8ifweJbaTrFFLX7Z11OzqhlhxrP7ybXXuzT2o5
	 5uGFRAyuMZt7GraCooWj51xHogpSn/FyfLK34XNJ4MVMGF0zIna+qrWvY/MiJqBq7i
	 pwGnT4VQe1gdREGEIa2394bFn/0oH7VEVQ7BUZVjn8gXnKPJw864NJfwo6cFCs4ort
	 DN/HR/HhMd70Zktg6oP7p2DbCxe7nVK4y0Oo4Pg1xXtWePsKm06P6A4l+kskTCnBdW
	 RQ+8PmeBryzPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ACPI: PCI: take native PME control on Apple machines
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924132859.24751-1-fbeltranmillalen@gmail.com>
References: <20260924132859.24751-1-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 13:34:11 +0000
Message-Id: <20260924133412.0CD931F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> negotiate_os_control() skips the _OSC handshake on Apple machines and
> hardcodes the set of features the OS takes over, because those firmwares
> return failure once _OSI("Darwin") has been acknowledged.  The hardcoded
> set is ~OSC_PCI_EXPRESS_PME_CONTROL, i.e. everything except PME.  No
> reason was given for leaving PME out.
>=20
> The result is that host_bridge->native_pme stays 0, so portdrv never
> registers the PME service for any root port.  A PCIe device that
> runtime suspends still arms PME# (the PCI core enables it because
> pci_dev_run_wake() only looks at capability), asserts it when it needs
> attention, and is never resumed: no service handles the root port
> interrupt, and the polling fallback in pci_pme_list_scan() skips the
> device whenever the bridge above it is runtime suspended, which is
> exactly when the device itself is suspended.
> [ ... ]
> slightly fewer warnings than a boot without it, so taking the remaining
> control bit does not appear to disturb anything else on this machine.
>=20
> Fixes: 7bc5a2bad0b8 ("ACPI: Support _OSI("Darwin") correctly")
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924132859.2475=
1-1-fbeltranmillalen@gmail.com?part=3D1

