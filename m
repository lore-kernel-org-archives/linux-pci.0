Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450476;
	b=Iq2+6urRrO+KUyLlrTdYyC/hy2X3dtoea69H1xmglokcouPzhcNUVvP/5fEvMSDwZtfP
	 9TPZ5yg8sKq+5A23TCkbRGJMlcqaWn/HA7FDRTX7Yd61ShERteF8Ft0EUg61VBHZwx99q
	 gscoxR/vl2HcqYwSESVGLNNqVBhH6hxCukLTlkNlkHlGIqBODLGaid/BBUcvFuVMTi0Ic
	 xRaKR4Ixt6+iQd/Sb0ymPHCzAhsRc8ppGxPcIyS2hJySSBocc1VoK7tyvh/YGSI8vgUl4
	 BYgN5AdxkGgiM5sXb0kVmeO8ypsMZXqyEWfjBhsyLzyums5fvvjzYDbRjL55t+V1GMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ICrnL4UcR8LLqLqCE9GWPo1oFojYY9xg1h4vGR95yGA=;
	b=4ilfCksxYdwRtDllJJWEcdw+ElfhQTIFeIubKd7NIBTebxNkORUqRGVXrgWor7y0alFM
	 cl7UlJ4NHSi5SHbCyxNpohAtDc1mqiPHUNnxIhBbZQ5ULVElRCRoeYnowOWXJcycWdVvM
	 WqBEtJsvSUtPphABPOVMoMkqlGiVdDcvNyQ/UUoBCLjioj+m3cCs87v3OUnAhf8bXL0VK
	 sL6PoQyaB/oDY+hjd+Vyv3/VDxYmvG0G23YHSZ4TqSDQ+SZdfRxyBCzbibdm86EnaCfUs
	 YXAQGFmOIGyjQFYAsSKbmsemC5vxwhlJaz2Hdq9RaQ3nbcFHnZYemwWqH6Ry9sHxYCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw6wmlPL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63F606A321
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bw6wmlPL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C9D1F00A06;
	Thu, 12 Nov 2026 02:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450476;
	bh=ICrnL4UcR8LLqLqCE9GWPo1oFojYY9xg1h4vGR95yGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw6wmlPLVm5ZLiIqcdnBnS/QacKQLrtbEsFgGy8j84RIQz66NVdkbrvU/KYrJfRbD
	 mnX1z2+lwKpl+ej6309B36XwqD07T6QII6Om+V7avPPuUGmP+RskVqhruoq7aVAgH3
	 7tJdL5PeB/mic0sWStWLRIJ9MKi16px8GA5+41CZ59O1sac+AUjFI7Ta/GTruahtXs
	 DN7a8Q6GNagu3ch8aEqKdI8yropPJjGHf7/UM1QurQfcnUU24OlXS5de2msI7Tn6Cm
	 DxLciK6TinyTmcIFnGaeQ7EchVf05EIAVmSoa3vlNh54OHf8JgpXoFy4gf9QA7wKzk
	 rJYfooIdY95jw==
Message-ID: <sashiko-outbox-210191@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] PCI: Make pcie_link_speed[] private to probe.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112022405.1230200-6-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
 <20261112022405.1230200-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:27:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pcie_get_link_speed() is now the only accessor for pcie_link_speed[].
> Make the array static and remove its extern declaration and export so no
> other code can index it directly.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112022405.1230=
200-1-18255117159@163.com?part=3D5

