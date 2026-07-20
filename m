Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE242A80;
	Mon, 20 Jul 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583390; cv=none; b=hfU88yW7w55yq03j50k7WjmAla86almE7rZ08scDYofBvokp2FeqvpsFlyAIKHpPwqzIKdjUyenUI6x55BoKB5d9pw0XEUG3Pdq5vYzLBJfGZgG05AIolHJCipI7R+7hgEfpW5uRCcJUvfNHWh4IaiTLMGjl53E1hDXfTP8bw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583390; c=relaxed/simple;
	bh=BL+9f56UTCEJO+eMC7ihfAG0NyN83fcjjrZIH6SCZvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZqmwBrpgtGjy2jls4WjW91HGdqQ0TjZ8C9X/tS3KBSptkiTK1IgNVHclkiKCdXB2JlQEKhKWWsyQF7ENPqMaAth0Xjd2ZRWoKA1uZ1TH7BG5SJ9xnBFEGHdOQbumRhSS7ycefKXVngOe6cfjjJvXkyBaHjwlZkToduweapLd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WffceVuj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WffceVuj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0F51F000E9;
	Mon, 20 Jul 2026 21:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784583388;
	bh=5xcm1f6RAqbi8oLN7UHtMa4VnW9ylZSq3hoXwK/VxXs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WffceVuj3rlT8i77X17/8GdwzB58M+xlZJe4FtnqE34F0xH0h4qgt7QUxp0877S3F
	 FWakL3GorQJBRI/NgZ4RxNG59Mk3USLtmQat39QBq04onYjKpRIWL8L1f4+vBo7GD2
	 znMgxQ1ZSp47bQmykTNyagCTaTq9Dbeo7T8phW+BcJiv2VMGaJF9jK/JLMVYnIl6ia
	 Bjs2KXQV2+l6p2jgbn7ikCUxNLA1YDylkC7dqx+60bSg0f9u8Zkq2dyNlEIcgPUYDa
	 nMBQX3l4Ux10MLvkDn9Pa23H0txz6xQwt6rCEM0rjNfFKOOhuP8TTZ85OgODnEVCJA
	 0Bi8YHl5Vwvxw==
Date: Mon, 20 Jul 2026 22:36:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: sashiko-reviews@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL
 CPER work locks
Message-ID: <20260720223625.6176294c@jic23-huawei>
In-Reply-To: <e4e1bb5b-2cc3-452c-9499-d74aa41965e6@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-3-terry.bowman@amd.com>
	<20260717224919.9F80E1F000E9@smtp.kernel.org>
	<e4e1bb5b-2cc3-452c-9499-d74aa41965e6@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 10:02:05 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> The LOW issue is valid and the extra cancel_work_sync() needs to be 
> removed. I propose we fix if a series respin is necessary or otherwise 
> fix in future. 
> 
> The preexisting HIGH issues are GHES area and to be fixed by owners.

Mauro, this smells like one that your nice QEMU + scripts could detect.
Fancy it as a test case? (he says hoping you'll also fix it :)

Also, I just flagged on discord that we should discuss what we do about
these sort of issues and tracking them at the CXL sync call tomorrow.
(Tracking somewhat discussion here: 
https://lore.kernel.org/ksummit/78346752-E2AC-4ACB-929D-70A45794474C@linux.dev/T/#t

Jonathan

> 
> Terry 
> 
> On 7/17/2026 5:49 PM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> > 
> > New issues:
> > - [Low] The patch adds internal cancellation to both unregister functions but misses removing the redundant `cancel_work_sync()` for the protocol error work in `cxl_ras_exit()`.
> > 
> > Pre-existing issues:
> > - [High] Fixed-size memcpy in cxl_cper_post_event causes an out-of-bounds read if the provided GHES CPER payload is smaller than sizeof(*rec).
> > - [High] Missing bounds check on untrusted dvsec_len in cxl_cper_setup_prot_err_work_data leads to an out-of-bounds read.
> > --
> > 
> > --- Patch [2]: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks ---
> > commit 70fa064ce36bd35723148aab9a91c80d0fbef760
> > Author: Terry Bowman <terry.bowman@amd.com>
> > 
> > acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
> > 
> > This commit converts cxl_cper_work_lock and cxl_cper_prot_err_work_lock from
> > spinlock_t to raw_spinlock_t to prevent a deadlock between IRQ and process
> > contexts. It also restructures registration functions to warn on double
> > registration and clear work pointers before cancelling them. Redundant
> > cancel_work_sync() calls are removed since quiescing is handled internally.
> >   
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >> index 3236a3ce79d6b..ca7a138c1ff2e 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c  
> > [ ... ]  
> >> @@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> >>  	if (cxl_cper_sec_prot_err_valid(prot_err))
> >>  		return;
> >>  
> >> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> >> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> >>  
> >>  	if (!cxl_cper_prot_err_work)
> >>  		return;  
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does cxl_cper_setup_prot_err_work_data()
> > lack bounds checking on the untrusted dvsec_len?
> > 
> > If firmware provides a CXL protocol error record with a maliciously large
> > dvsec_len, could this lead to an out-of-bounds read when calculating
> > cap_start?
> > 
> > drivers/acpi/apei/ghes_helpers.c:cxl_cper_setup_prot_err_work_data() {
> >     ...
> >     dvsec_start = (u8 *)(prot_err + 1);
> >     cap_start = dvsec_start + prot_err->dvsec_len;
> > 
> >     memcpy(&wd->ras_cap, cap_start, sizeof(wd->ras_cap));
> >     ...
> > }
> > 
> > [ ... ]  
> >> @@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
> >>  		return;
> >>  	}
> >>  
> >> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> >> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
> >>  
> >>  	if (!cxl_cper_work)
> >>  		return;  
> > 
> > [Severity: High]
> > This is a pre-existing issue, but does cxl_cper_post_event() have an
> > out-of-bounds read if the provided GHES CPER payload is smaller than
> > sizeof(*rec)?
> > 
> > If firmware provides a CXL event record where gdata->error_data_length is
> > smaller than sizeof(struct cxl_cper_event_rec), this fixed-size memcpy
> > could exceed the bounds of the error status block:
> > 
> > drivers/acpi/apei/ghes.c:cxl_cper_post_event() {
> >     ...
> >     wd.event_type = event_type;
> >     memcpy(&wd.rec, rec, sizeof(wd.rec));
> >     ...
> > }
> > 
> > [ ... ]  
> >> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> >> index 267c679b0b3c2..7c6faee7f85ed 100644
> >> --- a/drivers/cxl/pci.c
> >> +++ b/drivers/cxl/pci.c
> >> @@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
> >>  static void __exit cxl_pci_driver_exit(void)
> >>  {
> >>  	cxl_cper_unregister_work(&cxl_cper_work);
> >> -	cancel_work_sync(&cxl_cper_work);
> >>  	pci_unregister_driver(&cxl_pci_driver);
> >>  }  
> > 
> > [Severity: Low]
> > Is there a missed redundant cancel_work_sync() call in cxl_ras_exit()
> > that should also be removed?
> > 
> > Since internal cancellation was added to the unregister functions,
> > cxl_ras_exit() now has redundant synchronization:
> > 
> > drivers/cxl/core/ras.c:cxl_ras_exit() {
> >     ...
> >     cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> >     cancel_work_sync(&cxl_cper_prot_err_work);
> >     ...
> > }
> >   
> 

