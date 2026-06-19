Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A935C1B1
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860274; cv=none; b=SmmInBK9vcq5Y8NBySz/Gqoctus90OaHETyaHeqg1eVekGdYmWlcLtyURWho6Vijox0C013ub0sVkHLOTB/BwFia/+omovDzpgABdsuQ7BkIlaouLHGRwNAqze6zCZNj9Wzd2KIP61luhEbznK5/BtkIY2AUXgK2ylAiodzltYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860274; c=relaxed/simple;
	bh=GgAMFoC2FtFdyEx/xLb/VZGn0vZcYQS2IZ4Ojx8juUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FzsnIw1dG7ef7jOmFwi0QU65egG9UGc9USabRuvuzqMWlDmHQ5Te5JkGTb4bfEm9+o4xuwiPazfkyZufbcIbBjhKiumN6GgEp9d+dBLHRBp3lFGaBDrU1LEuTCPpTPboQqXfqraNospMsvK3obF21E1VhHdll3ggUkrFrWDw1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWKoydfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWKoydfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2FA1F000E9;
	Fri, 19 Jun 2026 09:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860273;
	bh=nLng/lH/FZiXapG13MliM4f7YZ0btT1Ec/30puFSp0Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TWKoydfXkOT2nyrvo5X5bEqm8Cm91DxxwMZbnscXRmika9n9HgMMJp0iWDVyvs4TB
	 T/vTZn+DqQE04sv8LhO2Qt6oW97gVHPW8X4M6qYs5BJudwcmXIGrgh3XXOiSksvx6K
	 2CbysSXco60zIrZTCV7ini+fWaNXP4o8Yyn4WnKkiexdribqXWRi2D1qCtSSkZFImQ
	 6xV2PoEjBa5nGSDMXJ0gWIFPRdGHn/2NOsFP/krFzFCzc/NGrFqYSBY651TGS+nqwf
	 Vv0dVjheQQchZdXS1lMQbca0gZlzu7eKAkJyvvGcYSNVT/MssZg6LzzKVFMJjHuU2v
	 Ci/gdPg59s0VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/25] PCI/sysfs: Add static PCI resource attribute
 macros
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-7-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-7-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:11:13 +0000
Message-Id: <20260619091113.6A2FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add three macros for declaring static binary attributes for PCI
> resource files:
>=20
>   - pci_dev_resource_io_attr(), for I/O BAR resources (read/write)
>   - pci_dev_resource_uc_attr(), for memory BAR resources (mmap uncached)
>   - pci_dev_resource_wc_attr(), for write-combine resources (mmap WC)
>=20
> Each macro only sets the callbacks its resource type needs.  The I/O
> macro conditionally includes mmap support via __PCI_RESOURCE_IO_MMAP_ATTRS
> on architectures where arch_can_pci_mmap_io() is true at compile time
> (such as PowerPC, SPARC, and Xtensa).
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D6

