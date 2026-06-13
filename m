Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE12EEE78;
	Sat, 13 Jun 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363673; cv=none; b=rAWcvdS3YdUn3l08GgZaqfTo0Iono2w0LCsdDZFTYz8P52Qjpsjmn6KIGETe4vJYSNl9k0bZGG7vY0hsGpS/7a7X0jN/i/Qsnyl0PR1GAkyhDUqK09ZRfBvN71Lww7YbJ+KQm1KcLO5Pi6YyKq1ROA5pxe/xtF32H0NQ9fpFqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363673; c=relaxed/simple;
	bh=opt81One+1EVTBL04qo1AD3PBVrDMQE8KTOImoclYKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPJubyhtR6CDmEcG8ylzyhYG7f/YT12CCar9ipMmBIK3hdEpo1WFvWk8ekw67asSxDl1xhLfNb6CAMxcwa1N4HvWb4kVEkfz/rJetuDbI+CFN9th+tISrYld18f//GVQdnFHMt/Nu7kJO2bSJyyy4U9vPF5tw5uPB689Jr2AEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld8dc8kN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld8dc8kN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589A51F000E9;
	Sat, 13 Jun 2026 15:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781363672;
	bh=r3N+SGvmtpAdRCvEa9GYupMrffw23eb9e4e2iTb6KJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ld8dc8kNbJ6lDnr3nzHwzmKO5bK2w0gI6hs8lA+cR+hvaRWuNaxYNMtwrPinqyLBg
	 D/e5HfXjR54GyZhByeyQAu3IQkZzDvHI6DkyaZIJ1inWU88UXI9ecTu7+gfjYH8A3k
	 6GocnabnB3s3C0VMrubf2tA7NuIdLBnrIlhCMnktxu1z6R3bEDs+sRIBvRl952fXUP
	 y8FmYyCCZmSA0x8UdfG95k28zzfRiL293aP/fl/QDpDy1dABGV7n+LZ2pwmReZRgVO
	 I86Ggz4ztC+UxCmJQR6VZKlZVgQnBd9JSRmwjVG+MOozkptf+8queFgsyTEbzuDQSg
	 bFKEKs4huxPlQ==
Date: Sun, 14 Jun 2026 00:14:30 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] alpha/PCI: Fix I/O port accessor argument order in
 pci_legacy_write()
Message-ID: <20260613151251.GB3086320@rocinante>
References: <20260612232400.585195-1-kwilczynski@kernel.org>
 <20260612233426.B7EFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612233426.B7EFD1F000E9@smtp.kernel.org>

Hello,

> [Severity: High]
> This isn't a bug introduced by this patch, but I noticed a problem with how
> the val parameter is populated by the caller.
> 
> In drivers/pci/pci-sysfs.c:pci_write_legacy_io(), there is an unconditional
> 4-byte dereference of the dynamically sized buffer when calling
> pci_legacy_write():
> 
>     return pci_legacy_write(bus, off, *(u32 *)buf, count);
> 
> When a user writes 1 or 2 bytes to the legacy_io sysfs file,
> kernfs_fop_write_iter() allocates a buffer sized to the requested length
> plus a null terminator. The unconditional 32-bit dereference causes a
> KASAN slab-out-of-bounds read and populates the upper bytes of val with
> uninitialized heap garbage.

A known problem.  I will send a follow-up patch to fix this.

Thank you!

	Krzysztof
