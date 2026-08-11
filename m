Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87F445ACE;
	Tue, 11 Aug 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456378; cv=none; b=X/QToWwtCqKZ0LuMXU1C7Qs0YOXJPd7Nz+sIchN392fUdIcRF2hglGeE8XidQcMYFZeUUBx8GAHhRXaK9zQfVecgNrn8bLDbGdtrkJqS1xgamj8Akr5jIQ4jW1TGEEmT4XI0AHWg03PCs6Zu1cjkMRlDy/dtJz43FvnKDHi5voQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456378; c=relaxed/simple;
	bh=xzJCCAoV/N7nZKcJAlZ0qlaQgaXzKmuZe4RYU0tnlPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDtWZ+P8YPW0PgWCpQChAVQUHl2FZNbCzTnf8Bakq/vCXSZyRJljN2wYlG8ryQVbuoyruXHuDZ9EXafgmEu+0F1A1fJyyzEOyn5K40cv7rQ45ZbkN7VogLItdbjxZL6Tvt9277F0tmOG37bmcAHkuWvS5u2PMAyOBxUmeVn05kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph072EQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph072EQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA0C1F00A3A;
	Tue, 11 Aug 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786456369;
	bh=ai1iCuLtWHUDu1L+UQBqF+4g2Y2TKRc7LE849lL12l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ph072EQm8rO1cUuzH41VQgwDhqJ45aKeUknJTFJ5Mr/89DYxfzTA6ZhWp21UOtJy+
	 QAHNLG2s+uPe0KjYBVeI6ro560IgrxaeX+xEArv98UdBgbtdEYZEHWOslsLn11kiRc
	 qmIMdXq2AcAfyxce45MKxKSQQnBJxIHycKpdfmrPMGQBiu9mzP/Sfh0oJnMZdJ+S/D
	 FymTMue1bZN6Wg7DO1qerXA7n382gZ3VzIKF4vKLj64GQgiVI81uyQM4zAN/h1386p
	 44bElrYGKImzBC6lgWp10g2YGx7+sj7V1VPkDLDRICqtA3RvpFM+R4oYSOpeI9XNWg
	 JF7LxLBcy0vfQ==
Date: Tue, 11 Aug 2026 08:52:49 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-rpi-kernel@lists.infradead.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jim Quinlan <jim2101024@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: PCI: Correct white-space style
Message-ID: <178645636779.2073597.16267787912876708944.robh@kernel.org>
References: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801195517.235161-2-krzysztof.kozlowski@oss.qualcomm.com>


On Sat, 01 Aug 2026 21:55:18 +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues, like double space after '=' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml       |  2 +-
>  .../bindings/pci/renesas,pci-rcar-gen2.yaml          |  2 +-
>  .../devicetree/bindings/pci/ti,am65-pci-ep.yaml      |  8 ++++----
>  .../devicetree/bindings/pci/ti,am65-pci-host.yaml    | 12 ++++++------
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

