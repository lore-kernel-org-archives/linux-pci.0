Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808E43230D
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423611; cv=none; b=E5FiaoBZcZCn5jvaAHQA6mXJKIdQw6M3J6u7gOq1EOI9Hl2yvF1S98Z7q5Z+6ZWTl/M/+1FlWleed3x7i+B90uydvY3qy5jV9WsxSEJ7z1YuGJcaqWSqP1yKP+Z66WVbZloQMsyRY3GKO5VmSksWKvgHqEMeMLE78+OP8bwkfZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423611; c=relaxed/simple;
	bh=0v+75UbFVa71mPXUDuDA90zV/XuPMaLrTQRlGB5LzSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQYW4mB3RNAhGY955J/3pAlFD1UJdL3EeZmubqXkloHaqJ5PRiFDRRnpC4utOho2HDuL3ijHD5W9AefBXxtgHtI8N+N0EOj3bR0g6RG9dtIFZNFPNRvukqOK/z7jXJGfDZbgE8/UZafxi7yb16EHqElZTM+JYhCgkMqT1Q5+NNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jojqdBLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jojqdBLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0897F1F000E9;
	Thu,  3 Sep 2026 08:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788423607;
	bh=R/ILnFYwY5kyNXCGppBs9AQYzpP7GN2ZEnkx5tVKRjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jojqdBLB1KO91UXlx6S2Z+ivdMkRUjlrjCm8sEkobHf08zVo8rx5XQfAPJ1FkZ7rP
	 RUrnKsxdJ0XOJP9TfFpIMXB7yiXRwAEOzB+olh23GehiWTyf5wQjv0uuMudSdDuL+8
	 MaBulRWW7HAyfa+aLEC06b2eNcYjJGrAeJnWN93MpdpIERcEMz83zj2arcyogLviI8
	 ZVkC4z9VTQT3gL8igsLw+vXjeFeyt79wbMJfNB+HUkvZRZ/HuHACixn7pdSSUHDOVo
	 OkimA+qVj+6vbmSX/RHfDTmvs5mZJlWVDStqkGM2UKFddUpu7hvxfxePSCyxfQGY+J
	 xA9QL3F1vn3lA==
Date: Thu, 3 Sep 2026 10:20:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH 0/2] Two small INTx fixes for Rockchip's dwc based PCIe
 controller driver
Message-ID: <apktsxxgZ3yFclo0@ryzen>
References: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1788403477-71491-1-git-send-email-shawn.lin@rock-chips.com>

Hello Shawn,

On Thu, Sep 03, 2026 at 10:44:35AM +0800, Shawn Lin wrote:
> 
> This small series fixes two INTx related issues in the Rockchip
> DesignWare PCIe controller driver.
> 
> Note that patch 2 depends on b376b3ff9cb0 which is not yet in Linus'
> tree, so this series is based on linux-next.

$ git tag --contains b376b3ff9cb0
v7.3-rc1

FWIW, the commit you are referencing is in Linus' tree already.


Kind regards,
Niklas
