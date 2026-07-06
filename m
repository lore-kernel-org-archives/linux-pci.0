Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7C42CAE0;
	Mon,  6 Jul 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341750; cv=none; b=Lz+Pcx+cpnTZvZheNyxsrvk2iioJYPkgK/cD8XBVqHYi+xX1IJFAuv6HwYcE7rEFnhn2H6OUx6uodfIhQopIKzRCFnD0k92UA0FHXJy5zLQkG33yioBlLf6Jks48cCuckNMwaDCUXLjpCshpL5CKBLaERzZJKFIk7AugjLjfhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341750; c=relaxed/simple;
	bh=DyRoMc+CznYGHXuPFcoXGT4MsIK/zcH0EdtlfriR3Wo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPgC3/M+eX8pEGJGcaxh8qgnU/NtTIED3CRm6UvmXsEMDe5nV0AUk5dsdj9WhSA8DnkTeTl8nDBjHn8Yet3Hy9YI3cHmlvVseyF0Ux5zTuFu0ifk3tLbsuy3MLTmP397srfMgxuZLlqZ5zKKPDxBZFYtsKezPGIvc19NI0cvl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPacFYC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPacFYC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701281F00A3A;
	Mon,  6 Jul 2026 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783341749;
	bh=543krN9qmzFTr0e4zZeLiY/vg2bTtCtvLD1B5JDZWZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QPacFYC+42kGj6ZnS7OoBOQLXJFG80TxffBjSRuCYUwMKslnYqHXsuQKixHty9fgE
	 aodP3k86INCXvDgH7jpVJPIwx5/Bb9oxMMacKhmXb8ifPPN+m6rBPvXhJvDihOxdua
	 xkKrLrgvENTTdCYMfI1C5+Shtf9oh9NbLONZdBN/f1moDEY8aesC3EvYMWzRcZvKST
	 9OhdLSbkFy6GXzRoj5sgc8algV4FT69zWGZzHZ/Gplx/SNZSATVlWEHYdpd8EkNHMi
	 7nfRmGmIRjH57bFmzFmQRmJjO8QbR/MaWO8pNYTXeo3xnx6VJQpwarYMr1kD+CSL+c
	 JAY8Z56P0IvPg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 13/15] PCI, device core: Add private memory access for
 DEVICE_TRUST_TCB
In-Reply-To: <20260705220819.2472765-14-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-14-djbw@kernel.org>
Date: Mon, 06 Jul 2026 18:12:20 +0530
Message-ID: <yq5aa4s4i91v.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <djbw@kernel.org> writes:

> A device that wants to access private memory needs to have its trust
> elevated to DEVICE_TRUST_TCB. That trust is established either at compile
> time (unlikely), the bus knows the device is within the TCB to start (some
> paravisor setups), or the device is dynamically added to the TCB in
> coordination with a TSM driver (primary TDISP use case) and the trust is
> elevated by driver match.
>


Do we have the last case, where the device is dynamically added to the
TCB in coordination with a TSM, implemented in this series? Do we expect
the CCA driver to set that up?

>
> When a PCI device is associated with a TSM for security services the low
> level TSM driver in the CC VM has the opportunity validate DMA access.
> That validation happens at ->dma_configure() time when the device attaches
> to a driver. The TSM driver is responsible for proving to the platform TSM
> that the VM is enabling DMA with respect to the most recently generated
> evidence. If that fails, driver attach fails.
>
> When a PCI device is not associated with a TSM provider for security
> services, but the device is trusted there are 3 options.
>
> 1/ Arch requires all DMA enable events to be acked by TSM driver
>
> 2/ Arch does not require, but admin policy is responsible for knowing which
>    devices need TSM coordination to become active within the TCB.
>
> 3/ Device is approved by a paravisor to operate within the TCB, no TSM
>    coordination required.
>
> In cases 2 and 3 if the device needed TSM driver coordination, but the TSM
> driver or association to the device is missing, it triggers hardware
> errors. Those errors are a configuration error that the kernel does not
> actively prevent.
>
> Architectures still need to fixup force_dma_unencrypted() to call
> device_tcb_trusted() to tell the DMA layer that TCB access is granted.
>

-aneesh
