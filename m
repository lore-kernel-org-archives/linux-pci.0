Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56E3B992C
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095025; cv=none; b=bfuMWbv24uAMHh1UfRYVGN9/GFnAfgxZHPBwuRN9RbdVPdTIfjIxoH2wTh9RZhX7au1BhQGHyWELuPzuT6MAGNiCx2gGaBQQulcMLKbyGqALFl2j+izDf3awvD/eX+pCTej/DIP/Zx2QrynrEbErXAAUcqCCKFxBH9fahcByYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095025; c=relaxed/simple;
	bh=vB/O1qhMGuTBJHey0Pw87Qwukyv/9aQbpGs1Z5O+AEE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eHl41SxN6VMWRbon3WnNP7eSBB2Km7GxqXSHACDgsYpqU7p9/S6RMoEaqSbdHwvMDAoiBDIuAhdvg3CY5fDZ8CzSL46vypO+HXDgu2R3PuMiLil9HFDUDmCmk78M/wlKsrcfbp5+ypjuVDEPkLwgbkQs81H/O/rEva4bcIwJ1+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkZyKyeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkZyKyeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693A41F000E9;
	Wed, 15 Jul 2026 05:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784095021;
	bh=a8xSbZZLfGeRS/b7b/8vJT2mxEq4N9ZZJpfquelYFcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PkZyKyeQAKUqyA7OK9Cyd9Bun6gI14OYEfoSgvuOVIZkcQZDgw9fh+D+mr1vAss/y
	 vrFHh3y9pb7+yqKQQvyCUP73LyCy8EKHrtJ+yTgMnoPqERy64ZOawP4cdUAGy0ZQha
	 /jEzGA+EUSk2gC+Nz+/KakyTiqLpzReUygjzkOlDfh/hxFKrtaaIXTa+WUpsFN2UAs
	 pQ8gwDnvyS7UKxwAfz5AXakEEmZS2HSayEOvdhpIb1dNvaVKyWc6nzXratW99DQPaL
	 sLPCyHL0ucdwak965LB6JrdtHcQbftDGBDBy+aMVqunJw5LB3K8Y6gBQhbJrO8I+IC
	 z0cUiUHu4kktQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, 
 nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev, 
 kwilczynski@kernel.org, robh@kernel.org
In-Reply-To: <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
References: <20260628143450.92492-1-ali.alaei.tabatabaei@gmail.com>
Subject: Re: [PATCH v3] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Message-Id: <178409501805.37475.683537046498875265.b4-ty@b4>
Date: Wed, 15 Jul 2026 07:56:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sun, 28 Jun 2026 16:34:50 +0200, Ali Alaei wrote:
> On Intel Arrow Lake-HX systems (e.g. Core Ultra 9 275HX on Acer Predator
> PH16-73), the VMD controller reports BUS_RESTRICT_CFG = 3 in the VMCONFIG
> register. The existing switch statement only handled values 0, 1, and 2,
> causing vmd_get_bus_number_start() to return -ENODEV and aborting the
> entire VMD probe. This leaves NVMe drives behind the VMD controller
> invisible to the kernel.
> 
> [...]

Applied, thanks!

[1/1] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX
      commit: 22b47bd49e45c2f8288ee6b760a6b23508d9d799

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


