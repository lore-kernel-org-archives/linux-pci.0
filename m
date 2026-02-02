Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304C2E6CA5;
	Mon,  2 Feb 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026535; cv=none; b=BSK7vdgZ63TYf+piSCotqtIPgI8J3/hsv62cBQyibNfOrY4ZeLcgx+R0Wt/CVM9wFFPfiHKS7QLULlGfDkrVulWDvJrYfHKTfN5F3bSXzogBbWzplNlmoxWha/fnQPch6tqfSp6HVTYCYS4WFOwfy/tqqs5GXqXDCZ9AA/ZCdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026535; c=relaxed/simple;
	bh=J5BGzuN2ty2qBHUEoZnjE5Et++MOWK6EDUcZfLtgETA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/YMMnDcMNx6kUXK6yXxW69TWSJfN3a9bjGUFpAoA8X4age0uIJc8Eg4iVSpZKKtHZQkmBVUymGLLMp8TJhJIoLqpOqPtisOizszOY3HEi84nyQbCX8GvySKAJp/RtMkKjuq0GhRiK6Xt+RUYEqRAdZqcS75h2BC4Nhh1Er0WUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izUCAWIa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izUCAWIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89750C116D0;
	Mon,  2 Feb 2026 10:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026535;
	bh=J5BGzuN2ty2qBHUEoZnjE5Et++MOWK6EDUcZfLtgETA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izUCAWIaKJ/T/MeoqThDFIpU9m/ilQsmhgs5NRtAHvYODSJah93V/vr51/RY57sL8
	 dcs9cd2JoKMRfduTEtDpIeuB7tzFn6RTbKeIQYQ08io5rp08F9rWlCat9YuV+uqkCd
	 oUNoKGhUeEuyBDhrsO6aOhi6WKD1EW+Ac60QUNrsXxZhGGl3wvBpmPTdSOBrtG0vbz
	 HBAkR4YaYch/E3rC6woFF227/LxDn7prPwo+f0KmIfA17U4pEEtu0JYvxJsd2NTPNh
	 RLfhJTcMycPZdGg/aMpwM9oFtR7OPxsZDxkme2ZBuagt2hVBM3Nvz4SFxjnwBj1qcE
	 ceg0Lo7O7EAAQ==
Date: Mon, 2 Feb 2026 11:02:09 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Grimmauld <grimmauld@grimmauld.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
Message-ID: <aYB2IVdh_kth1wtn@ryzen>
References: <20240809073610.2517-1-linux.amoon@gmail.com>
 <aXtpg0V_sifQEWHJ@grimm-nixos-ssd-2>
 <aXyHITrZ89Mmn8_J@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXyHITrZ89Mmn8_J@ryzen>

On Fri, Jan 30, 2026 at 11:25:37AM +0100, Niklas Cassel wrote:
> Note that I've built the network PHY driver that phylib wants to load
> (CONFIG_REALTEK_PHY=y) as built-in. As long as the PHY driver is built
> as built-in, I don't think that the problem the modules code is warning
> about can happen. (But I also don't understand why it is trying to load
> a module when the driver is built as built-in in the first place...)

FWIW, the reason why PHYLIB tries to load the module even though it is built
as built-in (i.e. is already loaded) is explained by the following comment:
https://github.com/torvalds/linux/blob/v6.19-rc8/drivers/net/phy/phy_device.c#L852-L855


Kind regards,
Niklas
