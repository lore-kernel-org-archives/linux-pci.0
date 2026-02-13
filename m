Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E623AB9D;
	Fri, 13 Feb 2026 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014806; cv=none; b=tt66gx9i4vehTreF9fCI6alnKwIaMKPkBNFvLHihaeY30BfVpnbZkCWRyH3SG6hCyuh0O+oiOEQQZd9QXKPz1nExJjc7f78lq7ecufBsDxwLc3NlKkwJJeAJbsMrpcGk9uBIZs2wOTnLNAgydPh65SRZrRG6jdBRw2m0oF5nn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014806; c=relaxed/simple;
	bh=pmsGgNGAlAB0kNHZRIueghS0hE9sslQs2cfoHwsmqb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay8htakWVYOB4RmxtNEV/6pCcZoExvN98sZY40YwALPQngToINkOU9C70E0r55xBs9+ScmHtGGTTO89oNWIg2gyMTyIfZoOtRueBfeDVgyPxM5FErkWVnKk631xRjuDxlm6JG/dsW0eXq+3F90s/HgyVLgTkrFXirbTfGHzu4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lojyy4b+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lojyy4b+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37491C116C6;
	Fri, 13 Feb 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014805;
	bh=pmsGgNGAlAB0kNHZRIueghS0hE9sslQs2cfoHwsmqb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lojyy4b+l7aLIqPeIavbcrCLV0xvpgA4q69R1eG+or5truDhSFf7hdE4WemB5StE1
	 yCSWEiqGt1tlVDOL6E5zZOXl6ki4A9c2pdHh86HUy9QEJ3TKzx9UWUudJO29T4vzOX
	 b6iGbIVP/+NoIm68si3OZYh3ITJzrbetPHMnKKTQSQH3U49HhGFIR9wajWPxQT5DPs
	 ekNrs/0ga5pLaixiSRrnybU+AF2v0LhX6qYldSmXMZO9vLc5lMNqz+T/jVi0L1lFz+
	 Tl7IWMbPKRfrmi0SECKWoXPc5r35/ApxnOR6x2AyMfYjrUkzSe1GupQtwHFltJ0oPL
	 6zPYKq3/0qBug==
Date: Fri, 13 Feb 2026 21:33:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, s-vadapalli@ti.com,
	danishanwar@ti.com, srk@ti.com
Subject: Re: [RFC PATCH 1/4] PCI: Add documentation for DOE endpoint support
Message-ID: <aY-KkFE9Ya2ZF8ED@fedora>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-2-a-garg7@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213123603.420941-2-a-garg7@ti.com>

On Fri, Feb 13, 2026 at 06:06:00PM +0530, Aksh Garg wrote:
> From: Aksh Garg <a-garg7@ti.com>
> 
> Document the architecture and implementation details for the Data Object
> Exchange (DOE) framework for PCIe Endpoint devices.
> 
> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>
> ---

Usually documentation is added as the final patch in a series.

I think this patch should just be squashed with patch 4/4, and the
squashed patch then being the final patch in the series - patch 3/3.


Kind regards,
Niklas
