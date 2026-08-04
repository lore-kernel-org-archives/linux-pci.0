Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450A48A8A7;
	Tue,  4 Aug 2026 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874231; cv=none; b=PRvjIotUTfuKcLiNXYVChZHi6MJ9yxyCFZaW+xJu1W9Tp+vnodNQkoeBj8U65XY2cwPnhzzm+BaZy1IiqI+Uqs4hfxq140WSHfCM7r5YGcAcb8IJc2wc31nOde+EuyNsZPDBBbQ73r5TUJ8prWFcptcih58S2Z3YFXq4HZem8HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874231; c=relaxed/simple;
	bh=AjmUzfY+vEbZcOw71ELjIqCFMK9wUupfH+b6ioJ/RAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdiMNEMrzaQn1VbA3FGuyGhLVI0tEpbjuivjjn01tJl0zxZ3SgIlG7Em6G2MZ35zsCXGxEtaZgTVuyZuUCx79w+8dQ6AYNc8pAFhvqK5FnK/HxkRQW344MX+HONIVLeuYNorJ2H5Yj+vgq8I575tyZAqd9uZ5F/7IRp68F1shu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TvhqnR7m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jV/BhCRP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="TvhqnR7m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jV/BhCRP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 84DBE14000BB;
	Tue,  4 Aug 2026 16:10:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 04 Aug 2026 16:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785874228;
	 x=1785960628; bh=DGDpNHg7f9ztXGjzjzb4ybcoE+sIyQ0zmpGoEdgW4g4=; b=
	TvhqnR7mCECTjp74lUFk4G4kFKYnDIbC4XNAlIU5Z3FhZ2Yp14QvfA8I5Dge0rZj
	AVMK050Y2EXORNA+5w3npdI8mTHHzB7brHEtxkAfzizr7JwtFXQW0HIJ3EIz2p6c
	7/CTBd2jrTNd0iFl1no3FMI1bBInZqbM/OTzKZ3o4TfdGCa5Aupf2SzrFTRaoyMO
	kjmBg+dMDXgWk8C0iBK1iM2kS3W9XglkkC3PRvzWgxNssG6QcpCpTzb16W3+ENOQ
	7g5ub4ierd5E1KJ8szv3WolRxMN0056ctenE+S4CGBVwqWPu6MaLqyxvOmdR+Med
	nilmm1ADQQahAe58GZPN6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785874228; x=
	1785960628; bh=DGDpNHg7f9ztXGjzjzb4ybcoE+sIyQ0zmpGoEdgW4g4=; b=j
	V/BhCRPJYsv+ODbPHoPDuYrD4LYQJrbE58aquOw6yEKnyMaQdkkrfis6i0rONgoM
	XaS+Kd3NkLxFvwJjOq7AzGCq0uzFCabQ8qynR9/PE96snQm+uc0cp1+OE2SzaR7i
	tk05YXDlKfRFu0TRkM1EqiIaE8vCev1iAASqrsZuP4cdsgamHovx34DiQiWjGHqj
	SOUma0xptLjEUB/ABgR+Rth8RYrcf2zHLJnFjo/jH0RglEkkhWzz5VJpbqOZrKMD
	XJg6TztYWZx1AoN3fRK0/WjIxmyqZpH3fyTvxULZIamL0Ok1/Bx5craoOy7qLlx3
	7DliLKr6E5eP38TrHHATA==
X-ME-Sender: <xms:M0dyapdXOK53MZxGFwM9IEhajUFmem4pf5oKoDXJDzp5V4CJ_WIzZw>
    <xme:M0dyaioHLH0De3JSkLQpYHvbFqJ9hAWZRWqMIkGS6t5pn1vmTgNFN3Eyb-Kp3C9sW
    LQzIrNB5tfJgf1364dmNBtrxOO61pnyk_xpz7SdJhj6mpbEqdSBoQ>
