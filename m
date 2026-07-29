Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5933C9EEE;
	Wed, 29 Jul 2026 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357144; cv=none; b=JEoOqNA3QKNsUwXfq5XvZ2T7s6CF0x5M6hOTGu6dPiW3CS9JS2vDY6ANAvgBU3XiCtUGlVTeW30u1ZlZzXlRoovdFRNABhkfUuhsTN3XMar9erKvBho8YuOXcudaDjGO5F1Gidkcryg7j48bVNrz6j6Qm1jjQgZACXUHoXdOYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357144; c=relaxed/simple;
	bh=F5IKq6tStFr/2514NCP6oWZPmmawnjIGz2XNjviaS2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E9CpBnZYdE6nkEwKc8VO/tQQqBO6NNYqy67CP0p18l4Dv1mzTwXZ4xyuxxTxFSbqcAsqLQwo2/iIVM7TV0nn7y/65Y6C7oj3GjJzOxxhGqGPxM/RsKvLrEMx7EPj6S+WtLjVDMl9IuWTWMuKxuYQ9WAXAXKL1b7blJaQ2s98cDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8XJqTZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8XJqTZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AD41F000E9;
	Wed, 29 Jul 2026 20:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785357143;
	bh=o4LwrGMKdsyiGbYcgs69UzBmVusf0+mW1ZKjaz2vMXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=a8XJqTZ/HQZ9S20Svo+TSeJ3O15hqPvyEAFQHqwuLVM7Y8GQCrC0lw7lylri6Hrm+
	 eO3howZapdbNEpYPTUqtykbCQOpvtlHC6hKftdD7GKmyGkGDIpeFQdW5rhtDEF3Ome
	 Q8EQQGlQ2QNBXWomPXj2frAYA9rnqVY63aGo4SmN3Y/SLpJPfUtInugJvud/YiWo4L
	 2ZzmxH9HuTwCsAUp+a8+k2kh3kZNjIdmQg5zxniMfNZPLA3hmNmjPzU78PHneHJCIv
	 u/PCq1faZh9hg55FcxFYK5a2Fx0EytjGDX7R7ceowr/k0ysoFFOtysWufr5GkxhSyp
	 3KbDmgbdu8MOw==
Date: Wed, 29 Jul 2026 15:32:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Kevin Xie <kevin.xie@starfivetech.com>, Aksh Garg <a-garg7@ti.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v8 3/6] PCI: Use standard wait times for PCIe link
 monitoring
Message-ID: <20260729203221.GA1465128@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-tegra264-pcie-v8-3-23e51589229b@nvidia.com>

On Thu, Jul 16, 2026 at 07:07:14PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Instead of defining the wait values for each driver, use common values
> defined in the core pci.h header file. Note that while most drivers use
> the usleep_range(), it looks like these were mostly cargo culted and
> msleep() is a better choice given the fixed delay that the specification
> calls for. Convert all drivers to msleep() and use the existing
> definition.

Thanks for doing this, removing all this needless duplication is
great!
