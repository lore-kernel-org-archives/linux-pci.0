Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984208;
	b=h02OhAMww7E7JSDqOqqkK1UF2JjwsJxss+asae0FBEJvIwCF1evPLE7e16z0ECIMrxPR
	 z6NhBZKW0Uv1aSMAsfO2QwdPQuBcV/M6BG6M0F0xrw4ilpyIieg7D8O72TOP62KDrIIYk
	 zqTnVtyO/B6zV86hGlB3fksTQwC9tkCRFo8g+r2dM7Vy5PQ0zgm1ORiwVcj+4erHyWVLg
	 7MlnTrL7SDX4PYsbzRP3KeJKStYOZ11n1xMMneNrPGnWZOTbHjWn5qx8qSrxErRRDNynG
	 dZCTocH78LmgieToF+SFp4LHdM6/1oRvkt6s+7y3GINHmTJCDvNZcCGgbB+v3FLvyDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984208;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UMoPahHv2EIHkQEJjh5Tshzm/BTxLvso7C8eR52i+G4=;
	b=xA1kLNUQZGsPNwOXJDs24jAEhnMbg+KwJTEC6eP6FLMiP1qvwND0Ko3/Kz5dOI0fF4s3
	 Ln78O38NQR1EiiUjqpDwWu1p1GSBKfpz9DdWq2wB7ZtuT7pbdAngfaxcMtpcP1PUAiy4H
	 JDPtyjoFKst3LEWY5Z9WCCT1Z2Lzp95GUv9ETMfkFZ5KVtIPKOI9XCdq04nExn7HtwP1o
	 Qb8Bzoi4o8cIYRhQsUrG/rsadTfH6WWhBcGnd7OeOjNMUW/Qg7RcD/hBkG05QdOBFwZvT
	 Z8Qk3C/18CF2IZDhR/ZguMVAPff4dJeuPt6Nlc43Y/8H/6wJWAF9aQJLC1SyRm8tXZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AI1VXYlb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295A606A32C;
	Fri,  6 Nov 2026 16:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AI1VXYlb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72DD1F0089F;
	Fri,  6 Nov 2026 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984208;
	bh=UMoPahHv2EIHkQEJjh5Tshzm/BTxLvso7C8eR52i+G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AI1VXYlbGHKHBSDeYRPa9IfNna+l0TQHpTzeMjjLxqEtHsr1KUrWx3LjcHDD2EsHG
	 Yt2z+K3hQchT6TrSnr2E5e971gHRhO08bC1flVFfNKFN2BwCSojbig5o6XgMZ1xjJN
	 QKS2nlzPe8fqTHeW+MRJ0cg0f+k9RZhUkismQhDXEQMSr6B6tr32DI4nkdvppZVSik
	 jJdi3wftovQmwF2tl8gyrJ4K8RBaoICTVulwRxUuBsk5apX2nuI0AuNJ/rx+wAJ7cq
	 93KRStOvSJKCghD/E/i2SyXdr+rPUNNhbwLbwnA4qNgQp3M7Wu+h8FkLe4WVmmJ83a
	 a/JcOXxrCyf3Q==
Date: Fri, 6 Nov 2026 09:56:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex@shazbot.org, jgg@ziepe.ca,
	kevin.tian@intel.com, kbusch@meta.com, michal.winiarski@intel.com,
	satyanarayana.k.v.p@intel.com, sonangp@nvidia.com,
	ankita@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com
Subject: Re: [RFC PATCH v2 00/16] vfio/pci: Handle PCI error recovery and
 report state to userspace
Message-ID: <au4GznJ7p1k0kdcD@kbusch-mbp>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>

On Tue, Sep 29, 2026 at 06:32:49PM +0100, Shameer Kolothum wrote:
> Hi,
> 
> Currently, vfio-pci signals the error eventfd from error_detected() and
> returns PCI_ERS_RESULT_CAN_RECOVER, including for permanent failure. It
> has no slot_reset() or resume() callback, so userspace is not notified
> when host recovery completes or whether the device was reset.
> 
> This series adds opt-in host PCI error recovery for vfio-pci. It blocks
> device access during recovery, restores device state after a host reset,
> and reports recovery status to userspace. The kernel runs host recovery
> and the VMM decides how to recover the guest.

We've been experiementating with this recently. It turns out that doing
a meaningful recovery on the user space side is a bit more difficult
than initially thought, but we can at least get more deterministic
behavior with these notifications and gracefully stop affected
processes. I don't think there is much else the kernel side can do to
make this go any better, so this series looks good to us.

Acked-by: Keith Busch <kbusch@kernel.org>
