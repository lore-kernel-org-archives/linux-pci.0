Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D600437E5D7;
	Tue, 14 Jul 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064197; cv=none; b=IakkZXQkPkEJpvHgIv2KcbZx02dodXMEnjn3IudMdySRw+Xed/l+ZDHIY2IdbRr0PdtsauKpBTVSNBSXNqAePxQSRuoW3QRVfN1wMAXZ7uH7dxm12mReQokm0DeN8Be/QJ0L0pF4W8FpZ2V+1z4kWAcbhvCwQCqy1xko39gKx2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064197; c=relaxed/simple;
	bh=WrhjaPuLe0j+3sEaX1xciIONL4OiJl5kfhnLmC/Ws38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XhzKwvqzg4yRMJp7VaVxm3XKt0Q52C0/7Ss+sXzp266QNIa1MKg8BMRzxzaKUPatOFXyPXNJr7il0hAevUmvOl2RilG/e9hlbGjqsiA2ibpdOzK21MStP7I6VGFXS2Osnm1RD57xPD6AV+VzXBnSK18k3I4Ixv1CMWKb5LOWBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Orh54189; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Orh54189"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEA31F000E9;
	Tue, 14 Jul 2026 21:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784064196;
	bh=WrhjaPuLe0j+3sEaX1xciIONL4OiJl5kfhnLmC/Ws38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Orh541896cNHPSVK7rdcM9JkwunXwvH+JDAaq0zxifAupm0vLsC/CM+f+z1NP54g0
	 09bqtmLteoCBRf40nr+R5qRTJ7aNo94722WumaWAfAOKF6OJgj8lRBBupGeSIBVDop
	 dYX7GZJyzqEnVLc25hV769AahcCG8D2dXjsixmkHGbSCkzAaPBMsG90RD60GswSVuy
	 7madnh5RHlGZlvTRqFhwVFkCm8Gwzo2k0oqYvmCI8FbGuW+TEdGP7gTFnjLDyjXXYn
	 s9+pgfvAhzgbViGljda2Q8vJMQvIfqOkXUQqf6MkvsD6xkMSIpOtrgu8PrcEi+0Uk8
	 Yfn/CSTm2tv+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] PCI/switch: switchtec: Add PCI1008 device ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, vkoul@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260714212010.230606-3-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 21:23:15 +0000
Message-Id: <20260714212316.3DEA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the PCI1008 device ID to the core switchtec management
> driver's PCI ID table. Without it, the management endpoint on a
> PCI1008 switch is not bound by this driver, preventing userspace
> tools from configuring or monitoring the switch and leaving NTB
> functionality unavailable.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714212010.2306=
06-1-logang@deltatee.com?part=3D2

