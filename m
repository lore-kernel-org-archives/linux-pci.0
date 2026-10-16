Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945E1D432D;
	Fri, 16 Oct 2026 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792190486; cv=none; b=P8ZDqn7tmgBT31idzEp57oDG72PfLv6sKjKGQsXy6L8t6L2n0zrH9uuUzDv2v9+4oXDNt/IcBVwyqwg9lhKCxg4C6T2JuwFrxoGeoVFjaFhXJE0UL/dmEfzVQ3JYrLOgNJ1HjW7bYd4k7KsU6dag88Z9Pt1T2O83Dab1qiqUsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792190486; c=relaxed/simple;
	bh=nOmlBcRzNKtRPQ4eEUsj+/2m3286iFfddMj78Z+R054=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imalEvjoguz2Vja9R8/pvSxmNsi+av8GOw2IZ1iRCsbSK2ZgulJnb4j7apjNci6MS9igvuIVwY439k6yDRF0gGjbwd8T3EsNPEZYa16Iy3utmoBQQ9fh5T0p/jmrpvw1SrCf1EQuW4NICD1+NiWJ+3I42IfO0/A3y7+QDL/the4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hH71egwH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hH71egwH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B801F000C4;
	Fri, 16 Oct 2026 22:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792190485;
	bh=wlqZJKJYIhaeE0t+tvS/zxiZ9grWXt674kx1cECAGCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hH71egwHYq9vWkbUXDiJA2QB7ySa4Da0tZ3L8qH+Zx70I9dvyd3tvxyOhOOy2zUPw
	 nIYzx/JCugdltAn/0Xza23DF4+AfZ3MW+gM6Q79ynl5/3JZ4LUTi7tnfmi2mRBeP2a
	 F50Uuzio+26S2WjZGFYXoQm7N6wX35FGf81LayX5errbMnOSIBJOqBrokBw53cUlYs
	 3T+23U+vKIxm4ZRyCn1r/Lbb1S1ZJSSDHp5MMo0PfXR6fYWiXElfKHy0Ejdv/rFVji
	 fXl1yfrlLWwxa8SXSEU6bzmDNgoNQgcSNSTOSfbhWceLNi2h5QSUDHbOxfkBu3zFaR
	 eZ39RiLw2w32g==
Date: Fri, 16 Oct 2026 23:41:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Ira Weiny <iweiny@kernel.org>, Li Ming
 <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Terry Bowman
 <terry.bowman@amd.com>, Alejandro Lucero <alucerop@amd.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl: Account for link width in latency calculation
Message-ID: <20261016234118.20f6a7e1@jic23-hlaptop>
In-Reply-To: <20261009045452.1107921-3-den@valinux.co.jp>
References: <20261009045452.1107921-1-den@valinux.co.jp>
	<20261009045452.1107921-3-den@valinux.co.jp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 13:54:51 +0900
Koichiro Den <den@valinux.co.jp> wrote:

> cxl_pci_get_latency() derives bandwidth from the per-lane speed returned
> by pcie_link_speed_mbps(), ignoring the negotiated link width. This
> overestimates the FlitLatency contribution for multi-lane links.
> Sections 2.11.3 and 2.11.4 of the Intel CXL Memory Device Software Guide
> describe the link bandwidth as the product of the negotiated speed and
> width.
> 
> Replace pcie_link_speed_mbps() with pcie_link_bandwidth_mbps() and
> migrate both CXL callers (the only users of the API). The new helper
> obtains speed and width from a single Link Status read. The CXL
> bandwidth calculation no longer needs a separate width read and
> multiplication.
> 
> While at it, make error handling more robust by converting PCI config
> read errors to negative errno values and checking for zero bandwidth
> before calculating latency.
> 
> Fixes: 4d07a05397c8 ("cxl: Calculate and store PCI link latency for the downstream ports")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

