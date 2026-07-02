Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27B480DFE;
	Thu,  2 Jul 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996718; cv=none; b=RLeowzLI73mJzBZpQoNFHeGGlZo/HZkMg86arPwFXbE6eQnpE6bG35s7GWo9CrR7b/Cu/6jPfUo7evAbqQUEZmE+KUmZMPoo058Pd+It8w4PqQc3AB4EFkx6lVmWFaxDviZXvSBJUwa52VfECWM3fUzFgIBTFepHyDQUqsoxBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996718; c=relaxed/simple;
	bh=kQD8xlZ79LXNuHKfJla3M4h523Rhu8zju8qVja7O1Bc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kxcva8TAHC5eNOojvKjPgDvis/Xak9H9Yt8O5vcct/HGvTCVg4XpwW65beSIZdh5aVuxkBiO698c5oX6IAhlbAbSdafiXvWt+IH3lwAqxbM2k2fmFjlTJKF4LPJdvsENfLpHv9OeRdHkJ02a1TSkd5ue78n9hkdYvyMvXlbs47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJ872NJG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJ872NJG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAE51F00A3A;
	Thu,  2 Jul 2026 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996717;
	bh=kQD8xlZ79LXNuHKfJla3M4h523Rhu8zju8qVja7O1Bc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OJ872NJGO/26KB+bwGyOG5btDZZWYq4d+qotOcP4gVJMJ9cI56LLCz7LMxlKno1we
	 8BuU6P6ZuKA/jA6mvEAYPuEgmFjZHb6JqXM2yCz7h8JUZsfn9fyG/yxLhqs1G7oQOA
	 6grld2vFXzEjq7n1hzLNXHM2IdWNoLTYpIp6OCgU8JWYhCo9vKeQdqJ/3oDotl3vnO
	 CoPjdxEPRCWoFQP8DfdymtVa6vkGWvYYylrTETsSNZ4FNoranOR6H5kixs+jdgUFl4
	 zTa2RYeTJH43ZVYPFPmrgE5PbbyryXiBquymvJ0fVCuh7Yf3bbN7QiJ5mmdwN1eX0Z
	 I35+rHYfvLqiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 02/18] PCI/TPH: Fix tph_enabled concurrent update
 race by bitfield packing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-3-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-3-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:51:56 +0000
Message-Id: <20260702125156.ECAE51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
> u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
> 1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
> highlighted by Sashiko after VFIO TPH exposure. No functional changes.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D2

