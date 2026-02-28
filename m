Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB36A33B
	for <linux-pci@vger.kernel.org>; Sat, 28 Feb 2026 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772237194; cv=none; b=dERXmABvw0+dNoFTEm1E9/1BKoghu3I93Cfl/LnF77WK4eYhWAoiK/s4E7wrN74ZRnhzqX7/KefQvxT5AycLF6xf2sHoU5wHtUAulnpawh4o2F3Mk8r/L8cQdKQ3BryQYlb9EB1FuUXyiHDYbizcz21FKY3edy82uB1M1UxpHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772237194; c=relaxed/simple;
	bh=D9pygYo/MNi4R02Zm4iGOoF0L2rPsDKjb9gvCd6vgKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLxxDQX/0EBoxf3LuRpWyGNbIgS8isTmHfRNnj1C0xFlNOrl8W4U13Hq83CptTa+ho85jESBAM5p1wuduwzPxQVmk+ENFEGzX51c1pZ//4XOHPgqFUuNPI+pVe8pd3941/67YVyVPMCd3rykrZsifKfNpNykHfUvHdHEW38YGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dkzrgaMg; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dkzrgaMg"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cbc593a67aso200587485a.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772237192; x=1772841992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0PqAr3dacsxbzSna3ChPqWEVOFqnIEsALZmA66GjLs=;
        b=dkzrgaMgalXVIq4VPm3pXWlfPaLhWVRII9QYSEEY7PMPFc8NcZANNZNC5sb+GOcz12
         c1YIlimtlvGmKWT2ED6wfQvN9ZQRaLofd/EeTaL/GSjb+xJ0gZYQ2A/g3qPH1mV+M9my
         v/fNbyTsbn/p7nxxYsCRb5oOWX8kYPvYZx0NVVxr7DQkZjQz8mBfbcP49XDi69hjRWfY
         NxinZF224MnEr73E4RGAntwf7YBh3xXNkhWt6k7rnYdg6j1AY3dVA5Db312Eg3J2k7Dw
         EMgArEKxeb+xKIbp7ibIkmlMZztWdURA3Dz16+kVHBV2WplIeI/PjNlpT/HkFKyjXUnf
         nNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772237192; x=1772841992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0PqAr3dacsxbzSna3ChPqWEVOFqnIEsALZmA66GjLs=;
        b=UOfEnvkVGOti6Q0B5j6Lb9ay0LIViN7wqzsstmVA55wUdVl0/55YlnEs01jT5PWwtH
         vtejiYNs+M/bz8bYNpR6LZ4HRnV8gGMai2Yvw2SuH69N2EHFzcD4P04lTEp1/r+ByfQN
         mSGZcexwigvTGrm0xJskGXnMbq16dsoBoJWkBWCyRn57zrfuhiJ7kLwv8jMUOJhVash0
         LEmzYr34wS6op7M56ZfwAdRjhOQLvYef2Onj7JZJnYq1xMmhKWjbxAPS8iLxaFfCvnbN
         +vODqfuKaoGfXw1GEZ2my2Su1Xle571GOKHlT9+/rTLfQXuTzn9gsSPlfQHqLg06X2xu
         lxkw==
X-Forwarded-Encrypted: i=1; AJvYcCVFIzwCP4A0ai4ythXRrQtBZ+vnqZXeo64ZbOi0DW/y0aWyTBn6PKNNPlDOHFWF9Z9iK/IM9FLMX3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dzT6Ydoe2vbaYn1A0omCWmx2LXHrtvmjONU01tqwXB3E15C+
	us4d3ih+2WCE/DUmN4OzLq5Uxr1RSnoluaDMCtMRbD8AhekdT8VvrFpDUD9JzhoZ7SU=
X-Gm-Gg: ATEYQzxRmEBFaQr0p+Np/4JAHrl6m27TpiswC55gv4NQ8uoq6H5t/N2qVCI8k79eCAE
	yse9oNT9wsJSivCZzfe34wOeGkCSay72Pq6b7Fs2LxcH1UmTUJYkCe1Ao+AhGScybyNczmzOo3S
	S5fOT8OWfMclZm+NuisXsNYyi2vjPEzAJcvCHR5GktQhVIIMjTh+9lYQ7u2kHex+KHXpg+mxC2x
	iEtBTlVueuPQFLGWv98oRNV2xVTGweg8BjO9As3Zr9yDKyY3MaLZHfuLX/f0TPT901pEsmgAk+S
	ZEgLNZjSFggLV3MT76iqjosDneJkqlxjOLvi0pJ1wIwqFwqPUQtGaxTspcVxpBY6N9yqzyttN4S
	dxZbUpYYSBVDzP4uqwPrR4Iil7DrI7VMf0TmO/zS7QqE1N3nV9pB7NnH30pYAIAYiUq28lRSv0t
	hjBLKwRvVN7cke7YG/Qkmr8mX0uHgaoTLGoF8a5hPHyZT8+M8r9O1LTHCkczRNWPsY6EmoUB9es
	3+9cj12
X-Received: by 2002:a05:620a:1a92:b0:8c7:b0d:df23 with SMTP id af79cd13be357-8cbc8e39692mr613986085a.79.1772237191471;
        Fri, 27 Feb 2026 16:06:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf72d3casm601180485a.42.2026.02.27.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:06:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vw7qo-00000001WqD-1LkU;
	Fri, 27 Feb 2026 20:06:30 -0400
Date: Fri, 27 Feb 2026 20:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org,
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
Message-ID: <20260228000630.GN44359@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-7-aik@amd.com>
 <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>

On Wed, Feb 25, 2026 at 05:08:37PM +0000, Robin Murphy wrote:

> I guess this comes back to the point I just raised on the previous patch -
> the current assumption is that devices cannot access private memory at all,
> and thus phys_to_dma() is implicitly only dealing with the mechanics of how
> the given device accesses shared memory. Once that no longer holds, I don't
> see how we can find the right answer without also consulting the relevant
> state of paddr itself, and that really *should* be able to be commonly
> abstracted across CoCo environments. 

Definately, I think building on this is a good place to start

https://lore.kernel.org/all/20260223095136.225277-2-jiri@resnulli.us/

Probably this series needs to take DMA_ATTR_CC_DECRYPTED and push it
down into the phys_to_dma() and make the swiotlb shared allocation
code force set it.

But what value is stored in the phys_addr_t for shared pages on the
three arches? Does ARM and Intel set the high GPA/IPA bit in the
phys_addr or do they set it through the pgprot? What does AMD do?

ie can we test a bit in the phys_addr_t to reliably determine if it is
shared or private?

> > pci_device_add() enforces the FFFF_FFFF coherent DMA mask so
> > dma_alloc_coherent() fails when SME=on, this is how I ended up fixing
> > phys_to_dma() and not quite sure it is the right fix.

Does AMD have the shared/private GPA split like ARM and Intel do? Ie
shared is always at a high GPA? What is the SME mask?

Jason
