Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE0548EE;
	Tue, 30 Jun 2026 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841068; cv=none; b=Y3PiFy8jfiriPAgnsj7IemgtFsSJKN8NW7ncHMTKitpW2tkRag/Vc43Fa/ksz3MVXjjvsbYVJBLzzpUoZQ1UqNY8jr0kqbGSfgGr3GAzxGs1mosDJtkRX6zuWJNex5Hi3P31DIj1KASDAD9kTCfyUvSqlS7Cn+EPaKsp/IpNVjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841068; c=relaxed/simple;
	bh=HJRM5qHyE5meSMlSI6WRBAbKT5AnOu1oLTv0gbcogxk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LWBEmsmcM4V4/kc4J4jsCeH/EqvZlAJvDIS7ElpivG72YXDR3u+836ZhRMmmwEv9J0TS9GJNwedDd4PeEDovjr4KsGQEgtqPDa7/6pxbrb0yX8hhPkeZDoXyMcaPEO4WyxKbox1OjaZLGEwav/MCKk5nDL9JIVroS+bhysvpo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NERHJxgT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NERHJxgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BEC1F000E9;
	Tue, 30 Jun 2026 17:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841066;
	bh=oKhxSVXGDVm+qucXMK8YNhWI4lwMIt4fOF8+IcyMJ5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NERHJxgTlKQbLnw800mRU4wiRtidr8eWnJrJ6u1axUtwriB6g9JzkCQhz9rrdY+Xc
	 Lg0RB0duZfXGnPVNlEWZ+xrl17cdL0/H+Do75pa/AK56vUOiNxUfSPEmwcy7QrFuOu
	 cl0CLGjqiv5VrS0cr4EHHyY+93wUMTJpIfXXkscL1KpRb1DYFb+DXMuEz9kcKGeSdT
	 KC5zCbtLTjHFlFzb1MgU0oh+jk/utS6XyjtH+7ukIKxnctwVGEz3358ser+97m8ZgH
	 vH/UKSJJPjwAfB6CHNNYWYATM4bChF3YkQZ+p7sWTDFX7J58HFOoTt+ao4cFAIisti
	 HckZe76qpZXbQ==
Date: Tue, 30 Jun 2026 12:37:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com, marcel@holtmann.org,
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, brgl@kernel.org, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	sherry.sun@nxp.com
Subject: Re: [PATCH V4 1/8] PCI: imx6: Move pci_pwrctrl_create_devices() to
 imx_pcie_probe()
Message-ID: <20260630173745.GA155769@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630103139.3823329-2-sherry.sun@oss.nxp.com>

On Tue, Jun 30, 2026 at 06:31:32PM +0800, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Move pci_pwrctrl_create_devices() to imx_pcie_probe() so that it is only
> called once during probe, similar to other regulator_get calls.

Can we say something in the subject about the purpose of this?  "Move
X to Y" summarizes the code change but not the motivation.

I guess previously pci_pwrctrl_create_devices() would be called during
probe and then again during resume, and we don't want it called during
resume?
