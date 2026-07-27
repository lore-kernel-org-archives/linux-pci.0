Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB03FCB13;
	Mon, 27 Jul 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169794; cv=none; b=tHDefYfX8HMcNI226A97KpAPom+DR6TcMy/KhsdHcKBvLqMYq2yU0jYCL/1ouPo1IQXzg+KzzP1s0u3aAhtgTWSqZFxbM4648RGYKoUFDWASCjgRbi5mUrHyerrWJewphW0ru9BDhmAnLD8n+U9OWvTPC9CDmbI2Nh8qhaUn3uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169794; c=relaxed/simple;
	bh=s233RDk5EXqyOEM0EHsCtOIW8YHDDj09r3x6gmh+2Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qXpxTCS746gjXifzokuMkFbm45v4zGFSP8XldIAAno/++URliqjlLp1+hCimkMMv6D89hQARSh7AfXXdfyVKW9JNJKsSNJoF/E03elJqFW8110jxW/M4DgXlNrmJraS2DS6ktmybjGE6pgAbXYAQbMtRNEhdA/B26XcUVbU/YWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrg4BVIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrg4BVIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347221F00A3A;
	Mon, 27 Jul 2026 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169793;
	bh=L47/XAVy6uGpTmEx28snyF02XsTSIsQGhvMg3tgmCcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=mrg4BVIgEP4iiig5dpMITrjDV9g1bDxSlrBj7LOD0uTDW48AWiOtqhEeNokwSCSMJ
	 aBVFrLkyX1A7q450oKojMI5AmKv5rOhV5RK1nBty1Ev7jtOKBXACdY8qJBr22mudP2
	 S47ewoHs2JVgWaFJMo9VRbgUndF4JlnA73Bf2frGvBJnOdUt8sC4jQF6bMFWmgUivN
	 X8TrknYj5yx8nPYboxmSTQBuE0XX3t/xPVEVhyZWdjpcWYXNbzJGvZmUOkdz8lrBWX
	 eQgLPxZrWaBO/o16NJoxnj72UAX7YgRkbbLyMEInrOr+ijNFIxd0P7kx/hl0jXInlA
	 dJVNLJ23wHXJg==
Date: Mon, 27 Jul 2026 11:29:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Elder <elder@riscstar.com>
Subject: Re: [PATCH 0/6] PCI/pwrctrl: tc9563: Several fixes and improvements
Message-ID: <20260727162951.GA1230192@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>

On Sat, Jul 25, 2026 at 10:59:12AM +0200, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series contains several fixes and improvements for the TC9563 Pwrctrl
> driver and the switch binding. Most of the fixes are related to ensuring
> correctness in parsing the DT properties for the switch ports and the
> integrated Endpoint.
> 
> More details are in the individual patches.
> 
> Testing
> =======
> 
> This series was validated on the RB3Gen2 board.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (6):
>       dt-bindings: PCI: toshiba,tc9563: Restrict Tx Amplitude, DFE and N_FTS to USP, DSP1 and DSP2
>       PCI/pwrctrl: tc9563: Fix parsing the integrated Ethernet MAC Endpoint node
>       PCI/pwrctrl: tc9563: Power off only the external ports in tc9563_pwrctrl_disable_port()
>       PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning for DSP3
>       PCI/pwrctrl: tc9563: Rename DSP3 to VDSP
>       PCI/pwrctrl: tc9563: Move Integrated MAC Endpoint out of 'tc9563_pwrctrl_ports' enum
> 
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    |  21 +++-
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c           | 129 ++++++++++++++-------
>  2 files changed, 104 insertions(+), 46 deletions(-)

Added to pci/pwrctrl for v7.3, thanks!

Happy to revise if you respond to any of Alex's comments.
