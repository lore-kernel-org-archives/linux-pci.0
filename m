Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28C23546C1
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557204; cv=none; b=ZwAptYohyBzJrV0q413ledx8swjGw19PHP1zIN3zFaBAgsVGx5vBj3E4inqWAuZXuMMVPtmsIxSBl8+g+qkRFWfYPUVKCFDnbdAiBkBBlbHE+xGFGvqPeYpC8bfASTxnPRHNTDik5KkpatAa5IyO3rJAqtXfRWEkGrTcrD1WthI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557204; c=relaxed/simple;
	bh=UAy8NywxBufXtt+fL8NnTeaU8ZFQCJNMaqa8XalBBFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldnvJAW4GhA5Tbd7WwCcpbF1M04A0KWjaJwB4iTBvbNcaNcguKyN3qUZS3nM89pRvSAHdMEK1B/OVQX1Vz5LCO5n9hX6/cguxPwOgWYm9wyH2f5Le4dg94bNYtchYTt1InU2YP0BG52iLYs7dEylMQZF6/emCFifD33R7wEge8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaZ+I8dR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaZ+I8dR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017B31F00AC4;
	Sat,  1 Aug 2026 04:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557203;
	bh=UXS8psxrn2y2ifr+kCCRbzyp0+s8gXQ6esAdRmRZzT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BaZ+I8dR3a0uWPHiCyZiql56IdFofcMiLeI3r52RYn2fiwM6HnsZ0Uq4/IL4GC7zj
	 LAFcY4Ii+aUd4Z7qSrBzDTp+DMJBf5tJblqp1rneSAK93u9Qmjr3e5AgsNI0CB21Da
	 EVUQrDK3hu6nr5ooDMcAERT4caYIOJT0Ac3FnSEdu5C6wNPWrpxLxybmwSYco/y0Kt
	 mzzJZiycAW+FuagL92C0Qi6KplJfPmblhRZtOwe9nF9DWYTQxd4I7luHpo4NPOXqM+
	 UJYzywzApYlxscG/2YnzhVj6pGXz+khyy3uCD2oPO6M1nBAV0T+nOInBPJYQrXaFUC
	 y2E/itE0R97Kg==
Date: Sat, 1 Aug 2026 13:06:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Use file_ns_capable() when checking config
 space read access
Message-ID: <20260801040625.GD3183355@rocinante>
References: <20260720204145.1500105-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720204145.1500105-1-kwilczynski@kernel.org>

Hello,

> proc_bus_pci_read() decides how much of the config space is readable
> based on capable(CAP_SYS_ADMIN), which checks the credentials of the
> task calling read(), not the credentials of the process that opened
> the file.
> 
> The sysfs equivalent, pci_read_config(), has checked the credentials
> of the opening process since commit de139a339395 ("pci: check caps
> from sysfs file open to read device dependent config space"), so a
> privileged process can open the config space file and pass the file
> descriptor to an unprivileged process (for example, a process running
> a KVM guest with an assigned device), which can then read the entire
> config space.  The check was subsequently routed through the LSM
> framework in commit 47970b1b2aa6 ("pci: use security_capable() when
> checking capablities during config space read") and converted to the
> dedicated helper in commit ab0fa82b2df9 ("pci-sysfs: use proper file
> capability helper function").
> 
> Thus, the two interfaces check the same capability against different
> credentials.  Checking the credentials of the task calling read()
> makes the outcome depend on who reads rather than who opened, so the
> restriction is bypassed whenever a more privileged process reads
> through the descriptor.  Checking the credentials recorded in
> file->f_cred settles the decision at open() time and ties it to the
> file, where it cannot change with the caller.
> 
> Therefore, use file_ns_capable() to check CAP_SYS_ADMIN against the
> credentials in effect when the file was opened, bringing the procfs
> interface in line with the sysfs behaviour.
> 
> As a result, a file descriptor opened by a privileged process and
> passed to an unprivileged one now allows the entire config space to
> be read through procfs, matching sysfs.

Applied to the procfs branch.

Thank you!

	Krzysztof
