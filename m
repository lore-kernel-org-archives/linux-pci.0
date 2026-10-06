Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FF4A0EF5;
	Tue,  6 Oct 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301823; cv=none; b=UdXLjv+DBk7R+212ydBCvDOcXKQEa1b8zySLRwF2kFMY16Zn5EysM3dlQLsqKTtSQoPyKIJexHnOFnnipjWmVHz9wLDF3317b8nxEBjZWCrpB8N6rS6vlSRqZ8waHzReaA1LuRSYJBYJh9VMGxZ98EsNuvGfqt1KE+OwNvt3aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301823; c=relaxed/simple;
	bh=oJ07hBlzOEWCDMH3PxBzK7Q7WNjpV2k4xBGgOl+sTFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/UEOwSQEeknJ20tE7Udz5SXUUozdXHzG12/5Fjj5MtSDmllbE5DoTQ9bJIbYGT67ccMO2cpt5CItNhRhQ+sjs9FG6rNBH1kye+UJpfvyrtJQ1IUkW3H6qX9aKKPLVnDuau0MPBoRqb/x1oxEKdl9TukE/Ac615Ilh6Xdqq38xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn6W2CEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn6W2CEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39061F0089B;
	Tue,  6 Oct 2026 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301808;
	bh=MlmHww92f1vJW/S4QWSB1ZbKlcGagch0hBEyJ9FR60o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wn6W2CEmZCc1wmFlg+Vnsz5z3biQCNIJb9RVhkJBf4RvFhE+uWjpdf5k0lorTthIQ
	 invFXp/KL8IDg+OnlSlRFjV5eyhrb8e+r2lOg17d52DbQRWvfQhZfBV7lqXZmRXKf5
	 o6w+Hk4T/V78X2waoJ+VyxIBS7VnQkCuJ2iv0mkmnOV7JHUj3vup+cg/ECNdsOS8zT
	 FGUT0cvciRM2yj5bWY8C+Tz7ICdz0KMlxzy57kwy5vAkzdBMkzHlDBEpjHgk6w7Dqi
	 au0bqnftLOeUjqX3EOZIQRipBwqWnairTN3neiFfHgzQP1rAbR/ij4K7ZmrmzxdENu
	 HZpPC88ailUuQ==
Date: Tue, 6 Oct 2026 10:50:07 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@kernel.org>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	devicetree@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Yixun Lan <dlan@gentoo.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Longbin Li <looong.bin@gmail.com>,
	Randolph Lin <randolph@andestech.com>, spacemit@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alex Elder <elder@riscstar.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v7 5/6] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <179130180665.2390774.18094483716506116545.robh@kernel.org>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-6-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929083755.458238-6-inochiama@gmail.com>


On Tue, 29 Sep 2026 16:37:51 +0800, Inochi Amaoto wrote:
> Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> This controller is almost a standard Synopsys DesignWare PCIe IP,
> with some extra link and reset state control.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   | 55 ++++++++++++++++---
>  1 file changed, 46 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

