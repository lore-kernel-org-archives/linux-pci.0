Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293247;
	b=zNcGN8jpm9HHt6ZFjQ3YHCa3oewBDMl4RGKJlad+wF9/jDpiIztWyaoFZIKqaVHEsa1l
	 6Cs7QH95Xi3SylhN8svP5W/s10rFMNC00fjaAePjA3o/2JUed5GBHoi3L1vI/x20QMdna
	 x9c3KJAxaoCxublbSeEkK1GAG1pQWdZzdlARCKuse5syg0edjU1w7IpxCRF9rB1ABPP+Q
	 Cwh0mRcUnTU9ZwbvfoWaMFF62m1ltEgOtxHfmxIqk48kTAEREbD0FWshpKOM4c0H/JdQs
	 DuMMQ0QYwZ8mZi1879P8LLSP1NR+tWZ99xJX2dbdctWB0g1ssZYKz7xt3y360Rq0/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZD/qDGi1O6nHsAaexh1x5wdETQZTzQoYlRWPgZIsXpY=;
	b=M6qKIPRB8k3KXyxPhLqbKWzUbXH/hv71XZEcPMiyZDX1k+7hY9h1nANNULE6Jgg5uYRj
	 GOHi7qtnU7Br4oyJRHzI8H5IG7zl3GBXYr9PFkdhdVkKArGLM3WpfVJTkec2BkACIBdjN
	 2ZpO72kBYriZIMQckzawoQ1XNCRm0g3Nr612MioDxcSOoYyAyn86Krerra0ThS1UUTLCH
	 0j9zItyyyTp3IGgUdaqm5kRuaId7zlkECL/v7+ASFNct2nHJ+82Wz7AZ5iZ6qGxvaF+c8
	 Q7ko5i5HoSd9bO+STmOUHZYfKZUKbWOvPYA2sEz6L3vYg/UgY2AiCuIvRHif5cQDvpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b="P/ryviEr";
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC8F606A31E
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 17:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC8F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=P/ryviEr
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a707f37eso22666816d6.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793293246; x=1793898046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZD/qDGi1O6nHsAaexh1x5wdETQZTzQoYlRWPgZIsXpY=;
        b=P/ryviErdiPh42kReFxkMw1q1mH9fz9TsFFVhDr7/C5Fa2PSoxZUA9NuSEwkEuOkDH
         fNZeVoONCuCJO6q9+z+VTVZWbo0t4PQAZZQbmnCCao5RytIfbF7qM4u0UGfrh8SXqE5C
         1Oy++8U8wu01GKb+uUKj/3+Vr18qQiyVTGVonel5fUq452tyDa7V3ank6XovkMgPdMz1
         b4mfXcw4lUP07SJ9XOoL+xDmONdFYgfmQzR+4w8bOdy6pmffsNZIdJApXGGJQO3JrUXL
         yXzp8LM+iVAhhqSPhoFCJc5loCUVs6wj2cMaSUauBqxFa4vtTkEvYVcrRZ93WpEPiEEE
         wK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293246; x=1793898046;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZD/qDGi1O6nHsAaexh1x5wdETQZTzQoYlRWPgZIsXpY=;
        b=yso1ATkSxhQe/hd6mgR6fsgEJD12FyvpsSUD388rxlwP/HZP2yLTKmPw7sms8FaYLC
         bJjFABt9zy4Pup2O3TeCYviGCMIu4bsnp7hvtHITt7Sfw9glP0j6xFkPqkTdfuLfABO7
         XWx1KWdbt5DQflXB0gvypzV9dyweJdgyq87jUvCwBhDJ7m1yXon/LVIQcGq9Fl4Psmog
         yM+ArAKxfD2EM1+6dBxyLZ6joU5BnUjhvABm2GzS6zBq88hyfB5MVw3De8cmXzDATQwN
         +dh5r3+3Bz9eQNicJ61tNA/F6armVDMikFHpT4DDl8WQUHidAinXuUJmzHHN3ehk1SnY
         DWNg==
