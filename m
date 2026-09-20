Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA63DE45A
	for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789889552; cv=none; b=K2ubgmWlSSIkjFWu6Lpqc+Xzeek6P0XqGbF6I7CUKb2XRfHU3AdlsvqUvBaCFs+hAsmkheg82ITiDxtd5bSY+eY8Q48S5qFlE8S9so7zJHYIZoRiqrX/f7gjyQXOx5UIrYAc6Hk2LjJUTDtSKrtoy5+Zxb9YnZkFSqHi5SO7ddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789889552; c=relaxed/simple;
	bh=F4JATKFspdRNbUCy1Nz6HScRRKDbxyclK798tldncYk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVOmoxzEbdSEUB22cDPRPhhkjSCfPZBDof+WXyQQAIRSLDOiAO912lNEWoHlGIvgv9fEAp8Sm+kKjc2R2zbK1hxktqksovz+IF5Be+raH+8gGVCGp8NpTiaBCltloRfoUtENURN/zxtXoZOJvVHxVVPbRqd3G/lodA8mNtpiqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y623Z3vJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y623Z3vJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879351F000FF;
	Sun, 20 Sep 2026 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789889550;
	bh=F4JATKFspdRNbUCy1Nz6HScRRKDbxyclK798tldncYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y623Z3vJ2gUoyNpEf9J7gMeLsQsuhCNfeGqk5X+cQzZThZ33n6KRsZ1au9W0akaGQ
	 lzMgtH0+FG9X0SajjhCOIy9i8bP2pXbEhqPfgAu1wJSZi7avQrYHmQMvVYLNbBwAja
	 UMts9BN5mXdQ+xKU41L8vv9wy5H0D5QizPbuRgnHHJP02h+YUE1BXLo/d9de0Wp+Kl
	 5qeuM8xiV8nOwajUSdgU1c4nOdovwfzuVnb1NtTtIj7Lu6YcIBcncKiVxx2fkSoA2N
	 y0bREpiihXZgfUTP84rnswhrOneQPMZnai1JaZdW/GoQztXqj7tXvi6zK+Tvv9KLBu
	 pFFWfhhT7OsBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH pci] PCI: Extend ACS quirk for Wangxun FF6XXX NICs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mengyuan Lou" <mengyuanlou@net-swift.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260920072801.61016-1-mengyuanlou@net-swift.com>
References: <20260920072801.61016-1-mengyuanlou@net-swift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 07:32:30 +0000
Message-Id: <20260920073230.879351F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The new Wangxun NICs do not advertise an ACS capability, but the
> hardware isolates functions on multi-function devices by directing
> peer-to-peer traffic upstream, providing behavior equivalent to
> PCI_ACS_RR and PCI_ACS_CR.
>=20
> Add the FF6xxx device IDs to pci_quirk_wangxun_nic_acs() so the
> functions can be placed in independent IOMMU groups.
>=20
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920072801.6101=
6-1-mengyuanlou@net-swift.com?part=3D1

