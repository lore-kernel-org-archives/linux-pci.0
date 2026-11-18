Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020405;
	b=W5qTgNitr4/iyj+970Ck1H1ApHuO/97FqOZTEQTMHcvH70KA2G0Grm7FvtFYKLMeifl0
	 51eezRCP//JOpQvTxJOCLH1e600VXwD+mn3669TIsH2JJ+80nYaMzNaLs+3jWQbTevoZG
	 3AIYjYio9/1OHz6COIcNEAp/B5BL/UFkdwgJZHjHcJO8fbKNqTZVPTqBohPGhSF28HD6X
	 F8GrJjAPLdXWiMhyFWHHacpUcqyySiayWj/MlbJ8epjyna3MDsEZOogOZ9CAhLTkV6sG1
	 pXB50eVb/S6lBdNZicB3fq/R4hx5MSmhIys8gGDmhrk7qQ0Q9cvQu3GSvvAmB/fu9qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020405;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+oaeBPEfuBmrY3gL6dhCuUvIM7uxAAGKupfULFYYqe8=;
	b=wwWC8c/ZbKHHH2+mVWjGMGHCeZSkvwDirGyDm8IUbO2hjZwIwM5frO4aJcD6LhxF3C9c
	 +qEWkR1UrpUVMqoWF36yDTiWEBm6dMKFwn9WX1TWzaQy41p2p/s6AVLZGPCf4DKs5JR3U
	 pvINLNnLIr6fBMtCygs+Dh0LI9lOIH6EcfaaZ023T6ESMzSu7KdJ+rvqWdmA/npndJc2L
	 ZOx+5B8KUXx1RU8JOiH+Pp++oB4nkTnY9DqvApCCIiNn8d/QOZvY9UHGhc9Jv0wYT/0wK
	 CFzsw+L2UdFs1bUR9saVQGiZG1m4Phn+QdiaQ37M/W7n4Hc0oXZMrbGOF6bfuyQkihA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iH+mmEJD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3375606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iH+mmEJD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A71F000C5;
	Wed, 18 Nov 2026 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020404;
	bh=+oaeBPEfuBmrY3gL6dhCuUvIM7uxAAGKupfULFYYqe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iH+mmEJDFAflm+tg3NGZUPycERCtCXkVtzbEsVPvE5bkAqrX68dCJVdzQMkxhFYlH
	 miR6tLM73gR5sazK6bwPSGodQEsN8RzIsfivUQnqYexx7NJN2X1fXfB9uyO5f735ym
	 CMCWj6ARXNHazDnab+oSWlMlM4x/stEzhb1bdT4ozx7B4Zj8R+6GEhNudRTCGTTTIb
	 gfLjcR5FeR2XZgZn7b7Cv6gV5xEHyP85SaEcltWD1YdeHQjc1hrpPmI/37vQimK4sV
	 0+WobnhNsbHMnZCxILEvuhJMN6AnKeT3f+yd7XXfXFNEkMNjllgwKzCi+c9j/WYmW9
	 p8jcdxyMZdMZA==
Date: Wed, 18 Nov 2026 17:46:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: James Le Cuirot <chewi@gentoo.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: PCI: dw-rockchip: Unable to boot Quartz64 Model B from NVMe
 since reset changes
Message-ID: <av3WcJyt_tRXNj2l@ryzen>
References: <08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org>
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
In-Reply-To: <08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org>

Hello James,

On Wed, Nov 18, 2026 at 04:03:11PM +0000, James Le Cuirot wrote:
> Hello Wilfred,
> 
> Unfortunately, since your commit "PCI: dw-rockchip: Implement
> .reset_root_port() and use for link down" (b376b3ff9cb0527), I have been
> basically unable to boot my Quartz64 Model B from NVMe. Sometimes if I wait
> long enough, it will eventually work, albeit very slowly. If I revert this
> (and 4e9f69d08253) against 7.3.5, then it boots normally. Here is the relevant
> output.

There are some dwc-rockchip fixes queued on the following branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc-rockchip

It would be interesting to see if using this branch makes a differnce.


Kind regards,
Niklas
