Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A91147DFA5;
	Tue,  1 Sep 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255845; cv=none; b=JaXsEAM27wcq30DpwnogVKKOJx4Yk00iDS3fZzr4v88f4xoMEQ/ezQYcxQux8t2FJvvdi956fyDGQteZdcH66YjCoJWJJGiFVd6qPwVDXvbim2HBTZciqw0CC8zDeXHzMe9rTT2XON5fSmBd6oeU1wb5IO1k5pWgLs2InG+WpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255845; c=relaxed/simple;
	bh=JNPMcfBzDbawBkNEhinVH1r+LWFACHrSnTdM4silPVk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mOR0aj8MfAn7lWHE6NRSaYAfyiQvydNb9gbPgvv22J9Y1FCFTWVhRbu5yuPKA9xYTeZZXqTlTO/dyatmDF9oJrkz61eALHairYpm+8QOQUpb2LUVi+hEJw8ZfYYt6r1EL971UfqOG+y/YuM3qE+SwA+WQApATOTR4mHn4haTt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPadGlQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPadGlQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD521F00A3D;
	Tue,  1 Sep 2026 09:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255838;
	bh=JNPMcfBzDbawBkNEhinVH1r+LWFACHrSnTdM4silPVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PPadGlQ2EwiRq39tk7kqAuraW3+0ccqBa3GYEmHG7S8W6dtBpkEEPplEJXzRZx0ot
	 1R7H1ks5mddUVwRXPexKKJid9m53kRSMOrTn/vLAQG+d5R7jGqup5cMQ51oaAZQxV1
	 wqKL+DTH714ts97VY+agWFlxqtSaKrH6gzfW3GtLCnhZiGYzSQ4IIf4s+9oJmCgqwC
	 zq66rNvlkZLyBWRhy9BOHct1ggqatCs5CeipexuHNeeLCQ3PqrZvsSg3KDDSYO1spS
	 dC+iactuTeJJZNmGgr8KJOpGj+oQhaIqq7+uVjiu4CvaGmQtUTm6PQmRsHXVcbFlEX
	 5K30dEE/F/Xlg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/19] vfio/pci: Serialize ioeventfd writes with
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-7-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-7-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:43:57 +0000
Message-Id: <20260901094358.4FD521F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Share one write helper between the ioeventfd fast path and the threaded
> one. It takes memory_lock, checks the recovery state, then writes. The
> fast path runs from the virqfd wakeup with a spinlock held, so it
> trylocks and hands off to the thread if the lock is busy. The thread can
> block.
>=20
> The ioeventfd write path must not take recovery_lock at all. It is
> reached through flush_work() from the virqfd cleanup workqueue, and
> VFIO_DEVICE_SET_IRQS later calls vfio_virqfd_disable(), which does that
> flush while holding recovery_lock for reading. If the write then blocked
> on recovery_lock behind a queued AER writer, all three would be stuck.
> The flush waits for the write, the write waits for the AER writer, and
> the AER writer waits for the reader driving the flush.
>=20
> So the recovery state is read lock-free, and the write goes through the
> [ ... ]
> live, so testing it unconditionally would drop every ioeventfd write for
> every other vfio-pci-core driver.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D6

