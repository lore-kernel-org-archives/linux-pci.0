Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C554774;
	Tue, 23 Jun 2026 05:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191238; cv=none; b=Gyq8yvT2FgYS2BpL1XIdKoGOIcJ8kJCGQHo6+A1cnXd11UWssA0EbgjhfGuG7ZIf59OFvXzIJZfkm3LAxuERZ2KAaU0ELnIbk1HarGMeJ6q5++8+pRrcRhWTRT6oAXtkf85PqwOCuRtQVi917NeJg+WuqkmyRBRAJzOTaZFUzpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191238; c=relaxed/simple;
	bh=6QuA6vp+biubxbFbY/9RrCwe5gihipjZy0cAsAEFnkc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZlR0fwbA+WU3do3XCWQ+eAtT2L045G/1sQlwzrWmseuZKKsX6Bbc8D/EnDdeQU+60Gu0xaDuGjowslD5onoX652ZYBoB9gEIFG4BPz+xj5BlmadRBby1zOuYCbW41JkP7eK/TAJB0HcAWYyeCPtaC3KZoXdhTpGaaPERviNsrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTlC/FY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTlC/FY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA31F000E9;
	Tue, 23 Jun 2026 05:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191237;
	bh=LxTy/RPH/+MHFxhLuDVkjF/Aj2LzvquiG/h+AnnyKE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTlC/FY18WU28KO1wagVwRXTnJ7vbqTmkvgS2aSc/eEFSfjbN6x6tQ77nQreRQm74
	 MfUwDEJ1KEAtCs0vvLDyQNxbTc1Cq4L8q8VpRF2IeCmArW8XuGqBboRKdG31oCdTH1
	 mEq0bnBZAbPgmVAfTjnYAIKK6NiNx/7SJb1FCkk5iIJtnI5Dp/VWUekwpTI3ZxO0FZ
	 7xcARgQGbrNI5K4lCRDe5WAXOgxL2a7pwBY89U50orox/bQy9gp9ergjPBo1N6ygop
	 5goGlmzzoAIGz3iTsTJykM+UGxCsfPFu8BBmtEwXETt2IqQJIRAc3qD3FbTfN01eIQ
	 DyH9ktLmzOrcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/21] PCI/CMA: Validate Subject Alternative Name in
 certificates
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623045406.2589547-14-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:07:16 +0000
Message-Id: <20260623050716.CFCA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> PCIe r6.1 sec 6.31.3 stipulates requirements for Leaf Certificates
> presented by devices, in particular the presence of a Subject Alternative
> Name which encodes the Vendor ID, Device ID, Device Serial Number, etc.
>=20
> This prevents a mismatch between the device identity in Config Space and
> the certificate.  A device cannot misappropriate a certificate from a
> different device without also spoofing Config Space.  As a corollary,
> it cannot dupe an arbitrary driver into binding to it.  Only drivers
> which bind to the device identity in the Subject Alternative Name work
> (PCIe r6.1 sec 6.31 "Implementation Note: Overview of Threat Model").
>=20
> The Subject Alternative Name is signed, hence constitutes a signed copy
> of a Config Space portion.  It's the same concept as web certificates
> [ ... ]
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # except ASN.1
> [ Changed by AF:
>  - Fixup a few issues caught by Sashiko
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D13

