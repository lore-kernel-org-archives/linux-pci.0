Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72453BFAEE;
	Thu,  8 Oct 2026 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439706; cv=none; b=s0TKnB5qMwj7t1WSR0m7NEtWufVEJSc/LAdj4rrHVijEtx2mfjRdEaGH4Q8yjKAmdUQvvkBDsRl/OrCVduo6Mg5QXJS4kwONkuX4qr19kzisTJCPIv/v+ToSIfiBc2hEuZmFE1fdDTb4oxqduJYEmu+eacdee0dbKRl6gxsxoC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439706; c=relaxed/simple;
	bh=NszX61rqW8G2YtvPqlmTKMEBqGdpYZ/UzKVtOUDwL58=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=URrT4339nBiAeaNNq9WIdzw4qBY6lRBzSuDet2+a+OdisxVuWgaC3fZRSf9YUbSkut1WWI5raW3uWvB5iCdH/bQPvy/3tf2cP1jNh7LR6h9robd2xqtCjBOGSKGuV46bG5UG/snc5nW6H3X5uuxdUHwGCCCw0QOrR2Drk5x7YRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVDUZjH0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVDUZjH0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBF01F0089B;
	Thu,  8 Oct 2026 06:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439705;
	bh=NszX61rqW8G2YtvPqlmTKMEBqGdpYZ/UzKVtOUDwL58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FVDUZjH0FptI3X2LbnR+mdmx38gXyj1QgLJSrk1j8bSCIAkYTY8MoYjA1gUTNd0Wp
	 8M87KATKgMgh1816MXbi344nKJvZ2otEFboqgBZS7c2xzK3ISQ9q0X9Iiy9ifq8j6l
	 VY0QTyNWtKUpo+p8+J0Rq6qIDlac5rWsW7S0B67sA/0oZDkWHDT3WGT4TnH0vYNfmH
	 /BCUcCajbkIYHM8f+DOuHkZwOCGv0+JLc1MB/V1Sq3etYwW6v1Rlf3b9yNuE5tYxlw
	 +xcJZ6SRPiuBWov7W1ngpsdcLt2uhj5aUnIdDqdk6eZfgsPll7tXCMBzXfP79cTK8C
	 OUcwUlQLENMmg==
Message-ID: <sashiko-outbox-163659@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/16] KVM: Restrict kvm_get_kvm/kvm_put_kvm export
 to internal KVM modules
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-6-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:08:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
> EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
> now only used within KVM itself. No external module needs them now that
> VFIO uses file-based reference counting. Remove the corresponding
> exemptions from the x86 KVM Makefile exports check.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D5

