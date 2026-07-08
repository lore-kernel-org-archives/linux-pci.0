Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C4D4A2E20;
	Wed,  8 Jul 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520424; cv=none; b=dAYFvCl5qEjM3OfjExRfoJbeUx0+VMfnOUhshrhl4BmYgiYAdJtQqT2I7kRodJdc/hYBDHJ2f7N+ZnwD3rCD9LRpeka8Hqk59BrjdBsEaC8Id6R6ndcevOwLIuxfwufyIhmJwKPbpKyJO6dwKz5gadu0Q7yc6C65Z7fWl6uTYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520424; c=relaxed/simple;
	bh=VTNXFxmADtunm95Bl35OmYPHz/4+srrzH8x2hzNgwe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nm78QSqa+OhbrMz5UYB9y7ZaNgFm2db9UcRNjtw87B9KsUzhYkeKV4CqeFwaPhxU8DFNhHdM9bylYrFMZyD0D2suKE9ar0keLNYcX2+skOVztRDe1RtoykY8Y/EMUpXGwKRUV3T79mA8yiVDgYOLorkX4H46h6Ticb5uK3WYrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn37d7+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn37d7+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E941F00A3D;
	Wed,  8 Jul 2026 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520423;
	bh=VTNXFxmADtunm95Bl35OmYPHz/4+srrzH8x2hzNgwe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dn37d7+4VTYXLaLr64gO0WgrqZNI5qdrGlZhQTdmjTdo6bGo7EsezsUhq3IHNWbCS
	 qRFFdEHs8cEx4wUXPnbKBtmaP6wKi3idSqT5J4aKn2wi3522u00JqV9EneWVXRrOap
	 HbrS/QCzEiUF2YziqKToiGxL3to93U/Op0M4FRxgszf23b0iCcY7xaDjPjIVqlzuJf
	 YKqaJn4/XavN2DYd19QaPZVLiZtQMJS+saMxHF0J0zD+18NxiyOtVtfXbXy2sTl4gU
	 m1dOMtASl5O4wLcKs0w5zPF0iJxZMFTNLXUHYuTMkjsnfgS8uq+C5jZIGDoM1Ipkoe
	 zaQ07gCC4GqHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/10] ACPI: APEI: GHES: move vendor record helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-5-8b3a85216cef@arm.com>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
 <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-5-8b3a85216cef@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:20:22 +0000
Message-Id: <20260708142022.B0E941F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Shift the vendor record workqueue helpers into ghes_cper.c so both GHES
> and future DT-based providers can use the same implementation. The change
> is mechanical and keeps the notifier behavior identical.
>=20
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-topics-ahm=
tib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com?part=3D5

