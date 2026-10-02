Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20764FB9C8
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959674; cv=none; b=G+Dwke3qP/QU43/B+RST2Oaln3YW1zJI2RvAdYP+Fv7xs76Oxu5GlruBc8c+R/u3tR4hCdm+Bo1mglfux+cEdhbyE8VggCDrXjTCdZ14BmbQigOFnhYFHiXJdyoYA4wPsWHPVj1nSk5vGJM00ggM5lgo/oX7zrdtqzaeKiO4Llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959674; c=relaxed/simple;
	bh=GfLGRzNdrUQtKcYv331zMoj3Gl5JEVaaZYE2NszLXF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3dPvFNCUtlReajoRXKoUojq24rCfkMy7OdHC4cdmEmgwLdFM0YfRYSmt8N1k0DUDatC0kJazzOMjaOuwiZKRCrryck8JujogWGwR+0Sxc8F26OpUt9RQBj5bRVZYhG5v4ipcMsw8MZg41uLKEGokFnSx6edZRTZJ+khysLRbsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NFLU+lFN; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NFLU+lFN"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-149d5ec8e96so2220045c88.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2026 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790959670; x=1791564470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M8FgFfsrFu7NaKoGhtbGJNDz2Gwi+BLzqOzLKsff8ag=;
        b=NFLU+lFNR6hO9d50Zwufb2z/NzoVmMAl14UGet0DeHq6a5obEDMoeHrWveApPng8wK
         L2Aij0Dx+ZGh0ym+MwiBe1srkNL/sI1GV9WK5XVo0f3J+lwdC3OvgRaAhhNVtU6l2nvt
         B6ToeVUaI6qo6hX30dPKw0+GBYyOQogyDgC9whYikB2FevRCPhsVr6YXwhw7ukTasVMT
         hxYSWPZRHZgwUCu/GQ/9ixGiq3aJr5RyLwiAKfDFZjSOPXYgBSPaYKHjvR5pR6NdpaI0
         5xCQImOjoE25lHcIU0TwuhGlY2timDR7pPpxdf92aWoY4f3tA0AsrX4cfbGpBKiIVsyt
         +0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959670; x=1791564470;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M8FgFfsrFu7NaKoGhtbGJNDz2Gwi+BLzqOzLKsff8ag=;
        b=cUtdd6Gyr1Y6tf183X4wVsYrJITkIYdVCy9ALlB/fOOPhXjDPtBNaFL/W7S+rYSYW/
         0SDfx8dM4dtYnE9s4gYRgFWBHxfCeZSB80LokxsaNw1Rjm9/jtxEd/FiM14COwYYoDrF
         Omh63VwveXA+AzdCRSSlFHYlwfYXqCXMSofjIJyURfhn/mbDCxlBOLq1YthxKmw0dDRg
         VIy9lL0c0WH6IzvXXcv1CJo2snPwGz96KXQd3ytFtd3FKO9FQ7IcHtOKphVRli/gWKIU
         5cPcBpffpqOwDcsp8yz2ORUG9miVA2wX5SMQO7JMML8UCMirbkNF5/6OqcYNovhQ6HNc
         ZTTQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6o+Ny2V38/owTDKfjZNIUbAmCzFOceguaSTdxHP9iBABBMO+4VYKhJyS2ymzNCT07vjEcADZIpy0=@vger.kernel.org
X-Gm-Message-State: AFuF++l2ESjgGPf78ioYCcXgRw3qIemY8zrqFvqxTkQ9pkcglgMRcs9J
	CXPjTe/SoqP/WSJQPgxlNX05t7Lfjhi8eA1FRYcHgrTM6RQYHt55FrZc6sGF2cx4vyA=
X-Gm-Gg: AYBFou2bC/WKPpF/VrxmYSkyzBKtLrFUORd7845dSwmwtQ2LeDV14cZLwd2IxEJJHHm
	aB/q24m4GFX1/aS16JhrB1o2NouXHaIZQGXnmTFUCocUqpgFEnqA2SjBD2FJvYOXabrw/ehPedY
	iNrss1+kuGF4phm36JSfRwRbQEX3afXYzltmfJ1W38Tlq2Cn/2BvPoBFhXg0innLl2VES/Y4GT+
	MWFkgJzHNbEXmZRKADPG8rYkzuLjXznzbt8q/QEIOHj8jopVx4kGQf17XxsvPA3tUpb0ChNzHjT
	FVcXoDdvfxHFPk9ic2NbTHyn6WlU9wRWAAoaUQNq3YR+eBsmLypGBsJKlXQAbg+iZCwH0f/5vQo
	r+qAeQkB7Wcdz1tpt0G1SQDySsTGn6phRX0pYgPep04gyBPiALTRZHCIGsfmSj7svwNRBmxyxRX
	lMdQZbg6opPQw9/HZz6DkcNpRGZMIxe8iN+ujMwHhXsgr7
X-Received: by 2002:a05:7022:5f1c:b0:146:852d:60b7 with SMTP id a92af1059eb24-1508932185fmr1788544c88.8.1790959670092;
        Fri, 02 Oct 2026 09:47:50 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f45fee0afsm8489793c88.5.2026.10.02.09.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 09:47:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCgQG-000000008FP-19Pb;
	Fri, 02 Oct 2026 13:47:48 -0300
Date: Fri, 2 Oct 2026 13:47:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <20261002164748.GD3481470@ziepe.ca>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar6gY9grmdMZcN/M@nvidia.com>

On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:

> > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > during resume (the SMMU resumes *before* the EP is made active). The EP
> > can't use its ATC while suspended, and if it loses power/resets on the
> > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > back with an empty ATC.. same assumption the PCI reset path makes today
> > (pci_dev_reset_iommu_prepare()).
> 
> In that case, would the STOP flag be too late? It's only set in
> the middle of the SMMU suspend. So, an ATC command (via doamin
> invalidation) might be issued prior to the Point of Commitment,
> which will be timed out due to the unresponding EP?

How can you ever fix that?

How does power management really work, is it expected that the end
device is already quieted by its driver?

Could the first step in power management install a blocked STE? Then
we don't have to worry about ATC desync and that automatically stops
generating new ATC invalidations if we go and detact the domains too

Maybe I'm wondering if power management should involve the core code
so it detaches all the domains from the device, setups up blocking and
then the iommu itself could power ofF?

Jason
