Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108035;
	b=FCldHF0POV2la+CAmn1lpB0SZaC/eYBLJn1ns3W5hkZw4DvtW5ZULzymX1kAvA7LcwYT
	 nz4Udu3eOuTBOaYnQGmFZCxt+PKaWkdSMfn4M/9jOjXIWEvt9U0fXxxmPrIpkqqABVUcI
	 FTxsyySVXZWVWkOPOPKSuwSvpPazTBxHsS8qT3of3rkB08Akcphgr9F/N2utNunuaVz4Q
	 jB2QRf1KmSk7H1W2BeMG4LtSiUP2VQUCU4ddoRh0kSay6f4Rwgq1arGESXyl3/vIkKMiD
	 LxnfCL8wcmXZXJaqChgOyXYorRyHnH74B0f0vN1OnXPopS1FJBvJrA1um+N6APdbpWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108035;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WVY95VfAf6Dx/V+HeJOcaUpQA+1y6sdbaKc5qI0bdTE=;
	b=ZzfnQuksaOHBGYdoDLF+kMhgb5gijLbwoQRpIoeUsC+bLxyVRdm2hGe+mmYuGlFc6xQ7
	 tRg9V05/jGQSM3jPPiYlLAuZLZZPd4nZMnohZhOij0m6geQYZ1yqD1VZPBYicXfXKslN6
	 50hY11uBtge4Ej1hkkTOlEmjfsiL7onDr2JLkvHjlgQ1b4iwztZIfFu7FVNhnIkDRPCgg
	 iFLPvb/3GQ1azwhCmt86TcJNy47A1c477x+uV2DopulzFaEA6hfXC85bkownsmBSHdrt5
	 GqAVOtG5iMHjEE2WuVo6dY9Z4gUsuVto6o39snOclp50SR58YLP6b14ySzMCEC2nBEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWqA6WKC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB3360A2606;
	Thu, 19 Nov 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWqA6WKC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D881F000CA;
	Thu, 19 Nov 2026 17:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108035;
	bh=WVY95VfAf6Dx/V+HeJOcaUpQA+1y6sdbaKc5qI0bdTE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=WWqA6WKCjvlnykjou3CUFE4kgGvpzu2p2Ez78nvX+FoeYtSZSSlCSLwhz/GClZmKt
	 TQXRCymIC1R9B7v0Q/h7xRF1sw15rEdm5oqx5z6mPfQMYFkAOBFm0QGWHvV47Wy3h7
	 SvgTPkLwkELFHTg9ygZ6hEUl5Ig4gbKrxHieplRiFNSqsDZyvPg9XN2nz+by0juALc
	 9WwgKHvpr7qXzp40vyTQGftAqCRBamRP+i9Rg9ym7wkPnQT5tI1bvucpEFPKMtroQr
	 CdiG5+Hzv4T88C+5PaJZGt39lH/AKcGCxDX1aWP7x7gqxMdsAgn6zCZFhAF7FQOGby
	 z1Xe7OyBDrsgA==
Date: Thu, 19 Nov 2026 11:07:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc: Habil Eren =?utf-8?Q?T=C3=BCrker?= <habilerenturker@hotmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@kernel.org" <tglx@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 1/4] PCI: Add pci_power_t helper functions
Message-ID: <20261119170713.GA817259@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <av8o-tHHScd0gjZM@ashevche-desk.local>

On Thu, Nov 19, 2026 at 06:51:06PM +0200, andriy.shevchenko@intel.com wrote:
> On Thu, Nov 19, 2026 at 02:35:46PM +0000, Habil Eren Türker wrote:
> > Add helper functions to extract, set and compare PCI power
> > states in the Power Management Control/Status register.
> ...

> > +/* Helper functions for PCI power management */
> > +static inline pci_power_t pci_power_t_get(u32 csr)
> 
> Why u32 as it seems the value is 16-bit?

I think there's one reader of PCI_PM_CTRL that does a 32-bit read, and
I figured a u16->u32 promotion would be better than a u32->u16
truncation.  But maybe that reader should be changed to a 16-bit read.
