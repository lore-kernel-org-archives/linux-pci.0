Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC43F0741;
	Fri, 27 Feb 2026 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212556; cv=none; b=e+QQyTAQ9y7Ad4AF5oImeCMU5pOttnRHS99+MRYxLbB7geWgsAsvbLV2EQ/a7iWgIvsVZRhTh8XLOUagKG0e5ifFxUJvN+/WsnCI5cT230uzrZ7OeoONAunXiUASP0My5FLvUPmP25LW9O3jKktPNbElVxdWOa4MHus6GxN2TE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212556; c=relaxed/simple;
	bh=vY2PEim4h8ry91UAbejDugjqrXW6xhJuFeaKNWdNl4s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r7eFM5yWPULkEC/aJQmUEvR6fVuP8JaVG2IsKvVbitVwxCWtLw59mWkbdCKTG4qqkoJFcCPgMcfJ7X2CBmhiFUugxS3/K4ulkCWOsYUQdkElFr5fEkJKMFSc6N2wpC8deo8hjFOg7MYiA0aPdmOUQcAGgFCZsZYyP7hFPq61TPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laxgkdEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laxgkdEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526EEC116C6;
	Fri, 27 Feb 2026 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212555;
	bh=vY2PEim4h8ry91UAbejDugjqrXW6xhJuFeaKNWdNl4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=laxgkdEBO/NEZ7oIKJ1DHXEcv+D/BVuHOyjPm6vn0a7bZxBhxw6mZCFTBa96PAgyU
	 TpXaM7jazcFHTer7LsgecaBHJWfr60r/jHwN0iCM9UsseGyEQ/6SJg7uxf5YJj4zD/
	 z+C7dn2mAYWLG/3DeygIS2Dx5ANhAQ0pSIJaEYTUMjElu/wnxVRAaMg7eX0aVa918a
	 AbjvBAjjEU6J7+EsK5gikPmwXD8JupWTmoUHi5fBA508a4/n23LQvanx/adBVmxbm8
	 lntvclv59aZ6XVN7jQUO2m3zuLmrOfmVVHK2IlzvYtVMuRFqVeucHQRqKNgNuEMfoM
	 xWCKZHVw9NXkw==
Date: Fri, 27 Feb 2026 11:15:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	ouyanghui@eswincomputing.com
Subject: Re: [PATCH v11 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <20260227171554.GA3898780@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227111808.1996-1-zhangsenchuan@eswincomputing.com>

On Fri, Feb 27, 2026 at 07:18:08PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 5.96a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.

Does "4 channels" mean "4 lanes", i.e., what we typically call a "x4
link"?
