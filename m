Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E83AE706;
	Mon, 10 Aug 2026 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396337; cv=none; b=hpjh37tjCTtYozf585bRv6IdiGmnlRPZCdsrRoPrvCM6RWHiZkMsf2WPpvaCFK9NH1paIkjn6IiGnjvfWXrsxoOpo4j1eOOtTQE9S7Zy8YbII5YkpVwp2Ds6pjt05pQDmJaXJm4JT/2wF0TSuspQBxXg4yYY/TVxzPhwO494T7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396337; c=relaxed/simple;
	bh=4oSfONn5Yz63lyUzLtV+gfMtS9ynEzwvoGCshYVSCu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCkI0SkAPY0sQ4XNFxgmkFDIxeCB6cZwPNDG81DG9j7eM8EauP1gC2bmo32uGRQ6igZIAbkDSWjcddRKo2kGbuv9KFche3S3BVg5DSjy2WlHnsbf0sF5dUBaStBa/f4vxJOznaHYnBPAVf5fPoj4/NYwGKB/oIyacSS5h2ukSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XWTnSgQB; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XWTnSgQB"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 6FA341F8D1;
	Mon, 10 Aug 2026 23:12:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1786396331;
	bh=4oSfONn5Yz63lyUzLtV+gfMtS9ynEzwvoGCshYVSCu4=; h=From:To:Subject;
	b=XWTnSgQBHutL2fKLqJf4aoRhkbR7qWiLGZcae4flULuRgn7Tb2aM5hav9mSUzoGMU
	 ur+BfXUM/0J4oYdc1GRs2qSoVMPymIeTZ5toEAc21RekgM4zhNRRR7/uOC6hjYqu3q
	 72IXMHiR5hqiDLOghTTwNzGbiwY2Hcyi2zZda7RWS2vA75r3FRiBi7MY18UtAqE7j+
	 ld5sGLfTehy8Q7Eq18+tc8jCdRw0HvThS/I611mRCR+vaZPuxMIEQcH9AtxnX59u4t
	 2+dnSc9VXLRFqg0Sd3GPt5u2tKSPrbXmvA+ZACLkKpDVJanaGlD6+HotDsa208IQKC
	 OLBZwUxNuPlSQ==
Date: Mon, 10 Aug 2026 23:12:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	regressions@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, leonardo.costa@toradex.com,
	francesco@dolcini.it
Subject: Re: [REGRESSION] mainline/master: PCI link creation fails on Apalis
 iMX6
Message-ID: <20260810211209.GB4821@francesco-nb>
References: <bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgneropf3hpgwve6@n2m5uhlduw57>

Hello all,


On Mon, Aug 10, 2026 at 02:54:45PM -0300, Leonardo Costa wrote:
> We are seeing a regression on Apalis iMX6 where connected PCI device
> links fail to come up at initialization, as shown below. The issue is
> not on the devices' physical connection, as they worked properly on v7.1
> and are working on other stable kernel versions.

just to make this more clear.

610fa91d9863 ("PCI: imx6: Assert PERST# before enabling regulators")
introduced a regression that prevented the boot. because of that we were
not able to run any of our test in our CI/CD

commit 7678e81498e2 ("PCI: imx6: Fix i.MX6Q/DL boot hang caused by improper PHY power sequencing")
fixes the boot issue, but now PCIe is not longer working


Francesco


