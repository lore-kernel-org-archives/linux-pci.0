Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097C381EA8;
	Mon,  3 Aug 2026 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773480; cv=none; b=Gs++XKzzQy8DaIoPrx2D5QtBnuaEVHvwZmUnCAOb9VHGa4MZVdHugTEWm2rvSeKhuyap31OJQ9kdl8Q5k2u3wekXDpt5D5rsn+2Ff41FtmrUk/Q+snq/4+qIB+xcMvERWZkckcDnSnOUh8KSHWEPxj93wcGOJGeQLeC2Mt/VX6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773480; c=relaxed/simple;
	bh=6T5ASjFaFFeo+RF49QUk+cIewYeytNLX1wKE5pcHaiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rpu7to2w8SEl2wJBQYox0ACnc+P87J2+5HkVmOPN9QjBTPn3BlBAjdE6o4NwTp6tkQ4wsA1TCtXCYOFyvvXOI2BQtSL+ee986MdddnTFeKU0okaZoWtEc1IGkXl0rywoAfclhpAvwg+pH9yxOTPqiw1sJa0EpnfatcvQZTc4r7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4AC1F00A3D;
	Mon,  3 Aug 2026 16:11:14 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: jim2101024@gmail.com, florian.fainelli@broadcom.com, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
 bhelgaas@google.com, Sangwoo Han <sangwoo.han@nearthlab.com>
Cc: bcm-kernel-feedback-list@broadcom.com, robh@kernel.org, 
 linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260730072215.2090974-1-sangwoo.han@nearthlab.com>
References: <20260730072215.2090974-1-sangwoo.han@nearthlab.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
Message-Id: <178577347444.25420.9482634841308840205.b4-ty@b4>
Date: Mon, 03 Aug 2026 18:11:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Thu, 30 Jul 2026 16:22:15 +0900, Sangwoo Han wrote:
> brcm_msi_alloc() reserves a naturally aligned power-of-two region with
> bitmap_find_free_region(order_base_2(nr_irqs)), but the irqdomain core
> releases the vectors of a block one at a time:
> 
>   /* irq_domain_free_irqs_hierarchy() */
>   for (i = 0; i < nr_irqs; i++)
>           if (irq_domain_get_irq_data(domain, irq_base + i))
>                   domain->ops->free(domain, irq_base + i, 1);
> 
> [...]

Applied, thanks!

[1/1] PCI: brcmstb: Reserve only the MSI vectors that are handed out
      commit: 92bf60fbb80f94c1b0fc24c7ff67d7aee936a58c

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


