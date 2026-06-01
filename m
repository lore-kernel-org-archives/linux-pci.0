Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AB395273
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310486; cv=none; b=oFafQPWjXMOUnZvOn6C6c32WEywOQAnN8VAFHQwNnCYk60blYOUVsf0CzcTBrigQnVMTuNYMqUigvzZ5YDJk5eN32sV0AT0mmkfHVTL51Tbw59CS+Glw6sV1Yg4btCbb8ptT3BkqVV1gIqh9ErNNC2A7osq5juiOUzvyMLnQSjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310486; c=relaxed/simple;
	bh=SCXw0X4yCKiS+ZvYlUJutOAXYF6cwTtdfJyDOlKRbHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7ifyf21KGgFsun+srLm/LQ1AZq+QrfBrastH+B1kTWmiqdIe8AsRa0BnQb8RDa+aF5iTL0LjMcrTMkQ6fdXM//5TkU7FIJ7UcIxhIuNwPaCyKR3pCLXW04FfkZVLeARfLdmx17ELvb8WuuqDXBioJ6TwlRdCRhAbFhAiOlMPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bo1gt7Dq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bo1gt7Dq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf22c18ad3so125ad.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780310483; x=1780915283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+sldHCJrVX7HHPNnZ6TyMOXSdYqXeIyil59tqXzT91Q=;
        b=bo1gt7Dq+CGgza3PEfDpTf5dmFQMUnDq8rwTfQpmyRHeHkvX1IFXlvbAt3+bd//B5i
         GDY3ARZ52K+RdGNZAsORJaS9/1bsfNCCYzgbpbg/aI7qjTjKxacQx1BFDxeB8Ph00iiA
         KTVMm0rqWM/vHSCi2RT/VrRMa5XJ5ppomaR+YZjuUzO+a7DiBWdzk1obRQ/SOIlNBFo6
         hPAwDtcId4NJK/5UCnUM+mTdy3SptJidpdM8fVNH9p2PFajxrI7w3oVAn1nDX0PAkslt
         GCPtxSULCovfFdse99DZ3xoWVVATKGEZ+xPQo194YKv3bx4yq9U9CRh63nn8l0zTTYho
         rb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310483; x=1780915283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sldHCJrVX7HHPNnZ6TyMOXSdYqXeIyil59tqXzT91Q=;
        b=EVIHb77jvh48R7dHNAn9/pGYjnV7PNR6CR+5EZkq0nc5ONXy/KASw3kutvHFfKc/OF
         DwNdVBS+rZeeaH1B+8yc4X9UDUdPR2AJ4ualtZVEwxINT5OXKpUdbI0/IqhpNeJAZpfK
         cFDu5o7+pR4fhzaPdmi7EASLsh/mS7CIYfGspP4vljZh6hOYW1P1Pm0RA5B8Dtf9Z358
         d0Wk5qoDq/PjEEUeKX9mqEVjpMz9HX86iRYDu7MoSQZGkImRiILGHOL9sKBZUWLONFyl
         DDW/LyDe1RhapRlfTIeZd1IPklMX1LSGTJAKIxZF7G0Oz/FQ5dO8067d3haH2ZKst+YR
         Cbdg==
X-Forwarded-Encrypted: i=1; AFNElJ+YMXu1tbOk9oe34/g8RkW9+DfiMLHhhLz5Q6LUnuNfBFIHVZ21wNnMQ8c2GaPSAdj7cAm9lABe/So=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYnZiQX7Nz+0HkFbFLWtP3rUpGrYjthAvTQWURYma01vWhVJxO
	zKz584C3zIVENlp6jVlpBLkVwtWOpoYZL2k/EgkRqaZJ7uZOcTAXyAv5WZlIvINdkw==
X-Gm-Gg: Acq92OHcGeKp//an1cyeDOvBIZ9jPnNQT1ZHFflzfztZHVHwyj5HyMnTsIERxybvcbv
	NGnKncCvd9Os0PBJNNAhPElJZ4iQUVTdwmSLDabh/ojmbctmA4a/P2QNrZV4DI6b0yXNoGz8YlG
	7+Q18GAfPOY3c2egzAcnm3kTxjQ/AVdZvJUb0QsAeCPd8bXc3VfcPJq6q/AMC4FuCGhGc2YMNoV
	5Jwora5iME1kJWNP4mqiHW90qDOyxByfuxn9mHfYkDH074W9zARNs4DJqh4D8iAdcWSOkz6QsMk
	isGwqMLC3zpuKh+2eHDkIAnOPiRZievR9u6UlW5WJYS0x2nKR1j/Q8ww6kH18T9XKq4yjGCU7y0
	OkkInkyk4T1KvqjHwzaQSk/NDV8+hbKziuhG09zXPCK10swu6K98lPE1pHEv4riWUKcszPMCXob
	8fzH9977xZ6j6wzy2YIgaqaSokimB/H1gEdMQksPh9f6efg3BIWIayQ5tvHteTgmOjttL4FXY=
