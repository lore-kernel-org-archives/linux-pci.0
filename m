Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E039B947;
	Tue, 22 Sep 2026 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043420; cv=none; b=f8poGhKaKtorF9TY6J5gSq3XlHK/K666WeERILsvOSTmGkoXXkx9JboJejcCldnCussaFZGTh5wzBaNj2Gecl9EbUTXRWY8wIiXIdPSRJfagWuRCZZJ6mqzM/TloWS25zrxfloUDRMFTMBmjb7zX1LTBnvoG77ypyHUAvhncqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043420; c=relaxed/simple;
	bh=2vGBkI0xknqIEXH3MvA83d12Tvd7oJWD49BR1aQp6NE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJVDoGciDDQqfM3u+g+aZPEYc3g1Neb//BFFE8ijKiaaBKqx2ln69yRWOj4KuzaUvMMio+OT09JYqoaagbsLPNmMG+9Jo6dZ/4yefSBZ7eHFL83MuQmaG47XtSLl6wI5kMsrz4rKG79rZatNIHCnw/g/41vizKejO3XlpEGP9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hbacuVnL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TrhAFyE5; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="hbacuVnL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TrhAFyE5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 097A67A006C;
	Mon, 21 Sep 2026 22:16:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 22:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043410;
	 x=1790129810; bh=m5CLsYmH6SWKRQjuSodBxtKihfzSya8kG6HdASdWy8I=; b=
	hbacuVnLzriYn8pry5OTtRRAhCkDYi8Dqg7/3FI9lwv+9wgCNGxwxrQAe2sEj+EZ
	+Pz3IqnmE2Lly5WyQi8kn/n/i6s9Liws+Lr5cFDbUtFqCpcVU0QOhL81XGY4Tqv7
	G37jfoTPDyuRf1ZKSqf1lpeFQ0n6m9N9EDI+cEesamk4o/RebjSk8F+5WRI852ts
	dOfIseffoFnKDgzmppBfQtsHntwNTZBIkZ1Nsa6m4uP+10ENzXK84+3IHIHQ3ByS
	Ebt04H05FXr8V+FTs3Ze+MVqDBIQHlMAKjuJs04XMNFSWvBR1zb72DJxOepUtK3Q
	n3Q6s3Ngi9ZXvzOd79wItQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043410; x=
	1790129810; bh=m5CLsYmH6SWKRQjuSodBxtKihfzSya8kG6HdASdWy8I=; b=T
	rhAFyE5ENPCYKUFx6jh7HWxG+BQm5jzmjvCNLwCGC0xUwGdQYR5mrq2NxVpCTfWf
	bzdP2gVrO2wYqJGAtSnVsd+q3rL5d6ayoYnZTWdnNLaFEiJmve7noQ6Npb46LSoT
	zDjiEAeNybgAhEqLULSPjE+t+A9Cd26NvVSk+mDBxlZlsIwDgQp78bJca9kZILjf
	cfH3PW2xJ6EpGx0Z8uw77OzzTgjl4N6SkNfzyaZ7UUP0kOxFNI0mFA/4V/0UmPSE
	4pqfp0zUdJJT2+C2mn0eQEkWuX8MRTtafYvniFWLVwKyfb4d+zvzuD/xpeFDgwtE
	OxxXiJGT/cL0KKsqI3TMA==
X-ME-Sender: <xms:EuWxagC5gPip0GkT3GLFF3Cucex_spHkbiZTWF8yNPhz4mLaIVh0Zg>
    <xme:EuWxagKApE4P88CDms9j-q3mYyxVb3N113gphFRig2ASn1CeNG8mlzCZ_Inj9yrzm
    smHniyGvqqMPA4wRi_U55v-wElB48f4IX_JKinEFzaxbHZ20H0r10o>
