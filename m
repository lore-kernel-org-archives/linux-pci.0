Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE703D6692;
	Wed, 27 May 2026 08:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870253; cv=none; b=mWq99rap5rhM7ww4nE4adhBfw/0TZmKJMrYZMyKqO3RNhXMMgD+YEfJLtQXgZIr1AwpP34hUR15y3xwM8M0xkHQ0bTgBBq8HP2kluBb9oTasoUTwihqjBYlq9r2XHhkZxxlC501d1Kect48VjbydhUXSlmTlp7d/7x1iuj/IdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870253; c=relaxed/simple;
	bh=InDEGFHMHqz0bGgNPGIC3dOIF1xeaaKQbbuR0mwHqYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E66zifHEQY2+OM9czuvKbdaN7U8IR3/aL7HnbjloGCFcP16gcNCQDLAxGGT2IFqtnLthSBg/aQeryJjL0KuvvmlJN8IncwuIfeD/HBYSdWbo4S06dvFzLN9ia/Elz43zwTzkuYSOgiLKxQMSYsqk4EmjTVjR/4t/9t+VV9lNd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDkp04rK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDkp04rK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4ABE1F000E9;
	Wed, 27 May 2026 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779870252;
	bh=xjscdgSPyDOI7CNqIBusqsaIputbtH54H/1r7AkT1b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JDkp04rKWT/HYECAPH1TFeme0pGPvqkRB/xREgNQxKCUfXJZ/BNMIxJx6mOt3oMbN
	 bzgw5veyPuKAQYvmkLp3ZEtckfR2QCpdtSBBGiVXs9otCo8rrmDqRGGw9d70b91+D3
	 K1Vw4UmT+WMLTI10wXaBOZAFP7xxm32aP1emJedzo3o0m5PuXooGbnc8kDkXJQ0nNi
	 sIhLA9JwgrtJ4h/z05QtpOUi1fdzPmYDFB89eIayhtvMxWa+W5qwoyRZk2bma0fpGJ
	 l9Y8Qvf+Dx8pM94MeWLk5M4ZbwALinNmYjz9k0k9CvEnKBNitu6v75nZR4kX5StUuQ
	 T3OKKUTSDDFfw==
Date: Wed, 27 May 2026 10:24:06 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	kishon@kernel.org, bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, 
	allenbh@gmail.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-ntb: Add check to detect
 'db_count' value of 0
Message-ID: <wqog727cep7dhodxvpp3jfnfy3ce6kag64dahjd2vawxbkjrju@35immqrbyekm>
References: <20260407124421.282766-1-mani@kernel.org>
 <20260407124421.282766-3-mani@kernel.org>
 <20260512051926.GA1687877@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512051926.GA1687877@rocinante>

On Tue, May 12, 2026 at 02:29:18PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> > @@ -1297,12 +1300,12 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb,
> >  	vfunc_no = ntb_epc->vfunc_no;
> >  
> >  	db_count = ntb->db_count;
> > -	if (db_count > MAX_DB_COUNT) {
> > -		dev_err(dev, "DB count cannot be more than %d\n", MAX_DB_COUNT);
> > +	if (!db_count || db_count > MAX_DB_COUNT) {
> > +		dev_err(dev, "DB count %d out of range (1 - %d)\n",
> > +			db_count, MAX_DB_COUNT);
> >  		return -EINVAL;
> >  	}
> 
> Something that I was wondering about here: would it make sense to also
> remove this variable from here, too?  Even though it's referenced below
> here (which is why I think you left it here).  Thoughts?
> 

Makes sense. I removed 'db_count' variable while applying, thanks for spotting!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
