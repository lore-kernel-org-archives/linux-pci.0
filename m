Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4433546C1
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557327; cv=none; b=D/uzhDfo5iOyuHd642UvuZlQ5t1rput10vCEshJNikqqzjfixef0ZpGuEg352uZZt2ZXnwEXN/NjktMnZZitNUZMQEitvRXGZnyoEGZkZonw2Z3T/vA7vvybsH1VFPQGlh9niu7h8Md5g29bzubJXUbjwaQCgAR5C5Qvmsd0RiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557327; c=relaxed/simple;
	bh=n/WieTxjW3PBH9oPDlHF9BTuThzditzzrsTTQpcG0co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/xZCZigHQ9+NatC6Eh02HyY+3SRdUOhbVZSMiWuDuxq2Eb3zvQCjj7dlQJ1NawT7vJ39RH1D4HU0WjaiNfeZyP1JxLNKO2okhfZTVuNoaIbjT4i3EiL1fXpL+j32sDfEoB1b5809oqBeCyA3k43uV32DMRfu0Ibnw6q1tfmfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0toZxtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0toZxtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3021F00AC4;
	Sat,  1 Aug 2026 04:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557326;
	bh=uMKXope4ikS6H01f20678NuPz48A3X2X4SzUvc7T+gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H0toZxtpMfKMpRaiuqRYNXfnHytnZNJ7huatZrD4VigyhvQyINtFE2h2D0JYdQg/W
	 P8OCPqRN5ETKN3v0KxuK4vnw3CJe5wjcksxuVSt7Ixgv33dVkFi2Hn8S63YurTbf1Q
	 I4q3+PcDngNjxoo8PZ3OXMSZdrgF4vk5TDaQcwv5tw/2hQDa7xOfr0gM9ui0TGUc/I
	 yoSQCNeoF+9P2AXIKmFS4iaRrbUlV5HQfTKy7hteZ2lUgUNNEyHXELnsyNpYF67l8d
	 va/JKTzPFwW6LosLBn2CEQEO4xwZWeogC3qFDUZ92OGJvumLAyHQwJc1r/c1fyTMTk
	 1ssso+yy9wVgw==
Date: Sat, 1 Aug 2026 13:08:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Return -EINVAL for unsupported I/O BAR mmap
Message-ID: <20260801040825.GF3183355@rocinante>
References: <20260720204624.1503794-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720204624.1503794-1-kwilczynski@kernel.org>

Hello,

> Currently, mmap() of a resourceN file for an I/O BAR fails with
> -ENODEV on architectures where arch_can_pci_mmap_io() is 0, such as
> x86, because the attribute has no mmap callback there and the error
> comes from the generic kernfs dispatch.
> 
> This is a side effect of commit e854d8b2a82e ("PCI: Add
> arch_can_pci_mmap_io() on architectures which can mmap() I/O space"),
> which removed the mmap callback from the I/O resource attribute on
> these architectures.  Previously the request reached the architecture
> mmap code and failed with -EINVAL, and the same commit deliberately
> kept -EINVAL for the identical operation on the procfs interface, so
> the two PCI userspace interfaces have disagreed ever since.
> 
> Therefore, add a pci_mmap_resource_io_unsupported() callback that
> returns -EINVAL and use it as the mmap handler of the I/O resource
> attribute when arch_can_pci_mmap_io() is 0, so the failure is
> produced deliberately by PCI code, consistent with the procfs
> interface and with the behaviour before e854d8b2a82e.
> 
> Architectures where arch_can_pci_mmap_io() is non-zero keep the real
> pci_mmap_resource_uc() handler and are unaffected.  The mmap() fails
> either way.  Only the reported error changes from -ENODEV to -EINVAL.

Applied to the sysfs branch.

Thank you!

	Krzysztof
