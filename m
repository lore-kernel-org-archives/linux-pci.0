Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DD33F8BC;
	Mon,  9 Mar 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090530; cv=none; b=uRhB+KZkTJbWz+5BTe2Cjjs1A1VRgADFnPjKoFl3V513MralTfUY2q3rHqL6KCJ7Nklx04g4VxpwPaSh8c8NOWcYgHTNBZKuY9dhjT2MVoGlpQrcPdkPESD1lxvPGzknqPlDnpIrhdcWuPDtmGORfNd+hAvd43PAzHmEFHlfA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090530; c=relaxed/simple;
	bh=U7I3bh69J3B4cMe2WWPQdGTO1zM2gflc1SsDGP9ZT0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YLI+CQdQw6BwC0nmn57sdI5S6XsthirNi89gRUQVnE4Nv6nfwcCEm0aDHNdZEXPQzP4VaEXfFN+Fk3TfWLzQTCCI2JgM+LV5pG5ab1pDBAC+c5P3E6muD7v8b+pYfBqRGWmlbT1Tr5YDMVhYRnA7F2z8M7bAauEZ7iXg3rDSkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0L3JiuP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0L3JiuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE8BC4CEF7;
	Mon,  9 Mar 2026 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773090530;
	bh=U7I3bh69J3B4cMe2WWPQdGTO1zM2gflc1SsDGP9ZT0I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A0L3JiuPR1xjYzTSESZft46f57l2sFUINbyiBwaa6vFAi1NfK83JHNon+cdjeHKbn
	 7dtI21fEV5QD8ro2YvLh2Si8Xpmb/17KnuNGo/q5fBhZ11PkzUawLhZoFdFNhVyGZM
	 h/UhGimNDd/Bac8cHifHRIEZ0rQmMlZ0lNoOeU0rl8G4gzJtuuk805FkZ6Mu2QWd+Z
	 3MmBuE34eHGaY4YmNqZFA/7GR/Hc/hOENwdlrhexbxhowZ156iiF3wnKTE7av1xp4N
	 wTipYJkof56uIJTznJYFJZWnhgT23MKaop5kLLZPDuod/62QnQMcD8mDWMFBsMhO4/
	 d13soJV6gfW+A==
Date: Mon, 9 Mar 2026 16:08:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, imx@lists.linux.dev,
	xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH v10 3/3] of: Respect #{iommu,msi}-cells in maps
Message-ID: <20260309210849.GA591344@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-parse_iommu_cells-v10-3-c62fcaa5a1d8@oss.qualcomm.com>

On Mon, Mar 09, 2026 at 01:03:39AM +0530, Vijayanand Jitta wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> So far our parsing of {iommu,msi}-map properites has always blindly

s/properites/properties/
