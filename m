Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BE1C69D
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557135; cv=none; b=GLRW6oMllNIuDT3pD38ciIP6tkL6vRPVWs7sLpAjGGbcsIUQBYx1Cef/trAo3O7yrrEzhJo6nkBfcXZ6cOpP6HwuAr7RBg1vE9tMDzPyUKsLNmojshm0Y3hF8rdj+nZnIlTv6CgzwPr6lojlJaTEyK+sz4n59IBT7Kk1IZrQUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557135; c=relaxed/simple;
	bh=S3ywutfuXC5f4GE1LpN3PW969lqhtXlKhjZltII/Xds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8orh3cwtjVv0OJdVdtq8Tvi2OZvENq+e6kn7/NVlh2aStavFryx+Pyyvf0dUBO/rUiDowoN45Kz3dUOpazdJ2K0mgzWEaahF2hQCUrtQFclz/BR8HxSlfadrElABodEmJto6uvvrLNHuDlDvxboi+pGWsqfgMxKYp5gcVA6LrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISb69zwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISb69zwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1611F00AC4;
	Sat,  1 Aug 2026 04:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557134;
	bh=ANfNKZHNTBe1Rj7mmyowkuLRHy7IIawkIWyDwYYL31Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ISb69zwCzOSeZUO2oO9nP4qZV04z6l9hoTPawZSs3d8l1xJN67KOu73PUCivOxUkX
	 dWhlHzukZuR35ilJvTJzN2Q/k+RNVwYwxHq2NTa4nVHRjTsS0eA5OAiFhZ4cTGt+vR
	 /Wwz4WXP6gsvKUsECqVgCReEWJ18tuxchEkPRKqNcFk0E9oqUwU+g2cyePU3UYWuPD
	 KqysPQrmA4pmkSTm+JEgYk8Xq+8yjxkrCeTIJeqATFls5W+adJHHIgYtsoEGJ325G1
	 tTByNaauYseAjv2t8fWwhcnTMRBIqNMGSD3fB15GthBuqoofqBTf/Q7oTaQC3mPtcO
	 jbrzXUmNtrGoA==
Date: Sat, 1 Aug 2026 13:05:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Avoid spurious runtime PM wakeup on config
 space accesses
Message-ID: <20260801040515.GB3183355@rocinante>
References: <20260729075909.1219906-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729075909.1219906-1-kwilczynski@kernel.org>

Hello,

> Currently, proc_bus_pci_read() and proc_bus_pci_write() do not return
> early for zero-length configuration space accesses at valid offsets.
> 
> Thus, such an access invokes pci_config_pm_runtime_get() and
> pci_config_pm_runtime_put() around transfer blocks that do nothing.
> 
> This is a problem because pci_config_pm_runtime_get() synchronously
> resumes the upstream bridge through pm_runtime_get_sync(), and resumes
> the device itself through pm_runtime_resume() when it is in D3cold,
> only for the handler to return zero immediately afterwards.  Such a
> spurious wakeup wastes power and adds needless resume latency.
> 
> The sysfs core already returns early for in-range zero-length binary
> attribute accesses before pci_read_config() or pci_write_config() is
> invoked.  In contrast, the VFS forwards zero-length requests to the
> procfs callbacks, where they continue into runtime PM handling.
> 
> Therefore, return early from proc_bus_pci_read() and proc_bus_pci_write()
> when nbytes is zero, before any runtime PM involvement.
> 
> The value returned to userspace at these offsets remains zero,
> so the change is not visible to userspace.

Applied to the procfs branch.

Thank you!

	Krzysztof
