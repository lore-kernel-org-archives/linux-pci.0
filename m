Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCBC319851
	for <linux-pci@vger.kernel.org>; Thu,  5 Mar 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694912; cv=none; b=ovKbcBf0+BWYEbHx6pRUrSrsjKvZSEFkQFYdLxfN+V1hLqNN72gGS9TNHdPAdqDe5KMzm8Q8NlelvC8l56nzrszuUkk5nPshhpoZbLc4B3nQ+GitpMwYIq3grT7lGQI/cA5rcj5Ih7MHzce8kLpVJfEViAU2Bl60Rno1+7aYdjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694912; c=relaxed/simple;
	bh=mojt1b1wsRSWTHx4ywsg7Bv0GzpHYydcjukFr7WAwEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh8qP9G32CD1UjN7klNIqOJ2VAGoFziit8Q8JX9Tnucd7wWcGuiw0iHKvxiLja9LqnPKeqDbnbCDDKPI0BEo1VvGDUA8ihO7dRa5Jexydhk5XBGSIFexavqwr5OZCLK4pXiWsgCA1A21Jc647uwrxGwLDz4VM4G4zYF6obqz4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpHqC7DC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpHqC7DC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7089FC116C6;
	Thu,  5 Mar 2026 07:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772694912;
	bh=mojt1b1wsRSWTHx4ywsg7Bv0GzpHYydcjukFr7WAwEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hpHqC7DCI5xDVZmJ29wxcQNY9swOs8ivFrEe2Wy2wPpkuK4S4897mb8AicL7lvYi+
	 XqErfv26UlhHfYfH3unTKQ3DcvJ8N1uyaIR2uAaCSQdfVooFoBEKFnKXT9fnzSzz4p
	 yxZAvirKmjQapmlPGXrPv8xGf/aGjZw3ZdfsHO8q0Wge1/CzlDWUWwfcmx2lt7MIoQ
	 Bm5H8mRYw0A7k1N0b6cASEovcGmpwbyhgJ3UMJOXV9QsKvu1Tips31eOeFLMBay1Nm
	 gGKZ88D8VRux5D3MQQaprmowvxSMLMTBLTPi7GZ9ZW6Oj/5rTQpmN6NvEva3rpifmH
	 qk6verWteLZlQ==
Date: Thu, 5 Mar 2026 12:45:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, kishon@kernel.org, 
	kwilczynski@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] PCI: endpoint: Propagate error from pci_epf_create()
Message-ID: <qwo62shnnb7lypittgyjtwzq57fq5xi4klvhg3cc7rv4rszai6@vu2ucpiow3tb>
References: <20260227030701.40533-1-alok.a.tiwari@oracle.com>
 <20260227170620.GA3898635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260227170620.GA3898635@bhelgaas>

On Fri, Feb 27, 2026 at 11:06:20AM -0600, Bjorn Helgaas wrote:
> On Thu, Feb 26, 2026 at 07:06:53PM -0800, Alok Tiwari wrote:
> > pci_epf_make() overwrites the actual error returned by
> > pci_epf_create() with -EINVAL, which hides the real failure
> > reason. Use PTR_ERR(epf) instead and print the error code.
> > 
> > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > ---
> >  drivers/pci/endpoint/pci-ep-cfs.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index 0f3921f28f17..7ddf9e3c04d3 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -624,8 +624,8 @@ static struct config_group *pci_epf_make(struct config_group *group,
> >  
> >  	epf = pci_epf_create(epf_name);
> >  	if (IS_ERR(epf)) {
> > -		pr_err("failed to create endpoint function device\n");
> > -		err = -EINVAL;
> > +		err = PTR_ERR(epf);
> > +		pr_err("failed to create endpoint function device: %d\n", err);
> 
> Unrelated to *this* patch, but messages like this that claim to be
> about a device, but don't mention any related device, e.g., with
> pci_err(), seem dubious to me.  I don't think users can really do
> anything useful with a message like this.  There's no obvious device
> available here, but we at least have a "name".
> 

Yes, agree. Sent a patch to print the EPF name in the error log:
https://lore.kernel.org/linux-pci/20260305071236.23792-1-mani@kernel.org/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
