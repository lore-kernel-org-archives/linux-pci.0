Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CB36A022;
	Fri, 12 Jun 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247298; cv=none; b=M/Y1b7RiUvEjZl7ag7vFIlIcLstIFbRMkNypr1I+IVvK0dLFC/VXHxpRaeO5bD8qLgCMtGO9LOwVmmQ6wsgJHqIO1eeSWSO47TBydn7RBHhn9jOVosajyvDHGZqbO9DjI5vIhIeojeOp1xtRDbl2KS+eM51MbrVIibItj4EoTJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247298; c=relaxed/simple;
	bh=kyUxuUaYIZPEpFjQaNaj17hPwBAE0hvL2ecxh9GBLHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6EHV1Yak/apE8CQVRydjmHnQUqhahLe6SGPC4QfvBO24tV8MiIFxnDiq03F1+MclWXxpHzDAg7AMIkl+4QUSecPa2xS8cbQKS6kOTzCN9O1YGjA2kEWD/nil4P/bqdIHxhKEdZ2MvCVSmarZobrAQeoEN93lLBOraD8GcXnldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0zzp1Vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0zzp1Vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB881F000E9;
	Fri, 12 Jun 2026 06:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781247297;
	bh=rhHuyn9lAJ2TBe6sen6L7PJ/bBv8t8Eeg7AMLr+RBEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0zzp1VbOhwnHnR764SOHjzuUzLuCf0hRmFHEPQHn1tmhTJaP/SX0y/55bvPDoiUq
	 gHAzxMyVZaibctQ25ccizJUQKTyJATi/4P8mTr3aQ/Y/0adVBv/1q2JqZm6ekcZ9Ih
	 CGF+TxCzYGZuuURbgXg2XnPALpoKh4JJdoEBKPj9BmMmHB8rGL07qaCd9dfbsxGeNL
	 i6hZeQjlmqhXgDiZpvcUl+Wavsxqw/L6/g++NrRJpEcVX9rYWXvtLgMiuxkSMvw/DF
	 Bo3QwomiMYWWwXnnVD8pGpnHdoP752N3NYpX4UVdc35IRZBcPCtdTkCZhUnq8nvWSY
	 D04t4dmjsEA3Q==
Date: Fri, 12 Jun 2026 09:54:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aiutNINqxhtlm2Dt@kernel.org>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178124130274.908199.14827357870284807134.b4-review@b4>

On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2fb1c75afd16..6c618830cf61 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20530,6 +20530,16 @@ L:	linux-pci@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/PCI/pci-error-recovery.rst
> >  
> > +PCI LIVE UPDATE
> > +M:	David Matlack <dmatlack@google.com>
> 
> Please add Pratyush, Mike, and myself so we are notified directly of 
> incoming patches, the same as with other areas where the liveupdate/ 
> tree is specified.

Or we can add PCI liveupdate files to LIVEUPDATE entry.

-- 
Sincerely yours,
Mike.
