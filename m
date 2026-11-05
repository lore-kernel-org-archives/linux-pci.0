Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895182;
	b=WdcnQUBE6vbW2IirBSPyIVwCV8ygm0p/ZDGwf+hOzIGKLJV/jC2sJeFZFsOTlP6khxiZ
	 Amzd6yi4wfbiyAsV9vOuw8Nn6WocMdRH4W12YTOKSS81D7T9Mey0qHpCPEcwEmRWXNgQ8
	 w/HQGyewJhC4dHU4T10cs5qcyDfxQ2+AO5N6kbd85wCpaHFCeWryKYZpbdtzszGJe4DOV
	 HmmbinqgXw8Rvp+PNplqZCBeJpf19JYzRbJ6NWRh3NAS9UPp1/x0fKztuYLZ6PgwFASVO
	 SUGB7Wbiyqa590ZJZWOQ8nANiChZTqwy/Zka8H2X8J9PLjLQDh7LzUT0I+8hiJ3VfnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N1ZRBJ/RlTpHcN1WBwcPgEscw0U0HdkTsF3BNrNCo4U=;
	b=Vy01UHZezAlGwB+dcPk49Zn3raI2G0TNrgcxKbzYlXuk5KrMKk4FkiH279t71mif7XiT
	 7KzktkZZlphRj9osvxVh1A8XQPzu82P28sFVN/sv801FltSmOxepl/u9c13TGCiqUQDpO
	 0dlj2qfNNNkUYHklol/mxyMUwVoU0RM+f5K2hMSZt+DCoVkOZ4Gp8mMH7XLHSBsm4O76Z
	 uOHtxjaR5YSCHl8b4jixb/P3vtVeHIwmBOMjvTduo1xIpURrOyIXymFSBlDTGNsYgZdbx
	 WXsbtnPxb3Fkeq70INtwY+Nzw+nu+MDYtiHbjRoiUTQmJ9Ms86+OpbhU5FQI5/Da5gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nsg64IbF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62B606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nsg64IbF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A38E1F000C1;
	Thu,  5 Nov 2026 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895181;
	bh=N1ZRBJ/RlTpHcN1WBwcPgEscw0U0HdkTsF3BNrNCo4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nsg64IbFFnJ4Q5KM4y5Qj+ymuUNOsUrSFAPqdX3OV416zVQXSE3Xz4YaDZdz3qq9g
	 UGaLtld4ZMZnkg+oXD7gpyPwnm5o0CTEa0W9rholTNpkaD1R1d4PKVDd2J9Ex2PMa5
	 UjhfeqS4MCwLk9irdBakgGmjWMwECyhDH3LT/uBHxuHtQXiNT16EnttxzbrOpVSL5M
	 2gdXZcezBMOi4J2XIrIc8/RFg9Ep/VmWhKIGJFQyWvu96uM3dRsUnn8XmrT5YBepvm
	 lS8zNaBANkoel0s5pXWxGdvbqWwQY5Ad9UkbKwsYcVTj5Rg3TKC0MtJYPiSpPW1Ham
	 Fx83OfLIg8MxQ==
Message-ID: <sashiko-outbox-199449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105153801.435566-4-elder@riscstar.com>
References: <20261105153801.435566-1-elder@riscstar.com>
 <20261105153801.435566-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:13:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The flags variable whose address is passed to of_pci_get_addr_flags()
> is zeroed before assigning a value to it.  Skip the zeroing and just
> assign it instead.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153801.4355=
66-1-elder@riscstar.com?part=3D3

