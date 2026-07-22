Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF73B635A
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 23:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762584; cv=none; b=nOd55feZhftwZ0zt8IVQBPZZWOrzgYgHnGHwRQ0OWbkl4VhOyVMt0qLS+zPOCU5MGUfPsVDoXzuzWdiCSPN54H7aDHGK2gYWuJDl2nUjJXBp2Uc6hu67ktLHOnMHMvVqdV8bnBTmHf4RkjxMZLOoChzf82tr5F7oENt1hRUVL0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762584; c=relaxed/simple;
	bh=FzWBUD5xGyZ0IQP5Py7zW+UwOzEcFp485c33OqyJEyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DKb6u0974rRILrwR58TK/AttKKOM8iWbhXKeDLiI32TgDuOQfKYBLyhZ/rU6D2BRfeiBIeVsWsrrAmwemP7KAhv784/jlISStEmW8G85m1G4/M991zIMUKLmjum9wCyDsGaTcDyMetWUdGnu+KQpGxFVDA4Jo7U3KHZrOFVC8F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FafM9sEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FafM9sEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2726E1F000E9;
	Wed, 22 Jul 2026 23:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784762583;
	bh=FzWBUD5xGyZ0IQP5Py7zW+UwOzEcFp485c33OqyJEyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FafM9sEAhDKuUOPQooX/DFBBPlqDQlsI5gCsoY9OnSIyoO7M7H/qOQnYqnW1/QqGi
	 3qNci/JVKPDXfKZR9uopkrxp8MGIA3q3SzlQUiMJLYLjfUDsXWxQWo81d+iGQWr6N2
	 LqnG2Xd64oTe1mcK+AIwX/SdoZq0XNr+G7O0YulwhU0ROpFYWJggXlKWFUU9h5RArn
	 ucUAY4c7+PCtCqHM0Cq9Kr36KzmtWYeuE6eoHniBwgxbUm3MmUSfk7kjp+h0MIa9+C
	 pEz1pFAzjI3z1ao2Nzvw3QOkSqS5JASZfpCDPjKKCFpHpTqfRm4YW/92jL6XuMsa4Y
	 O+KUpwpZ2OxNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv2] PCI: dwc: uniphier: use fwnode API for
 legacy-interrupt-controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722231532.872962-1-rosenp@gmail.com>
References: <20260722231532.872962-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 23:23:02 +0000
Message-Id: <20260722232303.2726E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert uniphier_pcie_config_intx_irq() from the OF-specific to the
> generic firmware-node API: of_get_child_by_name() to
> device_get_named_child_node(), irq_of_parse_and_map() to
> fwnode_irq_get(), of_fwnode_handle() on the child node to passing the
> fwnode directly, and of_node_put() to fwnode_handle_put().
>=20
> Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ
> or a negative errno and never 0 (it rewrites 0 to -EINVAL), so check
> pp->irq < 0 and propagate the error. pp->irq is an int, so the negative
> value is preserved. Drop the now-unused np / dev_fwnode() locals, since
> device_get_named_child_node() operates on the device directly.
>=20
> Built for arm64 (defconfig + CONFIG_PCIE_UNIPHIER) with LLVM=3D1;
> drivers/pci/controller/dwc/pcie-uniphier.o compiles cleanly.
>=20
> Assisted-by: opencode:hy3-free
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722231532.8729=
62-1-rosenp@gmail.com?part=3D1

