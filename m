Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811266;
	b=UJV/PTzI9/ih7akXAbaeaTGFnTNutXmgB7MbE/aazwJWnAjQRj9tL/b3YKe0pKv1tMIt
	 FZLZHmUyob6Rh5V8RVD6T4+aljEjIONKQ3tq05k17YDe59D+rUNHWgZit7TiUVhCCcuQ4
	 T8popz3dxpRDkIa2alJAqmaWQLMnEMu5pp7uarmb5cmkFyjmbXANIE1kJ6jJ++A+pZz1G
	 GV0GrF82musxhrw9PHRVNP+nVINFX983rGXWNUCRvjB4o2l1oSHo7FtmfbrY5NKsALaxi
	 53oZafPTJXTDCClsL9mdYq/gK4w2gjNoebUka+lbd7fFLfRmKueJh1OmEBGI1efj+mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MTd+CsQvxBtxolnJ49k0wVN8fdtPwZuTne+6T1M5bdE=;
	b=Pmze7m9QSfBOe+gjj3eqSaB7ov+DDZRYO1VznFTcYpJqWc3zeE19Ttpj7FeWhjoYrLJl
	 YBoKoNsEYvaWkcEKGaSOR2DBinjWE5sC7aXUdXFKUH25qUwQQJuPTzUtCMfGkO4Al3wjd
	 LKmrrmYOUwTp2tx+cWxQ6X/lqVEtUVe/tvGDPYTCQbfDkANMN2WHzj1sEy6TwgRyXSslX
	 1EIYp/TF/Qp/iJINBnCrKcA8tmdfmnwWMqCMnQtWn/FVOz4QuS8PHonMTsS6S3iWe1yGZ
	 Cq27rfBkhawEuO0LEseWr6rhBpl9yNyghPB15Bz6IM/iMboMjodhHTISwngU2NedmEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHBuWsFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C3606A31B;
	Wed,  4 Nov 2026 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHBuWsFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B741F000C1;
	Wed,  4 Nov 2026 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793811265;
	bh=MTd+CsQvxBtxolnJ49k0wVN8fdtPwZuTne+6T1M5bdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHBuWsFBhNz6CyOYhF9FxWsaqIwiHqs0vw729yXQio5917JXGVM+I+ylYaKDqgYjR
	 8wXJg8qtqaATjbqB9rhBEJIxC9awhEcb1kPdGaCMfzde2eHJqvUQnx3VgtUzKJQMKG
	 wX0poGPB4PrEsWwxbzynUmeSFMlBiX8G7HE1ANCxdlwITYW1PdocYWTGxSoqEwbLHX
	 PoLg2zHhKLLJ1vDo/RYHla2lxmm/WN2q6xqHh0z0n7VL2mn18FdidmYuFJUrvmdAuv
	 Ov1TXKci/wD1MTJtrhDT+APM7DqOnyfLJwdzDYQjit7riWA5r1A00srCkU00SwOn6D
	 DJ1H7GGrTWzoQ==
Message-ID: <sashiko-outbox-197698@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] iommufd: Add a vDEVICE operation ioctl
 framework
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-9-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:54:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommufd: iommufd_vdevice_op_ioctl() returns -EINVAL for non-zero=
 reserved field
--

commit 02d0f32280b8147168fe9f8c2300f3939bdda343
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd: Add a vDEVICE operation ioctl framework

This commit introduces the IOMMU_VDEVICE_OP ioctl and its dispatcher
iommufd_vdevice_op_ioctl() to execute operations on a vDEVICE object using
request and response buffers. It adds a supported_ops bitmask to struct
iommufd_vdevice and returns -EOPNOTSUPP by default when no operations are
defined.

> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viomm=
u.c
> index 0dbd382eeb981..cdbb597f35888 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
[ ... ]
> @@ -121,6 +125,38 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *=
ucmd)
>  	return rc;
>  }
> =20
> +int iommufd_vdevice_op_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vdevice_op *cmd =3D ucmd->cmd;
> +	struct iommufd_object *obj;
> +	struct iommufd_vdevice *vdev;
> +	int ret;
> +
> +	if (cmd->reserved)
> +		return -EINVAL;

[Severity: Medium]
Should iommufd_vdevice_op_ioctl() return -EOPNOTSUPP instead of -EINVAL when
cmd->reserved is non-zero?

The general ioctl format documentation in include/uapi/linux/iommufd.h
specifies that -EOPNOTSUPP is returned when a known field has a value the
kernel does not understand or support, whereas -EINVAL indicates a field is
not correct:

include/uapi/linux/iommufd.h:
 *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
 *    understood, however a known field has a value the kernel does not
 *    understand or support.
 *  - EINVAL: Everything about the IOCTL was understood, but a field is not
 *    correct.

All other ioctl handlers across drivers/iommu/iommufd/ return -EOPNOTSUPP w=
hen
a reserved field is non-zero so userspace can detect whether a future kernel
extension repurposing that field is supported.

Additionally, in include/uapi/linux/iommufd.h, struct iommu_vdevice_op names
this member reserved:

struct iommu_vdevice_op {
	...
	__u32 reserved;
	...
};

Should this member be named __reserved to match the other UAPI structures in
include/uapi/linux/iommufd.h?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D8
