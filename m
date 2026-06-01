Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BBF3D8117
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326376; cv=none; b=iYvdlTJmDutOeslnV/PjUbOImqCUr+FBkhTLN07tKel4nwOBXneAMXZROhXOS6zq7OAAS1zwp+skMyoRBFh/yHktaH2RH44DJa3RBSSqc1dAfDkZIJ27dL26u3B4CA2RJW0DHg3YCcygeurBeIKon8wp2rN93DIFx1FYPy6b/Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326376; c=relaxed/simple;
	bh=lYpvWmZlpLwqfjWLhV7P+kYs4avfhrBbGxvzjiuHYPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a7ck+3fuS8ig0ZGwi3KQM35eZdpRfJXoxiDO34D2wqrSFoa0eJ3LdDOtxbrVIe1WRfy93+QYq4b9Ttc40NUv9LLKCKfGi99kD0qRPRGAZRBoHlaAjbQTcjdrN9e2vyAw4GzIbrtsI8vE5DbAYhFzUu0dqd5iSUfMZWbl7LPz3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHAcsgjP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHAcsgjP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9B61F00893;
	Mon,  1 Jun 2026 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780326373;
	bh=AA8eX6PJxpFChSpB4KHS8jvBxJ7W1133mTSa4LAsExM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kHAcsgjPr3/WUfCRlGGvDx23thMsLHzRCtX+6mprDgcHL0+jpR4zxqoKpkjPN7hFs
	 nIcbbq0zjECQR7cIBW813axH2Dcq/6xtq9u+QGykv6VZigM0lC5oEzuCFi6AzURywJ
	 tI7oDxEQExfwqGkFy+Dj0kaYodVzFU7dGaAgCvLTlAISJta8u26X7M6qAiYmBX2FTz
	 5bNVTlA5gxIlcH1xMk3PFcCIJgYDIKyU+ZBVO6Qk+HNPP6pyZJ7fl+RlLDLG9iWP+Y
	 LixCMHkadv8nJwP7IisYMN4axlwBE+sCGJHQLQLV3JFh0+8jnA1/b8eVmGIntUli4w
	 WIisFW4jaAYYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260601143644.2358771-4-praan@google.com>
References: <20260601143644.2358771-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:06:12 +0000
Message-Id: <20260601150613.0F9B61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling `rb_erase()` on an unlinked, zero-initialized stream n=
ode silently corrupts the SMMU streams rbtree by zeroing the tree root.
--

commit 785579083a69b017d9dafe6dce3c844bea656662
Author: Pranjal Shrivastava <praan@google.com>

iommu/arm-smmu-v3: Fix a UAF in the probe_device error path

Clear the iommu->priv to NULL while returning an error from probe_device.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index a10affb483a4f..54c7f1ae3a841 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4206,6 +4206,7 @@ static struct iommu_device *arm_smmu_probe_device(s=
truct device *dev)
>  	arm_smmu_disable_pasid(master);
>  	arm_smmu_remove_master(master);

[Severity: Critical]
This is a pre-existing issue, but could calling arm_smmu_remove_master()
here silently corrupt the smmu streams rbtree if there are duplicate
Stream IDs?

In arm_smmu_insert_master(), master->streams is allocated with kzalloc,
leaving the rb_node zero-initialized. If a device has duplicate Stream IDs
(expected for bridged PCI devices), it skips inserting the duplicate node
into smmu->streams:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_insert_master() {
    ...
			/* Bridged PCI devices may end up with duplicated IDs */
			if (existing_master =3D=3D master)
				continue;
    ...
}

However, arm_smmu_remove_master() unconditionally calls rb_erase() on all
nodes:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_remove_master() {
    ...
	for (i =3D 0; i < fwspec->num_ids; i++)
		rb_erase(&master->streams[i].node, &smmu->streams);
    ...
}

Since the rb_erase() implementation interprets a zero-initialized node as a
root node with no children, it clears it by setting root->rb_node =3D NULL.
Does this detach the entire stream tracking tree?

The error path in arm_smmu_insert_master() also unconditionally calls
rb_erase() on processed nodes:

drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:arm_smmu_insert_master() {
    ...
		for (i--; i >=3D 0; i--)
			rb_erase(&master->streams[i].node, &smmu->streams);
    ...
}

Would this also trigger the same corruption if a failure happens after
skipping a duplicate ID?

>  err_free_master:
> +	dev_iommu_priv_set(dev, NULL);
>  	kfree(master);
>  	return ERR_PTR(ret);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601143644.2358=
771-1-praan@google.com?part=3D3
