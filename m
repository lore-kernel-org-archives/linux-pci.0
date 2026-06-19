Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1263B19D6;
	Fri, 19 Jun 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888706; cv=none; b=e16MdihgFRRs9dIygRxTcCBPUEBOpsTavnzBdu68i4YKRmX6N5pSExc3uhKSrhxw9BfBW1IwuY6xR5UUzI/bFCxorNDnkigy0gLtMkbrm56hGxcBjGmJBJXFH49VrP3Cm+n3uLq5HWb5XEMt9BGMdCmekIpYysW5xk5FXLAmIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888706; c=relaxed/simple;
	bh=SRRzcwaH4d1wxFZYtGSRDSdJpieIh3jJ5CEMg853dhQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R/ANQJn/0RzJ0LxdJa5dMQJGF1YZmO2C9B66pbo+rinDv3iNzEpLG0T2rR/4ZqGCcA8DtWFeGEvv+3KzawDDNifTKhDQWzC4hLoXLUgjprp8wqbuO6ZfSguhMtecRO5KDpq9ChyKCaGn2K81lt2QUshTrf5BGcBTgd5J1CpK0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Digz7RkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Digz7RkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9091F000E9;
	Fri, 19 Jun 2026 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781888705;
	bh=SRRzcwaH4d1wxFZYtGSRDSdJpieIh3jJ5CEMg853dhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Digz7RkV5vKHK3x/VfyiCMQpapcFtP/wf8fplSSA66JmR5jQBgx/GKyfBCKYmxg3G
	 vgkQimbUZeuR2PD45uJc+gu4keQl/W3+X1XN8qG/bAWZnrNrJ0UICDiyjVEVWIZI8C
	 PBEHoKZ6pOIRthUNh3EDGHeKAOdkCK6AmbEDjp0rZT+4ZKgEFDu/LAEj3RftFmoO31
	 Mq76japzgC70tKC4CzaoJtGCPPGfl2ZULr9t7tPVPgDTA7lPavrnmtyWXDO66Lw/w5
	 GWtbZzAYY/uImIlz3ozHF2La6Ce0TfHfHCnxdKHlTFt8KtDYUUSVV0gQ8gz8sOQ9mk
	 d0x9o5wFJfG0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] rust: driver: remove duplicate ID table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, conor+dt@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260618-id_info-v1-9-96af1e559ef9@garyguo.net>
References: <20260618-id_info-v1-0-96af1e559ef9@garyguo.net>
 <20260618-id_info-v1-9-96af1e559ef9@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 17:05:03 +0000
Message-Id: <20260619170504.4B9091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Previously, `IdArray` contains both device ID table and info table so we
> keep a separate copy for MODULE_DEVICE_TABLE for hotplug (which needs to =
be
> just the device ID table). With the info being changed to be carried via
> pointers, `IdArray` is now layout compatible with raw ID table and hence
> there is no longer a need to keep the distinction.
>=20
> Deduplicate the code, and remove the redundant copy for hotplug purpose by
> just giving the `IdArray` instance a proper symbol name.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-id_info-v1=
-0-96af1e559ef9@garyguo.net?part=3D9

