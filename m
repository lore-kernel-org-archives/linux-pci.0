Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9764307AE3
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530017; cv=none; b=J6wU+cJFwMLkOXvR8TIzmLqcYYsgsa/ZPJmjgEbUyC0VEY8DcFtONPDx3vRukyZbn7W81msSE/BzERGdPQV9k60FJzcs8lUyd1cBV5RK7EpeCt9l+Xjnt0fJDMxGNnsKWtteJGodqSOlDiSwB3oCTVTHelKBYi/K3Rsc2k4kiLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530017; c=relaxed/simple;
	bh=Ed38Dl8CI/Hm8sRCM7qr4Vg5xUwP5AbrQhaovrDFylE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5xW+gEH18sSwNbq6GwVRIr3e2VMqjxsqwFf8sqvWNZoMee9Xm9rqfQO3Gp7ie0piymecgT+iE1gT8IplM45eeFwkqTPLeATyjdRDjbTOq///WLYPKFtjeuz43OvSDFjbx4AeuBDEsxvHpLVqtOiJ0dA7AIoyAKITvZH6QH0kqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrC9EgHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrC9EgHF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B927C116C6;
	Tue, 27 Jan 2026 16:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530017;
	bh=Ed38Dl8CI/Hm8sRCM7qr4Vg5xUwP5AbrQhaovrDFylE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrC9EgHFRgNeLJwoXqJYl3fSEv7QwOiam/ZDzDPjoaDSpqzrVSQRDKMtnOm6V2dJ6
	 SIDTE3zprhQCOXpDfjsfht41dAiXH86lfC9SgIgak4ZnJYvexPrSEqqGwpSzldxNNN
	 qHd9lmE97ln+Ln/l6MXxq39CDaANhmOlwgfhzW0i31NHisRMTZz3NQI8Uy35PkHz8h
	 QcgHcXf5Nu5AW9OHcgVMpsWi8IAE4O5Xoc8KR0boFbtIgJdbEuYz5gzbHyY7DIW8qZ
	 ehbkdlOUEiohFIojUR/67qdlC+xZWuxxRInNsObdmU8aTmhaCEfyFUftVTA+2y05nr
	 tIiy4wMHC/iFQ==
Date: Tue, 27 Jan 2026 09:06:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Qinyun Tan <qinyuntan@linux.alibaba.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Message-ID: <aXjin6e18UxcTpQz@kbusch-mbp>
References: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
 <20260127084807.GA342@lst.de>
 <20260127143143.GW13967@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127143143.GW13967@unreal>

On Tue, Jan 27, 2026 at 04:31:43PM +0200, Leon Romanovsky wrote:
> On Tue, Jan 27, 2026 at 09:48:07AM +0100, Christoph Hellwig wrote:
> > On Tue, Jan 27, 2026 at 03:33:44PM +0800, Qinyun Tan wrote:
> > > The NVMe PCI driver exports the sriov_configure callback via
> > > pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
> > > VFs through sysfs. However, when the PF driver is unbound, the driver
> > > does not disable SR-IOV, leaving VFs orphaned in the system.
> > 
> > That sounds dangerous.
> 
> It is not. In a real SR-IOV device, VFs are created by the hardware and
> are independent of their PF. There are several use cases where an
> operator unbinds the PF and reuses it to improve overall device
> utilization.

If this is expected, should the warn message "driver left SR-IOV enabled
after remove" be downgraded to 'info' level?
