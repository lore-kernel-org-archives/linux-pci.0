Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF219F40B;
	Thu, 29 Jan 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710275; cv=none; b=ZpVR5KO7w9+rfmor2tdIXPaoiG1zaxYtzkFuDddM1CJ24B26Kyrp1R3E/CUvVlzBV9hxeKjeTasanSy/ucpe4MbKsUy9h19BDvzQspRngU5lpUw20kIIaEWBUTgENqW+r+8CDqSrQ17ZmQgVW4UcO+OY54CzsJmRrB36Ud+O8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710275; c=relaxed/simple;
	bh=3Au9COKP+vRsf+RlNddoz8B4QzP+leArD8miTuKlC1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EanFh514UfqQgUM9pRu5sUie4va42SCC+TjGBi5F1m+sqS+UeyVN84t/UfD0QXgCo57RmionqSB1jWiV6X14+Py6bj+7wsMydJSYZYV1MYTEoV5W3B5RQkPwWUuuC6kFhd66fz6J4Atjq1SERcAGCn9mQJqAuGQxt7P1HL19TXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm2MrgTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm2MrgTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D144CC4CEF7;
	Thu, 29 Jan 2026 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769710275;
	bh=3Au9COKP+vRsf+RlNddoz8B4QzP+leArD8miTuKlC1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gm2MrgTISL7NlkFAsK1t2vtt8JUCr14uepW9AgHCbfWVGiTdOZ7INDSBNzJrZKHGN
	 +5JXllxrpHZBd4m5KLFEQL9gxFceakknubpmtc00iVn1azvi0HVsjqSs17IW9t3f4q
	 z1adpmfG9ynlgkQqe9Nt5SB33ArDiJZaOf8KEiePWHOFjMqkMVXwo3/rmq86X/+nYt
	 JSSk4WFTYEBV6I7tI+o1ex5zBOXjfMv6pb73xd/Bk1FFJ6+88Qp6afDuLNxg9lLg5K
	 Wb//99Lgn2tdGhKVybVdKFaKCcf3PSib+eTeJRKjeizoijP9F+8kQ/smqftFe6IcLg
	 rVV3a2xELSS3w==
Date: Thu, 29 Jan 2026 12:11:14 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: mani@kernel.org, kwilczynski@kernel.org, shawnguo@kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, festevam@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, krzk+dt@kernel.org, frank.li@nxp.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org, conor+dt@kernel.org,
	bhelgaas@google.com, s.hauer@pengutronix.de
Subject: Re: [PATCH V2 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset
 GPIO in Root Port node
Message-ID: <176971027369.1393650.10286669434894758293.robh@kernel.org>
References: <20260123021445.3782170-1-sherry.sun@nxp.com>
 <20260123021445.3782170-2-sherry.sun@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123021445.3782170-2-sherry.sun@nxp.com>


On Fri, 23 Jan 2026 10:14:36 +0800, Sherry Sun wrote:
> Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property
> for the Root Port node.
> 
> The reset-gpios property is already defined in pci-bus-common.yaml for
> PERST#, so use it instead of the local reset-gpio property. Keep the
> existing reset-gpio property in the bridge node for backward
> compatibility, but mark it as deprecated.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

