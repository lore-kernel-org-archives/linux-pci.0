Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD7137187E
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310120; cv=none; b=Fs0OfcWAB050BX4Qi4IKzIJHq4yYqfz4DsWz8f22ipTkYvozFkKfAADCgCgfJjM+9lqF/YGQKnFeJu8HDRG7Y14/2LvcGkWnXacVwV6sIz+/fuX7E/fTV0aNDoKgXlsTKUFTk45PfLtk0yKGKAMofsMO68AzGqhkIu6LNRegLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310120; c=relaxed/simple;
	bh=EsLJvdLsMAdY3Oobb657DBhag9gfNQ+8zMcfmReVvxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3pDNySax0APJQ5oWEzUn3EPg5IpPt9wPb7BET5GXnClhIVsua/l2TuTEsoZTuyf0cMbaoi4sKdffhGniSJgn1ZnqJ2OWIx3BQ3SjchpKq4gVrBR/8OpWVxojmWcMAWbljdx/5LpyFgSyGvPVbvYruNi8qb3DtGuLl6VPOTu9O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6BIR0qI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6BIR0qI"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2911f93cso585ad.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780310119; x=1780914919; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oDUgrIyB02FM5mea3gf7dEX+Hdw7+v6D42bl2KCdIiE=;
        b=j6BIR0qI+z8qob63Ef4nXHl8QzgmzEIoKk2ikwxkSKxSd/WbBSctmO8ad0NUE7e1Mr
         vMNqeBd32ZWrXLZEPCvi+UcBA2ONvd7d5VaEqcuQ+k58MWj248un8UbGvk6rMH7myv8S
         0veUMk4bZkiJ/2Gp43+WNbjbZkEtPU7FhLWfVXgPYVX/QgbvJ/f/l83SGqlBxCjSEA15
         5p6ldXawEEuQfHWROtjasJEMLQr3E76rwoyI8aexWkiaPwE2Z9u1/LoT8ItpwN/IEHBa
         6IScjYAGm7I15vXVcE2TYGr+PwTA+4oN6WSA6lG9e26eWIFCE7kiCHW0d5dqXro9rG/d
         RIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780310119; x=1780914919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDUgrIyB02FM5mea3gf7dEX+Hdw7+v6D42bl2KCdIiE=;
        b=ikjDmYq6jx1Rd+OOfMAPa2VCSrmCZ1eu4u4WSYkw9g/yBX/VeMjYhhwb5FdckQdTwh
         n4xuqdX0zC6Se3riKqmCOnPXrn8ZYkzySNs1UIOhrbb/V9zsSALsLf5B8pop56rbwqVa
         6VsqrxXROPqcYcDAbziN2Ywalt31VQVP31jiTYsRRGue0r+6l94QBPbYVU3esIz8DuC/
         /h3BrzS8q7VXygKriOfqj1v3aqKRn84zq2/72TPPlJBk/w8KaW4IgJjcShzNUjlBRvNP
         7d5w0vMkXuBdXyzZGVE2Lyq10mmtNpwyqV96fVJ1PRySbB/d3OXxVFHCYtMZB6B+/Z42
         HkJg==
X-Forwarded-Encrypted: i=1; AFNElJ+akCohBu7IuR/D7HBzQNv//eCv3eSEe4pNSqgNfPOCan7oLB4jPHw5yISzljuay4hGXxgmiFB4Cks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTanmSodo/Otu9PQYpc40cfLyo/6ieyvE7/uvcFnNzA0KPPLX
	10Fpg8alUHJuIIls33n5+wMVKZLvI+8mIfWXo2uoOkruTOYpblLyzfR35yRl3ELL8r35DoHeweI
	m8xyEOA==
X-Gm-Gg: Acq92OG057kH1LBkGFiLabiy8Vh9zBX2hb8fUZ2S6qSGdqvde3nOQBHY+gM042Kjbbq
	5nOF4LVTwWuSQKT4LCrHvV+BC4pp1mTamDimx779Fu6OrwkDE6b8ycO9SKCOUW4rv8trGWkHnos
	E5q627rH+O3MDJb4JMR63lB2W0uX8kBvQa33BAeaRcBLc8pvRuDVnGGH8D8VjbFc5tBCl+ECaZ5
	35tiLTBSmOnUKuuOEVuQr/v4uqAGk3BSwq2vRtZ5cp3l5qPVpw23BHF7A+YAzdH8owgjQvt0CY/
	64WVXQehuj6KOQ/rO1Dfd5aEYbiKXKvq1yAy9ENKckLHyoDmzh+ggPeMOm00HKlvglJLEl9Op+O
	wuCEJtptXPwtoUQUZjinhs7VO57vtuhjJ7EEHIwx8vAUYB/gmiOhcualE1jcqteZvM7VAvxEyFZ
	58G45Db1zaRMOTOZCl3Rw8aZwZT+lpGgikOnpWT2CmuTjuypJpXQ7zI3nMeAvapWbvEK7YTmI=
X-Received: by 2002:a17:903:15c8:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2c07cb4cf8dmr4904775ad.17.1780310118403;
        Mon, 01 Jun 2026 03:35:18 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214affe29sm9720174b3a.3.2026.06.01.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:35:17 -0700 (PDT)
Date: Mon, 1 Jun 2026 10:35:10 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
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
Message-ID: <ah1gXgPIdVXBzo_w@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
 <ah0kyi5asHpnrpgC@google.com>
 <drmnqcya6v6wtcazil4wojno2crp4obywudycl45uvqszp66ms@5t5uj2624dor>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <drmnqcya6v6wtcazil4wojno2crp4obywudycl45uvqszp66ms@5t5uj2624dor>

On Mon, Jun 01, 2026 at 08:17:23AM +0000, Ankit Soni wrote:
> 
> Hi Pranjal,
> 
> Plan looks good. One pushback: I don't think you need the
> amd_iommu_restore_msi_domain() helper.
> 
> If point 1 preserves rlookup_table on the PD_MODE_NONE and
> pci_prepare_ats() failure paths, dev->msi_domain pointing at
> iommu->ir_domain stays functional - irq_remapping_alloc() /
> __rlookup_amd_iommu() find the iommu and the chain works.
> So fixing rlookup makes the MSI assignment correct, 
> not dangling - no restore needed.

Ack. That makes sense—if we preserve the rlookup_table entry, the MSI
the MSI domain mapping remains functionally correct and the chain
stays intact. Thank you for clarifying that.

> 
> On splitting: While patches 1-5 are essentially settled. I'd lean 
> toward pulling AMD into a separate follow-up so the rest doesn't wait,
> but defer to Vasant/Suravee on that.

Ack. I agree with the suggestion to pull the AMD-specific work into a
separate follow-up series. 

> 
> +Vasant

Apologies for missing the CC! I thought I had Joerg's latest tree and
get_maintainers would automatically add Vasant.

Thanks,
Praan
