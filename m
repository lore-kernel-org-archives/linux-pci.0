Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2E320A24;
	Tue, 10 Feb 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726013; cv=none; b=My6fWST99sKe8RYUxMazELnwx3T/C+ny7VkL2hTa59ZL0ldALqv0PgdDp24S3UDfePPgBx2+cMLINMEd2trY5xHd3ikIXweIANvKYryn+16ZRdh8kK4RBZxv7X7HMCOkJO2MQk4MRL51u+ZNCeBEo9Bkx01q65VBOCaJBGEVy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726013; c=relaxed/simple;
	bh=5EHraYJ35JodKfcdY+g9FOSgsgUCVFDpjm2nxWRYIaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/TwcKfFRDOlA+KyWpORBkze6F44lXh2y85D7sdc/W0GxiuazJn4rTkpiCmWadObTS6Kk8KQxXwLLZaoXVGyZ8Y8xxycQMQuN+PsXnZQa/q6Sk9oWQhVTU+gcVhl7kGIMP57XvAeskoR44/zPK/9XTIrWWhw5Q7nCljfDDYe5NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWAErzDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWAErzDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F72C116C6;
	Tue, 10 Feb 2026 12:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770726013;
	bh=5EHraYJ35JodKfcdY+g9FOSgsgUCVFDpjm2nxWRYIaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWAErzDdGtK6vT5aJWepskMukhunqc4ooog9/8Gucf9s8firK4/u/RXsaUAMux5QV
	 Z5pJXa6C7BTTflEh0mPgFF6WERF0EMQW06tdCc4Y923DT7EmNryrVeAtiME1PHMxJb
	 iTrJoz1D0DWimugUh6alKLm/4vB2vBw1IYR+ctYA59BwSDylWf8R8daY4nlHL2jSTV
	 QK3WHL9IUtHQ2qoTf1AKk+K6skREfaFUSAooU87uuhwd0n+iYIQAGgB7E2sCEhcCb9
	 gHbg70lHZzQCRryC+MKTFy3W6yka+RidrCU2TMccNK8FV4VnZgnoRDfx8DBxlJLb0x
	 NR+M+jkyP1tgQ==
Date: Tue, 10 Feb 2026 13:20:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@nxp.com>, vkoul@kernel.org, mani@kernel.org,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] PCI: endpoint: Add remote resource query API
Message-ID: <aYsieMlRDH1lRPwZ@ryzen>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-5-den@valinux.co.jp>
 <aYYsfSTrrLbR_txR@lizhi-Precision-Tower-5810>
 <ihe4sguchgrbiskeq5ht3tcti7yjzhsdhu7nobvbejbqtlr7dd@3n6p2poipy6d>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ihe4sguchgrbiskeq5ht3tcti7yjzhsdhu7nobvbejbqtlr7dd@3n6p2poipy6d>

On Sun, Feb 08, 2026 at 01:39:40AM +0900, Koichiro Den wrote:
> On Fri, Feb 06, 2026 at 01:01:33PM -0500, Frank Li wrote:
> > On Sat, Feb 07, 2026 at 02:26:41AM +0900, Koichiro Den wrote:
> > > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > > engines) whose register windows and descriptor memories metadata need to
> > > be exposed to a remote peer. Endpoint function drivers need a generic
> > > way to discover such resources without hard-coding controller-specific
> > > helpers.
> > >
> > > Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> > > get_remote_resources() callback. The API returns a list of resources
> > > described by type, physical address and size, plus type-specific
> > > metadata.
> > >
> > > Passing resources == NULL (or num_resources == 0) returns the required
> > > number of entries.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
> > >  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
> > >  2 files changed, 87 insertions(+)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > index 068155819c57..fa161113e24c 100644
> > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > >  }
> > >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > >
> > > +/**
> > > + * pci_epc_get_remote_resources() - query EPC-provided remote resources
> > 
> > I am not sure if it good naming, pci_epc_get_additional_resources().
> > Niklas Cassel may have good suggest, I just find you forget cc him.
> 
> That's true, I just naively followed the get_maintainers.pl output.
> 
> Niklas, I'd be happy to hear your thoughts on the naming here.
> One other option I had in mind after Frank's feedback is
> pci_epc_get_aux_resources().

Name looks good to me, but I think the cover-letter can be improved a lot.
(Even when looking at the cover-letter in V6.)

It seems like in v6, the main motivation is basically what is described in
PATCH v6 8/8.

On platforms where such an MSI irq domain is
not available, EPF drivers cannot provide doorbells to the RC. Even if
it's available and MSI device domain successfully created, the write
into the message address via BAR inbound mapping might not work for
platform-specific reasons (e.g. write into GITS_TRANSLATOR via iATU IB
mapping does not reach ITS at least on R-Car Gen4 Spider).

I think the first sentence in the cover-letter should be that this series,
for SoCs that cannot use GIC ITS, provides an alternate doorbell using DWC
eDMA.

So first describe the problem, then describe how you solve it.

Perhaps also show some performance numbers. E.g. vntb, you can show the
latency of ping against the ntb netdev, see e.g. the commit message for:
dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")

(I.e. compare R-Car Spider with no doorbell vs eDMA doorbell when doing
ping against the ntb netdev.)


Kind regards,
Niklas
