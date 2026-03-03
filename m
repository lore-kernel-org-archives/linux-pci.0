Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E551DF25C
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772497155; cv=none; b=KNHOlgGsf7eiod86o/UMhW1D1BLAjzgCg0Vs6xzVjt9sEaxiCV2COa2H60pAVPQumgEC56SBuzlK5f6QHMPTb+d4Ynr4l392GRjOSoHNcEP1PtW7jSq5GqtHA4jXw5VDsHaq0Nv9Pp3tmi2/qkQhVzZSdfknYQ3BzuAA4jcXwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772497155; c=relaxed/simple;
	bh=pt/lyo6zfzp5um0atVczBnFUoiSRW5zCwV7Y9opM2zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhmF+hpuL+sD3rgG1h+xbhL9crLSZ4d2PuGvDWOkJXex0pCrd+CPczfdCn8Dtt+VsRNCarjc3cavC6+ycUM6FR/VDEMf8H5TrDaKeLgMvaRgTmex43BpdwYWk//MQVc2Q6oMtjyQpQ5e2whkLSnZnLNRkuFlQs3wldNKLGkeDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eFN5gBbE; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eFN5gBbE"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506a747448dso44895301cf.0
        for <linux-pci@vger.kernel.org>; Mon, 02 Mar 2026 16:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772497153; x=1773101953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBmRMf9aoSKjaEvUH8kwvq+kwq2UPw7m0MsTmit1ZFs=;
        b=eFN5gBbErwVOTtyKEbm2+UHQMiJjY6+8B3n9VqHgozuGH4ST2aWdm3VXsDrkV5U7J4
         NZFuSyOGBAxZtmyzog6VfIYKLdTgaA3JY+jlK3fQR37PbFAmBsWvqAh3WHkbxGWgIBpQ
         c5EKTl43lE3tYaAbKx6YGNlTMmAvQXX+zCqFDkafQhgNitlrSlEBcagkJvJ8nfhvCGZq
         SQPFXS0/IvalVkGRbwY5hvEeoEwxtmD2kk8kF/2CQ77N92otWVJKn8gxGq0mlfcvsata
         xIOBF6bjvmNzgrqScf7zx6Q7Rh53V0U3fdf+hy6Ju9ze1Iynt+7jT3kGJ2kSAh92gOCZ
         cdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772497153; x=1773101953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBmRMf9aoSKjaEvUH8kwvq+kwq2UPw7m0MsTmit1ZFs=;
        b=uL5y4c6vgwL5XNjWEdjFhxDIu92yK1Bf4GW/YeKswR4EXK5dupW+saMk53bDvqMa9g
         o2uH6LlLswvxxCECsVFA+wjxGOGiNoFvZXK3SN8mAGKlhhFgGcK4L1tHgh376R2tt0fZ
         kgzmnM6MEOkk6rWhb6SyaJ2UnsujeJjeuViyjAac3FW0GCsNQjgtHoCt3AkKP1gh0jK5
         KxNs2SMK3lictPnEeKO8annL9iYyf9IsJSU61IRIxdNR8+8QTPtvVar2kOz5gNNACHV6
         pFMTSGpYuKyTavxFXsq+nF8PzkoedVpp/ki6RZ9W2jLPkDkT0g2QGPAggSfh1yo0GdWT
         DL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWFo4cFVO35aC585ujEiiE+bltZJWKsfCv19Hqe6QZq6kHHWI6nuHhR76CYCE+2fF8Vz9HZRmnvaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8bRYigupV4X6dhb9vysf1h8ZWj1Fy4VRHjfiGJm0uWkNpzuO
	VXTKalpL57Pz1DfbdQELg8nWp6GFVzz4+624Dpy9Ok2isUCk46i/BWex5fGYmuGuJzQ=
