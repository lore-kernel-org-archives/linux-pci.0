Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838F36C0A2;
	Wed, 18 Mar 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824295; cv=none; b=f/Mc/rAT3CvM5vrSxGmPrLyKPEVT8KKiIgftdsghJs0Tc+eDrq6VCdw3jd/bh4tluJvofVp1dBitFR8KTeO/hFdoFxfBGD46KRlAJfTmY5j4Zl22MEMNf9FckMDnaklCXvagQQbpekLt7YFp4OXh+23MrqX+pBz6iTHDaWFmkwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824295; c=relaxed/simple;
	bh=bzReJ9Pwdj5EBj3bqRGSECUEu7NLDs6kdGEBApkDEwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcHjXM12Aeo1ZokLXnkGN2Vm9H/vF+7m3BIcxMMkk104qOPU+1peZMFBzvsua2GnzGwU77r+XoYHRaSi19ip5FuskH12V9QOBeTGpKr0S9Jim2bLl2SIsw7yaH8t/BCTEoFTMlBv+2HfAD7s/7oBhJdx/EEsCZxzFVI7qvzSAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9nU961y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9nU961y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD8AC19424;
	Wed, 18 Mar 2026 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773824295;
	bh=bzReJ9Pwdj5EBj3bqRGSECUEu7NLDs6kdGEBApkDEwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9nU961yjNrXY5fZ8qYoIFWMCePCRSfr449fkwN/MBPVTMrqHQjiOreWyABY5EEMH
	 FduphzV8ohj7n6D13A4OIJ6UGZqPTmB6EkU6g3SH1usvHZYV5ZP0XAxCf5oRqR02+9
	 QEelk/5POMt4NO/a3ItuQmR8ZJN8q6pz+nHFZeA4jhUKIrVVxbpVkMQ0bWy27LV83N
	 esOZzPCwwcoieX3FOsgwuUFiMOI40JkO5WReJ1LysoGTHeg79z81zzxN3UtjmfQVXC
	 Ada6TyOCKkRWQYYRUrGOJkNwcqD4MhS0frZyErSJO4NleEg6eiq5GsQXwbNv2gIfn8
	 oUdTq4X3eAsJg==
Date: Wed, 18 Mar 2026 09:58:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <abppG38Zic1Z0Kuq@ryzen>
References: <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <abkdu_7n_lePaTIY@ryzen>
 <c3039068-1868-4a08-bd0e-0a9e85b85943@foss.st.com>
 <c9278648-1ec1-419e-89ee-0868a4c7c86d@foss.st.com>
 <abkpFpD3cM_cI_nB@ryzen>
 <ee9b1b8e-4bc8-4fd3-932e-9b944516e114@foss.st.com>
 <abkw5dltSWVThJYA@ryzen>
 <gbpwik2ad4cuqg3h3wbahhnvvudai3uesmrqinrzknluw555ff@rdkc6i66rge4>
 <27e7aa65-9464-4de2-b70a-575b99f6187b@foss.st.com>
 <0df07ae2-3e01-41d6-b857-01f5a81adbf8@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0df07ae2-3e01-41d6-b857-01f5a81adbf8@foss.st.com>

On Wed, Mar 18, 2026 at 09:35:10AM +0100, Christian Bruel wrote:
> 
> 
> > > > 
> > > > I think "modify TEST_F to SKIP if ENOSPC",
> > > > since it will solve the problem for all platforms that have few
> > > > inbound iATUs.
> > > 
> > > That sounds like the right direction, though I think we would first
> > > need a way
> > > to propagate -ENOSPC back to the host side, instead of just
> > > collapsing all
> > > EP-side setup failures into STATUS_BAR_SUBRANGE_SETUP_FAIL, which
> > > pci_endpoint_test currently maps to -EIO.
> > > 
> > 
> > I think the epf test function can return several bits in the status
> > mask, in addition of STATUS_BAR_SUBRANGE_SETUP_FAIL. e.g
> > STATUS_BAR_SUBRANGE_SETUP_SKIP, or STATUS_BAR_SUBRANGE_SETUP_NOSPC.
> > I prefer the former since we want to pass the cause, not the action and
> > let the skip decision to the host
> > 
> 
> Rethinking this, having a pci_epc_feature to limit the maximum number of
> simultaneously allocatable BARs might be a useful addition to the EPC
> driver. The epc driver would need to keep track of the allocated BARs and
> check it before calling set_bar() for skipping or not.

The limitation is not allocatable BARs, it is the number of inbound/outbound
iATUs/windows.

(E.g. with inbound subrange mapping one BAR could be split in 3, and require
three different iATUs, but another BAR is not split, so just requires one
iATU.)


Right now, a big limitation in the PCI endpoint framework, is that there is
currently no API to see how many inbound/outbound iATUs that are currently
in use.

So the only thing you can do is to call mem_map() and see if you get an
error. This is a bit wasteful, as in some cases, you could probably
skip/wait with a lot of processing, if you knew that there was no free
iATUs windows available.

However, I think such API would be most useful for outbound mapping.
I.e. endpoint to host transfers. Think of e.g. nvmet-pci-epf, you can
easily have a queue depth of 128, so 128 outbound mappings at the same
time.


For inbound mappings, you can only ever map BARs, so in comparison
to outbound mappings, inbound mappings are very limited.
6 BARs, and sure, with inbound subrange mapping you can have a few
windows per BAR, but this is usually something the EPF driver does a
.bind() time, even before any transfers have taken place.

If set_bar() fails with -ENOSPC or something to indicate no free window,
I would imagine that that that is good enough for most EPF drivers.


> 
> Do you think this added (minor) complexity is worth it compared to simply
> returning ENOSPC in the status?

TL;DL: I think a number of free windows API would be a good addition,
but for outbound windows.

For inbound windows, it seems a bit unnecessary IMO.


Kind regards,
Niklas
