Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038C26AE5;
	Tue, 18 Aug 2026 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036779; cv=none; b=UxqNQSUldye9dAEAvoRIb971Ha7JSTywoPTF9mY4WuoPGVrKbBL/5i0Zy+IUEA7arWlDd4lUo6S8A0GFTCP6bBfJnEMHCeKwIJeD7beviX/bG86h3+MSgXTkkjj4pFuTra63sLju8+gBQaSo+GrNXG21e4y5Msb2/IH/yGfr+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036779; c=relaxed/simple;
	bh=mChuPyeF05gRlH1VjUVw3Kz7lzWKz0rH51iJPC08Wgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBswBXA3EYco1fcgLr5Lw+Idb4k5ZCXrr7TcfmJ9kMG4TAmYtJxfH6nrBPPgt2uoI612nO/a0HD+pBMtFxtCyIdw5rh12HT1vA6DvevZ9m6AHauX5z5hiFvfqaZc62DMV76FochzImuHimi5hqdhSXt2cXBTiKHVBOcnpH8SCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnmDUoqz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnmDUoqz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C61F000E9;
	Tue, 18 Aug 2026 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036778;
	bh=NGXeti55rfsL+QIxNH+23V/SFO6fjV5CYs9tpc0kf6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fnmDUoqzkz6gpC9rE+MpRmsVk4t4fqISEBKKGm0FAVNtaTxh7CSfS6eX10wQVFC2M
	 afGm7/6KhniQcLBzXVmICJtEKf/Ie9fiN+4u0TeFtq9FmAQmQQBuC5xEydaFk92DNi
	 0tMxnMJwlttlLoYT8hBhFX3ArF9aK0m1Dhj/F9tWgU/AiV1KzcnACYoseTQjvOQWKQ
	 wbfd0aK9sNJ22POKHl6f3qi0swzBrTlpFPdOSQdYXHQZTpycUhWs6Hi8Jrc9azl0El
	 7JEVYeqgjEyvtCdHjc+GtO3J9IswyLHsyXZvaeMOXSXxFQbxGzQbDs7rP0bzi8SuNQ
	 Hm1SbNdFIlU+w==
Date: Tue, 18 Aug 2026 09:06:11 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans Zhang <18255117159@163.com>, bhelgaas@google.com,
	Manivannan Sadhasivam <mani@kernel.org>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, heiko@sntech.de, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 0/2] PCI: Configure Root Port MPS during host probing
Message-ID: <aoQEY5PDU5iqnD9S@ryzen>
References: <dae17d36-c7d2-467b-a621-3c55e08a67a8@163.com>
 <20260622171448.GA678675@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622171448.GA678675@bhelgaas>

On Mon, Jun 22, 2026 at 12:14:48PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 19, 2026 at 11:29:39PM +0800, Hans Zhang wrote:
> > On 5/6/26 22:00, Manivannan Sadhasivam wrote:
> > > On Fri, Nov 28, 2025 at 01:09:06AM +0800, Hans Zhang wrote:
> > > > Current PCIe initialization exhibits a key optimization gap: Root Ports
> > > > may operate with non-optimal Maximum Payload Size (MPS) settings. While
> > > > downstream device configuration is handled during bus enumeration, Root
> > > > Port MPS values inherited from firmware or hardware defaults often fail
> > > > to utilize the full capabilities supported by controller hardware. This
> > > > results in suboptimal data transfer efficiency throughout the PCIe
> > > > hierarchy.
> > > > 
> > > > This patch series addresses this by:
> > > > 
> > > > 1. Core PCI enhancement (Patch 1):
> > > > - Proactively configures Root Port MPS during host controller probing
> > > > - Sets initial MPS to hardware maximum (128 << dev->pcie_mpss)
> > > > - Conditional on PCIe bus tuning being enabled (PCIE_BUS_TUNE_OFF unset)
> > > >    and not in PCIE_BUS_PEER2PEER mode (which requires default 128 bytes)
> > > > - Maintains backward compatibility via PCIE_BUS_TUNE_OFF check
> > > > - Preserves standard MPS negotiation during downstream enumeration
> > > > 
> > > > 2. Driver cleanup (Patch 2):
> > > > - Removes redundant MPS configuration from Meson PCIe controller driver
> > > > - Functionality is now centralized in PCI core
> > > > - Simplifies driver maintenance long-term
> > > > 
> > > 
> > > For the series,
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > > 
> > > Bjorn: Could you please take a look? This series has been floating for a
> > > while...
> > 
> > Hello Bjorn,
> > 
> > Any chance for this series to be applied?
> 
> It's too late for v7.2; we're already more than halfway through the
> merge window.  We can look again for v7.3 after v7.2-rc1.

ping


Kind regards,
Niklas
