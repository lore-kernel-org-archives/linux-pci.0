Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074443C3F5C;
	Thu,  8 Oct 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440670; cv=none; b=CDBlNJHuiOFnvmNUt2JBk3wz3oSKDWWPZinsr5R5OQ0gtJjlMCKycilyA+4lpHTtJt5NarsrxTsJBrP+JI2WBuXnqw+xBKlTA3SR3LoN7RT6zjifJ8eTeN5yPDq1XuBU8rcRmxFrfj4ek4i37/GArJ8C+jxZDvNVtP3lNF/JvfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440670; c=relaxed/simple;
	bh=hzwsyJ4xD41Tfvn+ztUXOGk//z21/94BYxRIA8ULvhg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MWs+9odpjBOBCueX03ketlO1UQYY2ZCHVQGEINEdjoNh6d8m3swLdJ4hB4zIsu4GAqSvGXgs2O27N5Dw6dNTyxL1p1m9uFxIr6O02s2Wocfi9FcVDYRvqTUpLzFBlHLibuQ4E6alSw/eKwtwMXouD+wuLqvR5kJUMmszHq4zxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFl0aoYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFl0aoYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812151F000FF;
	Thu,  8 Oct 2026 06:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791440668;
	bh=hzwsyJ4xD41Tfvn+ztUXOGk//z21/94BYxRIA8ULvhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eFl0aoYsdOy72yduVlt8y1lOM2foifOljutl8joVmv+FgN9/IfUh7vWTSTVZZ1OsB
	 RNLTXZPpYaXXbTef94UtFS7y6Pxh0AQi6sC965YznJJ8BTeAeOsCZ7jBc+WVYJOiBc
	 SQSqiljsseUzjazA35E/YvZpuRwEtm87aaaL1QLHyEHN/8eTamjysB5glghMRaLrLF
	 DaGIYwTOaiJw85JaSfEHgcwXDtL8KB+SFvQw5UXCeqWUXfsc5ukbirNAjUhCSERFR/
	 bAlysengfbP5kTD9wyeJJw5a0pWN1wMbO1tZsUTln1Z0zYbGEj1N7Bpx+S0ATS7qFI
	 /XUs58khGd7nA==
Message-ID: <sashiko-outbox-163685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/16] iommufd: Allow vIOMMUs without a parent HWPT
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-16-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-16-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:24:28 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
> the selected vIOMMU implementation has no use for one. This would force
> implementations such as the following Arm Realm vIOMMU to create an
> unused parent.
>=20
> Add IOMMUFD_VIOMMU_NO_HWPT so an implementation can opt out. Require
> hwpt_id to be zero in that case and pass a NULL parent domain to its
> initialization callback. Keep the existing parent validation and
> reference handling for implementations that require a HWPT.
>=20
> Reject nested domain and hardware queue allocation for a vIOMMU without
> a parent, and document the two allocation modes in the UAPI.
>=20
> Cc: jgg@ziepe.ca
> Cc: kevin.tian@intel.com
> Cc: corbet@lwn.net
> Cc: skhan@linuxfoundation.org
> Cc: rdunlap@infradead.org
> Cc: joro@8bytes.org
> Cc: will@kernel.org
> Cc: robin.murphy@arm.com
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D15

