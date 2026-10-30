Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381548;
	b=nuxbXgDHs9MAvcx9SeA5EP5VtpdduPNCfv3VcD5jxc32S9t9C++WXPa0+YLSsOzO35Vh
	 IzEyHIWbywBdPbgDHFUmAIXc1XIOQga1HnwWrx5Au6hIjUNPMXJjJPjGP2QxgkRmuu62Q
	 buxiDcJSr2K+o00mEiyHaGqTPQ/veS6eWqW5vVu8O8NbExiChPXJggNuh1alkLDb0NadZ
	 NFscZGOuL4wtjiLaS+edrTrXum3hGjWvnw+cNtWFcpiKrU1ixfZyD9nv0K1+cYt/sU3Q1
	 GWX84W5t/kaSPbb94JlxwwZxIqdd/mExRm5tfbAFtfLwjoJ2r8ZlmY41o12wRb/CR5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381548;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q/CT7Jmj057Sdl0JBWeFE1cMcS2PpwuDCCF/mQJMfb8=;
	b=oXH9QN5niFOVVDop9wL/6EyBbyJZ0HQMRhk86G/8lrbJWO//lfgMSVcTAJUrYxXZPRoO
	 VNPJPduKACV01itMi8MBHG6bmOdcb99YHGcCLOoslCKcH7B8pu061wtjcr1WST8KnNAN4
	 6ae3OLIZrZnD4spLAwyH7MdGLVj9eh4ILlmBPbtU48d8FXWklD0Gu3OapU4z9/WfTA2IX
	 72gUKZzWmBfwCR4geRe6oQi8hqERcF38oahrHI+75AoNG0lop+86JlpxTVrIVK+JwodaH
	 0GDt/xcsiu9qGf1eDWNQbhoaD1jIKc4Omj1swfcuv3vEDHjflbNs+LkMomPWRAReMZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lure62SB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8BF606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lure62SB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407EC1F000C1;
	Fri, 30 Oct 2026 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793381547;
	bh=Q/CT7Jmj057Sdl0JBWeFE1cMcS2PpwuDCCF/mQJMfb8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Lure62SBCwP54dafqsa73Gm7CNru3d8ZsPCkmzPT0oAI7o+x1xDOgzIqKnMYSwki/
	 Zu1GQq8D6e6ecUvwTPCjNeRrAXd4fZYshIWLwpOOKMZNoidQJalu9IWtLfh2aIVHfO
	 FsRvQGHinFdC70FsApomKX7mj3HcccsJmdDUaYnrnJ9BOBcszJvm2Qee6/eUgjxc0u
	 TcxbdgZDM0Bn+/3Iu0sY2r0dn1BqGSdHM7xbXAklCgrh1fP3wg5FefgrpZFxpak+X4
	 Df47X9rwBATlK4jora/+WpBkRNh2WALh5YoN4asFi1nGt1b3A4lS8rWS5cc1QsSxpx
	 phUqj6OdGIdTA==
Message-ID: <sashiko-outbox-191347@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] rust: pci: add typed SR-IOV PF registration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-7-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-7-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:32:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Zhi Wang <zhiw@nvidia.com>
>=20
> Rust PF and VF drivers bind to separate PCI devices and may reside
> in different modules. A VF driver that calls PF operations needs
> typed access to the data exposed by the PF driver. This data must
> remain valid until VF driver removal completes.
>=20
> Add VfRegistration to register a pinned object in the PF's private
> data. VF drivers can borrow it after checking the requested Rust
> type, using a higher-ranked closure or a covariant lifetime encoding.
>=20
> Capture the core callback context in the initializer. Reject active
> VFs and an occupied registration slot before initializing the payload,
> then recheck the slot before publication in case the payload initializer
> created another registration. Publish only after all fallible work.
>=20
> During registration teardown, disable SR-IOV and wait for VF remove
> callbacks to finish before clearing the pointer and dropping the object.
>=20
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D6

