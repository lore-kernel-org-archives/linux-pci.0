Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE591380FF6
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269290; cv=none; b=CKavzLvboM54FjCr5GzBRCzfyLEZSmQBQ1N4yjws+H0RAxM0xFfR8dWKTvjWRWEtkJgET3FG+RlxIGUyBioZwoARklSQdYoAQZ84dnghwSrdfYxhXVVIoT1AbQI5oLGhSURyxctQ05q1N6Hk0WY+B/5eJNyuRDRcxv9FZKCSiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269290; c=relaxed/simple;
	bh=6IXmH8BEzdm56k456zStzKhvqs0R4Xd94RrWYHoaDOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lOehg4fR2He/oXu5NLrYPU4RYE5xaEwax/aC0itz7pxVYtWLb3uAF19WEaNjI1Q9hGqsROle5wrr3tg4DDqwoIG/TivwHDSTSBzLB66jr5QpNcixwP6bN49zcuN2BQFC6TszLLVMpMt8n07OyVMHf/k8+5618G47WhV42Z+c4HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjP4C58t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjP4C58t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B49C1F00A3A;
	Thu, 20 Aug 2026 23:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787269288;
	bh=6IXmH8BEzdm56k456zStzKhvqs0R4Xd94RrWYHoaDOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YjP4C58tsODwflIhHRbJ2S6cVSlN5EZnBXnrOldKv+n6l8KXGEcvOSTzAeqrED0FN
	 E7daLFFqGnweB09biAJ/yodizgef5kk67ZIQQLfocXtaC1TpzlkeShHKM+jfRvnyOc
	 1FgcoP8jlIx9A7cd8tjphKxtyiziFvDI/KwWM8uZoMgNAjUT+HRXRuRXwdC6LtvGaf
	 Cyw4Ne0rLrGWlygNguZ8nl36+k62eMc9ajvDx8AapAvlQ7yrmhrQbbw78cisLxzD6g
	 WZa4/KNRr7cvGJKvgl8iHinOuZARSle50SZNW5xAU4ISARmcTot/rz+pMY/6y8F3bU
	 RwSkkvu5Nf2FQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: cadence: Fix enum type mismatch warning in LTSSM
 debugfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820232305.80596-1-18255117159@163.com>
References: <20260820232305.80596-1-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 23:41:28 +0000
Message-Id: <20260820234128.8B49C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix Clang -Wenum-compare-conditional warning by using a single u32
> variable to hold the LTSSM status value, replacing two separate enum
> variables of different types.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202608201933.w2579mwx-lkp@i=
ntel.com/
> Fixes: d70e964dc099 ("PCI: cadence: Add LGA IP debugfs for LTSSM status")
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820232305.8059=
6-1-18255117159@163.com?part=3D1

