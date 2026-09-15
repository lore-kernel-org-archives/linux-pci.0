Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0E4B1293
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789490557; cv=none; b=ZHyc7bawMQRycXRTRRye25aW82tDhtdk5C4uvj2bl3jcez+PK2MSewzoKl8PzfAgP+LdjTeLnMpP02ueculmuXDf91/BYIJcrnc9RaONlN/q6C9bL4RQPE/jPAtgVaJb2gCX5/fD3XaZ1c624cV3fgohzPYoDZoeTTTQU7soKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789490557; c=relaxed/simple;
	bh=1mzaWRwSSFsNKUC7g7ZiGYMI1D4+fA9BZk0PS8f1riU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ng18t6oBADkeFG3JZgFfnRk6THZ0C471cZIAUv6C4vW4Kv9x3cWoRYACItl6q8jQanHXRTMRGUUM6ivhd83EAFll/wCbhkk19LVwy2kJholHGpUcRwXz6+8tOHK3oNgekauj8nIaMSt8XznEYRYoe+daenGFUU09Tpn6LWXRuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCSaCyws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCSaCyws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2B41F000FF;
	Tue, 15 Sep 2026 16:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789490555;
	bh=1mzaWRwSSFsNKUC7g7ZiGYMI1D4+fA9BZk0PS8f1riU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZCSaCywsxcoDlclwLFAEEE6ZABSefniW235zdmJ6vXOOUpaHHidnsquYSEpe9OhHK
	 qLkn+K+d8vf4RF+iFFacaIu/04er+JuTtDTa0AyAZrzeSQXu/vzNmDyANKH8wdED4O
	 J6PJhKWyddQZI5iBW8/YbNdHtkCP+YpfEZ4DPPey/c2448ERSReLWxjuj1S6Mq3Juz
	 cHQeCqDM/X//KupWD8CdHNhok19yKadOynz1xShJHwi5IK9+RJZjIWQ8Dzq4fEsKKX
	 y7GNR+J7lLlFf0WfEGEFwCQAcrFTKRnyzD5nMdgnQlhxHuvDknXlacm9SH6zbwt2TA
	 BH5DuW56lehHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/15] iommu/arm-smmu-v3: Add Q_POS() macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <1db9d32df4a59dcac286e7a82bc2704cdd69b8e0.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:42:34 +0000
Message-Id: <20260915164235.5B2B41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
> It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacit=
y.
> queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
> compute such positions by open-coding the two macros at each call site.
>=20
> Add a Q_POS() macro and switch the open-coded sites to it.
>=20
> A subsequent change will build a Q_DIFF() on it, to count the entries that
> a queue pointer moved past.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D3

