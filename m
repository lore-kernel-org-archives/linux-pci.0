Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84A3E3DA6;
	Fri, 14 Aug 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690899; cv=none; b=KyV2ssFJBZhErgsrKH7SPsi2OYE8AowSfNq1rOvGXvy56rLcnv+h1kD4tmez690mVohTcp57gKrUguo+GbcTWJak9BL8l8AbX5AWiUkDAhfG+9silhi5KMkhjnlSuRlrYyLwN1+se4Ed8TsGiMkn6VZIxnDD05fTQJu9hDS8ZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690899; c=relaxed/simple;
	bh=OyjNCF/haRc6pOSyjlBhfSfRUoRRih4LEiHwuGm192U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pb9XoHU1qRUwmVrrfXnqqqv6DoF6WDEFxsNOFNNSngRN16kmF5Y4Z/hOlEJbtQ7nXcC/3zuWuEX1iXbs9I4zNOXbzjksKM674EuXeYZG3CAO6/cEgyy/TXBxOw2F+cyuRrpok45RCtWhVkLpmzncXj0vazpA6KwtxP6a1PteH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oExF/K5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oExF/K5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F511F000E9;
	Fri, 14 Aug 2026 07:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786690897;
	bh=gDnk98YnvqKpK+wgZ+/iChiIxE+XTLUDn/JDs/9UuRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oExF/K5v6cLBk8Os51Yk4pSYanyUEXzTSZF5sc6NRqqvVk1lXWPkmj4Vc+Jmx6xc5
	 3iZVQ6A5bjVs1l+xyLRc5PhGtbCSstQwLOiRsigA+lySHHTR+Tpip3IeaFGAyXjBwn
	 ZBu42nIO6jFM535ft+vrEFBx1eQ/bQ0oLj8cbIq5AihDrkjX1GjaQwsb8tpIEMjC++
	 RiGGm/vAeq+gYPAyrS4Eadsz14/bEf3nGXlHzg2QRNUUlFO2YxqUsf3ONyeLYX9iVL
	 azIgLcOz6cUuUMxREJutcyK7wjSIS9zB8MZxIYOwcq7/lF/YwQqQpFepDDGYdHrcHf
	 uUx8STGKpz4SA==
Date: Fri, 14 Aug 2026 09:01:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, bhelgaas@google.com, 
	daniel@riscstar.com, mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com, 
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: misc: introduce pci1179,0220.yaml
Message-ID: <20260814-deft-unnatural-teal-1dbac3@quoll>
References: <20260813222943.1655453-1-elder@riscstar.com>
 <20260813222943.1655453-2-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813222943.1655453-2-elder@riscstar.com>

On Thu, Aug 13, 2026 at 05:29:41PM -0500, Alex Elder wrote:
> Define the binding for the Toshiba TC9564 PCI endpoint function device.
> The third downstream PCIe switch port within this chip has an embedded
> PCIe controller, and that implements two of these PCIe functions.
> 
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/misc/pci1179,0220.yaml           | 150 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>

There are no properties in the binding except standard PCIe ones, so why
do you need it in DT in the first place? We do not describe PCI devices
in DT by default, so you are doing something unusual. Commit msg should
explain that.

Best regards,
Krzysztof

