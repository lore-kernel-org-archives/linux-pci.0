Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F725B0B9;
	Thu, 15 Oct 2026 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036625; cv=pass; b=jbMf/PjT8kH/FFpeyVjOAaYN60ylU4nm8aW2be3gb6OrWmc9dnsdqvU9cObBXhzw3GYZWlKZ9p3YAdmQ8OOnQ/S925gPz3HC9Wtavx193g2J5Mce3w/6NZ4/79E3jSk5ZE5ZHtGbI50XlJmNxOXQFJngCSOyIrknvFNhRAzuMP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036625; c=relaxed/simple;
	bh=jSihIRXkAvNegGSpg4GhePbA5ylhlVWwIpl1+BYLpws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=miD5BxXsSC6Q4yXO9qKDPqnY+PcFoe4HrIoA/TqUWZ9F71x/5rBQuCqQXusc4Qk2oqtXVmembspFrXUW4OFo9HA3Si7kOCf3qhy49N/1OIEp4rGzbszaom3d4/1spGqOO3lm+keJAs+iOxxCFp1oH/nW2AX6V1l1fOGZOXfyRF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv; spf=pass smtp.mailfrom=iav.lv; dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b=Akc0haoJ; arc=pass smtp.client-ip=136.143.169.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=iav@iav.lv header.b="Akc0haoJ"
ARC-Seal: i=1; a=rsa-sha256; t=1792036578; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HyjvtTwhbqCnEDH+MM5AHhQ87mjpWDv0DrsKtXsvxuq6lhn5N8rGWPQIDyZY+fAh3AwiXa8Xe8gKNdvpdhizsg3rYIKeozFX0ia2GSRiCj5c2xsb6FL/h3xmfTAbUqDsPQh5Jh8U/yD/0CZi0W8xf58qk9HbFWXjr3xClzlQGHU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1792036578; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OJEWc0eoUwLODa0bYpq9gJ49xJvUkRMXg6H5LcqBKIo=; 
	b=E2eOfspFM5gCwbCsatAD8Fn64RGT0FWn/DZ21T2Vv7mPZIfNcaJBPbyt6tyxbyE4w8/sHczqOnDHrTzd56qEYsQOgN7zpToITst4OEZuCqK8qcKj1HEtzHAJlsP9QHCB44m8hXXcJ/MMGYJJcgDkbp5t2xrV/r3djHvQzPQvJKw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792036578;
	s=zoho; d=iav.lv; i=iav@iav.lv;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OJEWc0eoUwLODa0bYpq9gJ49xJvUkRMXg6H5LcqBKIo=;
	b=Akc0haoJe+d24pdB1r5qr5Bcd+Rzg071FeSpZ0OaUBwMo+3lG/uVXD9prR3yw8Jw
	+yU+IVSHY82dU1hfI40eJWMTNT8+27LnGlakJMMMuQtW/TVDIaykx4UkM1jGgrcfk90
	XGvHILAdm1gFbK6VaI6HvHZKz7m07gmIqnLQQt28=
Received: by smtp.zoho.eu with SMTPS id 1792036574971162.77080539620772;
	Thu, 15 Oct 2026 05:56:14 +0200 (CEST)
Date: Thu, 15 Oct 2026 06:56:12 +0300
From: Igor Velkov <iav@iav.lv>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH v6 09/10] PCI: dw-rockchip: Add system PM support
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com> <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
Message-ID: <20261015-m1-tested-by-pcie-v6-09@iav.lv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Tested on ODROID-M1 (RK3568, NVMe on pcie3x2) with 7.3-rc7 and Jonas'
EHCI/OHCI clock patch: s2idle 4/4, deep 6/6, the NVMe stays usable
after resume. Without this series it is lost on resume:

  nvme 0002:21:00.0: Unable to change power state from D3cold to D0, device inaccessible

Tested-by: Igor Velkov <iav@iav.lv>

> +	ret = dw_pcie_suspend_noirq(pci);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +	rockchip_pcie_phy_deinit(rockchip);

When pci_host_common_d3cold_possible() returns false,
dw_pcie_suspend_noirq() returns 0 without setting pci->suspended. The
controller is then powered down here anyway, and dw_pcie_resume_noirq()
returns early on !pci->suspended, so the RC is not set up again and the
link is not restarted. I did not hit this path on M1.
