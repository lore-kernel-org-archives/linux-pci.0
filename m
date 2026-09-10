Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C28215161;
	Thu, 10 Sep 2026 23:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084199; cv=none; b=GrmOF61c4CbsjTJ3TBhdHMj35H1Xzv2/fKVVf6obln/3iv8LqNkBlNhT8Luabr545wrCZxIepaQAPL8GhekqNjU05ykGcsfRVsVs/b8B51NVbdd2pgh+Ih9GLAVRxUTF9eQA3+F5e2jSQDw7A6VFrNsO+N7nPChWFXC0Af0DvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084199; c=relaxed/simple;
	bh=4Sl7ZLYB44aVlayhdfMMFj9pK8ZJ2tIzvU7yQ8INEUM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fypJpePEY4hcn25B+yt5nZmD5XHMcDvpQVlQ7yiZi3eBPOg4tODjGIRThJerhnls2Am2Ys9ULE0WzxDcUXdHZD3dCofT2mIAfTGFCQL6aE5+79cd5kP0g/O1wTfftZtQjX9AR64tWtIf5dJgOCk3v6JbG5lDG3WAcMvlzj2RN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcVJARaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcVJARaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC061F000FF;
	Thu, 10 Sep 2026 23:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084197;
	bh=yDpON0CfstrMMVvgyqFjuA8QunpXRg/nhloNK4nTqMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OcVJARaH6Oi1j8XuEcGXhNRaXpqRaKPdDm2jT1O9TnaIFERSfP65WUqSnVo8d7Fsi
	 dh2sMWmgUOA5sg70lpCN5y/sesey3628HvmXS2+yXCP+WzaYrtcsPy2swaFDr1S/ML
	 negKqmBZROzz0wR6IdBYzxXLm6h8Mw4vbquWhDRvx6hT8lpbnlJ+IStE46soZ9vToa
	 EueBn4XirkPG3SkFz5lg6BJroLl6uN4O1kefqRFehAWQEZGV5HVZRKUqBcxYTV3M8j
	 n6JshkcZkGKKcQM9+PwBnjcwWO266P762oW+Up/K12YE2Bp7Gz9q0zJzgTpG5K+UgN
	 UQEwHZB2IgRIw==
Date: Thu, 10 Sep 2026 18:49:56 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <20260910234956.GA367108@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-4-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:57PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
> 
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.

> + * The PCI core does not enforce any ordering of ``pci_liveupdate_finish()`` and
> + * ``pci_liveupdate_preserve()``. i.e. A PCI device can be **outgoing**
> + * (preserved for next kernel) and **incoming** (preserved by previous kernel)

Thinking about how this will be rendered in the formatted doc, I think
"i.e." is really part of the sentence, so in U.S. usage this would be:

  ``pci_liveupdate_preserve()``, i.e., a PCI device can be ...

I understand British usage generally omits the comma after, so that's
OK too, but IIUC the first part of the sentence shouldn't be
terminated with a period, and the "A" shouldn't be capitalized as if
it's a new sentence.

Similar issue in "PCI: liveupdate: Document driver binding
responsibilities" later:

  bound to the correct driver. i.e. The PCI core does not protect ...

> +static unsigned long pci_ser_xa_key(u32 domain, u16 bdf)
> +{
> +	return (unsigned long)domain << 16 | bdf;
> +}

Add blank line.

>  static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
>  {
