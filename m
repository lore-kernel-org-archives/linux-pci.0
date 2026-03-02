Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145BD377007
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458531; cv=none; b=FhgwrrGQLdZV2kbvGAUxYdfbl6kh3WXqaUOunLA2zqAr6dzH9r8p3Utmpff+NakukgTz4vW7BRR4/OJluVFj1NjZKJCEvyOOeDKmhrzz/4MmlLhcFTLKd+1rncjXFF7j/l1QEar6Kkv3FxvkjfotUWe4wu+iADZYmj8AJrPnKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458531; c=relaxed/simple;
	bh=FbvCdNY37UamTN31SSyauOm8sq3E53gqKRjT2KA5HYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQRkVqR29Df6FPd76/Pb4n3hCWYJj5h6/yLJAy9j/hBdmPt0D053wSJAcWz0dAMSIJN6geD4inG2vwsthx5StyipDB3YJbASbMGpClJcAh9lESldNNkGC/1M5tsNTwbLaCb06k6og/f58T/GWjheevmaDsdApxdlKiTzU/YDsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I1M0dET2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I1M0dET2"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899a5db525cso39407506d6.3
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772458529; x=1773063329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+HFg2ochnrDtRr4Pe6iIPk9bCWPHCXlKNRCptQLo7I=;
        b=I1M0dET2Ho1B+9mNKm59IIWPjOOp4DFEB6sr8tvyhIGtableCz4iUafcseALk0B3Mg
         58uC+8aJDwvTfa5jdgPiuGUPA5do6INXBHg7IS41vIFJHJ+Qa4CkEccCPcCd8usLq3zY
         w/TYwl/chBBA+PGiOkvRsJ6OpDZ9wqBFD/ErtLLkbn4HAYMNRXcsNufcZQtS0dfKmcr3
         uIIyGiWDpd2zJStNUIALQAvzj39dkaU72ozsfsL6vS1UMd7JOM+uptBiUwMOK3bZXjqp
         orbE3ZKzdDCd8M4bJYJZ/rmXlKncVepAJ7MyoGVqS2shEwyJHI8okw6m/Pgp3pUyKaSJ
         9IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458529; x=1773063329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+HFg2ochnrDtRr4Pe6iIPk9bCWPHCXlKNRCptQLo7I=;
        b=EI1LvQrKPeA9bMVonPUjgAfBGvW7UCBHElFnvuqml7Ds3NA7owgTun6nSeLTecl+2U
         tdJsYQdMFoiX1Xj57lfYj+ymcxKxNtZnm1gCJ3iiXkRETEK3rPIvqjmVj/oRVvMUN6ep
         +8tCH/m0/eglTDYjmxDl1K+hfkGtgj4oRxRw0fu2I0yh7n4IjyIn2owonjT1EaHAmTJP
         xzYziQ08+a96R2kgJlSO1oJM94dZMFS8UQ9uvle0eVswpIU74vKq+8kCmiQ8+dDqQpDi
         RaT9sF+qXwUlh2flCuoPpc83n92nsGbbh6uWq9/DGMBjmRNFmBSD7XDVZhCgSre4yVS0
         v5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3UH4/fS5DpDrPDHoJw2s/XaUGBQNObWKtAv9OxZ4IxC8HG3Fmf+0zEPNC3Dj9lMyF3IowkSIk0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ocqgi/SWW/nAtVNCzo6QodBIqq/oIEn7flxa6BrZo56i0tOM
	aJOyt5cAMxJ0+PMv64/KvAgSvcdsFb9Hy6pFGF6N3VuXBTKecG80Mtvqt5ld67ivED0=
