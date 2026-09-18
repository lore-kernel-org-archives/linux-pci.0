Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C974FD268
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743975; cv=none; b=Ac7/6Uk2V3rN9u7ZMc6yA3B++HojmwF2zV+bEzM/pyWflXfI21rlACP4436ArveV+CE68vCRqGMoyZpzUYyl+vbu+mq+CQZ020rz3t4x0HaCyNIlMpIwg7G0zZ3iHFq5Z+26xn/xGwsHH0lj8ASvpvepCS88AkhVlzxeHyTyfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743975; c=relaxed/simple;
	bh=DrbIHJ6nIRL4eiU2EQL0iJN2n9gHmE9Saf1nB+ffuuc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pGP8wMmAPnBmsGFbKQH/4OsTsbhswYzaXTC21pFfA9YAYj96NwZSToazB8yIj4xdpUY8A3Gsu2GDElYqaV6MQCMcXPhGZOopwXpLITtipldWyOS8bH2erU/j7/Mqj404MAlt3WSuveECXcEXVK4SFDKPM/6KSv+ImBO2sZtOwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/uuLjoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/uuLjoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A601F000FF;
	Fri, 18 Sep 2026 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743973;
	bh=DrbIHJ6nIRL4eiU2EQL0iJN2n9gHmE9Saf1nB+ffuuc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J/uuLjohpfVoIheTtyt9yZTqFTVX+QAI7HZfGk4f37jPZsls6IVgQ1Dv65NXoAqI4
	 jjDXshrxPtFM0v6izchruhvrTEZ2TD0uBDa+yyzg3j29M7EPQc36cpk/YFqNaI+MTy
	 JjVLxHK4nHo9BoZSFf4aAHxT0hqB2QeEzFQX3nYuaYPhMBawuKnYImjC3u6ToK83jZ
	 0ptXXw+xVCIZNQE+N0IeYBYkLXUoTmffQNYhQ82Hl0Hln+zYS3ZOcBm9LHEyoi7gPj
	 WE+pXJ2k4maPiWESz+e4UQOnCuz1TRUPX5xOL9l2yQryULHEDQ3Nz3oo+wsLfQfvUh
	 eXafuu+88z4Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] PCI: Share the AER ratelimit sysfs accessors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-6-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-6-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:06:12 +0000
Message-Id: <20260918150613.18A601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The show and store paths for a ratelimit_state exposed through sysfs are
> the same whichever capability owns the state. Only the expression that
> reaches the ratelimit_state differs.
>=20
> Move the bodies into pci-sysfs.c as four helpers taking a
> ratelimit_state, and add PCI_RATELIMIT_INTERVAL_ATTR() and
> PCI_RATELIMIT_BURST_ATTR() to generate the attribute pair around them.
> Convert AER to use them.
>=20
> The Makefile builds pci-sysfs.c only under CONFIG_SYSFS, so build the
> AER attributes under it too. They were dead code without it, since
> pci_dev_attr_groups[] is their only consumer, but they were still
> emitted and now reference the shared helpers.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D5

