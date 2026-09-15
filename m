Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD435DA67
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789491107; cv=none; b=R0dBuas79GnZZmJu16ok9Jl9aM02/5t2WuqWID0C5exq5z9NHr7WqXgb7WwjbYCvvb12sMIifa7dJyjSQmG5Kwyz1VW6ZIBL/5IkLMl6O03CGvzendM7zFPn5eSYCCS/UPwpYTNsOKRVkM+9I2QJwTcB7JJgRaEQ5fzpGY2loQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789491107; c=relaxed/simple;
	bh=LmJf7k6sslbBQz+hIWOCKDrN7eJqVVO4XcVWfAxDYgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=byQhqw/K9V/t/gBuxCDhG1S94aeL6OQrim9IOcJ5ene7kECIO/50EenFNDNDUAat54tJDdXjc+Uso2T5i7gqoaOrq0oY88MCjDW1D00f7fuEDtwPCbqHxPAoGo/Jdy4w/k0MY//kU0nsN6EVqNUvDfMKbAZzYxQUQ0gtjGIodSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxTRA7In; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxTRA7In"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDF21F000FF;
	Tue, 15 Sep 2026 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789491105;
	bh=LmJf7k6sslbBQz+hIWOCKDrN7eJqVVO4XcVWfAxDYgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxTRA7InnGOCn+5tSRgW34Ju9oIkYpjG2GZMe5EG4jQKyLRu/66RUZqpWmn0fiwDu
	 4WWZqXl3pJXZ8d5JoqDW1aTDmvPvbw3MpGvIbtVJ//vRBtyo9/qtgrtQiB+KN3zwqf
	 hUP/gMxMhTTzm6/Wi6LH445OOW+PkHTE4zcdaXkVtgsPRqKDwt/ZpqFjP7rTJ+XJwB
	 DW9R9HU9se1DTnKDihIb70Zy/E01ZhldkeoLiu6iOirG9JtGYH/u2H+QBrXB6/7i4q
	 luay+PvoooO+fTIopLS+a7zEjEKrirzcPhhAT75ztz9+0HIQVwbLcuCIwQG3T5oukg
	 BWDer9g3B7O0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault
 events on domain detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:51:44 +0000
Message-Id: <20260915165145.6CDF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When a device leaves a domain, fault events for the old domain may remain
> in the SMMU event queue or the IOPF workqueue. If the IOMMU core frees th=
at
> domain before those events are handled, the work may use freed memory.
>=20
> Start with the hardware queue by using arm_smmu_wait_for_queue_drained() =
to
> count entries consumed by the threaded IRQ handler, and poll the EVTQ when
> an IOPF-enabled attachment ends. This prevents a pending IRQ from queuing
> old-domain work after the drain. Its until_empty mode can drain the CMDQ =
as
> well during suspend and runtime PM.
>=20
> queue_poll() cannot be used because it is an atomic busy-wait that expects
> hardware to consume entries. The EVTQ and PRIQ are drained by threaded IRQ
> handlers, so a busy-wait could starve a handler sharing the same CPU on a
> non-preemptible kernel. The new helper sleeps, and might_sleep() catches =
an
> atomic-context caller even when the queue is already empty.
> [ ... ]
> Fixes: cfea71aea921 ("iommu/arm-smmu-v3: Put iopf enablement in the domai=
n attach path")
> Cc: stable@vger.kernel.org # v6.16
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789446520.gi=
t.nicolinc@nvidia.com?part=3D4

