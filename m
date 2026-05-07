Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219A2D8399;
	Thu,  7 May 2026 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178328; cv=none; b=U+L/uZ7FGyP32JhLd41p6xqVnnX7GhARUtrjrjOqxvhlOpxZ2Xunxtpz4MbcOm1FjSlT/glJP1oDlshKebdGNneImQCzkltJkLS//ds6xIa7CO/AzqzXPskkBU21BUEYUYlwA7DO90dvQUMxzAsfkmdFaBJNvvnW7Y1THVQ1ZJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178328; c=relaxed/simple;
	bh=hd/cCq7/D5ttvLfjExtlud7dBiVFd4gFuaPymfWpbhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLs82ERCaONHa9brxEeYbXXCIksYzvm2soCI5KVzz2o97O/qXWo+A4ja1P8YtjmVPv47ioGj8DXWPeKTClJLVSqUu2kvhwQFptVaPeffDdBMNYooFAiaa73jnFQO3pDY5ULiSc3Bd9CJnqmYRI6GltQS13DUWcw1AGJ3Yie3J4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTeu+dPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTeu+dPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43ABDC2BCB2;
	Thu,  7 May 2026 18:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778178327;
	bh=hd/cCq7/D5ttvLfjExtlud7dBiVFd4gFuaPymfWpbhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uTeu+dPSnCw/Qa2uCuZPT6RTVgVMKjUcFqVNAXdrl/EDls2tgC4QxAkTZeHi5tUS1
	 QXet+iYJNbwq6/9xUpEWREexFSzLkj620wmYRLOTJf68717kM9W13+fv02iDjvRxpe
	 xl0/rvm2nWzKwPEdFlVG3SyeIQr/62EO0VNPFch+lPsnU+KJYxEx4Efgl1rXxDOnO6
	 IUqv0S3cxFGwpiFYjwFg00k+wQsV0APpTwv0yOPqvpiSOIIIqTz5BsVNsk7W5A02Hy
	 QdVYCJxHn3A5vqaHc+it68M26IV8/f1j6A/wLMIjmIaLHHaFAmJ3sj5JTOiPnQpvpq
	 rx6sDiwLppuVA==
Date: Thu, 7 May 2026 19:25:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v17 09/11] cxl: Update Endpoint AER uncorrectable
 handler
Message-ID: <20260507192513.7d982f95@jic23-huawei>
In-Reply-To: <0cda6505-a217-4c75-b3cb-51a8c396793c@intel.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-10-terry.bowman@amd.com>
	<0cda6505-a217-4c75-b3cb-51a8c396793c@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 10:43:02 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 5/5/26 10:30 AM, Terry Bowman wrote:
> > The CXL cxl_core driver now implements protocol RAS support. PCI
> > uncorrectable (UCE) protocol errors, however, continue to be reported via
> > the AER capability and must still be handled by a PCI error recovery callback.
> > UCE handling is required to provide direction for recovery.
> > 
> > Replace the existing cxl_error_detected() callback in cxl/pci.c with a new
> > cxl_pci_error_detected() implementation that handles uncorrectable AER PCI
> > protocol errors.
> > 
> > The handler decides solely based on the pci_channel_state_t parameter and
> > does not access PCIe AER capability registers from .error_detected, matching
> > the pattern used by other drivers including the NVMe and ixgbe drivers.
> > CXL.cachemem-corrupting protocol errors are routed separately through the
> > AER-CXL kfifo to cxl_handle_proto_error(), so cxl_pci does not need to
> > second-guess the AER core's classification.
> > 
> > claude-opus-4.7 was used for research on PCI error state transitions and
> > requirements.
> > 
> > Assisted-by: Claude:claude-opus-4.7
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
...

> > ---
> >  drivers/cxl/core/ras.c | 43 ++++++++++++++++--------------------------
> >  drivers/cxl/cxlpci.h   |  8 ++++----
> >  drivers/cxl/pci.c      |  6 +++---
> >  3 files changed, 23 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> > index 5cc4087c2807..a98ce0f412ad 100644
> > --- a/drivers/cxl/core/ras.c
> > +++ b/drivers/cxl/core/ras.c
> > @@ -253,38 +253,27 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
> >  	return true;
> >  }
> >  
> > -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> > -				    pci_channel_state_t state)
> > +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> > +					pci_channel_state_t state)
> >  {
> > -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> > -	struct cxl_memdev *cxlmd = cxlds->cxlmd;
> > -	struct device *dev = &cxlmd->dev;
> > -	bool ue;
> > +	struct cxl_dport *dport;
> > +	struct cxl_port *port __free(put_cxl_port) =
> > +		find_cxl_port_by_dev(&pdev->dev, &dport);  
> 
> Move this to right before 'port' is being checked. It's ok to do inline var declaration with __free().

With that done LGTM
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
