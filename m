Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79F5625FA
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933297; cv=none; b=R9wdLZpJhgzHDv8k1MNOZLDGWB1I4cPxKmM5Chtkg8YcH0nfedKkJOBMBNs38EEfmdE9ICaPFYOoy/XNFRy4tlH7MQx2vcpi0Dg7MjYj94uQZiQsW0cvew0Oek8mi/lQJVjyYCNAs60wpaX6bogwr3Qe/VZWm6TqX4/WnLcXcf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933297; c=relaxed/simple;
	bh=BddERsuDP6R4Cbn9usKbmbzhf9XcSc5rHPxWpQU/TjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gShPmZnO9PI5rPL1v9nMkXAbPo6KwlWNnRiCdRTOCoRhFzG4nVLcQYk8D4u6UdMRUqT3jusQrPh4HLVRqhZif8Wx6NVJFzX6XYN57ubjKM28TpXhnofPzbOHNL7QaWbI1Fx7B0c8LiZID5tmApdvjqt6Jkgjf9pAN2UKykIo+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Jna4mtJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ucvmNWWd; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Jna4mtJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ucvmNWWd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAAE07A026D
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 19:14:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Oct 2026 19:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1791933291;
	 x=1792019691; bh=j3cnmPFN8rnj/dARNtFEfslM+rCB4ZDQFnUJp3HQPBE=; b=
	Jna4mtJcwX4rVOYRRRKpXoeeKw0fTRAofebSwA9yGi9SKkraJWbjC5eXHJlPTndQ
	7+NVUqGIi72qiLgtE6ukMy5AUrqRRrugxvcZblUdIDEZmX2ZLBuAQmrUSFdixwGs
	/RJVuYj+7HYq1eN2ieBuEsdOdrsYGCunrlP+EnUDSf7JFuSdzVPT3pk59L2jGbPo
	7IWzysvIZn0Rtv7T7WDftSxNQAeAKHrtRsfDyjy0Y15B0nabusTI+BgsG6ufwQ4/
	tC29OE3NZDtKwvilkeJ8ueDtbed4egud8Sx5WC5ZamI9tBpm8j/7+jSGaEi2G8MW
	TLj5lYJBeYN/Qt7IrUW8+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791933291; x=
	1792019691; bh=j3cnmPFN8rnj/dARNtFEfslM+rCB4ZDQFnUJp3HQPBE=; b=u
	cvmNWWd8/liduv+SjZuZ3qy4YcSnDI0qAf/j0fJ6PR90se4nc3Al5diPQappmoqS
	FPBhuKYyecriJkP/xv2hZeHInwCkcCwyQjOGurUDTcQ+rJAGwDSLSBomwChQHESy
	lF0+5XAY805dFQpPzNFLEFxf2Y+XLVgU3mUyAnY1twrH6gTrR5wRrgrTQ5b6+iy2
	NRvWsCn44t0aRycWhZ54qA6nGIh/cWtJNJM22bHrufflD9HHWsudt4bQ4Zg1NGn5
	C0Sz5RiiRaiWc45pIWbhDVKeWif/DZWVZUIZKX+6rfrOoe1zUmlup7ZUNox0adTp
	GXxZaYg9xNTEaVcA4PovQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791933291; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NXUN9zDTjS57cYAlq1IsPXHLIjnmpLfUHn0VBGAolZTy/op
	l/5FUuOOR3NSk6sMYwxaIBSx+t/WES5sNs5y33n+bie3FRB67MewXD7N9gmw5VdL
	1NNlXz79bPcP4CsF7R2C7TIE+aki3MbZLx466jazQb0bf6DpMV+QmthKmxCUruM3
	DETZcJhDpIfR4bJXbbcMTuyXki4lJ7B2GMk3oI0ke+5mFFUQgaB4mgnUPM692Tr4
	UHaijIGDF5F/U/GZ2VSWlcw4Ws20eehSfq16abRrvtVYsrVAoCkhHWSY9Eth1sPm
	cdE8akRgA60cpX4GBtBwfkT1GAfFUKfFS6S1+fg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:vRLpZWNtBttavXmzypfYLdfdG9wLxAU8RaZwt2UIKnc=:BddERsuDP6R4Cbn9usKbmbzhf9XcSc5rHPxWpQU/TjY=;
X-ME-Sender: <xms:a7vOah9I5zqNJKzctcF3W0Xj7hJbmaAwkLcW1Z-w-jBbh9JdbaAgog>
    <xme:a7vOanWWolMPB0D3kiMX8xMmG6jspg7SpCRl8e2h9gNLLL3IqR72Wnc8jwasl6WPq
    vKVC3jb1OpqEioSchldFQzA3zwvesPAldDbLj8gwg3d7pJOEEY-nUU>
