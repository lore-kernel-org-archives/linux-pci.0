Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFE3FBED0
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501496; cv=none; b=E5iCBW8A3EayNkh0ixNFODcT11cK8nGpnr0+0d40ljQISbMNkRMj2S4calmoNO5LhSxJjO6adHPOITwpJ49FbM+IQSCHvuOstpBJ4mMKVEN2ZwnTGgNNi2W+uIdWZ7IGUzX5T4qv5ttQL1rKCLlyadmZUuunVTjn+EYl/5lsqdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501496; c=relaxed/simple;
	bh=zjnmKZXHRkPz1NlxWbpT04ztGOV8oopN0yyXsWMfIwk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7knZzKGoXKJT/KmpzrR7a2wuESaYQn+xvsxxM5VLtdtUlwOVCmzAxJz05vb9yQyiP0xeIv69UbovOnACF1PfFF8IWfrIzwHr2lbPYF7TiGIZ6y/a92UW6bXmmvyVEiGb0XRRQFrTdLmjEo1mFZezRSvrWzW51BVyCFH0CHv/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHetbfmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHetbfmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06381F000E9;
	Wed,  8 Jul 2026 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783501495;
	bh=am3J1DhM+ULZK3wUKr0r33robbPbahhn2M64DtIU+KQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mHetbfmBIdHH1O2cCYAdYsG6jNQrPETUyg6voHRWXB8jWtUH7/KXJXJdum/OaIwK9
	 PA3KjjxaMXLLMHhZR7SqtS7RZaujbhGwQc2pac1yw6iCvMAagtJ8/Oav+Z90JkUxks
	 IBfI/5vCXwry3cBEr7xj7ZXrN7hIk+wk8SV6O+s0597BIXHay3/m59RzCIVxqGf7O+
	 GdcQlPqLxmlWGqKMjBjd4N2ldrAjTPxSVbKGoRLtBpGhCwmDa4cbm+Fue679Wi5EX4
	 VnSD2dLfBIUr/+589LI4xCLDFI2Fw2+FFXIafdeMjqp/UBqdDF6GZjTP9TPr+OAV8i
	 MGVG2Xi1osHkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf/dwc_pcie: Support narrowed time-based
 counter for long time monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708084507.98242-3-yang.yicong@picoheart.com>
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
 <20260708084507.98242-3-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 09:04:54 +0000
Message-Id: <20260708090454.F06381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Yufan Dou <douyufan@picoheart.com>
>=20
> The DWC PCIe Time-Based Analysis Data Register (the counter for time-based
> events) is architected as 64-bit, but some hardware implementations do not
> implement the full width.  On these implementations the counter stops aft=
er
> reaching its implemented width. This will limit the usage for short time
> monitoring only. The counter will only cover ~15s for monitoring RX TLP
> payloads on our platform.
>=20
> Add an optional hrtimer that fires every 2 seconds. It'll take the role
> as the counter overflow interrupt to read-update-reset the counter and
> event counts to break the limits of the narrow counters. It'll only
> apply on timer-based counter. The 2 seconds update period is the half
> of the maximum counting period (4s) of the time-based counter under
> period counting mode of the hardware.
> [ ... ]
>   Performance counter stats for 'system wide':
>    3,543,850,268,576      dwc_rootport_20000/rx_pcie_tlp_data_payload/
>=20
> Signed-off-by: Yufan Dou <douyufan@picoheart.com>
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708084507.9824=
2-1-yang.yicong@picoheart.com?part=3D2

