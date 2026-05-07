Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9B28A3FA;
	Thu,  7 May 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167953; cv=none; b=BjzM0IlOLWgWqzFoLSLF5TvmQ1hf82lBni/FDgtDhTEFHHezoY+D8kKRyIiTkZqYUfJ5IA+cXlkL6nwiead43iY7piUALTa1cJW0GPgZrrYBskmUZgE6efo7doEGxsJLiH/6nK8otmp0NtlFe87zS2dYroXqRp8nelYlG3eYxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167953; c=relaxed/simple;
	bh=D7178ReE3wOSDxfxJhbvB5FA/ieLrP3Z9RYEYaBMV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZtL8G9ufBdRiF18IJ6XpUmtp5Zb7iWTFXEfxYaWsCygIcesF6GruLa0/dnfGw1QWhPJY0Ht96BL7S5U0DEPu0N3QajKaiki6ZLVzpH3ViL1ZQXrIok/d7/pPsxrdVvNZCeJUinKU0K+RiJrF+SiepybHoR14eAB2LFq5UI652Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSZ380mr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSZ380mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F38C2BCB2;
	Thu,  7 May 2026 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778167953;
	bh=D7178ReE3wOSDxfxJhbvB5FA/ieLrP3Z9RYEYaBMV5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gSZ380mrWffByWdhCS1EYQEYouFDInLt0MvpjeZjFcKzf43EWUrE/jANynbRKZl/f
	 8/yrZ9r9+8UHOJuPV3UKpLe7A5170Jd7u7U5++RYcZUaw7I3PIDmP/8tkYQe3dfNCQ
	 1GtwBGLDKF2h+uuWXrs3BJO+lAVWiGlBuRH7JL8JM1JFGK+2zGMin8qPZZU60dAqt6
	 ktEkBMwVUlzS3DkptsFFrA9nNue+HgkKZDVcPfVYWPgZ0a9proaaNZxSGolI0LLY0c
	 AwkQgnGVRBuF+vjUE9TtKaKa/NpSJDL7jrLp8gqf5UhQhn2ayw1iSzh8/z2aFJSxw1
	 1mePuTGCD34qw==
Date: Thu, 7 May 2026 10:32:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Aksh Garg <a-garg7@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>, sashiko@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: cadence: Use cdns_pcie_find_capability() to get
 PCIe Cap offset in host driver
Message-ID: <20260507153231.GA971257@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3280415c-3c38-4b69-b2a5-6b97d0d24e54@163.com>

On Thu, May 07, 2026 at 11:21:39PM +0800, Hans Zhang wrote:
> On 5/7/26 20:31, Aksh Garg wrote:
> ...

> > I have tested this on J7200 and J721E SoCs, which uses pci-j721e.c
> > driver for their PCIe controllers. The patch alone fails to find the
> > capabilities using cdns_pcie_find_capability() for Root Port.
> > 
> > With the "is_hpa" flag patch, and the patch "PCI: cadence: Use
> > cdns_pcie_find_capability() to get PCIe Cap offset in host driver" along
> > with the diff suggested above:
> 
> Thank you very much for your test. We need to wait for Bjorn's approval.

Just post a revised series incorporating the fix.

Thanks for the testing, Aksh!

Bjorn
