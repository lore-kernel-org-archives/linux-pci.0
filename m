Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7F37F729;
	Fri, 17 Apr 2026 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776412204; cv=none; b=TZb7j97ozhkQ/sq39WAtVu3zRRMMy+zfR7P2xpE6BRoMLmy9yBe84IJ6bERuoSwU0aUa9ujPRrc+px7jfEakJsCQpcJEZxBCrcXLFE2ISi96qtt2cva+Hvole3/NnBdTXTKDbuG8GqABMIbFmfobrnvAahpGSYGT+mrJ78S01dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776412204; c=relaxed/simple;
	bh=oVwJ37WsLfBvBVidoPjvHj+PbzMcx0J+WOYOZma3nPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HooKnul9zEpaqrtvHHUp0xC83kR4C9DsNbY9ZoUBfTpB4EZQDAf24GJgArJkK9OvaZ3PFGlSv5OaleNJQoCiC4iZh9WmXXWEX2FfsGeA2/JuQn9wV2+jgydjZc28eaNtZrh1JGvnC7I6F3fAuhF5m5i2hWkh7tpT3zTJNrp8TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=i1kQuzSh; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="i1kQuzSh"
Received: from localhost (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1905520db;
	Fri, 17 Apr 2026 10:06:56 +0800 (GMT+08:00)
Date: Fri, 17 Apr 2026 10:06:55 +0800
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH] PCI: Avoid FLR for NVIDIA 5090 GPU
Message-ID: <20260417020655.zun4qjiu3qsn4nnd@yuangap>
References: <20260416070707.3242381-1-yuan.gao@ucloud.cn>
 <20260416173100.GA13378@bhelgaas>
 <20260416223754.GC761338@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416223754.GC761338@nvidia.com>
X-HM-Tid: 0a9d9930f5d70229kunm9e0eb86b13c871
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDS0seVh8fTEhJSU5MH0tOQlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=i1kQuzShgsCW2r3wrSR5EZa+ugiQX1MFNPFq9TaKwZgV3MSinf6P242O2/XhmaYDl9FRN7oVhvo1xAjFvcjZ/lMe6TsPSsqSMQkredhQjffklisHMS47iAV6YQiTyZSX8lXyTbjqbyc9O85SkbTJbFgJQNdg3hMtNEYi+nQdTa4=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=bfqXgrnYB5A/hDRBS5OQqI7LAV26xC87aPYM7fgT1Uk=;
	h=date:mime-version:subject:message-id:from;

On Thu, Apr 16, 2026 at 07:37:54PM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 16, 2026 at 12:31:00PM -0500, Bjorn Helgaas wrote:
> > On Thu, Apr 16, 2026 at 03:07:06PM +0800, yuan.gao wrote:
> > > When passing through the NVIDIA 5090 GPU to a vm, there is a certain
> > > probability of encountering an flr timeout during vm shutdown, which
> > > subsequently leads to a soft lock of the host cpu.
> > 
> > If possible, would like confirmation of device erratum from Nvidia.
> > If there's no known erratum, there might be something wrong in the
> > Linux FLR and wait.
> 
> I asked and was told there is a known device firmware defect that
> causes this.
> 
> So blanket disabling FLR without detecting good and bad FW is not a
> good idea.
> 
> I suggest Yuan try to use an NVIDIA support channel to try to resolve
> the issue with their card..
> 
> Jason
Got it, thanks.

Cheers,
Yuan Gao
