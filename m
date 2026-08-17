Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107C23B9DA6
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969096; cv=none; b=FcmtnfEWsqhASmIDPA3uzJ2YiTEv1GaUM1xEo7N2TSx92d83HWeo6njCQHXX9o02lw3Vu9rWBOCcY/elR/tidV9JABLi9AKfN7W48rjTWEYp5wfe3gmbLts7xk8bv/3hiyQa55OUY9oz7sP9/vTPSUw65dvNbt+FR/+qo/ooLXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969096; c=relaxed/simple;
	bh=RG1WQKYzwFHfo9x/GFB8G0epwHF+rFnfAREYEUuqHv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdmBcqA2EvfnQ+Ea9vsIY5kJ2piikTVeDH1MzcOpPumC15ImtjaFg5wSD97nso0Okza0+iywx5I6XM3dOhkGPgSSKeimyJgpv1aUJ0SB0uwOKd6yglBCp4Al8BrJZno6NFCylLgR6vScUmj1WSFdTiWCmL/CDGSR0KpcVaoF8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FlpoiiRT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FlpoiiRT"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9309d4ea213so260419085a.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 05:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786969094; x=1787573894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssGSkvbB7xNlIkXjL7DRTJtJS9sZVm2NXMnYSqtWYgk=;
        b=FlpoiiRTdQA5bsaPw4RFj6uqEJdFDrfnXvUx3MC4WTB91SCMIAm+Tfm8U4AvHJK+Oq
         ClySINGGqjpEcbmJCITSDRLsCUtPD0pWgakkufi0iFLhKrpdFFwLUAqr27AhhdK86n1p
         nbng47gHBK9BffTnCEliXonDUBF2i++Okn4uVaGKXVVENH24447k0M0+vKUS/7osljeR
         bdSddS34v5mLFrVY7A/7u2HXPIsCrF54X14EbXRtxkcLQKYDvdvcobRNZ5iyTFUX+YLM
         QMDea8fxSzaj/g99KbXRtlDn2zOGrturounpLNVjCS0fyvU0a1qLROqofg+Dsc2ZxjPN
         SY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969094; x=1787573894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssGSkvbB7xNlIkXjL7DRTJtJS9sZVm2NXMnYSqtWYgk=;
        b=lgTrtQM1D9a3iUD34xWhEgoPqk4gayF5/FvnR6cJOGNPqHkx3oeEhgnXztrwRIgu/7
         J3ia29LW82ampX/dqhdmUWHHua9+d2Iq/GLA3yNwF8DQbPnYhKmmTlCj/QTQ0wXsQfsB
         JWnOGNA68I7zieuJwFsVyBtjQEbSn4+6TRJxxflrb1IOdt8MoB7D6KIJpyQVaaEi/c7o
         lrNuTNr9BhgdV4te6JK5oJk/MGCsYP62HCh8Csok5dRTjCxqJvO1zcbPj3HOz1pVsnGF
         LvrkRDotSwBHSKu2MT9ZuqC4DLo896COW0aeuJxrQs0izkHyvqa3OS0+myLRendExASK
         5Eng==
X-Forwarded-Encrypted: i=1; AHgh+RrQ8cSq1MZ7pYTZ+ZR+3OeKI75tVWe3zE7iO0y/2PlSikV4vjYIzEY+aLXdLbRJ7mfwiTW/gZBO74s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WtvV0Xm+ZIzEaSEuM0P9w5iPoPVeer77HUu43jznRXhRXjn3
	yI1x4gZ8OSubM/ZB0/7VU4L99ScJWl11YjwsMP4mCp+TavrQrKT/XGKiPtW6Yl2Jkvk=
X-Gm-Gg: AR+sD11loGuqOm7sv6Xscryx/Oa4XC8VkK2C/biKHq3THbXkcp4unojJbOdwycp71M7
	c85RwEahHG2CUcl4FeJX4ES2VRCNWZpd3+PM8NqY4OchszNu81VE3jQXx/HbOs7tPXviwXXp1I8
	MlWJYZ4QQQvcUaJqv8nY3vPu1lhiiKQtMeC7ahwznkcHrdbqyd71B8bcIhpbNlBmxll3JJmWOq9
	lbEQ+Fvs91IfmZ3F8U9ebVk3Mqqr0Hq3dSfHA6ZpZzhvloQ+jm36/nHP8/mD7Cxf0ZE+QX7ERYt
	I0Fl9J+gLGTAY7lnLr7Cq12XD+KSS4s/l9ObHnc18y0WIl2j6Fn4hAGahZUu97Qnd3VGCW8lzl1
	Y99xsuDkA8I55MaSTQu+MYvszPn58ORu6thSmesl2l24Z2trdbuRKBEtSlrHuSFNPzthg/tboIw
	0+p6389aJ9qR5AcNvmtxfuToFqf/lTZyQzN3xnug==
X-Received: by 2002:a05:620a:2904:b0:915:de68:1802 with SMTP id af79cd13be357-936d231eb4amr2766839485a.41.1786969093885;
        Mon, 17 Aug 2026 05:18:13 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fae8esm30006185a.39.2026.08.17.05.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:18:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvwI6-00000005tDu-3DCL;
	Mon, 17 Aug 2026 09:18:10 -0300
Date: Mon, 17 Aug 2026 09:18:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, kvm <kvm@vger.kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260817121810.GC933791@ziepe.ca>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <20260812045325.2733631-2-alex.williamson@nvidia.com>
 <an5JbIzz40svS3xe@google.com>
 <20260814083737.66bb83fb@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814083737.66bb83fb@nvidia.com>

On Fri, Aug 14, 2026 at 08:37:37AM -0600, Alex Williamson wrote:

> Devices are only ever opened into a user owned domain, the IOMMU
> context switch happens before this and regardless of the reset.  Close
> also disables bus-master regardless of reset, so there's no risk of
> ongoing DMA if the device is placed into an identity domain between
> close and re-open.

I've been told by HW people that bus-master isn't actually a strong
fence for stopping DMA on most real HW. More of a 'dma will eventually
stop' kind of thing.

It does reliably prevent DMA during the post-FLR phase only.

If the device hasn't been reset it should be kept on a blocking
domain.

> PF, I think there are arguments both that the user implicitly opted in
> to the best-effort reset, as well as a use case that allows the PF
> driver to fail and re-open the PF demands this behavior.

I really think we cannot alow a device to be returned back to the
kernel without a reset. VFIO should be keeping things attached to a
blocking domain as long as the driver is bound. It should force a
reset during unbinding as well if the device FD was ever closed
without a reset..

Jason
