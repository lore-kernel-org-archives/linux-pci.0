Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1716838F950
	for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792259356; cv=none; b=gMN38GETIs9Qo6963DzdKsau8BBdofgq3czoN4Z1sha3y3MRLEBYvJkFCccpJ1IZqvOxqgxzjIROmLDsrM9Noe+WZtZn64roVvgPCQQyTAg1l3veJK+/GeVNF2W3LfIdHISDfoE69g4QrURVMjgwHEPLEIBjCP30TwL3F+84oOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792259356; c=relaxed/simple;
	bh=9iVYwkAnCtZ3hFTHC7pQKEPigp9IEaagz00Mkpk73RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdjRrrL22hkwmtkdC0xcrQV5AFRw9bIodr/9KqdXPZqaLsc3yT6lTR00f8wUdNr4N8PC1Zs14FuJqAR+2HlIQikX9SuFgOLTuDri4c4skE59kBWyzx6oilGn+DCLioN9aSfbyiKd3Heyzfoglt8NT+5YndudU3XylvFEL+zPSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NRyAzGFy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NRyAzGFy"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91beb36fcc6so2889536d6.1
        for <linux-pci@vger.kernel.org>; Sat, 17 Oct 2026 10:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792259354; x=1792864154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ZKiIqr2wNuyAPe6hCnVLHZyBqqQ8TWVMIEldJ82jWw=;
        b=NRyAzGFywlf+ipFSkikeU1QJNkmpIa6EXsxE7+o7jrUMJwkna2NQbS0i6CDrzKuziq
         psUDgr5fFUjCbFn5Z0o7CdRmuU/DbCiLGCKKX/hpmeUL2U7oJE3UITKw3Pw4wn/N45/Q
         YHf1HlBso1n07ntQMSElPSX6T3YXss1oNmpm4GU7EuBoKpyVGaNgAgDo257Pon9Ygv9w
         ZNBVia5CXt5bw1UdncCvS5t2IgUKzmknh33OgewHLvfZAJuIi7pmCtYv4N0a4GpvoZMH
         ILm6LX2s+NXpb/KSr9bjW/jWVFEUqry6horlblCLB3Yo/LkcHY0MwO7Urk3DBr/dHaVO
         cMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792259354; x=1792864154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZKiIqr2wNuyAPe6hCnVLHZyBqqQ8TWVMIEldJ82jWw=;
        b=tyco0Hz2rpn61FBGebnLmgSCKg7En4HRGHOcp8VPaNMOPHxeKA42meQmnpBg6ljhbM
         rWO+7soel4BJVT3JZeabeGnN8TEjWrSqRn+cGA3aJz3OiYSxkqDPI6btVBuwHCHrlOUU
         rb4DUATbdUw0bCAhlMWlfg4g6iNGF8X5dHpHxVzoZyp9uAV05k5N5yG/wwV+kn+RvifO
         4/A+W++VRGMHw1tnXuTLf7nDkgucYNPZST1cJzo+Ifz7rjFY15v0hA1qOtTf0nwrNdaS
         noosSZbWVfV0ZQWj3LavzRag1Abfcw8lQeNewPpNA3v2kUK1rX2ylyQ/ITFa5PLEfm+X
         Ttnw==
X-Forwarded-Encrypted: i=1; AKwUvBypH2qVOZqOF9f8npseGU6GpkqR0r2TlfdMBiL77mBJ3tV9ZJ58UHuMOi+USBwN0x/RbbapYfjM0zo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBxBNU7lHPvOXciujw7UNaZye5BFog59oeqTysj8wsI1/paDJv
	u/AYhk8gKLH3QlHquVmaa8TCoIJAPmKJlUGpJgirrIpT6iwRg9t0QOOshqb7kJwScqw=
X-Gm-Gg: AYBFou1T8Lur7/YkrXl1EgWr9SHfgevpWkNkaDJniljnn+iSl5nSKXEuYWdYpRHyVJh
	AjkGcUtFLzc5aR8a0ByHIfjEfsTDIoFIX7BAvghw05F5e0NmSh0/4babDcapNFa3Fp/Pob02ET8
	IfN1ueB2wT9LYnsEklfosPBS/iSlVAVcdoGmYNAu/hAOyKvE5Qa/L9axilTESbFnnX0wyIm9qC/
	pOI43BeYTLyOSD+fTwWSV8xJ2CP8Ab4pEr3m4jDzlXXo94z9Xo7s+FM5dhJZ+2sYpxZG1uXYAkU
	MVD1Tqg5Y+dcIXuCLNcSPxs+z275IrWFQXWSfTC1AhAFButQ/q1uOAFMZKaJEaButsouuBuZCR8
	DnmwbE6f0DJ0DRzdee9aEBxlHqKF5n3j7t5v0wsILkrvC+CYS6/MN81voRhWzCaxbyPBsLjRQP3
	XAFwf4Ps4/AksJHtnnkAhkR4aPp2I/UUdQKzNyMeBuWqRymltCfvwvDuI0pV+TzH45alG6CQNmS
	7dNSfx6qae8DHSYAiC8uAtkafXTkjoMubn6uxiTHUk/RKMUguMqoj8W
X-Received: by 2002:a05:620a:45a2:b0:93e:c12c:9dcd with SMTP id af79cd13be357-93f29deb855mr546221985a.77.1792259353931;
        Sat, 17 Oct 2026 10:49:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f2f045ca4sm171937385a.29.2026.10.17.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 10:49:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xI8Wu-00000004sUa-33rg;
	Sat, 17 Oct 2026 14:49:12 -0300
Date: Sat, 17 Oct 2026 14:49:12 -0300
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
Message-ID: <20261017174912.GK14213@ziepe.ca>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
 <asAeCz_rmpe5hbsh@google.com>
 <asUvUf4PZJ7JCLXp@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asUvUf4PZJ7JCLXp@nvidia.com>

On Tue, Oct 06, 2026 at 10:26:41AM -0700, Nicolin Chen wrote:
> > pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
> > suspend/resume?
> 
> That sounds right to me, though a different API for suspend/resume
> will be required. And call them in pci_pm_runtime_suspend/resume()
> maybe.
> 
> Jason, how do you think about this?

Maybe lets just start by refusing power management when ATS is on? For
PCIe devices too?

It isn't just ARM that has this issue, every iommu is busted if you
suspend the PCI device while an ATS domain is still active..

Jason
