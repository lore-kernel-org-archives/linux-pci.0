Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F6402BAB;
	Tue, 24 Mar 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364907; cv=none; b=J0HtOQV7Q9Ve669xl6OKoXghkl6Vg6ys8Rus/2d6KuvPrETCTLRc+JZD4wJ4PRFpvinlSMRcc18/gJukeqEZ9kmsLjvfxSLORArSdQvaXHmT7FeEMc6CiLp6Kg27b+alF/qpKCPSz1knq0KxARs+nAQKER0Hh/GbUiygrvhJnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364907; c=relaxed/simple;
	bh=sBt192ebZ6UTIURRnm+LynelOlFw9P5iMkWpe5Wk0Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBZbfmIOSvHrAvzAPH0U/WeUs6tlBFEuN9YwUtWM2rYtE6EZDrM3ttLvN6Mtu59h4D6vZI0/BWos2CE88TtPFEXCHIG9F/tp3Mi2CYwmI8sVl4xfuIuxQio2ccminKXL6DUqyKjdIril9R1zJtunxkIICvVOCt360NWVox1/hkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APG2cjhQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APG2cjhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1842C19424;
	Tue, 24 Mar 2026 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774364907;
	bh=sBt192ebZ6UTIURRnm+LynelOlFw9P5iMkWpe5Wk0Sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APG2cjhQlBl1F/ZnKTNo6ZJMIowrLl6A1Ltx4H6JbRnVovR07YySaOa2yjG08OIY+
	 zsWPcLBjuiXMMeD75QXj0gzRgs+vYsI5C4NSePOZga3rdD/0c73+uRuasUkKndttxB
	 ck8mc+coeeqvpFMCoRBokj90QqosYecdLZDo100+Jr8/xvQjXgSJk0Z0GKktldjpUD
	 Ztwi3xLa2u5L7gnYK/za0WYBrL4vdOpMwRzVZsWJYHPSaKaHKwDLZSAQSjxaHeyB2I
	 lbost2XqNW/wxAFM0urPmSDDNMnnGdDC1DMgGS8pZmWpEql05TSLxK+PfNZkSY60IW
	 YZ4ziBL+4oAFg==
From: Will Deacon <will@kernel.org>
To: suzuki.poulose@arm.com,
	robin.murphy@arm.com,
	ilkka@os.amperecomputing.com,
	jonathan.cameron@huawei.com,
	Besar Wicaksono <bwicaksono@nvidia.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	mark.rutland@arm.com,
	treding@nvidia.com,
	jonathanh@nvidia.com,
	vsethi@nvidia.com,
	rwiley@nvidia.com,
	sdonthineni@nvidia.com,
	skelley@nvidia.com,
	mochs@nvidia.com,
	nirmoyd@nvidia.com,
	bhelgaas@google.com,
	wangyushan12@huawei.com,
	shiju.jose@huawei.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/8] perf: add NVIDIA Tegra410 Uncore PMU support
Date: Tue, 24 Mar 2026 15:08:10 +0000
Message-ID: <177435585471.1950471.14714231023010509332.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324012952.1923296-1-bwicaksono@nvidia.com>
References: <20260324012952.1923296-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 01:29:44 +0000, Besar Wicaksono wrote:
> This series adds driver support for the following Uncore PMUs in
> NVIDIA Tegra410 SoC:
>   - Unified Coherence Fabric (UCF)
>   - PCIE
>   - PCIE-TGT
>   - CPU Memory (CMEM) Latency
>   - NVLink-C2C
>   - NV-CLink
>   - NV-DLink
> 
> [...]

Applied first seven to will (for-next/perf), thanks!

[1/8] perf/arm_cspmu: nvidia: Rename doc to Tegra241
      https://git.kernel.org/will/c/d332424d1d06
[2/8] perf/arm_cspmu: nvidia: Add Tegra410 UCF PMU
      https://git.kernel.org/will/c/f5caf26fd6c7
[3/8] perf/arm_cspmu: Add arm_cspmu_acpi_dev_get
      https://git.kernel.org/will/c/bc86281fe4bd
[4/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU
      https://git.kernel.org/will/c/bf585ba14726
[5/8] perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT PMU
      https://git.kernel.org/will/c/3dd73022306b
[6/8] perf: add NVIDIA Tegra410 CPU Memory Latency PMU
      https://git.kernel.org/will/c/429b7638b2df
[7/8] perf: add NVIDIA Tegra410 C2C PMU
      https://git.kernel.org/will/c/2f89b7f78c50

The defconfig change should go separately via arm-soc (Arnd).

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
