Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5A449B1D
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581155; cv=none; b=T4nGbgL5vCdp9zuETy6rIyza816LqFqJfZFUniOVb7po6WkDr3lTanJEl6iBiceTVW5bqXv+hRRDWw+62hHZigriQE3IW9XB6xrYiNx31eLogk2vWraJixPE/7lUrR66uScCBo0YA1KturKLmZ43NoX7BQCH/x9Q6C4C9HQ+p6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581155; c=relaxed/simple;
	bh=SUtG/MgvQenOSWon3daFhZJ/WTLHIAnI0h4vk+O4w4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IcSK0CD7rSl9hWKvL5n8RQIV+yDr1G7/qgBgzMurU3O63D05f4Ej2jqYhBF625SAkS0E8/MXhedQEIl/yAhHgx8GHWbdjHSDFDmL7HK1vQB7uyCNVfb9m25vNcD6fRuWd/ufTHyN7ROCv7I99sdpwhbDTnPRjo7mFqtSKDSZZVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npMMPiA1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npMMPiA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B171F000E9;
	Mon, 20 Jul 2026 20:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784581153;
	bh=2kUJKAv7/XeSmgDtJfeKS+fbnZBkDDXmbvaZM8gnxpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=npMMPiA1oibEZrCbTvxbhl2d2R4iKwVwxpct9MVFccigdeQTlbdzUKAX9BirtbMoF
	 wZdn1Yf+XZngwuKx6Of6TKzSxVwNnM8YFroRTCUnj6Macf9ViWeQPuzhVsEkmuL1eJ
	 ZWqynczFvqNVXbx/aNtqjTjVwO2WNQSPjrwPIVwa3uzD8IFuoPDPSs5tuB/1PrtsGr
	 vuGBwkOhRfqNmSx/7XT4/GsqGFzJJcKmJPl1UIQvDqd/TxLGPVDWOkWlKbiHoDOUDt
	 3T3U0/AUF3EIKqPPSyb9ur4H8A/yjxjNkzLMzaHXk+yEO7uBaXt7Aj+G6IX44E+kmo
	 AAGIjgzeW2lZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/proc: Use file_ns_capable() when checking config
 space read access
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720204145.1500105-1-kwilczynski@kernel.org>
References: <20260720204145.1500105-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 20:59:13 +0000
Message-Id: <20260720205913.75B171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> proc_bus_pci_read() decides how much of the config space is readable
> based on capable(CAP_SYS_ADMIN), which checks the credentials of the
> task calling read(), not the credentials of the process that opened
> the file.
>=20
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
> [ ... ]
> As a result, a file descriptor opened by a privileged process and
> passed to an unprivileged one now allows the entire config space to
> be read through procfs, matching sysfs.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720204145.1500=
105-1-kwilczynski@kernel.org?part=3D1

