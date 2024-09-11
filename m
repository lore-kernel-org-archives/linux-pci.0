Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F0383B1;
	Wed, 11 Sep 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073855; cv=none; b=DbkAATcXHgCrPDvcd5ZRqk8QyYAIsdjaopl8URSK0C/VcIKsbGeHLQXqV0IAFcF7UBt+WVHEtLbkXovz31b94ldtYmwAqEjwoWtgwdXA+aduphCyjuVnhAG2rk5H7UM3eu6onLTTs+uS04pODRjJUU9ESJokfBRfGSyyysTsSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073855; c=relaxed/simple;
	bh=RvdHtkyLguHYflQYKvYjrr6EPKoRmooxRGtmslG1YxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPQBzv9VJPnKDOJM3BxIx3m84YLgFprriV0NPzlRNyTKFjyeqbAkByhyjx3ZjY1+M9+uDNtO49n9Sin67QCAPab6QD4o3qek4jKkNK0PTPorTb3M8urtxyGSdN3Vbo7ZvPEGtA2qx3PFpz4yJ2zfzXDteOwoTcHH9B/Zp85MjH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV8UsfZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV8UsfZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0807C4CEC0;
	Wed, 11 Sep 2024 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726073855;
	bh=RvdHtkyLguHYflQYKvYjrr6EPKoRmooxRGtmslG1YxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PV8UsfZYWpthYWdPGa3a0QIk7JRTVe+rWmQz98AN6no9rvwhgOXDntcSG/lJUnA8R
	 lSpccVNDGUNzD2pnxFGA8ofkNJNxnPX5Un31MFW9Xg590RkF/kZ9kDdnh0Ivb3hrBw
	 efFtSSxdiqZikPngb6n9A0ACxsnroMpaQEodojfR6DbHC9bXx51F8CBTBBrF2e9lxj
	 3KiumJHPXOblquBKWBNgQnyza/Am8HuUW8ITrQR66odbHSqMlPXfgWSk7tVv1pv2cp
	 xBPiz427XRs7nxqouxNvj4zA6WtFg9XUqqCz6rqYqY26C2UpdiRUazoMnc+HdufL4O
	 8O1uRHiNbJT7Q==
Date: Wed, 11 Sep 2024 11:57:34 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Phil Elwell <phil@raspberrypi.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	Jim Quinlan <jim2101024@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rpi-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>, kw@linux.com
Subject: Re: [PATCH v2 -next 02/11] dt-bindings: PCI: brcmstb: Update
 bindings for PCIe on bcm2712
Message-ID: <172607385005.912446.16195492027208168330.robh@kernel.org>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-3-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910151845.17308-3-svarbanov@suse.de>


On Tue, 10 Sep 2024 18:18:36 +0300, Stanimir Varbanov wrote:
> Update brcmstb PCIe controller bindings with bcm2712 compatible
> and add new resets.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

