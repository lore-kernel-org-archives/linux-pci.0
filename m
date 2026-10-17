Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807DA26158B;
	Sat, 17 Oct 2026 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792228687; cv=none; b=XSmeXfj0z0tM217PSp6JspbIinbgp1soXg/Rz6njpRLteBD3OCeX/ZJwKFVs7bhom2MQkQBj/t4ulF+BfYc5+LEM0E10N7GlNzjnv3jv2x4x19mR4BZ6BAfm4jP2TWXZyScG65GQ0B/DzNAf/b5164zJNkC9umL7f2yRdSvz3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792228687; c=relaxed/simple;
	bh=wGLIXMqMIit79JY4dxkVlmCkSwBSpHfgcR0Lu7rjGCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdUlAlsj2gsivXVlnMWBwQ0/POyWwrkLJr7WhtoYuWjFRizRfFO7bqlhHRwBwab/n9IMqTHGPhCP2v2M1Luiq2U0zWq30Vl7ii0JR2EsbXfiwlhcVATKrEsNTgV44WWQiCaqEV9Emb5jfMFSkmipxlkNjtZg2HlEti6Jd2oqm6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J27lFWNz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J27lFWNz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A511F000C4;
	Sat, 17 Oct 2026 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792228686;
	bh=u3cxCmvLqEJ04VCLvO1jqt58PxybhgR7pDgPLBOcQ6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J27lFWNzBbjJa8Qqgnf9hfEIKBHhhNmdcBHjXDjYksAzckkKPorOjpdNcuIYjlRTX
	 jah53Obp8ls6ObyikI6dmioOTlu4snV0PrzgpN9ljoHbJXJMZDpQAxJ6d2fW7mpq0r
	 w2XU3Z+rGqZOaNUdYB3IR3+vwFqrUqcjzMPSF3gq/FsNM1yCV65tMkrNiY53AdMpM+
	 V+Ld931CTsJJ7ryHGsyFmKUT5xeM2QW96NllwlCSoxGYYISucc4wxmSSadhWgx01qR
	 VJnrQil9JoC1ZraApwvX8vanoaE9ZIBCkAiaSG24btct8uUuDHC3b4oFhkalukmi3t
	 zKZKSs/x2ZACw==
Date: Sat, 17 Oct 2026 11:17:52 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: tegra194: Avoid full Endpoint reinit on PERST#
Message-ID: <6b4ffagwiepvhctdffzulxqvkie7rpk6eq47ssel4l6ilrkazr@j76sfnd3eush>
References: <20260923072554.1141864-1-mmaddireddy@nvidia.com>
 <20260923072554.1141864-3-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260923072554.1141864-3-mmaddireddy@nvidia.com>

On Wed, Sep 23, 2026 at 12:55:53PM +0530, Manikanta Maddireddy wrote:
> Tegra194 and Tegra234 Endpoint mode receive PERST# as a fundamental
> reset. Controller registers are lost across that reset, but DWC
> Endpoint resources live for the controller lifetime.
> 

What do you mean by 'DWC Endpoint resources are live for controller lifetime'?
What resources you mean?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
