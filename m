Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952C3BE167;
	Fri, 10 Apr 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775822143; cv=none; b=kEBfWFebAkDCa4qz/1j92a1w4M2pv/Y41BPn3judM2idXrZH6beshAQ/tqwEwsuJLvTtX2O2cpgPWV7yc5kGGFlMmZAh1BYGeYJhIcbyyqe6Lho+O5z+1vJI+63KLVNOEPTDbY4/Z3eDuRnsX2MMMRSTXijb8MQ+ShydEC9Ahaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775822143; c=relaxed/simple;
	bh=mdpaoKvaXfKLinXjUDc/IbjJOXSHqFvXpOvUOnu9NX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+jbEnR2ZNHT1wXbrtt9H2vm+n2WT+F66DJHEcXhjeINNnqDWTE67cXbw+UcsGEiaCkSfuQA6pGI5pRnHgEuxMS9g1y1iaijUJO4xguW2/O0fewXGpgdn+8X3VcV+xlYVlOVYsdhWs7mNWH7Mo98piHNcUBeMTePXGZ8KECHDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb/ZmOTV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb/ZmOTV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08420C19421;
	Fri, 10 Apr 2026 11:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775822143;
	bh=mdpaoKvaXfKLinXjUDc/IbjJOXSHqFvXpOvUOnu9NX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lb/ZmOTV/EI6r89sYKM9ULJyJetsrcgzEuFMg/9jkdKVHDvnAJGfhz6XABBV42pDE
	 tuDb+vDldQsgNNwYLOcZrBTikPs+k+KF+a7tGZuf4JesL90OlRBkKnyY9ttXH7PRhF
	 KMyZZBGUe7CHTFHem+Axjaq2pR3+kzKnCTPcWTdbknpkbY9bpWLqpkgQ//cSi7z7dW
	 JM9Z8kVYEjhEG/YrGw6zPJvyp3StfSjwyeG0Kz/ApB6/aG5lYpqf47YpvGvGF4AG1v
	 aj/jBzvtsjynVD3A0L6z5orp4L3dsfkgbRa0IwgajGiEEx72Ab5cFsooy/inKLAk6Q
	 sRx53daBp+a7Q==
Date: Fri, 10 Apr 2026 20:55:41 +0900
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
Subject: Re: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
Message-ID: <20260410115541.GA1770099@rocinante>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
 <20260410055040.39233-14-kwilczynski@kernel.org>
 <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com>
 <20260410112132.GA1756033@rocinante>
 <f6c036e1-9145-e784-8a37-2486fc72978e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c036e1-9145-e784-8a37-2486fc72978e@linux.intel.com>

Hello,

> > > This looks like entirely separate two changes to me which just happen 
> > > within the same context.
> > 
> > True.  I could split this into two separate patches.  However, the early
> > return is so trivial, that I decided to keep it here, in lieu of that the
> > linked patch did, too.
> > 
> > Thoughts?
> 
> It's not just adding the early return that would go to the first patch but 
> you also need to rearrange the len for that. Effectively, the change is 
> split in half, each becoming cleaner and more focused (both diff and the 
> changelog text).
> 
> As is I'm left on the borderline, while I can see it's "correct" after 
> splitting those changes inside my head, I also know it could have been 
> done better. I'd easily given rev-by for both if they'd have been done 
> individually, saved the time writing these emails about it, and 
> effectively "forgotten" the patches (including upcoming versions of the 
> series).

A simple "yes, please split" would suffice. :)  For future reference.

Thank you!

	Krzysztof
