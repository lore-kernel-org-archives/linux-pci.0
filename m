Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849805;
	b=eaiZPP6ZhqVnL6S0YeapmKasrxP0hplqyaL/FThNjcYiofaAKk3gyFqgQvT4XVNSOjYd
	 2afSFonb1SbtYUIJNG2dBIj06d588AxFgOqbBi7ogRDM7EP8tjC3DXqGl6NWWIwI4yR3P
	 14nNsy/ZCTjGfbiz/dIgpTJFwYfOuclB01OWP3xy2sduCWO0SVA48nxTd84gT501xhSHl
	 5sN133NkpdrFoLmEEUTdjK8FUTkvgd9weR3zLzPXpj7Y9HRWXANtKdQJF5bp+gRL3CLl6
	 u86uXyGQVYkdgQSFt6L68F28pujIDAK6DVxnerpMXYVaDFwrJ3ZoOoX8fmntw3fX6dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849805;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zdh7JKd+n/bFEUO+tVY/GwKaMe/9PGtTadA+erpvg0Q=;
	b=N1N9N/A2jJClZP9PF/7r0LCe5QywxUABmwAKNsc6cpN8UTVJ1bKuEduqQyZdzvY2ihOh
	 rHbpqNMLEzGjpaGoYBLY17BHsgFVsnXrbuNWdsis1ZuflOphWZjdQGlTewUWEHY3XWImx
	 /f8BS2Jzg8gIuvE77H1rTfOGaY9i7kInZwk2jlMNjAJrxaqLCErNYYFfTwP0BzcPlcBsJ
	 YoccIKy4nhwiKqviIp+x/WSKHSUEVbmMkR8/EjnGde1gjIC1eZi1OCKn8FQ8CvUuhbjGL
	 7g0s0UWQhTFhZWcKbO9Cs8/63YVQcK2imJFWoeMHOqh3fEFoHHOfKhg9bRj1QQnnxbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4mlvzh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A6606A323;
	Mon, 16 Nov 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H4mlvzh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADB71F000C4;
	Mon, 16 Nov 2026 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849805;
	bh=Zdh7JKd+n/bFEUO+tVY/GwKaMe/9PGtTadA+erpvg0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H4mlvzh5r0sL0YISOB8wTSfjWPljjf4EU02sMMFNdz0rw7BVQLx7DAtJVsLRmxayZ
	 u/z/Ua56PsonECS2vNehIyGl70BvTy0M+vWgY57xUh2+Mem/KNCIlOv5fKCPi4tLAJ
	 vwenaTiklyWAi3+Fj+G6H+F7j1io2DZB9aZuqSdyMQVKV69WBT4RFwnheGoKE5k3/J
	 Z+CMthLun9rOLSNYdoorBi1Y2vAF3aeZ4Qgr+8OLU04yNP1UF6hI9kaDDqSOcZ9kFx
	 BNscAqdOUr019eIKBPhuQnjZWfXmLGnYgUe2gstUXIK5m546LHuS4DM5wFanO+5X7Q
	 eCNrre6j6ybnQ==
Date: Mon, 16 Nov 2026 18:23:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Yue Wang <yue.wang@amlogic.com>,
	Hans Zhang <18255117159@163.com>, Rob Herring <robh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jon Mason <jdmason@kudzu.us>, Myron Stowe <myron.stowe@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, mx2pg@pm.me,
	Lukas Wunner <lukas@wunner.de>, Frank Li <Frank.Li@nxp.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>,
	Ricardo Pardini <ricardo@pardini.net>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/3] PCI: Fix and improve default MPS configuration
Message-ID: <avs8BTbSfZoTNM7I@ryzen>
References: <20261020122854.1500883-5-cassel@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020122854.1500883-5-cassel@kernel.org>

Hello Bjorn,

any comments on this series?


Kind regards,
Niklas