X-Gm-Gg: ATEYQzznROkPRdNneTDv8N/LM5NqWdDERn4G7rucvN3IWB6NldOSy5Ay/bdURgNQkA4
	NuP1Jg6AOe/Tro+9bqp4eGycgo/CZbfR0MfbJYfbW2wfyuafz+bvuIyOqrzPyyKS62ysbCco5JU
	S9UVtvsa5YawqC9K7s8LyI7pHeqG/pIp8z5Q3RMHs3mrbBGw/YFUGqxSttMzMUCi9EUazjrU3m0
	M2zZ+vo6aHM+P8QuWDh8IlaZPlWymtc1I3R7s/zNRHz0HLVC6i8CkToxfCi0m6xrHeyJC5DpaNj
	nih3kC2uKHSWWCfL3tNT8j8NVgn44r8HsgmWmH3rbfj+bDBKcJulms371oUwWF/B4hLAEf7LY/1
	w7KZBmVgIRR/S8HjhsoHqfmabtdxw8zz7/nEBpydpzlGUTiEZtyZ6RSuDV38sYyIZ5dOq77udQ9
	SHhKgMuYad3+sF2+Ay1GEgbH1ybiBwZFoH/j9JRhmexJUlSw1da/L0lqI+JBEBlHGwUk2S3bjNK
	7G2wPq0
X-Received: by 2002:a05:6214:21e1:b0:895:4b4f:133a with SMTP id 6a1803df08f44-899d1d8459dmr178895326d6.5.1772458528769;
        Mon, 02 Mar 2026 05:35:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f4fb208dsm35628906d6.28.2026.03.02.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:35:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vx3Ql-00000003fNz-1MAa;
	Mon, 02 Mar 2026 09:35:27 -0400
Date: Mon, 2 Mar 2026 09:35:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Melody Wang <huibo.wang@amd.com>,
	Seongman Lee <augustus92@kaist.ac.kr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Denis Efremov <efremov@linux.com>,
	Geliang Tang <geliang@kernel.org>,
	Piotr Gregor <piotrgregor@rsyncme.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kim Phillips <kim.phillips@amd.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH kernel 6/9] x86/dma-direct: Stop changing encrypted page
 state for TDISP devices
Message-ID: <20260302133527.GV44359@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-7-aik@amd.com>
 <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>
 <20260228000630.GN44359@ziepe.ca>
 <2a5b2d8c-7359-42bd-9e8e-2c3efacee747@amd.com>
 <20260302003535.GU44359@ziepe.ca>
 <500e3174-9aa1-464a-b933-f0bcc2ddde68@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500e3174-9aa1-464a-b933-f0bcc2ddde68@amd.com>

On Mon, Mar 02, 2026 at 04:26:58PM +1100, Alexey Kardashevskiy wrote:

> > > Without secure vIOMMU, no Cbit in the S2 table (==host) for any
> > > VM. SDTE (==IOMMU) decides on shared/private for the device,
> > > i.e. (device_cc_accepted()?private:shared).
> > 
> > Is this "Cbit" part of the CPU S2 page table address space or is it
> > actually some PTE bit that says it is "encrypted" ?
> > 
> > It is confusing when you say it would start working with a vIOMMU.
> 
> When I mention vIOMMU, I mean the S1 table which is guest owned and
> which has Cbit in PTEs.

Yes, I understand this.

It seems from your email that the CPU S2 has the Cbit as part of the
address and the S1 feeds it through to the S2, so it is genuinely has
two addres spaces?

While the IOMMU S1 does not and instead needs a PTE bit which is
emphatically not an address bit because it does not feed through the
S2?

> > If 1<<51 is a valid IOPTE, and it is an actually address, then it
> > should be mapped into the IOMMU S2, shouldn't it? If it is in the
> > IOMMU S2 then shouldn't it work as a dma_addr_t?
> 
> It should (and checked with the HW folks), I just have not tried it  as, like, whyyy.

Well, I think things work more sensibly if you don't have to mangle
the address..

> > But in this case I would expect the vIOMMU to also use the same GPA
> > space starting from 0 and also remove the C bit, as the S2 shouldn't
> > have mappings starting at 1<<51.
> 
> How would then IOMMU know if DMA targets private or shared memory?
> The Cbit does not participate in the S2 translation as an address
> bit but IOMMU still knows what it is.

Same way it knows if there is no S1? Why does the S1 change anything?

> > > There is vTOM in SDTE which is "every phys_addr_t above vTOM is no
> > > Cbit, below - with Cbit" (and there is the same thing for the CPU
> > > side in SEV) but this not it, right?
> > 
> > That seems like the IOMMU HW is specially handling the address bits in
> > some way?
> 
> Yeah there is this capability. Except everything below vTOM is
> private and every above is shared so SME mask for it would be
> reverse than the CPU SME mask :) Not using this thing though (not
> sure why we have it). Thanks,

Weird!!

Jason