X-Gm-Gg: ATEYQzwu2r9tD+QzHB7lQF2XJ5Z0FMcaLrhOgKUI2h6SSdId49c3IkLsJDtGbxpa31N
	syQcFydBnmLLGA2N5ATvF1FjvPGHT+r4nDg5M5G/RaNAmvsxSyULir0zPYAE9wTcrG60SeIBPWh
	uno1bPlZChHkHWstZXc0IfXYrOHf0vEmDAE5TA4Vkra3sqzN48NHpv3kBHGGIjNal0Pet2cpqWT
	2ti5u4zQpHKVMxoUgkZijaKatqpNOVBQTlmXgmkbKXOP0ikXem9DdzvmkZHWsBUKRp3Il2RAXmC
	8lrCjERz82ZFAQngvQtmgftnCubA1m08MO0qSb1cReQqTwGDLcqMFQBc0tyai4fRsXoqi9FeRm6
	lJeweGDrE0a8TLrFhHZnqwJqU8/ZlOCNKWJT52fXFJ95YB3SzeyEENhXO1E/qKKriynZSHwXTec
	BXKi4ABFpXhwn9+rnqhQJRgg2i2vFonutBVvu1+KVJvxi91RgG73xlrwRhQYjK1uMPLYV3yaz6n
	6ftoFd6
X-Received: by 2002:a05:622a:1ba5:b0:4ff:c8ae:efe4 with SMTP id d75a77b69052e-507527824e3mr187758101cf.30.1772497152911;
        Mon, 02 Mar 2026 16:19:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7159b44sm115519746d6.9.2026.03.02.16.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 16:19:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxDTj-000000042qC-2Ytm;
	Mon, 02 Mar 2026 20:19:11 -0400
Date: Mon, 2 Mar 2026 20:19:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: Robin Murphy <robin.murphy@arm.com>, Alexey Kardashevskiy <aik@amd.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
	iommu@lists.linux.dev
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
Message-ID: <20260303001911.GA964116@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-5-aik@amd.com>
 <699f238873ae7_1cc5100b6@dwillia2-mobl4.notmuch>
 <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
 <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>
 <20260228002808.GO44359@ziepe.ca>
 <69a622e92cccf_6423c10092@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a622e92cccf_6423c10092@dwillia2-mobl4.notmuch>

On Mon, Mar 02, 2026 at 03:53:13PM -0800, dan.j.williams@intel.com wrote:
> > > The specification allows it, but Linux DMA mapping core is not yet ready
> > > for it. So the expectation to start is that the device loses access to
> > > its original shared IOMMU mappings when converted to private operation.
> > 
> > Yes, the underlying translation changes, but no, it doesn't loose DMA
> > access to any shared pages, it just goes through the T=1 IOMMU now.
> 
> Yes, what I meant to say is that Linux may need to be prepared for
> implementations that do not copy over the shared mappings. At least for
> early staging / minimum viable implementation for first merge.
> 
> > The T=1 IOMMU will still have them mapped on all three platforms
> > AFAIK.
> 
> Oh, I thought SEV-TIO had trouble with this, if this is indeed the case,
> great, ignore my first comment.

Alexey?

I think it is really important that shared mappings continue to be
reachable by TDISP device.

> I have a v2 of a TEE I/O set going out shortly and sounds like it will
> need a rethink for this attribute proposal for v3. I think it still helps to
> have combo sets at this stage so the whole lifecycle is visible in one
> set, but it is nearly at the point of being too big a set to consider in
> one sitting.

My problem is I can't get in one place an actually correct picture of
how the IOVA translation works in all the arches and how the
phys_addr_t works.

So it is hard to make sense of all these proposals. What I would love
to see is one series that deals with this:

  [PATCH v2 11/19] x86, dma: Allow accepted devices to map private memory

For *all* the arches, along with a description for each of:
 * how their phys_addr_t is constructed
 * how their S2 IOMMU mapping works
 * how a vIOMMU S1 would change any of the above.

Then maybe we can see if we are actually doing it properly or not.

> > ARM has a "solution" right now. The location of the high bit is
> > controlled by the VMM and the VMM cannot create a CC VM where the IPA
> > space exceeds the dma_mask of any assigned device.
> > 
> > Thus the VMM must limit the total available DRAM to fit within the HW
> > restrictions.
> > 
> > Hopefully TDX can do the same.
> 
> TDX does not have the same problem, but the ARM "solution" seems
> reasonable for now.

I'm surprised because Xu said:

 This is same as Intel TDX, the GPA shared bit are used by IOMMU to
 target shared/private. You can imagine for T=1, there are 2 IOPTs, or
 1 IOPT with all private at lower address & all shared at higher address.

 https://lore.kernel.org/all/aaF6HD2gfe%2Fudl%2Fx@yilunxu-OptiPlex-7050/

So how come that not have exactly the same problem as ARM?

Jason
