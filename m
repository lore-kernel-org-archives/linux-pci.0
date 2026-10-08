Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933D3BFAFC;
	Thu,  8 Oct 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439810; cv=none; b=JM10AhZepuOnqKTCLA8tuGVm1v/X07onoWa85xKsf8D27jHJ7dAJIWeMaKONOfqsvOzyOb0scWXwo4wtHksyJxQyz9wccDXApZlaLfaB9BTyFffUeC3WYampV7Wc/o06GoysLpzHZfZqlH8Ov8TjrEr/pjrph/vAw0zZKqOYb2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439810; c=relaxed/simple;
	bh=Q6R5s/d4NXbI+k9kZu6LTkA7hmnnhfWvTFjcoF3hWLk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nlWy+QrGDWLhtETR/3GCg2nsDaV0pr1PEUeWGlX7+HHMcN4Jvt1U5HLeBqudsLdU5r7W+pcjqH9oNewrRjevIn/4dvrFpnBJc3CgjBb5U1TEJSECJ1L2pQxcmMr/0U384wC7V5cybAb8ZIuT09XToxMAeQcgfMHOS/TsWK4xoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHVfeH1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHVfeH1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC161F000FF;
	Thu,  8 Oct 2026 06:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791439806;
	bh=Q6R5s/d4NXbI+k9kZu6LTkA7hmnnhfWvTFjcoF3hWLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QHVfeH1+QnYCMBzHifFRzQBxrKHSpQGYZ4Ui5SlMwvMJ2Z7Qn/gdyY3E4XigL+6if
	 qghdGKaYnJ+KSKheDuCFZoh7kicypRGeK7iMCZM22VYnNUYlMKzQoA00Xbm3x0E8Ao
	 4v03T0nS9C+/CuEkMmEpt66LmE9Znl8o9kus3Y8wGSPbONv0F77DSCYYpUoAX0N+j/
	 Mrh6EjHWh5Y8OnzPNuK9ffFS7z2mG5A5h4CnUeNc22p4P2OLphc8P4RKV7N8oKXW+O
	 zvG/MqGUsM+4DyuFzIT7UOSXf9D3S2SBUqje0fWWYIz9ar3BZpalFe40jyDSZwZ1tu
	 PxfT1ujXkUAHA==
Message-ID: <sashiko-outbox-163663@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/16] iommufd: Add the vdevice TSM request ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261008055955.4014342-11-aneesh.kumar@kernel.org>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-11-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 06:10:05 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A VMM needs to forward guest-originated TSM commands to the TSM
> implementation managing an assigned device. The IOMMUFD vdevice
> identifies that device within its vIOMMU and provides the appropriate
> dispatch point.
>=20
> Add IOMMU_VDEVICE_TSM_REQ to send an opaque request to a vdevice and
> optionally return a response. Define common operation and guest
> architecture identifiers for CCA, SEV and TDX requests.
>=20
> Let vdevice providers declare the TVM architecture and supported operatio=
ns
> in a u64 mask. Check these capabilities before dispatch. Define a
> one-past-last operation value and assert that every operation fits in the
> mask; reject out-of-range userspace values before indexing it.
>=20
> The ioctl return value reports errors or the number of unused buffer byte=
s,
> while tsm_code carries the TSM-specific result. Use userspace pointers for
> the internal request and response buffers, and u32 lengths matching the
> UAPI. Reject lengths above INT_MAX so successful residues fit in the
> ioctl's int return value.
>=20
> Cc: jgg@ziepe.ca
> Cc: kevin.tian@intel.com
> Cc: joro@8bytes.org
> Cc: will@kernel.org
> Cc: robin.murphy@arm.com
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008055955.4014=
342-1-aneesh.kumar@kernel.org?part=3D10

