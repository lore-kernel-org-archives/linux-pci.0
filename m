Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8F47606F
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130422; cv=none; b=o4v/WJMZG+fktAriQ8UgYni9IUeXnEqDGjCLPoEhGxMXgCKV+dCEdutX/NLHjvWUG1morZ+mvsyQSWbJ2zjYI6Nd7aq18mM6TcBqKFEgRRSzoHpX99e3jzqtM38MipatYj0yv3uN7ln4YYhR9eZSgd1DdnYnEL1PkDk3jyr2/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130422; c=relaxed/simple;
	bh=dV0dPjpShKtleBHnDxTXtvvhIpqs9gd7Q5M/RQ4skm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNPKkGh8yMarrpdKthAP3lV55FhIjWeO/HjUxcghMJ/gzx6nfjvW9JhYlTkwVLM1YfWXnIQMSle18DM+mBG6x+hE+mlemXovkOAUUiGtCsedmlZiez/t1f3NTysRtmXI3OUTtpHrTV15qAA64U6uFHLZT+voZt7Au6c9mIkJJpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcssALUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcssALUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6694F1F000FF;
	Fri, 11 Sep 2026 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130421;
	bh=dV0dPjpShKtleBHnDxTXtvvhIpqs9gd7Q5M/RQ4skm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcssALURcCXcLpT7f/tiFueT076uCLP/83YbtZZd0ugeZ1obuZIrFNPffdGlluslI
	 cqnAl+vFaXedqKdh8z6xMWNSgcj3zm5qOQ3991VWoWUC9sx2vrKFLUOGCi1vUz3uMW
	 VljpbPEG5K7zvB+Pe8TwDSRUBbwaMy4VsVidAU33uQFnJepcb+KxSNtW3aCZ5GlZmL
	 /Ftk8iwBnM8zEesuV7H+oKGUkatOjNBienPSNKjutuiLuMfAx63UhIvcK1cu3xqU7f
	 dMZC2sVMLPpHGHY+Nw9Tt+0sJNChWrSKVb7rBENGY3Fet5Fbh8thOoglVjGMKHu8FO
	 BxplZ8RVNyLWw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/8] PCI: Probe inline from node-local workqueue
 workers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911123429.11491-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911123429.11491-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:40:21 +0000
Message-Id: <20260911124021.6694F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_call_probe() dispatches each probe with queue_work_on() to a
> housekeeping CPU of the device's node, except where it already probes
> inline. A VF added by one of the preceding node-placed async VF-add
> workers already executes on its device's node, so the dispatch buys it no
> locality: it funnels every VF probe through the single CPU
> cpumask_any_and() elects and re-serializes the parallel enable at the
> probe step.
>=20
> Call local_pci_probe() directly when the caller is a workqueue worker
> (PF_WQ_WORKER) whose current CPU is on the device's node and in the same
> HK_TYPE_DOMAIN housekeeping mask the dispatch elects from. The gate is
> not VF-specific: any probe already running in a node-local housekeeping
> kworker takes it, while a probe from a task that is not a worker keeps
> the dispatch.
>=20
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D8

