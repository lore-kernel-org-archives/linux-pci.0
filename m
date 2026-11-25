Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595596;
	b=a/EG7WSchaDs8UbICt//Fh/84Oh5Agf88jDbFyG8a8P/GfJrItO0hshTGJShEMWRUpU5
	 n4llhWMYmnXHWhpyDPf6i5VrpX/tmSQS5u2plL27B/sqzmp7+5QeYfdqn/w2x2r4ZCTI3
	 pIiG65rLj02troEas0haUdH+z5dUNBYVvvWppSGN0xQkmgYSsyCKpWs5YHk8tylwPPRy4
	 e22mnnr9YHKqtJJK+7SWRYfT+C1mEkwayperrFMeRdOXzaVTSHJL/qKtzt1SxDpku4X4l
	 EkE1XeWhk7TFC/jFjM5m8D+czUlWUvp3X0nQUv0XJ1R5bvfMq57Q/1TaHWf7Tz0nqbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595596;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+tp9JqNIA6F9SlFATNPSGhUxhafMRHKXMy6268Tnw2I=;
	b=fZ+0OWQkrigsBKeRnSITm07vsmasqCoMk1cT9WtfWUkwQ82vbj8XAEvbtoK6uPmeqTJc
	 uRvG7u70CJoIhw7wkg/laWjBz5dUn3ExkdbLhMeVD+uD1CXE10MNv2SDnJ7dDWxZRWtl4
	 vFuR5K8Z1AjIHJhPzNIOE6hj72EMC48xhCApgs799dDRkgcdeTblaM2FFaTVHfqv0gfYl
	 XTvjAEm5AmnY8u7VWoZq8WLM3iRcjJ1I+ZZP65nV+muwxbkAJtwC+NOFiJARrApnJ4Hip
	 PR1oMwkw9f5OFsK8LvCYYXAVcktFzcch9XZlklmziyAXQozwvyVGrDNYFT9eJ4vIyeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCbFoZ5k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF2606A321;
	Wed, 25 Nov 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCbFoZ5k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFF81F000CA;
	Wed, 25 Nov 2026 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595595;
	bh=+tp9JqNIA6F9SlFATNPSGhUxhafMRHKXMy6268Tnw2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCbFoZ5kfGPfEfxEF9JglC4E6sqx0XDz9R2XsZPXjl6EMLWuZnRsBH6kMG3Nepbez
	 87PDgOdOixUpo3GA83pTEyxWylBNDapqbXHAt0T4UlCla29/dB+Uzr8lu6zifcRnKV
	 P4eda3TgIhQgHjOMGhYvQI9Jawxv6gIWH87WKrRfg7Etx1JLoOhOqaNuGwJplFg4Qh
	 3T1J3r0rNpUbIIMwou+zf0vOau16iR7HA5l9m0Gg+mqv5a33zF1FTrQMpkJOH1FYuT
	 ADGh5Z5D7EMMqncU2l0NkZGKhorZ5O9dbm4NSXwtl8HentlXvUZDec9VQdtJeZfpR7
	 CxUse10A4hTBw==
Message-ID: <sashiko-outbox-232909@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 15/18] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261125081121.379481-16-aneesh.kumar@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
 <20261125081121.379481-16-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:33:15 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] iommufd: mix of __free() and goto error handling in
  iommufd_viommu_alloc_ioctl()
--

commit c23c0e750868729bcf5c18f6b9904e0a5d226915
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

iommufd/viommu: Allow PCI TSM backends to provide vIOMMU operations

This commit allows VIOMMU_ALLOC to query PCI TSM backends for vIOMMU
operations before falling back to the physical IOMMU driver, and tracks
TSM-backed vIOMMU instances in struct iommufd_viommu.

> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viomm=
u.c
> index dab499d24c453..909ef86f39a98 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
[ ... ]
> @@ -44,20 +48,38 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *u=
cmd)
>  	if (IS_ERR(idev))
>  		return PTR_ERR(idev);
> =20
> -	iommu_dev =3D iommufd_device_get_iommu_dev(idev);
> -	if (!iommu_dev) {
> -		rc =3D -EOPNOTSUPP;
> +	struct tsm_dev *tsm_dev __free(tsm_put_device) =3D tsm_get_device(idev-=
>dev);
> +	if (IS_ERR(tsm_dev)) {
> +		rc =3D PTR_ERR(tsm_dev);
>  		goto out_put_idev;
>  	}
> -	if (!iommu_dev->ops->get_viommu_ops) {
> -		rc =3D -EOPNOTSUPP;
> +
> +	if (tsm_dev)
> +		ops =3D tsm_viommu_get_ops(tsm_dev, idev->dev, cmd->type);
> +	else
> +		ops =3D NULL;
> +
> +	if (IS_ERR(ops)) {
> +		rc =3D PTR_ERR(ops);
>  		goto out_put_idev;
>  	}
> -	ops =3D iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
> +
>  	if (!ops) {
> -		rc =3D -EOPNOTSUPP;
> -		goto out_put_idev;
> +		tsm_put_device(no_free_ptr(tsm_dev));
> +
> +		iommu_dev =3D iommufd_device_get_iommu_dev(idev);
> +		if (!iommu_dev || !iommu_dev->ops->get_viommu_ops) {
> +			rc =3D -EOPNOTSUPP;
> +			goto out_put_idev;
> +		}
> +
> +		ops =3D iommu_dev->ops->get_viommu_ops(idev->dev, cmd->type);
> +		if (!ops) {
> +			rc =3D -EOPNOTSUPP;
> +			goto out_put_idev;
> +		}
>  	}

[Severity: Low]
This isn't a bug, but iommufd_viommu_alloc_ioctl() mixes a scope-based
__free(tsm_put_device) variable with goto-based error handling
(out_put_hwpt and out_put_idev), which violates the kernel Cleanup API
convention and causes out_put_idev to release idev before tsm_dev is
released at function exit.  Could tsm_dev be released via a goto label or
all resources in this function converted to __free()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125081121.3794=
81-1-aneesh.kumar@kernel.org?part=3D15