X-ME-Received: <xmr:M0dyahPv1zAe0W-WWMO46nUWLEmDpBMK5JXdSwwmxUVbCIz91PqE0ge5uHPGlw>
X-ME-Proxy-Cause: dmFkZTFz0qZml1tMgspJLvQROyFjxo2iF8dhBLG1gtWRuVGqbuDRnJRSCDTFVRpCARIfiq
    p3San+6x+JgTfRDCa6JBZsenI68aONWfSHUYcbyfYK6A/5lMqgtwyRGiR3tIAbrTXet38u
    i+QO8myxi9xRWUJuwDzgccQxCLFmyqcbNr9Rv28m1qlQSzbceTd2CI4KV3jnRkdZM5/zA+
    B1dU/SLUd3a0UgVzR1Z0a0lAzAnN02ZTOGg0/5ioy3i8bBVIKEyL83cVcVtsr7pH78GSJA
    qRYYsIFmKmGey4GXe+l8asTXRBmpS9hhZyjnvk143mQEwWjndPd5+SEps8e/cZNACoZWlE
    4Mfpjo6x5KnZJioSCjIK5fIGt3/jP5Q5Tx1SlsHlmfBX0IYNe6wpw68EogoZ+YusOtv6YH
    pXSFT3JE7csZCMs3A3kW/8NM+xh8MLZtZ4lCCaxvhdjr6CuUpi1dtkttZVQTATJfUeBp22
    yWGUMbYdzUhFxjGmuWxC3aQ2wWzrIw7Xq+d0rAMbtpf9bxhA0N63qmi8YLz0ZJBJN1Tv3K
    lO+S2hZ3hh+cpORTKTBbq045O3Pagme9MthyaugmLDiXB7AZMouCUEXeZ2VSQ+jl99CfP3
    9qz8+Pa8I7u1ZCvyG7/cRNwNrlZstfl1eghiC4Xf7kf4/9xmo7lVxdVSejNw
X-ME-Proxy: <xmx:M0dyagEM4gSmDssLubmn_6YVnByO9-qB8KzWbeoc1e_0-NYwK7wAUA>
    <xmx:M0dyasFOPkII3QdfzcXRVDvt-06AFTE6dSPOamdXftyyUMcV3miqoQ>
    <xmx:M0dyanCJkbrtLRbYedsDNmVJGg5OT6a6XLNAqLuA6whv5Gf31wK3kQ>
    <xmx:M0dyapnVsAGlDqnw4TkWFKvLlIMrI5QLzuDd1oSD2l3NP8-qJJ3AjA>
    <xmx:NEdyakMeyIhaiVEwdtSqBLz0DIZTbrGyTWKemyo_Ta627fyHnW7ZPhvm>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 16:10:25 -0400 (EDT)
Date: Tue, 4 Aug 2026 14:10:22 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <20260804141022.71b6429d@shazbot.org>
In-Reply-To: <6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-8-matt@ozlabs.org>
	<20260729115204.2a9a50b2@shazbot.org>
	<6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 15:47:13 +0100
Matt Evans <matt@ozlabs.org> wrote:

> Hi Alex,
> 
> On 29/07/2026 18:52, Alex Williamson wrote:
> > On Wed, 15 Jul 2026 18:47:30 +0100
> > Matt Evans <matt@ozlabs.org> wrote:  
> >> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> >> index 9a1674c152aa..e2b4252e7c3f 100644
> >> --- a/include/linux/vfio_pci_core.h
> >> +++ b/include/linux/vfio_pci_core.h
> >> @@ -134,6 +134,7 @@ struct vfio_pci_core_device {
> >>  	bool			pm_intx_masked;
> >>  	bool			pm_runtime_engaged;
> >>  	bool			sriov_active;
> >> +	bool			zap_bars_on_revoke;
> >>  	struct pci_saved_state	*pci_saved_state;
> >>  	struct pci_saved_state	*pm_save;
> >>  	int			ioeventfds_nr;  
> > 
> > This should be in the bitfield usage group since it's only modified at
> > init time.  
> 
> This was intentional, but happy to change it if you're certain ofc.  Is
> it inconceivable that a sub-driver could set it after init?  I'd say
> they _shouldn't_, but only review will stop them and this placement
> intended to be cautious.  It seemed a low cost way to avoid issues
> around synchronisation on the bitfield.

I'd agree with the statement that they shouldn't, it would be difficult
to synchronize setting the flag once there are any active mappings of
the BARs.  Also, if we put it in the bitfield category under the
comment that the value is only modified at setup/release, it documents
the intentions, hopefully to the extent the author or reviewers notice.
An argument can always be made to change it if there's a worthwhile use
case.  Thanks,

Alex
