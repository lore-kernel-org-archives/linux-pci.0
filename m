Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB864AF9DD
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197502; cv=none; b=QcdIne1gEHiHg6fhVRDFqYRumnElPdJesSgAZ2J8evQ/0NtYT9dSJmcItJEOE/64E6YOgC4ATd0LDnWeuPHbCiKrFIZZD0e2bmaHjliiC1wUXWzjWNenCCa90wbj6FzXaxrBUkgyX050lHXdn9lgX146SIAQnvaiUCnv5PpMY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197502; c=relaxed/simple;
	bh=YeIS7W7sIDJGaXuQCWGL0r5tSa6EA5tjsPC0OZ6rGhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hqNpL0GZRUeQVfxx9eiF6tlI235EqRcu+6TKj+XvS7bt7jvRZ2PbELCfZnmOyEe58sETu4//4JkjUyI/n03qyduCvR3k/MoAceV2VWTHoWfRtewauhLTMmj2Jw7+ZJMP8JPww4OdFQ9m2Esui5uyyOwvwRVT9q+VvXoaReDp5qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAZkY2Jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAZkY2Jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297431F000E9;
	Mon, 31 Aug 2026 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788197499;
	bh=GqtSbDUwd6UXIjN2qNZ+wEIPIx3HbWO6/Gytc1lPirI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=JAZkY2JhiUiiRV6WUJ8srONhi2WeEtWgWJoRyu4GeBx0qWBLWjgh/8Egwttq1dkbN
	 l596aUebEfiPAKgiF7ria6j056vloQ4s5TEu4PF5uvUi1lM8WmD7xMsGUryZFWYoHT
	 X4QObn4EttliTby0l1hnTFuZCVkse+YXOv79URM+LiPiLs/OSnKwT83DYqeSVOlOve
	 sJbqBn+JpErbuecgpSVucrFzW+mT8DgtHO76YX5IaEUl8IVV4qzTxDepgMeurXMYGv
	 tVrnhn/LpI76RgEyUAYX54dtuk/VxlG2qIMXlgY9Wj3DpV+5gdNezEEOcvFS4wkgPG
	 nNLLD90+aKGRQ==
Date: Mon, 31 Aug 2026 12:31:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] Rely on regmap APIs in tc9563 PCI/pwrctrl driver
Message-ID: <20260831173137.GA1812555@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 03:34:24PM +0200, Lorenzo Bianconi wrote:
> 
> ---
> Lorenzo Bianconi (2):
>       PCI/pwrctrl: tc9563: rely on regmap APIs
>       PCI/pwrctrl: tc9563: use devm-managed I2C dummy device allocation
> 
>  drivers/pci/pwrctrl/Kconfig              |   1 +
>  drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 164 +++++++++----------------------
>  2 files changed, 48 insertions(+), 117 deletions(-)
> ---
> base-commit: b9851611bad7cb227c93c1401dca48995a815d94
> change-id: 20260729-pci-pwrctrl-tc956x-regmap-91a0b5ae71f7

Applied on pci/pwrctrl for v7.4, thanks!
