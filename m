Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521473DC4CB;
	Wed, 27 May 2026 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870380; cv=none; b=gaSMUbyN5UwBIR8FSnwuvXioh/A3+trhD5UbQSs6xfuRDuDWaFQjtN6imf471Cs/vzycKHXf+aKduWFWonMhnQW/sOJtAzA2h2AKtOI5LhZQTB6E2wGmZ1YJLSpbRoSzW5XAHO+tEFJrErroklGGCM1QQv83u+0eWbirxzR9JWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870380; c=relaxed/simple;
	bh=3t1g43laU2XxQRnXtS2LrMzBKutN0VDDLr8zIAbHsvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEXqUmsCEch6nxxuzdIbCXQTJSOLdOk8wGgjzeidZK9dfC1DUSYQvdePzQ2MrO9x7b61r/tzCAHnkTT5h00VJfHd6M99NZ+R3UquY3ZUd3syyQKDV7p/5aMiLswYHyd1a4e0KnyqfVcKBrLpz1JcHzfnVHrd2KAAo4o2dLePFOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqSVknSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqSVknSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC61F00A3A;
	Wed, 27 May 2026 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779870379;
	bh=9SMVY2yC57kjDoI0FopT6Z5Y42R0mtmcrjoQPrHDXVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HqSVknSHYVKGxuJQATtoGbmSYlfA8SbG2mBXGm0zOOfIRRQCCtNnkJJmOBzFq4MCR
	 isGBqvWaAORbtGWMdbJ9sjHkjTJ3tGVyONroXEzZnH4OMBFVHDKFT1GgWY+3/L/POM
	 Zoc+kdoP6fyCZJhZb0NWJTn9Y7TuzmYQwpnQgL1iskwOc6EgMsA2FPlO3jNhuhe2lw
	 DIcj29lahPiI1J6FlHQxCEaxkcwpGFrLQleu29zwbnxUxWT4nLetyBCVueo90JNQCS
	 hfTWWrzbrz/EMUsLhUagA235LUFQAIkGrJpobYlz0dC8fDyEkABd0fDy8OD1fGY6zY
	 wrrr9uNRQKqJw==
Date: Wed, 27 May 2026 10:26:13 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	kishon@kernel.org, bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com
Subject: Re: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Message-ID: <sm4ry7tr3quazfr7mfzawn4ssrekqltowxf3567g5fwhoytev5@hvoaa6jo6ube>
References: <20260407124421.282766-1-mani@kernel.org>
 <20260512052928.GB1687877@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512052928.GB1687877@rocinante>

On Tue, May 12, 2026 at 02:34:53PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > These two fixes are flagged by Sashiko during the review of doorbell series:
> > https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp
> > 
> > Manivannan Sadhasivam (2):
> >   PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
> >   PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
> > 
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 15 +++++++++------
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c |  9 +++------
> >  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> Might be out of scope, but since we removed one redundant "db_count"
> variable already, perhaps we could also drop this one, too.  Just to add
> a small clean-up since we are touching this code already...  Thoughts?
> 

Why not? Please send a patch :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்
