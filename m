Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2932FA18
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201793; cv=none; b=X1eDt2IBboQYoYMHI87iPnidRucV5Kpw5MLPpRG0J/fk/a+FGxJ0L5X7Jto8o73GtmLSP/SnzaPau7l82d7z8ApMa2qCscAiFHT5CdGHv8xN1D5U65g2aa3kxm7M71njWwiHz1LcwnjzdEOtB2khHOFr8NkHZ6quvxRC6I3dm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201793; c=relaxed/simple;
	bh=/6T9OxCp9BfBAX39R91Thab8mMF0XqoU64D3P4OeBeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huqex+eaV2CfRYCB63I6G314z6rd9nA59KO68V574S/FcyBh1bs+PphrvnzdaSkbwjNPkCyjO7COxO/zOurr6twIydzdxV/5ySgUxQEjhf5IZJGactegF4BXCjbuiAZTOhaYgoe1GBS6BYjEUkO4+L5D9YeD5U4sHqtWZ8dw0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O43c6v7I; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O43c6v7I"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-902deb2412fso468155085a.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201790; x=1779806590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXdhVWEeXcyE6eZ570qB7rBPR0o0acgN6kYHC3GZbqY=;
        b=O43c6v7IvmMe3/TI9zBvyvyP41rUTFL6q1rn96N5XoDPcUK8mitAbrTpjXw/HCMcZ4
         hEQVLn87ASeJbkTUZzXw6eZjGnfMBOFCylKOG+WVh6sfkPgdjwFWRMbzUXbHmepNlTOQ
         lHKF2GZaHquyrxamjs3naSAAafsFn6YvfpLww66mU3fd1IDuwXe1EuWW3FFvhFVu7Oh2
         BAn1K6fQYoikIdJDQXO1tXrT/P7Z1B6xaQIppLdeVzgoCVLYIreNxUfU+wn2UOo0FfIW
         wAuyBd/QuGJQ83EDMrhZpMiawUrvf86xpzLQ2dNvdwHpxqeKhO+/JhUf2UfNyij0VULA
         viww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201790; x=1779806590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXdhVWEeXcyE6eZ570qB7rBPR0o0acgN6kYHC3GZbqY=;
        b=Yu9hW+BtuHZbIcWJiN1swsrziHApyDw4Q15dmt2SsGYtf6WQC2wQjDqkwy6U49tR7S
         a+nDSw9XjBQQgicDieAmLuAS6qpXtyJCIo5KshyA0bmcXJldSfhbgifPKkrMFNPf50O1
         rzlYpYKIiprJuoS1llp22D6n+dMPkSeekTDO6EoZIwLWSriET/otTcbyh6eTPo+OGqTq
         x7yQXS1JZX2V/x3X7k+8WF1cx7YLB24k7t0xD7Yj8lZzSWGqKGGexEfGWvYSOCgbL733
         4zmRxIzKVlvsOneOkg3YMUpvh/g9ZNQP5oQOUTelFy/1GGaqO2gIdQ/7GktTDMYfNTnw
         2Exw==
X-Forwarded-Encrypted: i=1; AFNElJ/hg0xA3NyaaKAlkXGjN77IiaZmsWZbldTwyDD0zJY1G6m0+W4BscYxAFudEONlwS8MWIfZgJHQpEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2oOs9AAtO+vUtbhcDqyctgl/gDQAS48+Fv3rxGlAZ9n+5x9K
	dVkz5jTV7vKB4lQfnDW7lshsRD0Vah2xXsIwI7BgV5W1ojmcTOzJMfY0XVzUIYXxG7c=
X-Gm-Gg: Acq92OF8XmyNb7o3fBoKNaQDzjaBmg1UHdSYNTZm6dy/I1oBUJnxS+2bPKhKnQwEUGV
	21DxhCPOFgLR3/PF9dUbhZEGhIsNvw4wTmF5DMtkzf+8eSgVNtRG6UlbuZdk880FrFuf938meES
	8URz9EYZJRfGLbi7LV1uik6KasOWgw8ftR2+5/iVpJX1AXs7n2io1Q2TgLOPdn0WL5/Q87tykPx
	8Jv2EK5VKRa2j71ixSCak3xJn4MOZnPMZI27AEtRPeK+ZSQyTjCwV/C/u/jMnrDWd6wxKpEkkjZ
	qott1t+Rn8SmJzEAUNz9HlS3mhbnir1mhAuDsnFskn+IRGPbAtNeTcaM+jOjQ5KZp8xb2nrWUrw
	ZtcCjqxSOqGPJzZTn+9SOLDHlACsp4qZQdeg9MhVlHyTVsKJUfZWQiVZuX0RHysR9I3Tf7+sJeY
	cWMFwExg9z4Dzbja08IAmdQTEGkcu2Vx7U3iGTd/MrAOfcxPVMpelegRZxwcYH8z1iyXn0onKIH
	6iLFg==
X-Received: by 2002:a05:620a:2685:b0:908:e262:52c3 with SMTP id af79cd13be357-911cef034cdmr2991227885a.46.1779201789618;
        Tue, 19 May 2026 07:43:09 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba181322sm1861707685a.7.2026.05.19.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:43:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLf2-0000000F8WO-2rlK;
	Tue, 19 May 2026 11:43:08 -0300
Date: Tue, 19 May 2026 11:43:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 2/3] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <20260519144308.GH7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-3-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-3-praan@google.com>

On Tue, May 19, 2026 at 01:53:21PM +0000, Pranjal Shrivastava wrote:
> While every PCI Function that implements ATS has an independent ATS
> Extended Capability structure with a Read/Write Smallest Translation
> Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> driver to configure the STU on the Physical Function (PF) before any
> any Virtual Functions (VFs) are created.
> 
> Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> PF has already been correctly prepared. However, this creates a potential
> mismatch if a VF is subsequently prepared with a different page shift.

I would be clearer here, this is not a "mismatch", it reflects a
kernel bug.

> Update pci_prepare_ats() to validate that the requested page shift (ps)
> matches the STU already configured in the associated PF. This ensures
> early detection of incompatible configurations and maintains the kernel's
> policy of consistent STU sizing across all functions associated with a
> given SMMU.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/pci/ats.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
