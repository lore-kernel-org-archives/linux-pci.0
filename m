Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730636;
	b=bKFt03F/HS6lm3V2XMzdVP8UF6j5eR3d26o4D6bj2saTFiXoc4Eb66M0q9zHvs9/yFnj
	 p0QvwYhPvbzE+JiL+u90tPpeo1S66E4WTTOadwsb8cO8BNSm3JYuFY/Er37vzgZtbqN6A
	 9nF0wHhqkvJlluwdRN8NupSDQ22nBXMZBlMNYAQsAcAU5xTF/sj8Y1mIpU+RauUkMNA2C
	 HxRcBdxicpmNTh9EUlsxNiQkSI12QZcCMuNWo+7G41YxZ4yrbKTva0P9N1aZPmR0k42TS
	 hc1gIQAzjkVUAWjGnYYQXMaN42J75ftyohsBbxmVSBjB5QDPoWmp/dUG2Vqeo4vbeOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730636;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xyZd5fJSWNeJvwUmXzuQ0GHIpaYBMS6GdWZ4/zcfiQA=;
	b=XNu9hSa7rjFTqrLmhriSXArngQPyF/0O6QS9vCvfW8BypRSgQjPzYsm08pQWql3SNUmX
	 AmFF9GpvgulyLW2t76jkLKSqDmgQweEH/HE0gahlgiqUsZkgG2QBnq5WGmQrQ7OMlkwqK
	 wr7AikwN+5qwfWAimB/dDJAvT8W6vAw7PhwAFKuXRFVs6N3liUQBh1LWZJKiNYFqoIGKx
	 O9MbuWo7hFHsx20tbpmBm3p41Oj30znFBNDBI7KovgUCh5UzJ7yKgxXSlrn8Pkg7fqY5Q
	 uHyN+ftwgiMPhELm2x2J5YhK+zc2upKK95uk5ttBRoreC0F2/HeMsOj/VjtsxCga9xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyZ4iXWo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B4A606A331;
	Tue,  3 Nov 2026 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyZ4iXWo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931611F000C1;
	Tue,  3 Nov 2026 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793730635;
	bh=xyZd5fJSWNeJvwUmXzuQ0GHIpaYBMS6GdWZ4/zcfiQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=nyZ4iXWo7ItQIMot3Fcje8Mx4JNu5wmFsF4Qfq9pvmcpS2e7nxl/H+lIoC91L+Bgp
	 igYx01arED9Av3eTyMh6m1qa7GsDzVm3QYTB3CBF3ewuG4g1lYFTOO/8mck7t8C8I7
	 kBihsJVvlrjoZgwlD6M2B1nMtAsNEFSMZpG1//GZj9v+RUXHiUD9tidWW74JX3sg3M
	 GqfzVGb5dO40iFDA7F71I8TPWD75rlGL0BI3OaqASybKKq17ZBBIntB/6MG3KzMFbo
	 ZBe0/XWTHmrZDWcHA8DqA98jDF66cQkBNS2V8D3T0CcvU1pw4wP57ItMoYkb5e1f+9
	 J4guDuk3p5+ew==
Date: Tue, 3 Nov 2026 12:30:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>
Subject: Re: [PATCH 0/2] More switchtec device IDs
Message-ID: <20261103183034.GA1123679@bhelgaas>
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
In-Reply-To: <20261103170033.471034-1-logang@deltatee.com>

On Tue, Nov 03, 2026 at 11:00:31AM -0600, Logan Gunthorpe wrote:
> These patches add some missing device IDs to the PCI quirk and the
> dmaengine driver. The same device ID was added to the main PCI driver
> back in commit 5e6c21c56998 ("PCI: switchtec: Add Gen6 Device IDs").
> 
> As, like last time, these patches touch both the PCI and
> the dmaengine tree so I'll humbly suggest that they
> go through the PCI tree again.
> 
> Thanks,
> 
> Logan
> 
> --
> 
> Logan Gunthorpe (2):
>   dmaengine: switchtec-dma: Add Gen6 secure device IDs
>   PCI: switchtec: Add Gen6 secure switches to NTB DMA alias quirk
> 
>  drivers/dma/switchtec_dma.c | 4 ++++
>  drivers/pci/quirks.c        | 4 ++++
>  2 files changed, 8 insertions(+)

Applied to pci/switchtec for v7.5, thanks!
