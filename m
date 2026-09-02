Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13C45C6F8;
	Wed,  2 Sep 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352103; cv=none; b=EoWqsdBDdCMV3nhAmckaV/5tuzqKRJ7ov1xrdcRPYpAr8cCoeKLwEyABniIGu/Dh5Mx/d/9YL/7GgfuKZlGoywHAa2vaukX2euPfptnP5tg1aF6llTIceplpsWSEc1LaueWpI8Ox0doQCQJKAEj65IlQqEFO4eHx1RsI/s44WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352103; c=relaxed/simple;
	bh=4TQvM/PrMYY60xczAP81RVkG7wNLlagwqrKAcSs+AY4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sl7zDtxPYlljRK+HMq8sGgWHXYTL4GMc9OOZui+eG2KuuzibTYeAusf0l1DJESssseASwWuNcuQYcQJeT3+NPZZjUIb8pJ26rATJ5RDF0MSGYnkcPcyvnqnGqjfm+ju8TvOnX8k/PNJUge7QQskj9PDt9snV5+zdMaYHbI/jk10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53481F000E9;
	Wed,  2 Sep 2026 12:28:18 +0000 (UTC)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Nirmal Patel <nirmal.patel@linux.intel.com>, 
 Jonathan Derrick <jonathan.derrick@linux.dev>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rickey Bartlett <subtexel@gmail.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, 
 Keith Busch <kbusch@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260825043220.9047-1-subtexel@gmail.com>
References: <20260825043220.9047-1-subtexel@gmail.com>
Subject: Re: [PATCH] PCI: vmd: Flush initiator posted writes before
 demuxing interrupts on Meteor Lake
Message-Id: <178835209832.79920.2886314748680261549.b4-ty@b4>
Date: Wed, 02 Sep 2026 14:28:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 24 Aug 2026 21:32:20 -0700, Rickey Bartlett wrote:
> Meteor Lake VMD (8086:7d0b) is affected by erratum MTL016: the VMD can
> signal its MSI before the posted writes carrying a child device's DMA
> data have landed in memory. vmd_irq() then demuxes to the child handler
> while the child's completion queue is not yet coherent, so the handler
> observes no completion and returns without consuming it. The I/O is
> only recovered when the block layer timeout expires and polls the queue:
> 
> [...]

Applied, thanks!

[1/1] PCI: vmd: Flush initiator posted writes before demuxing interrupts on Meteor Lake
      commit: 95ac22dd4bf13373f90bb6d51bcd1fd1d8f5db54

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


