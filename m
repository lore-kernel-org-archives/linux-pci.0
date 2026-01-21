Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6A3D6469;
	Wed, 21 Jan 2026 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985459; cv=none; b=qVOKImzpQQfg8kBI1L7hPrGhWiXrtk1qwx2gRgbrZMZgMo/4A4H7Q2d3ZUp/aJ9BS/GXjkM2ZQQxP77Y75VChRc+Bk6XqfkXa42DK77vZaHA+2a87ez0810JUMsD+dzdAdyDj8yTTfaYSUxEjB9cUmItOcR/0LpO6YJ0/9XMEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985459; c=relaxed/simple;
	bh=4yQSagIYK6WDibtEsPnC8mcleAfDCZiCTDQZXgRAD+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENcPyc6rSGkx5+m/bD1beqfpTcsCMVjh8Ew1TqLuagTvtlAPSFGIvTTJr5wRT43+zeWEBZ4P1W5iAh8V3YzSATrBcs3bzonep7Q+XfARqhm9pzjD6ucvB8Do0N2E/+FjF5w5WWgy/+3l8/zGbL6TmRXm6Jcug1HAiwoH4J0LAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KT0tizBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT0tizBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA4AC116D0;
	Wed, 21 Jan 2026 08:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768985458;
	bh=4yQSagIYK6WDibtEsPnC8mcleAfDCZiCTDQZXgRAD+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KT0tizBaSg04EhRK8B8rSNa0DQe5gJzl+7LyRgqj6yGczfJblsgj9vZQvSUVmXMig
	 ONbZEM96ggPjLNTXmn2stNwL+KuclpqL+tQW4QsKTqjVNrDXrkQR8dGSDkA3heULXt
	 /v9FRGMHss5MATOES6kv4eKkQN/8roCCiyiQ5keJjSoCq+49R0mnDknjUg4njJXyn1
	 nWYcY8S+gP83SIi83yKXI2f6k2m1ciqUO/MrETJB17NW0ddz1TD0pH0spq2MzzTTpN
	 uK19lBKh6btQ/JGtnzjFJaaEA8HPYCFOhSjpndxlAdNbX4cWRZAxCGwFgj83fiVhl2
	 NtcyloYl6z0WQ==
Date: Wed, 21 Jan 2026 09:50:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org,
	s-vadapalli@ti.com, danishanwar@ti.com
Subject: Re: [PATCH 0/2] PCI: dwc: ep: Enhance multi-function endpoint support
Message-ID: <aXCTbb-0BWAWc2DB@ryzen>
References: <20260121054214.274429-1-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121054214.274429-1-a-garg7@ti.com>

On Wed, Jan 21, 2026 at 11:12:12AM +0530, Aksh Garg wrote:
> This series addresses multi-function endpoint configuration issues in
> the DWC PCIe controller driver. The changes enable proper operations
> for physical functions and enhance the multi-function endpoint support.


Considering that the DWC driver design has always been broken with regards
to multiple physical functions, as you explain yourself, the iATU to BAR
mapping has always been per controller, not per PF.

Thus, it would be nice if you explained how you have actually tested this.

Does the controller you are using have both Resizable and Programmable BARs?


Kind regards,
Niklas
