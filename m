Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591B8223702;
	Thu, 16 Apr 2026 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371947; cv=none; b=Z8uQ3JUCImBzs3R8jJiktZAwZ1Xh8CAaueIOOG3/C3FAd4/YANcFbpih5/TdgNWvs46PtGb4VSq6Nyxe/qhAzRVILedSwmjade4Da7hnTLUn97AyL51YSlD0KTvBL78i03Wj2SQ2btzeubugKyyIb2UWLNX9TJhXwYe++58sVgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371947; c=relaxed/simple;
	bh=RhBffrmsMOEQ9U00Vb6PjZXRgwm+dO9ZID94mEWA0Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Kp7leOS5DE6VbFlZeXWD+3UXRMb8AfIpjaSWvrOzlfFDRtA2MjFBhZOIu00komA6UjFqdJRf7fP76yXOX/YQfRJDTghvRMKat+A1blXHsm40gQ/jh/HZBJ4qmU43l+acBEz5pR5xVP9GHsAh4+lkP0G/DzF3uWeQsBYPaPD7/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIC+uZOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIC+uZOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC9FC2BCAF;
	Thu, 16 Apr 2026 20:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776371946;
	bh=RhBffrmsMOEQ9U00Vb6PjZXRgwm+dO9ZID94mEWA0Ak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NIC+uZOPOTFu7mybYkK3oTnc3bdL2r8txodTtcrLDkhApF+K+rfsBdgJQ6aSWThkY
	 JqpOvSaL0mArNGzN2M0iMSmFbee7mQNnEvqfAqWTLv6U1KEfdTbwejpFRsj+fVtIsb
	 wSB1W7m+2Y7VxZfP8etFbgvKsjrTIkLkEtJ5SYXL4uJdRKyzpjQ/ujP14rk/WfLYuM
	 fBLieuO+kfgLbJeeCbzU2S7ImUhAdGLeQU5oXRt9tS31b98FJutEdKNSmOLoQdXJtR
	 5Yq1GPtrt6yU21YRfIkHj1q/eLrGVHyqMdgbL0cy86aAHatdAKBahoPgjxliq8Dlw2
	 my5ITqYYZj0BQ==
Date: Thu, 16 Apr 2026 15:39:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, bhelgaas@google.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V13 02/12] PCI: host-generic: Add common helpers for
 parsing Root Port properties
Message-ID: <20260416203905.GA29913@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416111422.183860-3-sherry.sun@nxp.com>

On Thu, Apr 16, 2026 at 07:14:12PM +0800, Sherry Sun wrote:
> Introduce generic helper functions to parse Root Port device tree nodes
> and extract common properties like reset GPIOs. This allows multiple
> PCI host controller drivers to share the same parsing logic.
> 
> Define struct pci_host_port to hold common Root Port properties
> (currently only reset GPIO descriptor) and add
> pci_host_common_parse_ports() to parse Root Port nodes from device tree.

Are the Root Port and the RC the only possible places for 'reset' GPIO
descriptions in DT?  I think PERST# routing is outside the PCIe spec,
so it seems like a system could provide a PERST# GPIO routed to any
Switch Upstream Port or Endpoint (I assume a PERST# connected to a
switch would apply to both the upstream port and the downstream
ports).
