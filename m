Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761441;
	b=dX3eCP73+v8CJ1bdziFqRLN2xFuOG/sY2nGw0MmS6XnC+tS/Y1chOfCFOCEB+MHHXCe8
	 pBtLz/5/MzKxTFQOT9/C0Fp6d/1TVjDs2qIorI8ZHs88+s1hDZqrwqbf+4An0AvBEkDOW
	 PpHin182xHAS6fLva357LmqHpZmTN4uKvmrl4LioxQr91RtbK0a7wYMLREXpyFlKzU4ee
	 uzQmObHvQzenfbRgj8igg3x9zkSBnUWIVuYJtN2ERiLQlFgfZyeAf5Wn6U9ptmgKQh7xm
	 EMtQ9HKwMcEFTnMKslJ8dKu3WZAYli7CjCNhwJbK9L+hqJpVnESWMOa7em/8g3YRP/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1sOte9aZMW/qw9DmxmK2+mtVdZCe7JgqWzYHqiqlwUI=;
	b=vigXyxj+GMfVL+7RKiZtjEqS7ObAsgrRWJpSteqhRvXaep4122KSyF2XosxgjSoX9aea
	 Q8k99Qo8vuKSqiEvQNzuzS8yWX9UR5aAm+FqIAGHkMDHROum9WRo6M4yEn9UFCRb50HTa
	 h1uJQHXez3TJvYg19rCT9C0pW0UB915GHajKdBe7dZ5it9OFV8cqbdbkthglYWM4O6BVe
	 Kg/fRQY92csyX51j/XUAuBBmTCjXe6f9ksCXnJ30kpPc4pon9pmToZD9j6RWPu6c7CR4N
	 fYcYpLGxnQxxSx06BXHY5ViFSymqXYq2l++vCgyVDldVh6u4JraeIeLJAKpEC2+i8OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3RE81+1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6FE606A31B;
	Wed,  4 Nov 2026 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a3RE81+1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67C41F000C1;
	Wed,  4 Nov 2026 03:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761441;
	bh=1sOte9aZMW/qw9DmxmK2+mtVdZCe7JgqWzYHqiqlwUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a3RE81+1hdZ6trClar2PLmID2P/KoVj344ZTz5ghjlD2mAAA3DWDgKBbc6b45dhBq
	 HJGMLv8RDs/j8t5x8OVtYIGG7DdvqAnJwmCnjSU11w0p5ZEIqPTu0raUXhFApZAqit
	 EUIMY3ajwr4Cz49lHlSq+dN6rWlRBOmh9Xx25r96TPBvdGGStJ1TW+mUJyVJBHsnGD
	 CcsOZ3IBgjKE6MT44hfqMriIIbM4YTIROpjlucEv8ssDTDZ7Jsf4GAE5LtjuUxJ5gR
	 XvTk9gjJATMLEL6EV+aivZHmdK7Uqyr62mzOBIS7bXbFJR4SUwY4nSnnHPuAemMtwZ
	 mZjscBciCbrJA==
Message-ID: <sashiko-outbox-196576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/25] dmaengine: sdxi: Start functions on probe,
 stop on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261103-sdxi-base-v4-11-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-11-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:04:00 +0000
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
- [High] dmaengine: sdxi: PF stopped before pci_disable_sriov() in sdxi_pci=
_remove()
--

commit 44d5d7973859c1db8741ba90d53413150ded9a60
Author: Nathan Lynch <nathan.lynch@amd.com>

dmaengine: sdxi: Start functions on probe, stop on remove

This commit activates the SDXI function during device registration by
setting MMIO_CTL0.fn_gsr to GSRV_ACTIVE and polling for GSV_ACTIVE or
GSV_ERROR, and stops the function via sdxi_unregister() on PCI removal.

> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> index 6a293db69199f..d196ab5cf6f1c 100644
> --- a/drivers/dma/sdxi/pci.c
> +++ b/drivers/dma/sdxi/pci.c
> @@ -99,6 +99,7 @@ static int sdxi_pci_probe(struct pci_dev *pdev,
> =20
>  static void sdxi_pci_remove(struct pci_dev *pdev)
>  {
> +	sdxi_unregister(&pdev->dev);
>  	pci_disable_sriov(pdev);
>  }

[Severity: High]
Should pci_disable_sriov(pdev) be called before sdxi_unregister(&pdev->dev)
in sdxi_pci_remove()?

When SR-IOV virtual functions have been enabled via sriov_configure after PF
registration, calling sdxi_unregister() first invokes sdxi_dev_stop() on the
PF while the child VFs are still active and bound to their driver instances:

sdxi_pci_remove()
  sdxi_unregister()
    sdxi_dev_stop()
      sdxi->bus_ops->reset() -> sdxi_pci_reset()
        pci_reset_function_locked()

If the native MMIO stop sequence fails or times out, sdxi_dev_stop() falls
back to sdxi_pci_reset() and issues a PF function-level reset (or clears bus
mastering). A PF FLR clears PCI_SRIOV_CTRL_VFE in hardware and resets all V=
Fs
underneath their bound drivers, and pci_dev_restore() -> sriov_restore_stat=
e()
then re-enables PCI_SRIOV_CTRL_VFE with uninitialized post-reset VFs before
pci_disable_sriov(pdev) runs to unbind and remove them.

Calling pci_disable_sriov(pdev) before sdxi_unregister(&pdev->dev) would
ensure all child VFs are unbound, stopped, and disabled before the PF itself
is stopped or reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D11
