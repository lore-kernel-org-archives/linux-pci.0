Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DB315793;
	Fri, 20 Feb 2026 07:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771572469; cv=none; b=UO3xVjvXuowNiGeeRmRi4+3wRkdfcJwRzWN/sRneYXHlYyCjLubAT7Pe2qQ3aM17mwkXgiNeXYDbasW+gc7njbzxZEayljXywy6t8oNVBPSC+x9L5kP2aK0vlv8IwUofCARCEOiSDeN4L7T1eYlBNVnGrP95sYGCgMtamxdSJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771572469; c=relaxed/simple;
	bh=b5pyA+0WzmQOchcp2iQ8hOm0EPX+hYJEW7UxUeXuzV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPxhtM/R0TCBpxTpGgbMPE/r5blWK0LEZBwj6NKgPvnod/GKfNwP/lQRZtDoeO3sTNFDM3ohQ6qbV6YXC/nMmqK+FRayvtYA5uFO2Ombpbgf3ZzaPoAwO3DZE/iGLABS2xdNENB084qeDAdIi86uvKvhOQPCX+CB/5L/mBWQBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbTCxayO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbTCxayO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39A7C116C6;
	Fri, 20 Feb 2026 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771572468;
	bh=b5pyA+0WzmQOchcp2iQ8hOm0EPX+hYJEW7UxUeXuzV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbTCxayO3rKoJGWD3htKNb0EehrnXuiY7relCSPDnIlneShgRjSHosHQTtuNGa+N4
	 Z8s7gFi4SPSi9uSq5Fbbmj48JWE/swDb89aYtj+dCAHip1FgCXlLPbtPPcSzclF4zi
	 FOOlYb40d8yeDfjK2CsCeeeIWh7Uas4yWsKFoIUZK2C/Y6dIvcxtWHmBbp1FBDxLEG
	 N6pPkOsIR9AR/DLk4UGGht4+8rHt8je4lQdFWUfQGfQcCwX+hG/N8ZgegLvGdU4Tze
	 mSHAPSI+zBdpkGmEustVyuAHC5wlu2k+fiM8VE7lzACanuib7+N/9+nnyyxv/W4rb2
	 iOXqx6gTgEbgg==
Date: Fri, 20 Feb 2026 08:27:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be, krzk+dt@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org, magnus.damm@gmail.com, 
	biju.das.jz@bp.renesas.com, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com, 
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v6 06/16] dt-bindings: PCI: renesas,r9a08g045s33-pcie:
 Fix naming properties
Message-ID: <20260220-proud-octopus-of-assurance-0fd60a@quoll>
References: <20260219223542.6364-1-john.madieu.xa@bp.renesas.com>
 <20260219223542.6364-7-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219223542.6364-7-john.madieu.xa@bp.renesas.com>

On Thu, Feb 19, 2026 at 11:35:32PM +0100, John Madieu wrote:
> Fix a typo in interrupt-names: "ser_cor" should be "serr_cor" (System
> Error Correctable).
> 
> Also convert interrupt-names, clock-names, and reset-names properties
> from "description" to "const" to enable proper validation with
> dtbs_check.
> 
> Fixes: e7534e790557 ("dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC")

You have checkpatch warning for the tag.

Best regards,
Krzysztof

