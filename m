Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01E30C17E
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780543507; cv=none; b=BnYzrhIavyqAJiHcXpbl5qbJJnU2ObPLS28Uansp1HasVSkb10BEpddZ+oicKmE3Lo8d1J+5cn1nTXqVcB9ELOA+KaltS85kvNQG7jextPwGS0tS/txj6WU9XEK17Oul3D6CCZcRnojVeLz28ThBXmNGqyLHJdxStmXpNULT3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780543507; c=relaxed/simple;
	bh=lmBYwbfsa4e23p67rM3REKZjZPWZCovxdHMj0Z9UqDo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ntn9hXTGB30QIm0co1/DVejn9KOhWNHCNI8aL8VuyeDM6+5FFoilpxPU7Xa1VxJnWCyovQk8oAT8tNQovwH9MYGMsvpAOS9p4a5rkXDFCMIP8/8dd5RmWzhrXly4c2Y65KB2CI0rk8IHS3J3d4SYcpUH5+0J1648k9S+XYrWfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPjWfsLA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPjWfsLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC261F00893;
	Thu,  4 Jun 2026 03:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780543506;
	bh=d0Xz4a1Q+gJ22qJ5F1MHpUZ+0nilJhq4jgGVp55bDsk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bPjWfsLAgvgMG188ISGw0naYxqICj43VQJHxNnhqDUgngJBAMOQ8x8LolLqx0AMHA
	 gG8ArkVMlwoa25Upr+JRbw6PNWjjHuPcoqZwnOPnsBe33i9XPw6tHTs+rjgtVhxPz5
	 d0ChasdallOAklJP6RhsSt8+DuSpBd1vt87WZpcYDQUDi9YzKn1CMLoNb9jNMBMfgP
	 OrF1ciRGjWpPA1OKe0TFQ9ZADWNTDyMSNh30jcqy/JYT8yYbj9cu1WuwP442dZ5vWU
	 l1n94T1h4BMO1BckaafnUwFGssEhxiqVGkpO6p+eYEUCzekMzy2s9m+UNaZYLSHlVO
	 J7BzUdxZbDiCA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 823DFF40072;
	Wed,  3 Jun 2026 23:25:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 23:25:05 -0400
X-ME-Sender: <xms:EfAgau7Bl1B7hKDJnkllUR84iDLfO1VjGLfUmU84d7sEIJHgBj7P_w>
    <xme:EfAgakTmIRVUX8uaPJj6V3AX0JmwJEpeKrHvn516ALla-bNkbSa8umEbniMtVLhEi
    wwmhCZbF2NzmW_YxJhK3ie6O2GUfUEWWVrZtStzsV-yileowb8VWds>
X-ME-Received: <xmr:EfAgah60u_WSgGtwx1_fSE1RjMlE_tvKLfpD-xJ9Oc33BH4stGOMF9aSAxD9ZDuww5-jGYplhNA6rNVj-vF9wiS9BEYVDFJHXfc>
X-ME-Proxy-Cause: dmFkZTGtZnA4lNhAzhIaRH8KwXqznKm4Ddz0tb+abeDm3D/TQ9NI6sQFQ/x/eAhTBP3pEo
    yOE9ctGNQoZE0BTSgrR5e3Hs2d4DQ0IZdR+HcAqI7q8SFCiCPQRxa3eWlxx0JW5KP7Qy4G
    xkeY/F/rRw0+mfG/w2Q0Ln+LbRsLtIlIbHmqVKzMAq81lDZsVOMJeOF6gzy5EisTWGJVwH
    WHsmhM7vgTCLxhtdd5Vh+M4UTwLxk7Cm7Yx4FX847XDLGmHZs0jKTnDGx9qoSBAUtXh2hu
    gyW5/rglanUcKSz/zzuB+6klHXbhZ5uFWFT5v2YEWTnhKObQ+h2GVbcP7YPTArRwdxAgg5
    gb4tOl4Sfq+KGx/vOlZhKVhzdFdpSqjKxKoweoc0zzrM6uB+nh5izeBwrnliADjYGNBBSD
    QXo5opBbuXrCFr2fWC5qPzGS0nMcmVUlYC9R5mxrnloipQ0dyAqkcKWz57qowNZNC0VXrY
    plGsmsSOqBG7FV1HqaGQFXd39okxtsU6Um8B7Gds1tXApzvczNptVZqkkGhjccx8a/t40f
    9xKvjvn1E9MEUdCTDlK7YhDyFfIY9EPWS8p6fTt5GJ5xoDdCyIahfA4mXGZcjwl6iPK+Jo
    tF97nVqgzgDMHEOB0SBYT9LcR/mHPDzYA5a/hkQF3RafWh8qA38MfG8JbUUQ
X-ME-Proxy: <xmx:EfAgapS5m9tfi2ufyvloLtJnxCAxKvAxewLpcC7LgrwFAIztibbAfQ>
    <xmx:EfAgaumbP4O0ehHGG_uLs_YtYPeVY9PtngG3esIrcW2vsBKRZQEEaQ>
    <xmx:EfAgalTcW-xMkk0cCjby6f4G6CkZLB99FlsmTXB5jlNBHJ30isvkog>
    <xmx:EfAgattMq7SbCkuI-ihBOqeuya1E2o_JT7LAaCPcPWhOXdKsoElncw>
    <xmx:EfAgam7uistIMLZyLyEIXy2aBW-9cNH-qd74PIEiXp_r6qklwd8zvDdD>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 23:25:04 -0400 (EDT)
Date: Wed, 03 Jun 2026 20:25:03 -0700
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
Message-ID: <6a20f00f8d965_42b910033@djbw-dev.notmuch>
In-Reply-To: <20260528083154.137979-8-smadhavan@nvidia.com>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-8-smadhavan@nvidia.com>
Subject: Re: [PATCH v6 7/9] cxl/pci: Orchestrate CXL reset for affected
 memdevs
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
> Add the reset flow that coordinates the target function, affected CXL
> sibling functions, and any active memdevs in the CXL.cache/mem reset
> scope.
> 
> The flow collects regions for the affected memdevs under
> cxl_rwsem.region, verifies that those regions are idle, flushes CPU
> caches for the affected ranges, saves and disables the target and sibling
> PCI functions, and locks active memdevs to revalidate that their
> endpoints are still present before reset.
> 
> After the CXL DVSEC reset completes, restore PCI config space so CXL
> MMIO is accessible, restore decoder programming for all active affected
> memdevs, commit their restored decoders, and only then re-enable CXL.mem
> for the affected set.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
[..]
> +	rc = cxl_reset_collect_memdevs(&ctx);

There can never me more than one memdev or cache interface to reset per
device, right? Those controls only exist for function0. The siblings
will not have their own reset and cache disable control DVSECs.

So, per the other observation that this probably does not need to /
cannot worry about save_and_disable precision, it only needs to invoke
the actual reset/cache management for function0.
