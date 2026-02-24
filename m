Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D711494C3;
	Tue, 24 Feb 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916902; cv=none; b=JyxmjNEpei/49sntIhQhGOFnDm5JkxEwawjgFJmzzJ3U0Bgtt+THWh+XT79DfkLQrQIdiX3vP3tJK/rOQx7M5IGsSycHe9YJxL1aExMxgKoy791ywyu4MFsCM/CEMDnJ21VKjGTO2qRDW360eID/9ppOkvxhkwf2HL3NNfiB67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916902; c=relaxed/simple;
	bh=siLJw2A0f62cJlgh+YOYFnZcJEatTZTiHAV7JLbKcWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caet5Idv9zVC9L2Q58v7VW9rFYCDe2pbf/6Mybq8rFgho2RYoDOKr/chdsLbV0yvWArGK89XkxWoYiF3+oaxpyXlgyTYrI1/eAB5TI8HClEt4SId5jJlxjRKMMwgywiqQA39n7QtA4adNvqb5WmTbBwLCwczlFcG73mnWR2TUgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOZlD083; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOZlD083"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FF9C116D0;
	Tue, 24 Feb 2026 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771916902;
	bh=siLJw2A0f62cJlgh+YOYFnZcJEatTZTiHAV7JLbKcWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOZlD083B/DGOpAprjcHeUB65aH90SMO89jFdeFYasoxgqZ4vd42DgnnJccFivv7r
	 QOQp2JBzvjBjvi3lLzOGgOQwjwsIkVOF2ijRmBhuPyduOIGl/o+gKevb7Jyln96CYD
	 bZDnRoEYjgHP6/jIxkp0AVc1f4IFOvJ7EY1S4dNOmvWwweyD9P7P5AFE9FpoMttzm7
	 7XHW6yVEXqYUrGh6dcOQ5EUXpwvFKQbULLmPlUbLixxaZ+0OAQZGUyjixjQdEfOXWI
	 1OdcBK0aGbEW6a5jdobGaHGvdMIEbyqLvUMCtMEj8ZWsao+AqoVWjjy371bTj8e00Y
	 e+lNzjZoqCsdA==
Date: Tue, 24 Feb 2026 08:08:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v5 6/9] dt-bindings: connector: m2: Add M.2 1620 LGA
 soldered down connector
Message-ID: <20260224-bold-dalmatian-of-weather-d86259@quoll>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-6-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224-pci-m2-e-v5-6-dd9b9501d33c@oss.qualcomm.com>

On Tue, Feb 24, 2026 at 11:00:52AM +0530, Manivannan Sadhasivam wrote:
> Lenovo Thinkpad T14s is found to have a soldered down version of M.2 1620
> LGA connector. Though, there is no 1620 LGA form factor defined in the M.2
> spec, it looks very similar to the M.2 Key E connector. So add the
> "pcie-m2-1620-lga-connector" compatible with "pcie-m2-e-connector" fallback
> to reuse the Key E binding.
> 
> Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)

Please drop. You cannot test a binding. It's IMPOSSIBLE.

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Best regards,
Krzysztof

