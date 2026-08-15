Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14563372EFB;
	Sat, 15 Aug 2026 06:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786775324; cv=none; b=mbnUqORHMzNZOmTu//cRttYwXPejCsGrYI2+OOYVMlHy0eYduM2nZypiD8XGlJVkJzaiS5XNTZDSD9CvTlGH3SyycII6UUXZh00naxMi1BtOEksRHdE3ue4kWyoTYDTmqOYUK5KEWBe5Kc5hkTPjr+RXD5sLRc3rWnkaGS/aRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786775324; c=relaxed/simple;
	bh=ykM0R8PGcwxLNQmc8rZNxl4q0EsFcQM49z2MfXEgG8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CK7QPyWyCm/cHqQkRSFybRbccqG5xBxHmOPN/AM4MvH5kkV2GIeQJcbAZFLjurnpR1rC366Y7CqD1MR70JGCOla+j+19oMNMXzLbhIqc6CGcFt4wvVD9PTA0Hv1RW8L4GlXdt9J4F7R7pEuy08JDY0HqUstWI8qkDVjR6UtBY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXOOq0fX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXOOq0fX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4012C1F00A3A;
	Sat, 15 Aug 2026 06:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786775322;
	bh=p3Kaea5/4QRfxkV08KgglL3TBfF6yvhEMPHKfExIBhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MXOOq0fXuEq1NM3LiK4D0xeGvzqPoDsUnLQCENrdVs//002shNcoj9BJnsPdZ4Dwu
	 Wb2wXteFNLrzsklRyYfpOMAHgctCDhKMDY7fvS1knRaty4VxJmcJt6NgKojOYmsq95
	 izt5rTPQL5+66JwPaqVSEkdsX4RMDy9LQQDQckMmkzgc1WyNDlb2CbOr0HUWDrqNc+
	 x2tFdLiQnA956TkhpdYQG/HMYnAAjXVO4MJqSulWUpZnsnabZlwNVBzvyg/Jq781Zy
	 7v9DD2U5eMSXxbygLDrzQhwOvC2FEEz4awEawZXqfW9NjH8CQ8HZ9L3APYS/zJi/nl
	 HFtCK1AI5yU1w==
Date: Sat, 15 Aug 2026 08:28:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v10 2/5] dt-bindings: pci: tegra264: Switch to PCIe root
 port bindings
Message-ID: <f2wdbxqudd7kice4fcee4skgwektcftgqvccihi6l47ztwlssg@ufehmcwfwjh7>
References: <20260814-tegra264-pcie-v10-0-05d08c592b05@nvidia.com>
 <20260814-tegra264-pcie-v10-2-05d08c592b05@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814-tegra264-pcie-v10-2-05d08c592b05@nvidia.com>

On Fri, Aug 14, 2026 at 05:38:56PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Switch to using the PCIe root port bindings in preparation for using the
> standard WAKE# handling.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

For some reason, you just keep missing Rob's R-b tag for this patch:
https://lore.kernel.org/all/178594272722.905042.3804777775947567354.robh@kernel.org

I'll add it while applying, but please ensure that tags are not missed in the
future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
