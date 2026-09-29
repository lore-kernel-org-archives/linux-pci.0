Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7837A821
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660262; cv=none; b=tTl+Xe3SFQqBiFHwhi3ZLv3Uw5/540I2nQQNEgtUt1N0yfV7kdSKjCEol549Uj1xYR2SN28bX6Pj2gTSMTHo4COCkGchUhaVo879830jKOCSJn8UWGGg4bKhDYwHXr2YSs/w+mUoM7OH2etQx9Eh/ovH/SO71XjZYc3hgopKDCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660262; c=relaxed/simple;
	bh=wUcOBWx0/uKYpnjNDtz153oOfr1CWqhxIoAXukppKWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gyxug1M63QNvzNWp03xA56o4RWerDNTp12/5nYDwa2710bVY+aU3fk2lumCRXFcO0Hk/Hq3jQBBc3b3JULAGEqX1hUX9NyxeB4idNB0291+gyefclfZmxxn7kpXpzFFcdINshVfvl3Ov//uo+5FGeWtZVCTVoWkBsPZgqwKzGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXBLEDwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXBLEDwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4161F000FF;
	Tue, 29 Sep 2026 05:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790660261;
	bh=wUcOBWx0/uKYpnjNDtz153oOfr1CWqhxIoAXukppKWs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXBLEDwlHf6DeBf5741dUs1T1gL52CdwintrBPKCzCd8SD+l+Xm8RB7jwYBXdwgYy
	 89id20P30WkdGbBSjZEvUNjk+20bm2FJ+027TU/SUSbhWaWAq3I/RxZXNUa5lRu68R
	 giBDVW3wR66gdofbtt8m8eUbNw5SXKozU7V7OIfZUnogwfco52ViFHMqFG97zMj/+M
	 omBX5u0q3qQryBVd+37CwOr+yiHb9eNa+niCNYwET+ad8CL6I3CF+Gvl/THjuQun3E
	 /Do/yMFHqYdy+YkXII/StLTDUlE5IJONu43IlRLZG2MpmbkuEoTf+BNbVfADm/T5j7
	 HCbUZ68QE6DQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-11-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:37:40 +0000
Message-Id: <20260929053740.ED4161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The GERROR register's state might be lost when the SMMU is powered down
> during runtime suspend, requiring the suspend sequence to handle any
> pending errors before the hardware state is lost.
>=20
> Refactor the gerror handling logic into a helper function. Subsequent
> patches will invoke it from the runtime suspend callback after disabling
> the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> before the hardware state is lost.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D10