X-Received: by 2002:a17:902:da81:b0:2c0:c14c:bf37 with SMTP id d9443c01a7336-2c0c14cc181mr2103265ad.16.1780310482513;
        Mon, 01 Jun 2026 03:41:22 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84246844780sm4225556b3a.30.2026.06.01.03.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:41:21 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:41:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <ah1hyp0oB5iJenQt@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
 <ah0kyi5asHpnrpgC@google.com>
 <6086ebd5-4538-4b85-bbd3-84df9c6198d2@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6086ebd5-4538-4b85-bbd3-84df9c6198d2@amd.com>

On Mon, Jun 01, 2026 at 02:58:11PM +0530, Vasant Hegde wrote:
> Hi Pranjal,
> 
> On 6/1/2026 11:50 AM, Pranjal Shrivastava wrote:
> > On Mon, Jun 01, 2026 at 06:00:15AM +0000, Ankit Soni wrote:
> > 
[...]
> > Hi Ankit,
> > 
> > Ack. Sashiko made me realize that this regresses IRQ mapping for AMD,
> > and I agree that the call to iommu_ignore_device() is a bit too 
> > aggressive as it  wipes the rlookup_table entry required for IRQ 
> > remapping, particularly in PD_MODE_NONE.
> > 
> > I was thinkig to address this in the next version as follows:
> > 
> > 1. Split the probe error paths:
> >    - Proper init failures (like iommu_init_device) will continue to call
> >      iommu_ignore_device(). I will fix the double invocation here.
> > 
> >    - Config failures (like ATS mismatch or PD_MODE_NONE) will return an
> >      an error but skip caling  iommu_ignore_device(), preserving the
> >      rlookup_table entry for IRQ remapping.
> 
> I was reviewing v5 last Friday and decided to fix probe() code as its been long
> time I wanted to cleanup this code.  I have a patch series which pretty much
> does this.
> 
> I haven't fixed iommu_ignore_device() code, but should be simple to fix it.
> we can use amd_iommu_make_clear_dte / amd_iommu_update_dte. It will set the
> dte.tv=0 and essentially blocks all DMAs.
> 
> If you already have the patches then please go ahead, else I can post the series
> this week.

Hi Vasant,

I have drafted the fixes (including the alias clearing order and the 
atomic DTE updates for iommu_ignore_device), 

I'll go ahead and post them as a separate preparatory series soon.
I'm also happy to incorporate any of your existing patches if you'd
like?

> 
> 
> > 
> > 2. Resolve the Use-After-Free (UAF):
> >    To prevent the UAF on the "DMA-only" failure path, I will ensure that
> >    the hardware Device Table Entry (DTE) is set to a safe state (like
> >    blocked or bypass) and the dev_data->dev pointer is cleared, as the
> >    IOMMU core does not invoke release_device() after a probe failure.
> > 
> > 3. Fix iommu_ignore_device() infrastructure:
> >    I will address the pre-existing bugs identified by Sashiko:
> >    - Fix clearing order (calling setup_aliases before clearing the
> >      rlookup_table).
> >    - Replace the non-atomic memset() on the hardware dev_table with an
> >      atomic DTE update.
> > 
> > That said, I'm investigating the safest way to revert the MSI domain
> > assignment on probe failure to avoid the dangling domain issue pointed
> > out by Sashiko. Maybe we can add an amd_iommu_restore_msi_domain() helper
> > to revert the assignment made in amd_iommu_set_pci_msi_domain() on probe
> > failure?
> > 
> > Please, let me know if that sounds okay?
> > 
> > Also, I'm wondering if I should send this as a separate series specific 
> > to AMD which is unrelated to this one? Or maybe handle AMD IOMMU in a
> > separate series altogether. Let me know if you (and Vasanth / Suravee) 
> > would prefer that?
> 
> Lets separate out AMD fixes part as its not related to this series.
> 
> If you want to keep this patch then just the "iommu_ignore_device" part that
> should be OK -OR- if you want to drop entirely and pick it up with AMD specific
> series that's also works for me.

Ack. I guess a separate series to handle AMD IOMMU sounds better. I'll
post one soon.

Thanks,
Praan
