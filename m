Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21E2745E;
	Sat,  1 Aug 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583738; cv=none; b=eJ5/gIuHP/32z4FASuvpkLhD1ZUouZG6YAg4hkFj8T/Y1J5fcljchlnZUMPV5MZ2cQgQII0NWjcS/bGXl/Bybua20BmaPlkSB+0BnhX5FB0w0mZkF5xRNDJ5Dtqz0++ZMDnsHdblSJpTTmR8f+OLgePDxarsVtNkwyO3qCGnAdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583738; c=relaxed/simple;
	bh=nc2aSOX2FyiK4FOf0SlE3Cyb+aQTvSgdmMgR+PlVG40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kG3g2IVfcXJ4UMzQ7JNQ9az7/RhlQuKAsALCtwxlwqo2zr9rl3yLjFO4qv+OIzZ5MEw81iVAYeF+BcCXPwjykm7j1g9IKIGbzBoTd3Ik1ugeBzjd2HHaRtO4rqdWyBiI9WSRCXj53ZqNVUfeJJk/8f+6AOukM0mSpiDI8aT4wXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxTvf7Ha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxTvf7Ha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D291F00ACF;
	Sat,  1 Aug 2026 11:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583737;
	bh=rebPmL1X8jUzQI9vxjhYnMCO0SxHN0dKk2GfIA8VbKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxTvf7Ha58Fa+O/RHjeGnCnTGAtP66JG/hy7UEUotS25nYk424o8nh56Gg/gAf6u2
	 gT/CxFz9tHzSistnH8wZ/31uQVFFxrXOEdO8oZwh9urAK81QTBxHe5v1RzME4CxN8E
	 oKEW+r9PETuGYCGeAMAF7ZmQIP5uqAkZKo+xXTSqhgrSPXnpUGKwcoiLHd5tmd5mpl
	 axCVerVPUD7UBEVE/FaXwo630hzzjyMFStyeRrD+51Ytw82NmUG9usV+aIZzRNUvHN
	 nuA7vkzNE2+gksA/yeLgJXZ1Xdmny4ySobwESNOdpE2xSbAh6uw7A9FcH2xhDnUdC+
	 hot4okdqf4UgQ==
From: Will Deacon <will@kernel.org>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com,
	jic23@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yang.yicong@picoheart.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jingoohan1@gmail.com,
	mani@kernel.org,
	juwenlong@picoheart.com,
	geshijian@picoheart.com,
	douyufan@picoheart.com
Subject: Re: [PATCH v3 0/4] New vendor support and optimizations for DWC PCIe PMU
Date: Sat,  1 Aug 2026 12:28:33 +0100
Message-ID: <178551552738.353168.18017558423722059226.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708084507.98242-1-yang.yicong@picoheart.com>
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Jul 2026 16:45:02 +0800, Yicong Yang wrote:
> This patchset mainly enable the DWC PCIe PMU on our platform (Patch 1/4).
> Besides do some optimization and refactor:
> - Patch 2/4 extend the monitoring limit on platforms with narrowed counter width (< 64 bit)
> - Patch 3/4 switch the driver to use the faux device interface
> - Patch 4/4 fix an old issue that PMU may counting when corresponding root port
>   is runtime suspended.
> 
> [...]

Applied first two patches to arm64 (for-next/perf), thanks!

[1/4] perf/dwc_pcie: Add support for Picoheart vendor devices
      https://git.kernel.org/arm64/c/cf65b4d765b5
[2/4] perf/dwc_pcie: Support narrowed time-based counter for long time monitoring
      https://git.kernel.org/arm64/c/18ec1f543ae1

I haven't understood what you gain from the third patch. If it's purely
a dependency for the final patch, then Sashiko has left some comments
on that one:

https://lore.kernel.org/all/20260708090109.B20D91F00A3E@smtp.kernel.org/

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
