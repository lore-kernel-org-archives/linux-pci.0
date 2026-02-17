Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9031A800;
	Tue, 17 Feb 2026 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326694; cv=none; b=DwO/yFyXBh+A++1/csOFa6yx1hglP73GigUJdTB3jYhf3H8mc26RIVnr8lKAByOI9sqxqO5syzFAeNRLuu+sXTmkignX6l8V38d+rRrDb8LQiK9EMwuXxjNnegrsrYpr9HwquuW7t48lEG9M8R42UXOK6jvali8WObcJdx/OV7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326694; c=relaxed/simple;
	bh=ksGhkyEQ/4iARM3Z/FpKDgBdKFLwJoclNfAttGf4/RI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpb2meNkX+7LCgI5Ey9DTidHQKLKn4xqz7HmdhWhaYj81mJ6hmcAZzzg1sOUOa4HK5WxhRMq8DjSDCSCIk8xu2+2+WqYngtMWOJ1mA98yPis+sXyZjrcVTtluRAJnFc+uane6nmHqmhmEE2y09o4u1xHZpBfK36uzk+yVhMIeYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFxO1fjQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFxO1fjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F64C4CEF7;
	Tue, 17 Feb 2026 11:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771326693;
	bh=ksGhkyEQ/4iARM3Z/FpKDgBdKFLwJoclNfAttGf4/RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFxO1fjQ7OEepB9DUlC5a1figPaxvzHShpc0qF/sX1jm2mXLAFCJxww+jcNi8Ybv3
	 VE3IY331gCqbbPSl2oUnlQKxdaj6dxxsF2PBscnThEnYAIupHT7rshuJ/1mvnnAn5c
	 4ecjxSTfXCydWxcwdxkZ4F90TosVqjOpSSx6LeDv50P67wFVic67xxMek1yDxmmBXv
	 7mF4Zy7jejnzmEgGxSXyf3azDD/vb3rQ+EgDPSg7pZvhB7DZ9uz0DfG4oXGcjFUm2t
	 KQT5zJi3Wpbd6MR3LsubVeqBla7cZVzx6oLbqVsQfm6eZI8Rhs/DtdpxRlx0UOae4H
	 /nc0wwN8nw9xQ==
Date: Tue, 17 Feb 2026 12:11:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v2 2/3] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <aZRM4ICyyuAe3Gix@ryzen>
References: <20260217063856.3759713-1-den@valinux.co.jp>
 <20260217063856.3759713-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217063856.3759713-3-den@valinux.co.jp>

On Tue, Feb 17, 2026 at 03:38:55PM +0900, Koichiro Den wrote:
> pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> doorbell virq, which can trigger "Trying to free already-free IRQ"
> warnings when the IRQ was never requested or when request_threaded_irq()
> failed.
> 
> Move free_irq() out of pci_epf_test_doorbell_cleanup() and invoke it
> only after a successful request, so that free_irq() is not called for
> an unrequested IRQ.
> 
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
