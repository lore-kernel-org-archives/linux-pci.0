Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131D4078E8;
	Thu, 17 Sep 2026 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624403; cv=none; b=SFlhbei2E1pwxr+02LvPTD6hbSnty7AalyC9z/g66w77VtciM/wQBNRxYiK1KUeMJRUw2vQns2TXm6URCQtjXi3braANdBzBxgAiVikq0lqTgpdruJIvGVGfc7qd4CX3xX3mzX7WNfAFpo6QgdL4jmN1xGs868JkV/r/ocGUrF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624403; c=relaxed/simple;
	bh=Pu/x40pJGVMhz9zchWmf4jWM2Nihu/6jlZ2EG4rZ+E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy227gNv3qTtBx+Nx3ZRWowa+6WXnOL3/L+0FTIXKR1/DUTaPhbFP8PfIOhijemZOmYtGq6AdZWaFN5YiLom8rhYs/C2zm+hWfbuYyRIV97fkzBH1PUklbJXrVVjLJYSa6HM5RsQiRTO0vd6zd3gOzg2K0UyS6CFP0G265+0N5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fO+GCnMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fO+GCnMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0C91F000FF;
	Thu, 17 Sep 2026 05:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789624401;
	bh=Jt5OrhL4ZK3oVcVBCEqDEvrJpFdWDKtjMX3j00yjidw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fO+GCnMHf2l5XhyrvFJUuN2CItjoC6O2A/xZ6SyPI6/pR9sVUmPjwEO0w5vZDrVj1
	 COBVfti5FlvuC7z/uP7kX0XJR1LbUTTJVMe2JSPai0mYJGsou3wbunxsvqBIe9upre
	 xLahI9gH4399rwj7TQEkZ4AapcB0q18NWHta2Oi29brWp/wtr/N0zcGYX6N6oWmwKn
	 a13d2edkB0jsHkIOzYcxbUPhFeFcYK56zXvdxvbfckBjB1TyqhzhqA9OeHtpoYD+hb
	 HSyW35Xuth7pZxEB+zrPIcmCIr0gFlTwNwu3zOe+PiBO48PMSf7w51XPRElG9MO0bo
	 4wSZi3eYKiXGA==
Date: Thu, 17 Sep 2026 07:53:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Honor IOMMU provider's #iommu-cells in
 qcom_pcie_config_sid_1_9_0()
Message-ID: <762d2otuvtr5knnig2scoldk4hes65wmnqchbgjhs6g6nrsia6@wci3ymfw3hhj>
References: <20260907143349.317495-1-mani@kernel.org>
 <20260907144408.EF06B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907144408.EF06B1F00A3A@smtp.kernel.org>

On Mon, Sep 07, 2026 at 02:44:08PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Out-of-bounds memory read when `iommu-map` property length is less than 2 cells.
> - [High] Unvalidated `#iommu-cells` property causes integer overflow, leading to out-of-bounds memory reads or divide-by-zero undefined behavior.
> 
> Pre-existing issues:
> - [High] Infinite loop if the number of `iommu-map` entries exceeds the fixed BDF-to-SID hardware table capacity.

All of these issues are only applicable to a malformed devicetree. Devicetree is
a firmware, which cannot be easily tampered by a malicious actor and if they do,
then the whole system is compromised anyway. So I'm not going to add these
defensive checks which will end up as dead code.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
