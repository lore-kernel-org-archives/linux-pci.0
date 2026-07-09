Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72F439335;
	Thu,  9 Jul 2026 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611757; cv=none; b=caCBBI/YIan96cHQimNjwjjw+FD7KXGqmdUcyedp7tLJQ4NzlkfWUO4XCcMoLMRsjLs7r1nCDHt/2fTG4azc4y71XUDjdQih/y61OuTp6Qq06Qx9a2dCR6eUaaepGFqdYoZkXNU3RhIeMlkXdu87bkMSxhOvmm1E+VV+cklvPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611757; c=relaxed/simple;
	bh=wRguRAMe4XF/alHh/gUiCpzQi3fzNVb79odLvpwRn9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CyWJGayO4gMq1JbBBaBJpqhWlj3QRNLKjz61Wa1YUaVycFTTkcnq2NVYvPOCTfYVzHYhphoo+7BYaC4gUtigGDaOBi2zWzckyr/OmivHGOytWXETNms5+1FhhiOP/cMeFWaRy/EQeI3JTIwbKm0I36m+NbGYZCG0DcW0jp5govg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpz9HM5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpz9HM5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3061F000E9;
	Thu,  9 Jul 2026 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611756;
	bh=wRguRAMe4XF/alHh/gUiCpzQi3fzNVb79odLvpwRn9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpz9HM5TKqCzp3OE7qChoCchEHLF2DZFyBReKN3g6vbh6ux63t3xch7miRtpstM/i
	 C9liaDRok6aes7ZsDqiXAKFDmxbpaq7h/j7i5krEA0Eguf4W+l1zPpcSiu2Phidey2
	 ORQ5RLyx/HHa6VIsZQFKKP7QghviFphZYgChX6hvyi0IIxoBeTaPVQS76GLbO8YS27
	 XceyEr9dModD2LvCTN6AnsoExTJonN+vxweoZ7VRPauOjcncf2czt7QfXndGH0HbA5
	 F7pLQYgESlS4FCdm7AOcWrmoylkpdC/nFCJ4nZuvNxkvT1SNXh+SEnQbW0WCIZ0ARk
	 YbO0YaX1usIGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] dmaengine: dw-edma: Add callbacks to fill link
 list entries
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: vkoul@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260709-edma_ll-v5-6-e199053d4300@nxp.com>
References: <20260709-edma_ll-v5-0-e199053d4300@nxp.com>
 <20260709-edma_ll-v5-6-e199053d4300@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:42:35 +0000
Message-Id: <20260709154236.5C3061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Introduce four new callbacks to fill link list entries in preparation for
> replacing dw_(edma|hdma)_v0_core_start().
>=20
> Filling link list entries is expected to become more complex, and without
> this abstraction both eDMA and HDMA paths would need to duplicate the same
> logic. Add fill-entry callbacks so the code can be shared cleanly between
> eDMA and HDMA implementations.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-edma_ll-v5=
-0-e199053d4300@nxp.com?part=3D6

