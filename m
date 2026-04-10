Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A54397E89;
	Fri, 10 Apr 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819621; cv=none; b=SdyhgrTjMa3sgkbO0bJqA+7nmwt6KSRa3auz68NcyUTWbyH3VIjKngtLO4FKPY7V1lvRXg4Ton08PKGoYO0Q7NtxYgzNRZ2iYO27pKdRI3UtH43HI94tW1X4b9dOMiobLzsnIdNluQ1ca3QUA91Iq6SYrxha/CT640BwYCWM6cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819621; c=relaxed/simple;
	bh=tp+2vBtC3b7i++pW7T3oZUkkQ00XThq2Bf8TIH4wQGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSENZahu3o7mN4Jdl9Fb2XDPR2kIMIfdcbLXvNocWxyirJLnCOG2dPIV30x0P/z9dz2GJXih+usej0knobFCDB59U5bIlvwUXny83ESWZksN+klcImPWU7TRArIXSsMdUH6XIT2UY7WcNY4lLplGfrwEXvj3cr7KIhfGsp4RYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5l16K95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5l16K95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BC9C19421;
	Fri, 10 Apr 2026 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775819620;
	bh=tp+2vBtC3b7i++pW7T3oZUkkQ00XThq2Bf8TIH4wQGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5l16K95Yuy7Zv4u2Ee+Up4qtxS0POfOwlZpsSGzrt9Ojmt3piTwXDoyWVgseWXnE
	 BE1JTvmcNII3Rc6iilUmw/jJL/PBTRga43FG1gGeILK4OVNM7OKK9FUzYXel4sElhg
	 /EzZY/omP6f6NsjJlZ1lVRYAYLkQC1UFVtqIce6UXJWtaCvLa0faqH7IhfUWjfPoiU
	 Z4B3RwVIrJbExnBeBJwyqduESMXXdJyGkzKeIYCL3jlNGM0rFFh8JrhxIsBb6OlgJW
	 cqWeDJanlZfnOnWa90YObE79zRwptPIDMf0XaXxMrtOBMxZ98I6EKnpFY1GzK1TrdZ
	 1L3qfid+pwhPw==
Date: Fri, 10 Apr 2026 20:13:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	Oliver O'Halloran <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/20] PCI/sysfs: Convert PCI resource files to static
 attributes
Message-ID: <20260410111338.GB1750802@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-7-kwilczynski@kernel.org>
 <4fc23ce0-7103-545b-bc11-230b52c2de94@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc23ce0-7103-545b-bc11-230b52c2de94@linux.intel.com>

Hello,

> > -	/* Expose the PCI resources from this device as files */
> > -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> > +	if (!pci_resource_len(pdev, bar))
> > +		return 0;
> 
> I know it's same as in the previous code but I dislike assuming len != 0 
> implies resource has been assigned. While it currently holds, I'd want to 
> change that eventually.
> 
> The current behavior causes issue e.g. if IOV resource fails to assign, it 
> is reset (making its len 0 among other thing) and since IOV resource are 
> optional that is fine from kernel's perspective. But resetting the 
> resource means we also lose access to that resource because its type gets 
> cleared so from kernel perspective the VF BAR stops to exist. Losing it 
> means the user cannot solve the issue by e.g. resizing some other BAR 
> smaller to make space to allow the VF BARs to assign successfully.
> 
> So I think this code would actually want to check resource_assigned() 
> which implies also non-zero size.

Makes sense.

I will update the code to use resource_assigned().  Since we are working on
this code anyway, it would be only prudent to also do the right thing.

> AFAICT, this change looks fine (despite the diff being very messy).

Thank you!

	Krzysztof
