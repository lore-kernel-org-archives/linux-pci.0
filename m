Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8022E3F0
	for <linux-pci@vger.kernel.org>; Tue,  3 Mar 2026 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540113; cv=none; b=NGRO+YmnUOOvkDWNmvFTi+uyKDezJNhTHSCGI/qGzsalA7QVusLvri4AaR8WXQnss8FEPc4QLH0Eplf8Jhi5c2hQhGmH+IJs+ChCvPm8ca5kmPKTJZZQfnbLvwe3cPTUzp+rCuklAJ+7JbAewSzv1fskh/NQw2DTCM1X1F9kO3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540113; c=relaxed/simple;
	bh=7Rc9j3LNiGnIyTeHz2J0Avp/KOXJP6cs2JgWLFyvSoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhhIVuB2f6R/ElAS6/Y1N+1qd93uGyLsj8J9OJH5ocnBzn/k42yimHCiiyc+FfrWXnor7W3jtzYgJBLR00LOegRi5UJD4pLA1kj4P7E0DvC4YkbWrusViGNVvsQF+vsdEZZewXXmvrFmu2kceMZrWogsiiI3yGa1/Y12UXEjr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xi9hTjQX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xi9hTjQX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506cb1b63d0so67770571cf.2
        for <linux-pci@vger.kernel.org>; Tue, 03 Mar 2026 04:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772540110; x=1773144910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MM4W4u3ny+cRpfXrxu8DnH970Z9q8VF2tWXlyBc85c=;
        b=Xi9hTjQXci5LpOXbCPKiygALDSRfu87R3o1ecGvrUT9JcQZayA37DX8wKo7FWuU/Ss
         DGy/hw1qNq+fCpNUaWmrUqz6xUbzVj3kKS33Yoy5tW6cDlvvsMN4Vbjm3/K8DWxUcW/O
         SvJIvzXO+4ah8oP9zc7edsqWininE/2EhJJ35uACW5teVJaBJfcKI4fDDRvF18JHcjOO
         eQ64C7iz2eTpKM+doTs8lq+zrc/4Dhh2x97Lueyk3dWxjNFntCknXcKk5LYo8P+F5KZh
         2uVqbTJ8LwpE3ZV6+0fq56VTkfHOAg+Z51M2fjrh+dHM5MMNJjDW3edk0q0thnAzAHGA
         u1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772540110; x=1773144910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3MM4W4u3ny+cRpfXrxu8DnH970Z9q8VF2tWXlyBc85c=;
        b=AwAZSJWL7k5An4ldKXERmmPLuJ2G9PqrVQ+I90E3l55qRpkOvvYwGg24GVUqLuo1IA
         I+f5PBQ2mV8lDoS0wfNlhg0StrrZyndt2nq+cZgx5g3OCIKJJiNtbxmn/W+kh4kzmCxG
         YFg5KcR+krv75B80OCNZl+elXQlHMqxhaWn2mKCzMyGY1eb4q9K+fPWh/n96mNTQX3pT
         t1OBCtVc3XsqbNNMYEse2c0LE+Q9lBim1Gg1qFbi7Tv6+0EQdEc/g0h1AzqFFSdj1yk4
         pat3ufte39Nv9uysyfi8llu8ju4344nvDmeODiJDxXMi6d96ZFz0i2juAzktIt/dpE96
         4PBA==
X-Forwarded-Encrypted: i=1; AJvYcCWV3vCamor1DFZ7J+WQkbMUgwvhEbpTnME1ydl0PJ3IGC03MRVof/Wq9ob8zavTXxHLOtALuQuxgmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqdcs08NnZY87CmOypnqCbiUTA7tHr1Khn2P96Xlx6wouv0kb
	ETpSpxCyHjxCoX9C/P1cbk0NR9omJW3attu9fLXlJVT104b1gssayCghikP0CwJkl1Q=
X-Gm-Gg: ATEYQzzwGsBPP8ZxXcOmYeucIVPtuhoRul9fTSyzQ1EuV/7zzsd9ZmUu/8dIyfA+Y16
	KZ/NsDPA4C6Dvm+3ow/Oar+/w9GOm2wgjrZ4VNzeOAgtFIHapvGzx5MDVTbT/yV6g6Fyk0C7WDu
	BuklpbT6p22yomahAR7F6kSTeMtRi3xIeU4CDXDKThWVvJgq2fxvfB9NiMy+3Zx0bEUrR1Te/He
	KCsnw2ka6uAhoc/m/Vc2UdTt5UF1frlc2D4BGoqR6p/MQ2338u7atvGPgvm36cDEHgOKnuUHWu3
	0P3RngF0B2x/nocqWcj7CIxll6zijSAr98uVmiFA+ZQ4Cld0ErPPULkP83nhmMZm0/gzx5XXMFZ
	Xy6LoXmo8axe/DA9MJpweyToE736idzxnkj9A5MYNlqzxpzxRC6n9qR9aX9XQnBGkZgS4Z9O/2T
	HndXYdTH//4cEc8l9ppX2H6azU1yjbvrES6I5E6HEu+DL11fNoH6GWMwz6P2CDSAv1PF65Ozfw5
	6R/NTFN
X-Received: by 2002:ac8:5908:0:b0:506:a287:a87 with SMTP id d75a77b69052e-50752849955mr200806971cf.40.1772540110255;
        Tue, 03 Mar 2026 04:15:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5075feb4db9sm79588961cf.22.2026.03.03.04.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 04:15:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vxOea-00000004CWJ-1Uzg;
	Tue, 03 Mar 2026 08:15:08 -0400
Date: Tue, 3 Mar 2026 08:15:08 -0400
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
Message-ID: <20260303121508.GD964116@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-7-aik@amd.com>
 <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>
 <20260228000630.GN44359@ziepe.ca>
 <2a5b2d8c-7359-42bd-9e8e-2c3efacee747@amd.com>
 <20260302003535.GU44359@ziepe.ca>
 <500e3174-9aa1-464a-b933-f0bcc2ddde68@amd.com>
 <20260302133527.GV44359@ziepe.ca>
 <9cf2e2e6-0fe2-4804-9c62-bc60c89d57c1@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf2e2e6-0fe2-4804-9c62-bc60c89d57c1@amd.com>

On Tue, Mar 03, 2026 at 07:19:36PM +1100, Alexey Kardashevskiy wrote:

> > It seems from your email that the CPU S2 has the Cbit as part of the
> > address and the S1 feeds it through to the S2, so it is genuinely has
> > two addres spaces?
> 
> S1/S2 PTEs have Cbit. Addresses to look up those PTEs - do not.

So we are back to what I was saying before: using phys_addr_t to
encode a PTE bit is probably a very confusing idea - especially when
contrasted with the other arches that have a legitimate address bit.

> > Same way it knows if there is no S1?
> 
> If no S1 - then sDTE decides on Cbit for the entire ASID (with the help of vTOM).

Sounds like the intention was the IOMMU shared/private space would be
controlled with vTOM which actually does a create a legitimate address
bit in the phys_addr_t.

A sDTE global control is OK for non-TDISP devices, or even devices
that haven't entered RUN yet, but it is not OK for a TDISP device that
must still be able to access shared memory.

> I understand I am often confusing, trying to unconfuse (including myself)... Thanks,

It seems to me the AMD architecture itself is pretty confusing. :\

Jason
 
 
