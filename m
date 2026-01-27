Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBA1F130B
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526176; cv=none; b=Dy5N1b11v9z4jVPyBsYLPNGdkTf/FTyjiPtnLSO1ooDEfL4C/CrXINhIcIcOtjq5mA9ZXzpeTVMIxzFeHIFI3upWkhlMdRWdoypw0s40HM3CzON/5zijJcgrc+JqPLJ6/16sZBk+s0Dkxd9a1OuHqBGDGP5oonfzv0OYYDqQ9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526176; c=relaxed/simple;
	bh=p+NXcJQmGrevEoT3eyGQSWcoRHdh2wj1IE2LS+y87kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxCmhB1Yut56IHG/0jsCH8YE3LDhdD0JAtbn/Ud1NQJLzxIq079EUhXXKaBNjRwinRC5gf7yijiC/k6rzksPJIYPvUjQMZU0zQ8ducnoLyUTXuxXJvvbvUJXZdtWEbllpQTZFxKsfDGS20zPMir6Mp6ikFvLfVswXtO+4jR0jI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwvFB1T9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwvFB1T9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17469C116C6;
	Tue, 27 Jan 2026 15:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526175;
	bh=p+NXcJQmGrevEoT3eyGQSWcoRHdh2wj1IE2LS+y87kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mwvFB1T9jwL0A1q2xNHkw2EkHGkjqDNvq2uagou3Sf4qhE5w6Bs7L3TmYSw7+Qjxc
	 J5pwbt0DQZ+KDoxls8OaYhnH2w0DItgDis0kkkxJb5G/3DMIlEO39BXlkg/IcCpFYg
	 XIS89W3Cagl+OhgCWVhgyubkka/qRlIDVTeK0FtaJkfTu2B+DJQTfuXIps/TUgYExG
	 i7IXgU9+jd7jv6jh9PS5kijNhmiPqD92OKFwe6D777NoqQtXzB8ZZ6yMDy0aAU6jBu
	 aN3hlCpapm3+PvHUUrFVvxr0zsUewDn+9J54U2WvFulhTwADrXn/itTB/JSTlwxc8x
	 SkezymjtJ1DUQ==
Date: Tue, 27 Jan 2026 16:02:49 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Frank Li <Frank.Li@nxp.com>, Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com, "Maciej W. Rozycki" <macro@orcam.me.uk>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-ID: <aXjTmX6R2f4bZNgN@fedora>
References: <20260123182835.831710-6-cassel@kernel.org>
 <20260123182835.831710-10-cassel@kernel.org>
 <7fd4fced-86c0-4fe9-843e-60a30a9b74a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd4fced-86c0-4fe9-843e-60a30a9b74a9@kernel.org>

On Sat, Jan 24, 2026 at 05:53:36AM +1100, Damien Le Moal wrote:
> On 2026/01/24 5:28, Niklas Cassel wrote:
> > From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > 
> > When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> > before configuring ECAM iATU entries. This left IO and MEM outbound
> > windows unprogrammed, resulting in broken IO transactions. Additionally,
> > dw_pcie_config_ecam_iatu() was only called during host initialization,
> > so ECAM-related iATU entries were not restored after suspend/resume,
> > leading to failures in configuration space access
> > 
> > To resolve these issues, the ECAM iATU configuration is moved into
> > dw_pcie_iatu_setup(), and dw_pcie_iatu_setup() is invoked when ECAM is
> > enabled.
> > 
> > Furthermore, error checks are added in dw_pcie_prog_outbound_atu() and
> > dw_pcie_prog_inbound_atu() such that an error is returned if trying to
> > program an iATU that is outside the number of iATUs provided by the
> > controller.
> > 
> > Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> > Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
> > Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > Co-developed-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> It looks like this patch depends on patch 3, which does not have a Fixes tag. So
> why not squash together patches 3 and 4 ?

I think it would be wrong to squash the patches.

This patch is mostly written by Krishna, and I think it is wrong to squash
a cleanup patch with a fix patch.

It is okay to have a fix patch that is done on top of a cleanup patch.
(It would require a lot more effort to write a fix without the cleanup
having been done first.)

Therefore, I will simply add:
Cc: stable+noautosel@kernel.org # depends on Clean up iATU index usage in dw_pcie_iatu_setup()

Such that stable will see that this patch requires a small dependency.


Kind regards,
Niklas
