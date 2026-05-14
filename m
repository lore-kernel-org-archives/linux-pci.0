Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D03AFB1A;
	Thu, 14 May 2026 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778753776; cv=none; b=Mg94KaWDRrQpGAlZ/KmkvE3Tvx55qI2cfjdH4ZJceDgFk+YBFj8zNbeIFyQ5+KPV5lA61LzIY4TqOmjsotPnzwfSTcXx/xPj8FERbm0iEnWcMXME7S3H+8ErI9kmpD+gBrfpSOqzsLAtxSTNWYGXdRA0wV4yS60c+kl8+skTLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778753776; c=relaxed/simple;
	bh=MVkIeOS8yFdKE4JHU+qeb6s0/70ldISnfTAI1PjQVt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuDyiSekAB4V4bm0l7zyQevLAPIIbBN9FHGncYVP0vMNyQANoiDZ+1g31+1p1hyrlPTbiYeQ4WnmIUVP/Tdkga9n3oICm6UUpRbk6yDWT7vY0fj+tG2I1DmAUK0bV6X0R1skFJ5TivnlecBhj0Qo0TcBYQtBs/UzAc84m+pIGjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG5yh085; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG5yh085"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4735C2BCB3;
	Thu, 14 May 2026 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778753775;
	bh=MVkIeOS8yFdKE4JHU+qeb6s0/70ldISnfTAI1PjQVt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gG5yh085PRYj5m2zyXmyL1cYJBjLTd64W6A2QJopdSbz4ogeHpFmN11YAMZNCqg5E
	 /yC2WuBLU/WxfxOBX5IxBXwn5MVqDDnt0EGXqC/2zA4YvxvYESvuX1A8XKvtLI7egb
	 M7SRmsaO1mqr1sGeOEbNy7UJ8RwmMM6I5q089WAIW1yFHBjfpVGtlPI0/yFyTGj9+X
	 v72VkAeDkBAs7LUGsCmGcMAQzZ5x3UyvY4M9JSBiGqBp85ABF6XEUBwDPfTSh32Nxp
	 J8P0iPRe637fhS4PntSL/c30QJKywouH7v5z/5xZ9B8a91p7qx28JYP87HXmHrLq6h
	 5Rlm6/C9b2hZw==
Date: Thu, 14 May 2026 12:16:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: imx6q-pcie: Add intr, aer and
 pme interrupts
Message-ID: <20260514-lush-onyx-trogon-48eca5@quoll>
References: <20260513025101.1498104-1-hongxing.zhu@nxp.com>
 <20260513025101.1498104-2-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513025101.1498104-2-hongxing.zhu@nxp.com>

On Wed, May 13, 2026 at 10:50:59AM +0800, Richard Zhu wrote:
> Add optional interrupt entries to the i.MX6Q PCIe binding to support

Describe hardware, not "binding".

> event-based interrupt handling:

Same questions as last time.

Best regards,
Krzysztof

