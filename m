Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1674071FC;
	Fri,  5 Jun 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687587; cv=none; b=bqwIrWjgGdbKIOF1VG649ySw/GjUPa1tVXUtFveEKImN/zJYZSR+9Un+Wggy2BAJt2+//QZkE4pDVwVTPwxmRCeldu0Rqjhq1t3Ywycsf2mGcNH+pqxI2BnZtsQ72+mBUqJanEVoE894AWKmV9IxjH/iouvb77/jsRzpigXuq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687587; c=relaxed/simple;
	bh=giWNS4+tfftdDEVsyGXDVou+jFlMi9toV3U2iEhy4/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/UvrdP3cSieA1d1UDri+znTtX5c5jt3Ak9sCfvjoEVShJU7QM0ptsCVAQ4F9s8vKI3R95ya8CXt1+UcaZtFFCUlzEFeS7rqlpDQCfTjaYExglsRr8a32czV51Yf4nxR5ClcgxvBQeGsNh7cBclIaUQTzoEBC4SneOoNfBNq7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=RpYmGY1Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yz+2l8Ew; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="RpYmGY1Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yz+2l8Ew"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C839FEC0190;
	Fri,  5 Jun 2026 15:26:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 05 Jun 2026 15:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780687582;
	 x=1780773982; bh=TQG6rK+DT2Llkzb+7UWII5d0rUPWDAdONOL4lGCmhH4=; b=
	RpYmGY1ZQz7EVFqdlqVZG6U4hy6ZwouhwMR9PZGpHOlan/SlCmy9JUdQMo7yBymX
	+6xja5CSIi/WguPwM189fl3zqMlpPhstQW01enqFqSc5Y+O5VHO60euVBd+NZDad
	MYD7HtpJoJwy85iDXR20tRVMXzPkpR3hzU28sCqSeo/91/lLIJVZ1/kVnGqZMrPr
	DZ8AbUdwnWECaDj/BbS68x99Tma+CPtOZ8NuJmJ+yyOQ0BJt8B9uP6k/PvN9YWa9
	ex/bM/GMVSzjIzTMH87JO3PNXO8F6j485tO89wKoMTQY2SU5pHVeXi7K0T/FhBQ3
	2KqcJFOd39ooGXsRJ/OChA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780687582; x=
	1780773982; bh=TQG6rK+DT2Llkzb+7UWII5d0rUPWDAdONOL4lGCmhH4=; b=Y
	z+2l8EwnPn323LBOWNw4mkqUnHlshC8bqbKq7zkL1hvQ+F1n/Wi39bcc2purtAkU
	9c4n4ZGuQtWtkmssT1TGL7mIc9mxwyCoAmOLh+467GNKE7FXEYAYBZ+C0D7kVQm5
	qQkP9PtrZb+f5vSorVoqIezuILh8KUSvKcjLMsdlFak7IKJBiTfkQkCHAgj772Ur
	10jPkaiqpnQ9PvMInu214VGOUdmznfb0WtQyTreQHOmRMbYJH/b622e0hbnUiyIT
	4ATJPtXzM13atWUyQzju6BZbXctQ4UOxbbZAD5d7jwAYwOnylHRx6y4d0R6QhOhj
	hDc+eUB8VScGcXrEg4Cmg==
X-ME-Sender: <xms:3iIjarrdV38Xu2humFgS4aWV0b75SEFQam6GAMBbUf3709e9SWQjQA>
    <xme:3iIjahhX-9NIdrZNkowXF6Dkibc_OB3GES6t34_cqxz-qLntK_dXVgeyAqU9PY_Nr
    cYrZtVV8ZKI-9tvvXwuQCg_9qUO2VXIDI0ukP_0NtK2UbV3-YN_DZo>
