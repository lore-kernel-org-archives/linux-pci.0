Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AB175A6E;
	Thu,  4 Jun 2026 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542789; cv=none; b=iFfNJxsNiFQcBkKUJ4+nzqTL/i+ri4CDyZ2cugGmLdjaY7N4rgsusukSm6KJ6rV0LJizhuVmF+aBY9xaxdXlsQw7Xy10xKmNiQ8mqSHagAqCJ/yN/tBWJXFgYtUYWrrjadoWro2+ghswFZlfWCs504wZc0N8usSuOEs3OnHBehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542789; c=relaxed/simple;
	bh=cVFOiRw0Dbts0+UiFbiTM+VB4PaBozEeh2vLYB67g3A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eAy1n+4ge+u5JWNh+onbg9mCAc+HfHmbRPc9zOa9c2FSChzsIjuKy61jOm8tx7sUYeZ4tal8F2h1f8bDh1xp1+5HEDpGY5D2BXn8H4XEz64HJFGP07H0Z1iksUNkpyf+T5mHLOWQJNoYv7V9NcIzDXEUnNe2DABEWWBN/1Dcev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJbTalYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJbTalYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2B01F00899;
	Thu,  4 Jun 2026 03:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780542787;
	bh=nlppWMLpCM22Hv5DcjYZHb6hoEyvBsTnWA3GV7sEuRk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=KJbTalYI5FweqJu/pDvP7NhQwOxrS8rx4N8QX1sj9gApDKC7IQexeNxxorl6wHFrE
	 bCFK6tjBKQ7v+WmWwBMXgyYrR+3q7bc9Wme7A1jQprAYLJaskuB6s05K5hgHE/eBjO
	 iTmMdxCcfDcaibIS9tJYWhhTPlLe0A8z7H0eLiemHTsONLsNLCzfxZmRWaiwprmtB1
	 bTOAEia61gK8BTn70SOgi+TarAiYJ5k2ezCPiaA+gKzcyzD4s9SUEAAPHDMRQBITNk
	 b8M0Wob1TIe1J3vkVGKtvE8eilwamE7XGwne9uIxvrg5cgU1aPCOTUZg/o87isId/n
	 fSXYx4e1rzFlQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6F5EFF4007F;
	Wed,  3 Jun 2026 23:13:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 03 Jun 2026 23:13:06 -0400
X-ME-Sender: <xms:Qu0gapHGExgIkNdxOX10RtkRyDx5P6wJjbnI-b5fu_pK3G_43-kPBQ>
    <xme:Qu0gaudiORNBtZ0QP16T-8L0rxh66KSjxlp_5AE_rgYXswkyP83cM-l85QqSklVAI
    hepRpXrmGc8ePZvnwP_r91eEup3B6AXNmOnPHMVZylsbqEod84tuQ>
X-ME-Received: <xmr:Qu0gaim7c8RkJkwBsLu9dqu8ysGuWw4sYL49Fh5iVdlap9zEFZ18um7oZhjvKWxcwKVnDKnI8lD2z-PjRu3XSNVojp7Vox8Gs_0>
X-ME-Proxy-Cause: dmFkZTGR9uasAgaiJwYgGNQNVXP3RLnc02vrupb4uY86cFDYrULwArM4AgV10ycMl8N/Y2
    3sNNuuhxgDkm+pTQqL933Og6Id+euhVmQfQFu5dyMSrDbNTtvUKSy+CimlkPvLQoBA0p0M
    7LiqQQ/B/Fx6REsLZJLUdWFP/8WcaY5bf7gqJRHMeEbfZliTfF207Qa1KrhoJkjI8y7h1b
    RsWOAfOfcb1EywGo2pNDSppBjZX7aguAgDYTmVYn0EiKpFIYp1KAd2c+HeQGQ2dj59IuMI
    zu1FgIA1eRwwAUqwcMMuVD7eiRyf79i9i4SanM/tyRsXHmczBsEP2AyFf08EOSe+BnETcL
    sq5nRbh9WAeSFVtnoNTFx98OLCC/QR4TyTx7ETc4yy6IBo/8owf6RGUD5jckXkDfxfoRZF
    llvneAhHOwGUoSwQ1i6MopABxbxbxa+WT0bey58TZVKg8kZ136fmeMbgT0NIWr1u5+rf3o
    c1M+daq4QmrMSWc5SHaPSeKevtymhjo0XJSGLwwPBIocferK6kBc3jjoz9ZYPSMcKn0wWv
    9POVaXm4gXsXvosUkqubaMWZp536ThefyvKbJC6tQ+k6DPRs/Hi5Zx0PSO/7RoQWMAlNG7
    J9uq9dbAEiCbw22Dyhm5MxuTLb8C6Y/Dz3lnDS+hzzpRi+3+yY4E7zZ9B4vQ
X-ME-Proxy: <xmx:Qu0galomAGQSEt1_kvYzMYxEMeDPJVBs5Yf7r2jgeAv0ltOhoEICLw>
    <xmx:Qu0ganFU5Dg94wp86FyBan8mxJVq8cEryMbo1KxWj5C_qCfzSZwN2w>
    <xmx:Qu0gajR_bMf4pvmQy2f_sO_4--jL2zMdundVg9DXWNr41NzJpvhMvQ>
    <xmx:Qu0galNUFfPNayexHSVrd2EpqGgd5Io5tGOOew_nLvqNRJqBMTQLmw>
    <xmx:Qu0gaonpPsFU1BZqxrI0PzepvRxh5UrraiQtUjryWmMk9EnddZkAtHk7>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 23:13:05 -0400 (EDT)
Date: Wed, 03 Jun 2026 20:13:04 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a20ed40c14f1_42b910022@djbw-dev.notmuch>
In-Reply-To: <20260528083154.137979-5-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-5-smadhavan@nvidia.com>
Subject: Re: [PATCH v6 4/9] PCI/CXL: Add sibling function coordination for
 reset
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Add helpers to collect CXL sibling PCI functions affected by a CXL reset
> and prepare them for reset by saving and disabling them. Restore those
> siblings and drop their references when reset coordination completes.
> 
> Use the Non-CXL Function Map DVSEC to exclude non-CXL functions, and
> filter remaining siblings to functions that advertise CXL.cache or
> CXL.mem capability.
> 
> Use pci_dev_trylock() for sibling locking and unwind on contention or
> allocation failure, so competing reset paths fail with an errno.

This is a pile of code just to precisely save and restore only the
functions impacted by the reset. What is not clear to me is what is the
cost of over saving and restoring. The specification seems to imply that
CXL Reset has the same effect as FLR as far as CXL.io is concerned.
Which could maybe be read as all functions that speak CXL.io (all of
them) see the reset even if only a subset participate in CXL.cachemem.

Otherwise, there is a good chance that the pci_dev_reset_iommu_prepare()
is all going to all apply to the same iommu group for this device.

	pci_dev_save_and_disable(sibling);
	rc = pci_dev_reset_iommu_prepare(sibling);

...maybe the simple thing to do is just treat this like slot reset and
use the existing method of walking the device list by matching slot to
save and disable every function on the device. In other words, it is not
clear that the precision of saving some extra save_and_disable cycles is
worth it.