X-ME-Received: <xmr:EuWxaq_eHNTulr2sCGvdgLDToflpM3K2SilqpI7G0ursdIi7RtZs3nZK2dgHig>
X-ME-Proxy-Cause: dmFkZTGXJSHqMq/BnZYJ0YweOb4rS2VUXpPM7d5+lSYGhnppGFsNjl5Bysv+w6+cDnCJ/7
    /L3Cxi42gIwxQ2NUo+88ApQMAdaEv47yc8fAsLypxGx87oHF4HT7ama3q0ueulG4TPc0DY
    g9aq/+AIZ/88RBFY6z24OfxBW3WPjyGYAaKrF0WRpWdqsttcvGMxliaYSaCPsYHObnA4na
    kPveiLHd3CCXxarYrwtQo6T70Ls9xKt0FRJqIrLM1i8XMnEKMgqeJVG7tIy0ld86sgmRqY
    QTP1Xf0Z/CD0h9dlYVSVFIdwBL83CGpVR9ekjjvy4BxnnVieSYFxqs3RHn4BnowjRSHsN7
    rR//SOuezp5pQ6FuD1S1ndDvE5zpymT9GuUjVB8dP5lzw3ALHldut5NIS/6oiZLPowXQv9
    TRZ7gMnoQiIU5aIuTKGPh3BqvqFZwzMMm3aXU65kDgNxnIKonMXCWbecS8kP5RX289tXz2
    Hj5NExCOWlHCL6fcQAPufnCRokTwGuKT2IIioF/EZ32xonW32mEpfHQ+vL/CCd17lKWVlX
    Um6Ez5U6axfaPG2f6aCJ8jEGMdxDzvskH6XWSC2/paWTXm/OnBkHlLBEQMjZl+xpSzBkyC
    9vdFX30KJl29H35c3LsWlXtRU3O9mVVFmD1q6ONEmUccVX0uSUQtztjIO2nA
X-ME-Proxy: <xmx:EuWxau_W1x2-NDQipzUW5KVfi9wy_HQ3II-Qa9w8iQnQuTF5KG5Kzg>
    <xmx:EuWxas_1PBC75ic96o06tbmTggd832JMjmnBx7xExkhdFUGVZxHFTg>
    <xmx:EuWxahIkMK_cU7BrCKUG537jRVn7tXkTwlWXxdEIbR7gWjdEPpAvVQ>
    <xmx:EuWxapTSXb-X0IoQY12VWELMLb1wtLcemW0HdeOcYPMjiVEGH6xejA>
    <xmx:EuWxas-uI8cnIjDIfIlpGs0nsFmR3Ht-TR0ilNH9WF533A9lceMYECv8>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:16:43 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:14:12 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 17/27] vfio/cxl: Own the whole component register BAR
Message-ID: <20260921201412.78b7219a@shazbot.org>
In-Reply-To: <20260916183540.3813685-18-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-18-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:30 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> devm_cxl_probe_mem() maps the component registers through the CXL core,
> which by default claims each HDM and RAS sub-block. That collides with
> the full-BAR request vfio-pci-core makes when the guest opens the device.
> 
> After the component registers are discovered, declare the containing BAR
> owned with cxl_reg_map_add_owned_resource(). The core then ioremaps the
> sub-blocks without requesting them, so vfio-pci-core owns the whole BAR
> and the requests do not collide.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 0d92e6a409c1..5c8a63833a43 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -89,6 +89,15 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  		goto err;
>  	}
>  
> +	/*
> +	 * vfio-pci-core requests the whole component-register BAR when the
> +	 * guest opens the device. Declare that BAR owned so the CXL core
> +	 * ioremaps the HDM and RAS sub-blocks without claiming them, and the
> +	 * full-BAR request does not collide.
> +	 */
> +	cxl_reg_map_add_owned_resource(&cxl->cxlds.reg_map,
> +				       pci_resource_n(pdev, pdev->hdm->hdm_bar));
> +

The result of this operation is setting a singleton "owned" pointer to
this resource, whereas the name suggests it's adding the resource to
some set of owned resources.  Is "set" really the more idiomatic verb
for this than "add"?  Thanks,

Alex

>  	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
>  		pci_err(pdev, "vfio-cxl: HDM decoder registers not found\n");
>  		ret = -ENODEV;

