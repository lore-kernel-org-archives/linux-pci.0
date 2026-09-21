Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544B44A725;
	Mon, 21 Sep 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977836; cv=none; b=LVhf0bWFefP1Mi71fBRr2LdlMznZkFUq5KpCgM3IVJWns1gQpJ+wEdVL4m5+ULaJ6VYXZ/sHm88oubvWTORrisfp1ErkzG1i7bQtU0xd3Ru2nx2EcbLHeLsw21sDG31OcwShK46t3HhkqItwxEtyH6rGe1c4ElkZPv4EI6/3hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977836; c=relaxed/simple;
	bh=EW74lXzDEC4ksALgbe1BO7LXRzfjlQY1fOBlGDazMQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5TxROVponagOTIU3mU1oIS61Dg37rd5VmQLVutDeKHBKhEdOGJWJFpUPKfSrZ1wy+Ta+jhdz9D8EwRehhzgmRK2ZMCgwbA9A99U8lR6yvIVj0TEc+3JmcJGFTS6H0HLEIXS6uJBcvadh8HCQtSqE6AEm9x6R8HLMFPZfzh8zvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyvcyeVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyvcyeVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828281F000FF;
	Mon, 21 Sep 2026 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977835;
	bh=KsQ90edjAsrAFhgm0/rE7PgtI+eNbFXo/5sMFQhaex8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iyvcyeVtgEssGNPqi5AqV9YcLohVP5PW4hfA+04vJnkWBxNwXDtjUJuJzu8N5gZtG
	 onJzbXPynz2tvKP4yxiUjnAax/oTMIIEYHAYckQc94cCQ/Pj91ZbDnQR86AmYKBwcy
	 m7jrqwIbDIo6FuCVYmsgJJPpPSiTibcDPAy/Io7lL3PovVQ832ShqgYRG5/4UNc1lK
	 NWXYRHjSsQZLnZoQBeI7+LncGpxLQx7P4RaOZORt68k6IDd9QSlIgP99CL97QF1+jr
	 Z2Pbl7GS4U5NdJ9ux9VO8pz0kpGxcA7tPE25y+v0o8Aso4rXjMDGW7FO1dCozHbNya
	 uhMthxWfECFzQ==
Date: Mon, 21 Sep 2026 10:03:46 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Encrow Thorne <encrow.thorne@linux.spacemit.com>
Cc: Bruno Banelli <bbanelli@gmail.com>, linux-pci@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Alex Elder <elder@riscstar.com>, 
	Yixun Lan <dlan@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczynski <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Uwe Kleine-Koenig <u.kleine-koenig@baylibre.com>, Javier Martinez Canillas <javierm@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [BUG] PCI: spacemit-k1: port C probe hard-hangs a CPU with one
 endpoint on Milk-V Jupiter
Message-ID: <xuafb5qshj6rowe3v6sxyfvtemy4wg2ttqs7lcwu3txu2mpyzm@fr72njh6zgvi>
References: <20260825052249.66921-1-bbanelli@gmail.com>
 <DLKRGJBNFVQO.15WZ2SXQLOY0T@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DLKRGJBNFVQO.15WZ2SXQLOY0T@linux.spacemit.com>

On Mon, Sep 21, 2026 at 01:55:42PM +0800, Encrow Thorne wrote:

[...]

> Hi Bruno,
> 
> The issue was caused by a missing hardware configuration in the K1 PCIe
> initialization.
> 
> The PMU PCIE_CONTROL_LOGIC register contains an IGNORE_PERSTN bit (BIT(2)).
> The hardware manual describes it as follows:
> 
> “When set to 1, the PCIe controller and PHY ignore the PERSTN signal from
> the link partner in both RC and EP modes.”
> 
> This bit was not configured during RC initialization. As a result, the
> controller and PHY could still be affected by the PERSTN input during the
> early DBI accesses. With the Intel I225-V installed, the first DBI access
> could remain pending and hang the CPU.
> 

What does this 'PERSTN' bit controls? PERST# or something else? PERST# is
controlled only by the Root Complex btw. Also, why does this missing register
configuration only affecting Intel I225-V endpoint and not others?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
