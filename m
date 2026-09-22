Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508A3A5456;
	Tue, 22 Sep 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059695; cv=none; b=mn24PnE7zPx/zGYV0oIKe6tYXiPSqmBfkt2kW0GiRFsXBJZyCjOeivrSTFD6M+Doj70FnOrCQRUok8D5JmOzQxrz2eyBm+G2bu+F8gxf7wWLV2S/q5Q1eKOsuMDPfAIb9VcmfXz1rXWreKU6q1SwFPG33+Ryx9RYtvC4Xu0qkZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059695; c=relaxed/simple;
	bh=ORpT7vIsYFrQ8GT4CBCh3lwwMTxkULqZ4cZugt291mc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FNcD19YSZSKxkqOWGnV0nmcFO/0SPOaSXEms5VUt5VUXfOPyV9/tocQ/F8kqZuJgVQAU9M3hlWs/QZrHp/Y3TO7mZXQBV2SMhEPuT6sjxQMbUTJNwf3EP8+9WA1DyQRlVOoU7pAD6w7yGfWAqv4jjTi11v1YeNWLKga9Vu1Dmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfDA3CJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfDA3CJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2651D1F000FF;
	Tue, 22 Sep 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790059694;
	bh=DFZ4AH8NrD9uS7BzuKBlUQTFfMHVHBHZfW2TghtrT5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YfDA3CJPtfEsyMVSUuK3BObRIN6DiY+rON8aWNCzRgVdJNy/d0Jcnk1dc29QbjE/p
	 h3+m70YLeNi9qVBaMa6tDw7rZF2I7dvCO5LeN3OCKLpDN/Yq6aj/WuA/1UGp/1DZu6
	 9glAiiVfETwyU8Nj8KfgqGK3yJXBlxhYrYiYItSD8z+6mzGOM6b6kN4GFs1HFsL4rJ
	 TxDNJYUk/EEFkoV7yBWvoxS4Cxf4T3bGu+Y+7uLcN5qpvcnctlDqlec5BOV/RqksNd
	 QIyUIh5LvtoVajqPwplwd9L8lmJqHYyQKBem93ybw+o4XKLO5qvP0aJvXng6oq4P89
	 /lzPqYIwkGmuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pci/vgaarb: pass a data pointer to be used in the
 decode callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Airlie" <airlied@gmail.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922064111.2468741-1-airlied@gmail.com>
References: <20260922064111.2468741-1-airlied@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 06:48:13 +0000
Message-Id: <20260922064814.2651D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/loongson: missed vga_client_register API conversion breaks build
--

commit 53a905b209a5cf4aa1aeb17a42069c191d47a151
Author: Dave Airlie <airlied@redhat.com>

pci/vgaarb: pass a data pointer to be used in the decode callback

This commit updates the vga_client_register() API to accept a void *data
pointer, which is then passed to the decode callback. It also updates
various DRM drivers and VFIO to pass and use this new private data pointer.

[ ... ]

> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 97129a1bbb7df..71a364669eaf8 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -33,7 +33,8 @@ struct pci_dev *vga_default_device(void);
>  void vga_set_default_device(struct pci_dev *pdev);
>  int vga_remove_vgacon(struct pci_dev *pdev);
>  int vga_client_register(struct pci_dev *pdev,
> -		unsigned int (*set_decode)(struct pci_dev *pdev, bool state));
> +		unsigned int (*set_decode)(void *data, bool state),
> +		void *data);

[Severity: Low]
Does this API change break the build for the loongson DRM driver?

It looks like the conversion of vga_client_register() missed lsdc_pci_probe=
()
in drivers/gpu/drm/loongson/lsdc_drv.c:

drivers/gpu/drm/loongson/lsdc_drv.c:lsdc_pci_probe() {
    ...
	vga_client_register(pdev, lsdc_vga_set_decode);
    ...
}

The callback lsdc_vga_set_decode() also still expects a struct pci_dev *
rather than void *data.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922064111.2468=
741-1-airlied@gmail.com?part=3D1
