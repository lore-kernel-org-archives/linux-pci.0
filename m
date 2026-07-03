Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F491A6807;
	Fri,  3 Jul 2026 02:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044955; cv=none; b=Mfh3VHiKjyXOq0FRDENAi3l54td8yXrwP/+WHnrfaTgtTzmhNY+iNVe4IuLNt4cjSErks5+pobLnfSN6WzjwMSuTg8fZaxU9df0wQ59TiO6gFTwdR8M+wt/sn4RtM0kC4YznjfsdRFLwRuCK8qsGtqvgwlgEQUFEBoVCFhbbFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044955; c=relaxed/simple;
	bh=OyPFk6SZmDKqRawa0cPhDvxvr4ffYAOOXhJqLN8X72Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=skpGRexTyHiGKzYgeYf5DQ7a1rer81EseoPIkYsO9BcJLHJFn/gmD3/UH8BUIcQHUW+H40WsBBc0g1j4Zdr+K27V03brW7ZX9N1ak7OVhroYePcGZicsexNw2/A6s+jKLZ1jLByEyhjLzX5ZNSEt3HKAfWKudlrSWdAVbvb+mu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffKaEDSu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffKaEDSu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC641F000E9;
	Fri,  3 Jul 2026 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783044954;
	bh=OyPFk6SZmDKqRawa0cPhDvxvr4ffYAOOXhJqLN8X72Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffKaEDSuyJIT/CxcdEZnI73R/AkZdo3BndIPjOrHRTumFOMhfbs5FA50tElREdsXr
	 eoC2de8pBJ/asZtayL6Ux3TvG2/2MDxfHAvJgWQTnkOW8feOJlr4hIcYe23WXTPvIb
	 B19lw4W7vzjXZHQwLf4sV+NvYRNc8hhXwZuEDkMBsQpCrEOlit5jXldKkwxYeEpzJH
	 FWt1yrtiZQv+/CFyvvfh+lFfzLbpFzXcw3Ch6MzseOmlH5VrF3np+gAwxfqO7rQXdz
	 aUlm2c7S1i6MtgSZjnei1BlSMcsMqNenEGHlvLYu5cFDy+Vtuq2+AVVlqKditvX9P1
	 ZWHNtCYAXHq5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/6] PCI: spacemit-k1: Add device data support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260703020003.485436-2-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-2-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:15:53 +0000
Message-Id: <20260703021553.BFC641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
> data to handle the K1 specific logic and make room for the incoming
> logic for K3.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703020003.4854=
36-1-inochiama@gmail.com?part=3D1

