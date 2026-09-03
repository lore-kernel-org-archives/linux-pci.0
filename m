Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196F4562B1;
	Thu,  3 Sep 2026 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435330; cv=none; b=so+pIn+NEf3WZ6gDQDmbjdyB44w5Wf78Jl+QKDw/VLqMPHskxJfzOYJA/K28TSBe2jK/23/ry9iJ+3hMHFQW34qmrZJTuy+H2boyngKsGuUjcDt51lnJ1wX2/SEL2r/6Vy9Yod0SIyWz3H6Fn3aBXs/78Kn7ySr4Z+r9BpFNypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435330; c=relaxed/simple;
	bh=fNLyfR++yFzplglYxdqLQSkkS9XmxQAlZgjL6YMvSmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+jJjPi0cX4o4kNNHW5iox5WRdJvTbt41TEth//31dJeRCzBQh4lGzdHXLW+sdYIcjNeZALLwnuE485ueA8+yZe+byyriEF/FXQ1k5lUVLGMJ1NgS1EmKpjJJaucZf+T73bN4/1EOM2VPpOOxh5nQjbiZGvr+aCfYy8H+FVqRkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUUh9/MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUUh9/MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156411F000E9;
	Thu,  3 Sep 2026 11:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788435316;
	bh=hZ1qCrDhJ33OJxxdaEUkt350dBb0FDB8huZWV3p0Hrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XUUh9/MVwvL7W9Tzsn8QpgfiMIKKg4iU5AV28Op3ZBggMrhZ1uJALZ9tGIlv/sIqY
	 9Z2D1lNgoe7nVOSvWR/OE5fIG7mWpQcPwnGJ3g38jZoXwFqSgIoWXeya2IFAngEfT2
	 TwYArnbcTcEXEEGWn9Q9Tx+BEEi7G5uP9vUk6UxOMpxB2ipiZc6o4wBqE/m5wVzsdf
	 tidzUG6l/uaE/J0/+8Fg4JKgXCwoyrLAezbeBesNjrqW+vKZgOetHesBJBC5J1SWKH
	 N6QZinGaZ03ACUSLd4LHVqwpG+nEdIolH4Y0fuL+/MZZCGJm2NJYa0QM4/+7MP8ZgZ
	 rsAU8v5IdJS5Q==
Date: Thu, 3 Sep 2026 13:34:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rama Krishna <rama.krishna@oss.qualcomm.com>, 
	Rashmi A N <ayiluri.rashmi@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Skip system suspend/resume for
 firmware-managed PCIe
Message-ID: <5bsz2arpufrnbglizghlr3ztkjeqhvsc5pr2qmgmkhj3n6l6ia@atgkmc2igd7r>
References: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com>

On Mon, Aug 31, 2026 at 07:07:02PM +0530, Mrinmay Sarkar wrote:
> For firmware-managed PCIe controllers, all resources, including clocks,
> regulators, resets, PHYs and link state, are owned and managed by
> firmware. The host driver must not attempt to manage these resources
> during system suspend or resume.
> 
> Skip the suspend and resume operations for firmware-managed controllers.
> The associated power domain transitions are handled independently by the
> genpd framework through its own system suspend/resume callbacks, so no
> explicit action is required by the PCIe driver.
> 

What about the D3Cold sequence like broadcasting PME_Turn_Off? Is it also
handled by the fw?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
