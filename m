Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F9E339B3D;
	Tue, 28 Jul 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279166; cv=none; b=VzN1oL0l2e5u4u9S70NtKjQ8Fhn1rDD2dJhM5x7uNFzI7vLEnO6LSGs7IZ9rKi5WyFN21vrLeCVTWvWRewq0FqTGb4LNA1Qrg7bfucj0VNBJs1/4RFk7+tVorJx8Zr7C5GgkEckSPvLUzqcunRSltpwOgYrd7Dg5+vTE6W7lyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279166; c=relaxed/simple;
	bh=kErU3jGyj9a4TunqRU2UFU+l2Y9omC5Er3xrQ8AMVLw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k2cNMX4LSepW1H6ZDK+HA64cCOWmPYoA6hQko6d6Ut0K3FOUSHTBmP+zQMkFWr3PmAwu5jGhztpbsKFs8dnxQrpHd1hxa486xzv6XWufy1BLIt9sdpvIc0Fgemcov4itkvASYmSkrpJzsybw5qZjSEqo/qmfnerCKylhGcXRkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rrFwnWoL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9neMRPHn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rrFwnWoL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9neMRPHn"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785279162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkGONtf6EJh34CHU4D1VPffU5cZ8vSI7HTKT1Oc1wSM=;
	b=rrFwnWoLaRUIKbEx9v0akYqGGogvTxd3AEAvfbR6ac2vaMHuaOQBVJPek1rZ6oWOPLs7b2
	acSKeYx8mDK0f8eLL7kRUECwybouto41atVCiDzQL4Wss9cv0N3eIilwPCqdc0bCiYvfLP
	bEJiJ5DnCVlmxo8SEqeCDKvB7TjSsiwfpwYfy0H6Q4tQsI9dRMoa8MHAQlJdAMQ73jIcbi
	8V74pPM0aZjn8bHgSeUxvalp/p+joT8LyXlD/P/WOvwFJCfIiOTXAnuBo6HaHV5HzlLxyD
	oGJr6xLpmd8Hjedcg0HyNaD7x3T5xcqTDsOto3+9v5SiVe8E4RuJVP06VhaG5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785279162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkGONtf6EJh34CHU4D1VPffU5cZ8vSI7HTKT1Oc1wSM=;
	b=9neMRPHncBYfQ1NcqxE4+F2bP4mY2IiJErgR+q+YOdsgSJXPNBl2l2tH9sd7V1l0dPuVD6
	G2UZalQFrLTeesDg==
To: santhosh kumar <santhu.linux@gmail.com>, linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: Re: [RFC] PCI_IRQ_AFFINITY limits MSI-X allocation on 384 CPU /
 1000+ NVMe system
In-Reply-To: <CAKudn=rGv-xwAwTis8wpg31mxekyE4YH-E8CQoDTYovsPrENnQ@mail.gmail.com>
References: <CAKudn=rGv-xwAwTis8wpg31mxekyE4YH-E8CQoDTYovsPrENnQ@mail.gmail.com>
Date: Wed, 29 Jul 2026 00:52:41 +0200
Message-ID: <87cxw6hgli.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 28 2026 at 12:12, santhosh kumar wrote:
> Observed:
> - Linux 6.13
> - 384 CPUs
> - 1000+ NVMe devices
>
>
> With PCI_IRQ_AFFINITY:
> - some NVMe devices fail to obtain dedicated MSI-X vectors
>
>
> Without PCI_IRQ_AFFINITY:
> - all NVMe devices obtain 2 MSI-X vectors
>
> Investigation suggests an interaction between:
> - group_cpus_evenly()
> - irq_create_affinity_masks()
> - x86 vector allocation
>
> Looking for feedback on whether affinity-constrained vector allocation
> could explain this behavior.

Math perhaps?

Number of CPUs:  384

Total number of available device vectors: ~ (200 * 384) = 76800

NVMe devices try to allocate min(nr_queues, NR_CPUS) queues where each
queue requires a dedicated interrupt. Add the managament queue to it and
then it's obvious that the total number of required vectors is larger
than the number of available vectors in the system when the number of
devices gets large enough.

Nothing to see here. It's simply resource exhaustion.

If you want that odd setup to be supported you have to talk to the NVME
people and not to a random list of folks which have absolutely nothing
to do with NVME.

Thanks,

        tglx




