Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF91481FD0;
	Wed, 23 Sep 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194903; cv=none; b=tG8lNWreb2QT4SWGk2XTdtyzAngWk2SJkrCYiMYuEuE2HoqHfs33I/b1ROTO2BXnpD4MJT9P6epLtSZQG1dQOPZak14x93HbRMWx3WXjRfqPB2fDvqtjfiU8aKCoAfxUA6CZBZCqDgHb/fabJsoTS4XMoJvALXN8lo5etdlE35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194903; c=relaxed/simple;
	bh=C4p9a08VYwFO2ZjznxNygcF7wc7N6gtkmZTxOzXD4aI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Co14TgAxoBQ0bjBlP5/GPK4uDvVcdpL0fg27lbFtEVCcC7TWVywdiDjBkg1YSuuQ9GznGEUNMUPEmkfRHPAxnEFXXyU2udpl4GhEaYviPyTyA0RLSovtB/QA1TOx83l/iUy5TIivZBH3Ba5Xr/fqXaxjbnwzsVsrLH7uOU6spbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fj33pfiK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fj33pfiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B81F1F000FF;
	Wed, 23 Sep 2026 20:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194892;
	bh=C4p9a08VYwFO2ZjznxNygcF7wc7N6gtkmZTxOzXD4aI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fj33pfiKgSmH1VxSPGOkDLYfPo/cOlRPUB84sYnxUJ3gjQ8QBbKp2N3hOulnn/wEh
	 0aesE/WE3ExHSqFgjG69vIBqpLT2i3tWpB6zsWg+5hfgHU7iYVpH4mBN3Lt4MphSez
	 AnvT5F58g+gyB7gXNX0SuPUYl7z43/C8CZGwjHvLbXG0M+zCU8hWHQi8T2kIE/nQvR
	 RT+u5BIon5qXsisd1gZEHMFg9Nju74yMAyIpckQVf8pOpjNiUa9C/X49AkX/x1yVss
	 ZsrYHv0nCuYhxKvENtNztPa+8l1l6GNRdJ/jIkNOkI5/QQEaT5sAHS/zVUcZhJGZlE
	 wX+UZPP//xY8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/17] iommu/arm-smmu-v3: Skip remaining GERROR
 causes on SFM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <bcd606d06beb726ab936e004ad23a2fe81c757b7.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <bcd606d06beb726ab936e004ad23a2fe81c757b7.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:21:31 +0000
Message-Id: <20260923202132.1B81F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When the SMMU enters Service Failure Mode (SFM), arm_smmu_device_disable()
> clears CR0 and the SMMU stops processing requests entirely. The remaining
> GERROR causes (MSI write aborts, PRIQ/EVTQ aborts, CMDQ_ERR) are moot at
> that point: the cmdq is dead so arm_smmu_cmdq_skip_err() would just twidd=
le
> bookkeeping for a queue nobody's reading, and the per-cause dev_warn lines
> add little diagnostic value beyond the SFM message itself.
>=20
> Ack the GERROR before arm_smmu_device_disable() and return. Acking before
> the multi-ms disable wait keeps a level-triggered IRQ source from re-firi=
ng
> the handler. The writel+return here duplicates the non-SFM tail because a
> subsequent commit will give the two paths different locking. SFM is one-w=
ay
> and the SMMU does not generate new GERROR causes, so the ack is final.
>=20
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D8

