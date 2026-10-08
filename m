Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E83F289E13;
	Thu,  8 Oct 2026 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439828; cv=none; b=ouZ9NSt7mnLVAP3JumRW9HE2lDuRk5FV7/LUV9tn+WqFVPFBEPBpz4kpCY5JUUCWUYWHy/4WS8RrfBnafZnXxM1XvIF/r3Bqo+0kEJqxVkqYHf+hNwC/p8iCvy2VbfkIkgQbwQU9M4iryRI0hl276KvwBVcrG1e69fOxUaVpHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439828; c=relaxed/simple;
	bh=yS2LdXxCssP3wnR0yRLPjkZdeTBAOf6p+bHAgYZ3cVU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=FyoXfJiQ9uI83rYmE5JCfVht7nExUsOO7vin777ApzQFFat8RbQZHEVzW3zeaApdLsu6V4jwKC1vzclb4s/swrKHWWZjKtny1vOKKDSb8kj93lqiCnp6/jAHsOCSBLXmg2vt8vRZEN1k4ZYaYHgWf1y0hAq/mOJMVOftA9Jg/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+LlGmLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+LlGmLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0471F000FF;
	Thu,  8 Oct 2026 06:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439827;
	bh=yS2LdXxCssP3wnR0yRLPjkZdeTBAOf6p+bHAgYZ3cVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+LlGmLWpkd5UKbWSCrNO556ku/rd5l+gt0IVsq7vWgOfze9dk3Z4A0kAUZ1c+ZLU
	 qyL+dd5X3cT10N7UbA355X9p3ZspRme0nXq6ThKCr7iikPyK2zHMmpK9EN4JxglYNF
	 FdgXiUxmqn6NE+a3XcsJLDdhNPIOTZDA4iPL3R0kps7Parn1EJQwy49b3G8kK8DCjE
	 r8KRIoHKTwjgDgCAfpm23rRpZOz0hkC2gErzakhhwTuOEgqFUFFT2JDkRvtwY8DnvZ
	 K3vHIfUFqiWKWVWRcd1VWzHjd12zR1i5sQFv9QzQtpW9SF2Y162AuFLD6NK9h457B0
	 P1+vDUqFesjdg==
Message-ID: <sashiko-outbox-163665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-9-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:10:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
> vIOMMU is allocated, and take a file reference so it remains valid for the
> lifetime of the vIOMMU.
>=20
> Release the reference when the vIOMMU is destroyed.
>=20
> Based on an original patch by
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>=20
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Cc: jgg@ziepe.ca
> Cc: kevin.tian@intel.com
> Cc: joro@8bytes.org
> Cc: will@kernel.org
> Cc: robin.murphy@arm.com
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D8

