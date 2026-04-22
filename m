Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C2A30F7F2;
	Wed, 22 Apr 2026 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839607; cv=none; b=AfgxrwFAa+qWinG1uH+UB5jcXXZ2XedGhkAMgX7l7c9jNWT1qy89Yoz5QVbSpKyxfeke/DPSj6webkLng+dpQIuVJM3Vr0V0jgvLbHRLfCgnIWQbm2jX/4booSSA6TDiTyvMTQM8sivBzdFkpEwkLdZzridLloxj0laNzDE7fpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839607; c=relaxed/simple;
	bh=Bk4eh4+y88E1ppkNmoeItMrM9HzeM1GmmNSolWA9pcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/+Flh4ZjMGk/MmXUJnmBmdQ0lAdPk4fn+kU/GuBWIQcK60sC6Vey/yRpt9fz2f/HWXihplnxVDlz7CeeOSNd9v8jQL4R4XwgsiRAPnAdWsk4H+QXKrecdeLzrtnCEla1PCDwBp/93v2+RW3nfGFIMVnt/Ir6ioZxiCOeEUyyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1038568D09; Wed, 22 Apr 2026 08:33:21 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:33:21 +0200
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
Subject: Re: [PATCH 4/4] nvme-pci: Use
 pci_dev_suspend_retention_supported() API during suspend
Message-ID: <20260422063321.GA6360@lst.de>
References: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com> <20260414-l1ss-fix-v1-4-adbb4555b5ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-l1ss-fix-v1-4-adbb4555b5ab@oss.qualcomm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

No matter what name we end up with for the helper, this looks like
the right solution, thanks!

