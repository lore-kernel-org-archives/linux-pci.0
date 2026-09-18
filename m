Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C803D649A
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744782; cv=none; b=s9+L2I2GRNhUTqU6SbyKQJDOOWVnurgpYxvKeLKWxe2yz0eiS9h91HsWP9hYB+gLBXQxkN1FAdVMIjTx7SB4qy3Cr5gMTNyrGLRvmGsYzWLHXE6z3XzrZ/m8fPB2TSs1hIh80pQO02z4j+UL+aAD647WUTT9YgT9iCAbQ7xk9Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744782; c=relaxed/simple;
	bh=5snpTzoOZCFKfebqipgqKRUYpEY6miX9APg9Ul1XvXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wk/LD+Q2ElWwP4TNGCAnM3ooIMj4pCfv04D7NjLSXmMO5IJ891Zj05zRwEMI0Y/gDdOtG3duPNHJvhM4LY4vPgMyiM2ivd1WaNJSNglYI/Us0LhYYchjTk+hUafQBzGeyUqfj+T1cA0qsnthPDmF7imGnIigA2GpO40S1tcyeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGS1H15K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGS1H15K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E7D1F000FF;
	Fri, 18 Sep 2026 15:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744781;
	bh=5snpTzoOZCFKfebqipgqKRUYpEY6miX9APg9Ul1XvXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGS1H15KXfuDQrQW7C6OioB+cQMtcxZn279a57NXx9gCkzgVh7ESATvMB0GDISXYR
	 Lwf+n5CiwMRS6g7CPPvldP8xAg2MosrVi37TWbbx+riViNM23oEDvsBhOvh3T0fYkD
	 w+iKNrQMRvejWCFP3Dd13gROPIQg2lHBcPu85C2Y6if0XF2AHdP8Fkai194YUqogUb
	 32mjcSQ5pfHRpUHpchwMoaJSRf55VJJXs+inENu7CpnzILfs5Mm7by7oMU2i0TTz1t
	 MJ7yFBitPiYOy9KzKX1hRX3tYdeaLjR+LORslKGdRxdLpdJhrAcTubNuezUosUvJvg
	 7+10V2sF4jRyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/10] PCI/FLIT: Ratelimit flit error logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-10-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-10-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:19:40 +0000
Message-Id: <20260918151941.39E7D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A high rate of flit errors can flood the kernel log. Ratelimit it.
>=20
> Keep the limit per port, so a storm on one port cannot suppress logging
> on another, and take the decision per logged error rather than per
> interrupt, so the configured burst counts console lines. AER does both
> for the same reasons.
>=20
> The trace event is left unthrottled, so tooling records every erroneous
> flit even while the console log is limited.
>=20
> Expose the interval and burst through a per-device "flit" sysfs group,
> gated on CAP_SYS_ADMIN, so the limit can be tuned or disabled at
> runtime. Document the attributes and list the new file in the PCI
> SUBSYSTEM entry.
>=20
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D9