X-ME-Received: <xmr:3iIjalPALvzCDBZcaKR-CuHEGLTtQjxJDZK3IxsVDv5zC_-kBpH0GUsMvDc>
X-ME-Proxy-Cause: dmFkZTFpipnKTl7QL/Y3uF0JuGw6GU/nB6CelnxWNVmS0L1RdwhuClSMw4Z2MxMrVYLIDH
    KFDDwq6s6fik8+Vp/2w6dQ8hS7q9lLuYFzYnby9VRk3rSlYVEv2jIWOKkKX+0zma2WF8Sw
    +74ssZaeGu+hUnspuLLxDUVmdp2mW4pWGeAM/qgqRjtGwXK0z8jpCqP2qrLGk9ZJzx3TYc
    JS+jynOn3qND1cDooJm/KX0bxP46Sk78Qj37Duns3dx2/RTBCV580riGI3ET7PW+uGDcxY
    PfwJQAvaqeMXNfMcTvW4sCDNKI9gb0gGAJB4oapzYYzjQNEpGc4FmIti9JuKt0AaOBqZIR
    xO5AK/kXpFx7Ss5cc6iHfYrKsC6eGQOGgklAk9YkCd0+9EZAbNGVVrS2jCirNpduhnzPKM
    XOJRFBPWKh1V3xNJEs3antMXrxSH4ei1oSSoUgsehfTtsOzJNRXLoFdBrcglZ1PTwP8+96
    +OwO0bJ/AnoDbb43EAI1DLL220edUt3RYWs+b1U/Q0BYRKri2ydMDTtvC7aB1UUGgvV5yw
    0z/kisV/YLtvUvZzs0ieY/Jzaip7qRah+jg7sLZ064+np+fLAHzIF9DnjI5lgzYXcuJsEw
    tp1w5YJcTUmO6rk68Z0Q1z1CTSYUPFCoZf4J2HTdSTELtdb4aC1COOWKfALQ
X-ME-Proxy: <xmx:3iIjajzgZ2SDdqrm6hS_yBcbp1X6Ev00QzaUhvkND_mY3zbMb4fwZA>
    <xmx:3iIjavqaUZs28vyBIuBvDrawzco59cD74t1eVqRcDIEqvQVZgw7ZsA>
    <xmx:3iIjarPVIVCddA2M8g_gNprb_KKaNBnhHQCJ9-kYyf4K9nyw9a7ziA>
    <xmx:3iIjardl9QV70qPSb2cINS4dJca74D_i7EPpLWBwIlMH6f7Sdky1PQ>
    <xmx:3iIjamL1E0jM-CKiUzZwGB-xtoSzJ7q0YkykorVxOYedhyT596dcR0g->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 15:26:21 -0400 (EDT)
Date: Fri, 5 Jun 2026 13:26:20 -0600
From: Alex Williamson <alex@shazbot.org>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: <kvm@vger.kernel.org>, <jgg@ziepe.ca>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <bhelgaas@google.com>,
 <clg@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v8 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU
 readiness check via CXL DVSEC
Message-ID: <20260605132620.4f99e7f4@shazbot.org>
In-Reply-To: <20260602063015.3915-1-ankita@nvidia.com>
References: <20260602063015.3915-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Jun 2026 06:30:15 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. The CXL Device DVSEC offset is
> discovered at probe time. Probe, fault and read/write paths then branch
> on that to use either the legacy BAR0 polling or the CXL DVSEC polling.
>=20
> The CXL path polls Memory_Active, requiring MEM_INFO_VALID within 1s and
> MEM_ACTIVE within Memory_Active_Timeout (up to 256s) as per CXL spec r4.0
> sec 8.1.3.8.2. Given the long worst-case wait, the CXL poll runs outside
> memory_lock with only a quick readiness check is done under the lock.
>=20
> The poll loops sleep with schedule_timeout_killable() and return -EINTR
> on a fatal signal. This avoids hung-task panics during the long
> uninterruptible wait. Extend this to the legacy based wait as well for
> improvement.
>=20
> In the fault handler the wait runs locklessly before memory_lock. If a
> reset races in, the in-lock recheck returns -EAGAIN and the wait is
> retried rather than returning a spurious VM_FAULT_SIGBUS.
>=20
> Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout field.
>=20
> Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 162 +++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h       |   1 +
>  2 files changed, 151 insertions(+), 12 deletions(-)

Applied to vfio next branch for v7.2.  Thanks,

Alex