X-Forwarded-Encrypted: i=1; AKwUvBzmnDfwXkt70YHF5mpczo1SAPGqEfYLLYJE+0PhG/5NDMLdB2i2Z8J8oYPqGzLdwyUJsNPS6nUSME4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwiMxQH1c+fEcVN79c2XC7IZbgFeTi5ULJS2hBAJmV8O9vyGB6
	2QVQwYmDLeZ8dlbBmJQnq5W2DSJvBDxUc0vYlXiRTJN5HlaFumYjUWukmGrLsMYvzG8=
X-Gm-Gg: AYBFou3KzjBH1Lps+Bh8tXcPQSCzHCaxeo0vl52YDOCcwmKmvlDijUOTP2bsfHHPDSi
	EV2hti9B8yFbgKE0tE6N0JEUdkzeL8+7WMgY0DZ/vA+Hh+Pz/LQxrZd4FOtIYOVpfhWs3AowAkO
	hNa+jvGC/eH8nTXSUloWHC9EeG1qXo/+Zmvc7xu0rjYhsVR+gRj5wFygrfxu1/uE0LKGx1/Xtrp
	HO179wlAgIPXv3jICopQ4nc5fOV7WG7WvJ8krPNnP4WxzLkxCeEt986je4ns7OfnN2q6Wo5e8Ku
	5iXxfvF+sjTcQJEU9BRxTrOBlrYxt6YRWuwIImG3GEZbQjSwD3EyBB/66oyDDdYHK2vTVT6oZUR
	CaVYxpPChWOZPihp+y3vmDYGj0b430oL1D5qt19RWoDoXPTgNRfe1jxVJZj4zuaEffAXNxO0MgV
	ExdsQsRxGUAH67GRM23MbuiP4Rc49mJONpYvLSNZ2sEBQFnnbCrl7aTHqRmdwXIZVzKNjPtbyXS
	o75J5TIz7olKPTu4VLJrDOe0MedE4f/a5HH7gy/epdFOjDmxrFQclO4T5Eesn6fR1jplB7uKUkI
	jh2Jbn6ONUVP/aiv7MEDkIworiwOy8NBIXrFpyquqRO9OGlG82Xom0hXTQGk752obKBWD5pwQyJ
	+bEPRZyNq9yQ=
X-Received: by 2002:a05:6214:3a87:b0:91c:6e6a:f1ad with SMTP id 6a1803df08f44-91c7cb836c2mr100048286d6.0.1793293245829;
        Thu, 29 Oct 2026 10:00:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca317a421sm870346d6.44.2026.10.29.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 10:00:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMTUa-0000000G37w-2g1i;
	Thu, 29 Oct 2026 14:00:44 -0300
Date: Thu, 29 Oct 2026 14:00:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: alex@shazbot.org, pbonzini@redhat.com, seanjc@google.com,
	bhelgaas@google.com, jjohnson@kernel.org, johannes@sipsolutions.net,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, vkuznets@redhat.com, kevin.tian@intel.com,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] ath11k: use KVM MSI domain for VM passthrough
Message-ID: <20261029170044.GR1685504@ziepe.ca>
References: <20261029163713.1366077-1-jtornosm@redhat.com>
 <20261029163713.1366077-6-jtornosm@redhat.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029163713.1366077-6-jtornosm@redhat.com>

On Thu, Oct 29, 2026 at 05:37:10PM +0100, Jose Ignacio Tornos Martinez wrote:
> @@ -855,6 +858,13 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
>  
>  	ath11k_pci_msi_enable(ab_pci);
>  
> +#if IS_ENABLED(CONFIG_PCI_KVM_MSI_DOMAIN)
> +	if (kvm_pci_msi_wait_ready(ab_pci->pdev, 500) > 0)
> +		kvm_pci_msi_get_address(ab_pci->pdev, &ab->pci.msi.addr_lo,
> +					&ab->pci.msi.addr_hi,
> +					&ab->pci.msi.ep_base_data);
> +#endif

This connection should be done through ACPI somehow, and I think
Thomas would expect this to be modeled on the platform msi domain,
just ported to PCI instead of this.

Jason