X-ME-Received: <xmr:a7vOajETBUAou0TnO7Xg-aGz8oxcL12EOvsYELAVOEa8oCxyjzz4xwStAlrVtg>
X-ME-Proxy-Cause: dmFkZTGh5K968C2Cl84ptSi+4y/RZ/kVjRI/KuhQFT9EdVF+wlBRkUV3+MnA4Bw8USczqh
    K75Ks9fzzqoUpxb7GlBjbnkhjHyFx4/Ig31C73IxKiEP0jiid6Tlem7NohMXSaR+5FMEhK
    ifHB8gtzfUTonlinprF4mw7WPTut7T/J1hPsQXDLSJK0xqaYcZbKfDVq23wYMjW2iywqpO
    ZIPaJ4ce5Zm6PCb9LkghPIarZYc8Qnu+WxwoCZiOXCKojQi16QdbuVc39mEboH71fqwON2
    cQwxZsIGEE5+oDvRemv0bEM6otLHIcNZE8FD2rvXxw3NzcIK91ZKa9ZQuG1p86j7bXidXt
    nx7oRau4R8ktjt8xx8AVoklGfCVCUxHEyEdb8WMKKkixyLlH5V1IUKqIe4eJkYIC24l2rI
    5UqKe04Z75OhfULWpLV82UV6nELVelihusnkJWTnseeRdGPxuGOHNKLSkvPjdlOFeoQwcn
    rEIWZtOghThAvgQM53yIkdrplLF3roKTrRNoUrCcM8AGtIAtpO3HsCkWRaTFsdJkRgPuSi
    JpPJwpdKBrCZq2YJicn2NgChcQyy5Mrw196pPwc/ujnE7Pmkau5ZUb2vw1rDmaE1JxcU43
    zYDiLC066uMCfXh+1iaphmES1zROZUOJLLKC2B4D0NzD32F86nz6vmPa3/VA
X-ME-Proxy: <xmx:a7vOar7YpMZLQlbVw9ZBEctsj3C7fw0rEkZcBygNKb5GreUwA_tMEw>
    <xmx:a7vOalKZDRDVNkrIVnmM5VOhJLsAqsB-RVeq2UJB4fOYaNTlqd0S0Q>
    <xmx:a7vOamDncoN8UmEySaGSIpqISdYnhmvf-EnLb_sVh-3E4Jq4AWikyw>
    <xmx:a7vOarTUeBiF4xaATUHEFU5CCp7poIlR5FiZKRzsXwBLw7keL19cVA>
    <xmx:a7vOarekC7KfHIziycaViAjT5kDRe5G-6eH6pi73idtDOCOYQuHvqGDS>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 19:14:49 -0400 (EDT)
Date: Tue, 13 Oct 2026 17:14:16 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v8 1/9] vfio/pci: Remove DMABUF export dependency on
 vdev->memory_lock
Message-ID: <20261013171416.40b00e73@shazbot.org>
In-Reply-To: <20261006193643.76330-2-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
	<20261006193643.76330-2-matt@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 20:36:29 +0100
Matt Evans <matt@ozlabs.org> wrote:

> The VFIO_DEVICE_FEATURE_DMA_BUF export previously used
> vdev->memory_lock to protect VFIO's list of exported DMABUFs
> (vdev->dmabufs) and their revocation status.  When adding a new
> export, memory_lock was taken for write.
> 
> A future commit will refactor DMABUF export into a function used from
> mmap(), which would create a new mmap_lock -> memory_lock dependency.
> 
> In preparation, this commit introduces a vdev->dmabuf_lock that
> protects the dmabufs list, per-DMABUF revocation state, and a new
> bars_revoked flag.  The flag tracks the device-wide BAR revocation
> state set via vfio_pci_dma_buf_move() under dmabuf_lock, removing the
> test of __vfio_pci_memory_enabled() and dependency on
> vdev->memory_lock.

There's a subtle change here that I'm not sure is worth mentioning, so
I'll at least put it on the list for posterity.  The initial revoked
state of a newly minted DMABUF is now governed by the device-wide BAR
revocation state set via vfio_pci_dma_buf_move().  This is subtly
different from the current behavior where the initial state is based on
instantaneous BAR accessibility tested under vdev->memory_lock.  Thanks,

Alex

> This is a cleanup currently, but allows the future export path to
> avoid holding memory_lock under mmap_lock and a therefore avoid a
> deadlock scenario (a fault handler attempting to take mmap_lock in a
> vfio-pci variant driver thread that holds memory_lock, vs another
> thread doing an mmap/export holding them both in the other order).
