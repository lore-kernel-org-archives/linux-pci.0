Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FB2853E9;
	Tue, 19 May 2026 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180436; cv=none; b=ZENOTmSMmPFHqEiNQR02LZn+ve2V/mr9tGe3wslTVEu3Xssy3lp5oQQlwDt7tA+KcyYTMIc6RnyWj+JJeIsQdF+6gmlwzQgoUA0xiV+1x6rSR7HhGyMQJ+BajVkmwG4tLEqNNTK+LereRg+823tK8fmRkDvZShGjpVw7HtoJH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180436; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss0bBrh/OVxTy9z3s0FtjPx4Tks4S+butMOX6Z+iISstIurZO5GTeVgdTIKHUkILaAOzs2a0+xVhhtqpzNHX8bcMSz06FjRZbAIXJoBLqFMTRX4JsHm7xiHU1Eao5u04/pA8v0x4auC95i/GzjvEgkv/N8Bhuy9siSnCgf3VI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AD4BF68C4E; Tue, 19 May 2026 10:47:09 +0200 (CEST)
Date: Tue, 19 May 2026 10:47:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] nvme-pci: Use pci_suspend_retains_context() API
 during suspend
Message-ID: <20260519084709.GA17226@lst.de>
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com> <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
