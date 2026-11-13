Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549901;
	b=QhWmYOh2tvRZuF7E9PjFgNvkAToU2fT4BHSGbPJVKruARjfMENfgQbQiegFPh3Fzt2Ob
	 sDIcx1f1mM46mTMG9yy5AsPJbKuso1XEIgpAeS2VRVlasFfx1NYfjf0Xh9rtvPik0C8pR
	 8svCp5pOawIRRz2rm5F6p7fjXwW+Vme8v6awF1QMQZRZFqpaiEw8PpPYxM+aa4vxWCRPS
	 OBQ4fggTD9NoTs7W2ijp3B6rE4HuTZ15tqo6v1omDWSq5IRCKH+M/iyo5nkvTx3WRMPrJ
	 1jMMZewOjWJVSVeltabln2ReTSRKjE3jY/NdREo7Tz27l/NPdATr7F4o+iDpZ8iXeAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549901;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=2Q0Kw6VKjPJ4bBmVqAq5ZaWu4zc0H8m2mSoY9o/wgk0=;
	b=El1wWPga4DJZF4RjFD0IMUyeYLxGJoRXQzSt1D0+EDcEevpjnC6ZOqdVrdu6WxGvmTK5
	 JOdtrQU130Cs4v0IsPSnJSv9TK1J5oLOyedeanf1i1oEG7OwE+kM0In8WbK/jBIKiDWBl
	 nFUFAaI7x+xgCTZP7roGgr426LAFUYkRkAHcT4HQ6HCxEGrpB55igymp6WHdTWJ4vhurf
	 uVVZ4qvjN6pGVeUhSgZ284EqEy+81fnR6kE9irfHm9ggo81hQ19hKa8N/BexBgI3z85xh
	 f0xQcnscdlx11Pdk8azAvI9EpgNRYOo1zns6l3UljzfQgELycrgMllx19O2aNp6/xkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REIrOkJz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16964606A31C;
	Fri, 13 Nov 2026 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=REIrOkJz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26F61F000C4;
	Fri, 13 Nov 2026 06:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549900;
	bh=2Q0Kw6VKjPJ4bBmVqAq5ZaWu4zc0H8m2mSoY9o/wgk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=REIrOkJz2AHn01Jmb34bj98BYasFg8BqbFiumMW4g2v27buVo7lZVCCUbaiZW3RuM
	 +wxBJ3/gX4+BELRdWdNU/J6PCzSOCrnZ2IYYh1A2ba4YSznn84fKf9sjN+D9wF4QHM
	 SvSMtf7+mrJ13TBMzOObc8QfHQSTE5vcrsg2P1RmXkJF0g5vPmFE7R+/836jM3RdJi
	 TzgoEtGCv25Lk+l6gF0k+8wxuzvl7lHKBraB7e32jqTKlGJ4O5Q7j1CSPzLdUvrLN9
	 TNkSDm8aEPPw+MSqEDh6WgmRs0zAuMxpqzrInD6NnrBYPRGuHiYCIIX3C/vf+TCuxV
	 RFWMNY2pAu6Nw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, iommu@lists.linux.dev
Cc: Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 03/15] virt: coco: tsm: Complete PCI registration
 before publishing the device
In-Reply-To: <9773f2fa-f80a-449c-9e9e-722d1c71f989@amd.com>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-4-aneesh.kumar@kernel.org>
 <9773f2fa-f80a-449c-9e9e-722d1c71f989@amd.com>
Date: Fri, 13 Nov 2026 11:34:48 +0530
Message-ID: <yq5ah5hlmflr.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 5/11/26 03:16, Aneesh Kumar K.V (Arm) wrote:

 [ ... 97 lines skipped ... ] 

>
> Why do we do this only when pci_ops!=NULL? Also, why do we even allow
> pci_ops==NULL? [a minute later] ah 04/15 does just that. Make it first
> in the series so following patches get simpler?
>

Sure, I'll move it to the beginning of the series.

-aneesh
