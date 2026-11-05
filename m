Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890033;
	b=PFyrfosSIOYm/c9NmqjLA79u1meb8oMJIHRSzYVrR6h+46OvwR151tUsL7jz7IfIL3Rn
	 uvbIeKcwUH52KuvFGaJmAltAR9SicaXGy/Xg/q6MfgAxu7a4Ftd+BkAtLnyd6DYoBRJa8
	 WFK/JOHrVtngRygOVCsVqNTo8jdUibcPAqtIEfhITG+lpui6JM519OAJ5SOa8Ovpvv6Ef
	 VgUNqepQyiv8zCkBxJowLtvctwkfkPA6wD7uYkUSA/S9wH7aFF4w06ppKD+IY9wJ/iNrj
	 0wwW0htsTEgr15ZREACSu9qjLSo6Pr7g14lw06D6CDyvqZMiHETGDt6s/HBeR+aX94g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890033;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=8FCyqzY+hBP2p+wQrr/5G4gKJ7J4jjyIRtVzo9yY/5w=;
	b=htREDUNKH8DGiHbt1yU7LIFkbt5R1KGbldJRkBh1b/DFfEalWYACOTzYWIgJRPhjafLz
	 eBuX4KhUzUqHVPsW1dk7eGpcqj6wRXdMlXbRLl9xAY/32QCdDagNu8FEDSusd4WrDrnWh
	 mov3ylD100GyrjNyhyFYvloKZy3CVjqQfKiwwM+LPCWPK05+QWIZ/L1ztv/T58aIXZLbA
	 4xs9Gkv2D1YQHExnYaFe1CFuqW7TfPrZYYx538AtrOwS7au8Wp7+3s816SOQKwXV4VM3F
	 Cr2x7pDt1A1McUSntD0NQfeMvOcg62g/IKuRWBx1Gz/MdFYyIW7oM+N2lhzPVBKvfpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EsRmhc/+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11194606A31B;
	Thu,  5 Nov 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EsRmhc/+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1F21F000C1;
	Thu,  5 Nov 2026 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890032;
	bh=8FCyqzY+hBP2p+wQrr/5G4gKJ7J4jjyIRtVzo9yY/5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EsRmhc/+iUBrLqmFnkfHnpoLYm1uuSpgf5bJkhotqO5nUzixcQwTeNIjaPe4BZJVB
	 T05LfdIveI1LpzjvAvIabdSiUa0IhppuhLXIQyBBYQT19kApZklN9hkF90UEXcjPQv
	 DAjSeyZDqP5rK6O9RIXVaTkDgqedpBiAr5irCGrXEAX00dvRPUKbccyPpyvya/I/vO
	 2jHhBZtWzPDycjyz+2nLPI8qWwZdmGjjuHGam8c2Xh60owdfrOeZnT7Qf1iOvGqB2L
	 izMmjL2weeoMBaiBZHCTYRAGhNWzgMtY8sx4+7HBp5BLKa+ShfztsKndyzG0uip2w7
	 VfKRypkHWE3mQ==
Date: Thu, 5 Nov 2026 20:17:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Szymon Durawa <szymon.durawa@linux.intel.com>
Cc: nirmal.patel@linux.intel.com, bhelgaas@google.com, robh@kernel.org, 
	kwilczynski@kernel.org, lpieralisi@kernel.org, asutosh.pathak@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/7] VMD add second root bus support
Message-ID: <auyWYoWOL5Lq9CsN@debian>
References: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261026205502.3502574-1-szymon.durawa@linux.intel.com>

On Mon, Oct 26, 2026 at 08:54:53PM +0000, Szymon Durawa wrote:
> This series adds support for a second VMD root bus.
> 
> Today the VMD driver can enumerate and manage devices only behind the
> first VMD root bus. Starting with Intel Arrow Lake, VMD may expose a
> second root bus (BUS1), and devices behind that bus are not discovered
> by the current driver.
> 
> The hardware model for Intel Arrow Lake VMD is slightly different
> from earlier VMD generations:
> 
> - CFGBAR, MEMBAR1, and MEMBAR2 are shared by both VMD root buses.
> - Root ports on BUS1 have PCI_PRIMARY_BUS hardwired to 0x80.
> - Interrupt handling remains based on the existing VMD MSI/MSI-X and
>   irq_domain model; this series does not introduce a separate interrupt
>   domain for BUS1.
> 
> To support that layout, the series first refactors the current code so
> resource setup, bus creation, and enumeration are split into helpers.
> It then partitions the shared CFGBAR/MEMBAR apertures between BUS0 and
> BUS1 and creates a second root bus in its own emulated PCI domain.
> Reads of PCI_PRIMARY_BUS from BUS1 root port bridges are emulated to
> return the actual root bus number, so PCI core bridge scanning does not
> detect a mismatch and lose BUS1 subordinate device discovery. This
> replaces the separate workaround patch used in v8.
> 
> Patch overview:
> 
> - Patches 1-4 extract helper functions for bus enumeration, CFGBAR and
>   MEMBAR configuration, and root-bus creation.
> - Patch 5 replaces hardcoded resource indices and constants with enums
>   and defines.
> - Patch 6 converts single-bus state (bus, busn_start, sysdata) into
>   per-root-bus arrays.
> - Patch 7 adds BUS1 resource partitioning, a separate PCI domain for
>   BUS1, PCI_PRIMARY_BUS read emulation for BUS1 root ports, and
>   second-root-bus support.
> 
> Tested on an Arrow Lake platform with NVMe devices present behind both
> VMD root buses. With the series applied, devices behind BUS0 and BUS1
> are enumerated and become visible to the kernel.
> 

Series doesn't apply on top of v7.4-rc1. Please rebase and resend.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
