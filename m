Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906209;
	b=BWxJmhYg3aGemKkFQk+hf/zERYcljsE4r93q4ycf2KfHouw+wy7nHJo6fRAMdFknVVqI
	 enC5tbo+byk8hb91/czlZWlSKk642CmaDDKWOHPfG1/m/EuTLP2gsbODO2gNf692j4Yto
	 dBLfRcgg//IjWiJWcX4P9uLgzVzxOTf9p5kn4+RaA3waQd3bTtH4L6efbO0I/HYIXioov
	 Kcn6JVkwo1sqUc49Ai3m5n33MiDbRdSk/OkMKK8ZzqllrUQPMk9JD9e+AceHQl527M0VJ
	 aePKkMRucvrpPBsSQ6Oal/FWHv/7vEpA3FaE7uUAcRUfTlZdJyR1EDcZPLtaC7hCSOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906209;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=e0BWnhNl7a2pPi8xA+Q0/ZqC7NPGJrybeKR7ZFEdk48=;
	b=gZlZ+nC/xkEZF3KPnlTHLpaFQmKkU1YDirUU2VfwAufIFhyyCVVfOEEQLHnVodtqAKHu
	 4fdb227G9MD+Qy0tMVhILN5a0ShdVkbdErTfST2ProGIherEpEdNllEebiS2udlUN2OA/
	 y1RVZZ+1LVx+CrpbYF2za5lajD7iWc/GE7o3pkJUDO0ed749xlp4cy3RSYcENSsyoV4Kq
	 XF48wuCy5N9j71UcZ/AzwkR4j+XarCMa2gU2cR/xojFP96kE+VU3iZbrd71LuypZGpkYX
	 NHnpYGvC5Un+MLHGggSN0nygEoe9Se48SZsYWvdhIM+qn1wbDsNrcbFsv6djrT0SGIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg2ZBkmh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1C606A31B;
	Thu,  5 Nov 2026 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lg2ZBkmh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25801F000C1;
	Thu,  5 Nov 2026 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906208;
	bh=e0BWnhNl7a2pPi8xA+Q0/ZqC7NPGJrybeKR7ZFEdk48=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Lg2ZBkmhzpeqVo2McMUjpqVm89GQ8M7Aq8KwyCz6Yd2A6/UoE7uTkfLSLvRau4FrE
	 No7yRMoSqx8F0kNm/8n/roLaHFAlk2fr5Vr3BVTSj13DvKGMMga+6xQHXAWIH318eB
	 0T+sKmIpPN0YPtZF2TsKfDlfWD439i72XmKxR/0rIxl5JKVqUkk6j5EPB9yf1rlg6N
	 tNOCdSSYBkld2m8IBrCdUEEYr6/1bgHb5ZF3IAKjc8nUM5S6gIH3RoGEfpNuoMcxAn
	 DTWaxiZyINtJr4o2bqM1Jbk1s4qn4YadIEs/aXd+H4ovaI+aUpB3mFRxLG59PWuFvZ
	 h9SllyPeHnUrg==
Date: Thu, 5 Nov 2026 13:16:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Encrow Thorne <encrow.thorne@linux.spacemit.com>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yixun Lan <dlan@kernel.org>, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: spacemit: Ignore link partner PERST on K1
Message-ID: <20261105191646.GA1549319@bhelgaas>
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
In-Reply-To: <DMMXR8IGD585.1QXMWPOMI19UL@linux.spacemit.com>

On Thu, Nov 05, 2026 at 10:53:05AM +0800, Encrow Thorne wrote:
> On Thu Sep 24, 2026 at 10:23 AM CST, Troy Mitchell wrote:
> > On Thu Sep 24, 2026 at 10:04 AM +08, Encrow Thorne wrote:
> >> The K1 PCIe controller and PHY are affected by the PERST signal from
> >> the link partner during initialization. With some devices connected,
> >> this can prevent host initialization from progressing and cause the
> >> system to hang while probing the PCIe controller.
> >>
> >> Set PCIE_IGNORE_PERSTN before accessing the DBI registers. When set,
> >> this bit makes both the PCIe controller and PHY ignore the PERST
> >> signal from the link partner.
> >>
> >> This allows host initialization to complete without being affected by
> >> the link partner's PERST state.
> >>
> >> Signed-off-by: Encrow Thorne <encrow.thorne@linux.spacemit.com>
> > Fix tag and reported-by tag [1]?
> >
> > Link: https://lore.kernel.org/all/20260825052249.66921-1-bbanelli@gmail.com/ [1]
> 
> Thanks, I will add it in the next version.

If you haven't posted another version yet, s/PERST/PERST#/ in subject,
commit log, and comment to match spec usage.
