Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA403F5BE5;
	Thu, 23 Jul 2026 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845272; cv=none; b=NUYlalDj92vqbe4Xby5Y6/f6NrfmkLQGEzmG+HMjU//T7t7zfI9kY7dTt2psTHIW+VajQxYOXxvR65CPY/IegG1xbPsv2a4bB+c2PSE+TyziuhT7vMp+/rA1pnv1SZugEhER0psAk+8MLQiBcBavuG+BXFIaWzwlRHMuQoSqgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845272; c=relaxed/simple;
	bh=JHPcdpsjEWsydofNBqVmzwni7hqFSiFH0+gRTGXdJd0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b8CZ0MbBz62zuOz49oWQYQn7MSJxetU1lnQmwUHPda4me8RU1tv/crrVVfOvVD27Pkuf04X+Qv/K0joBaDVmoFyxnR0lDMqsK2V4VhHGYEzhuyi4zc/NGmvFKcxeUxrV8lylFOVTR87vq1VBZFc45BUC3o6UfilHbNSV/uBJI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6oI+1Wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6oI+1Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CD81F000E9;
	Thu, 23 Jul 2026 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845267;
	bh=jt33XZg6IakrXoUrAEnJIibUYgZUlDskKhuW4fOU1xM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=I6oI+1WvIphSqo2SuYZlr+Z760iGzSCqCOqo1O52QXp0AQt4DpnWOjisJa4Dl9+HO
	 JERVpACfEtCncGeO3ANxpi2GaBQ94g9U/b+m2LChVg+v8C7Jj96R4FEHQemOqnV1df
	 gF8XJ3qDVMf4/f1lRpAYBfHrtjAtaYNxjerhzzJQ9O35DZ+nmDJ7bEIxwhEUUJN7Ye
	 Tt6/NS51u9fLd+CCzUdwtSjR+JsoOWluKNMUvl38CPvbY5NrDPcKPsKklnoXAfp0Hc
	 LJ8hgorhXMMGA5x79fdAR7IgtS9Ri1F8IjDr++NQof3NE313yZRqh3C/6dYKWCte5P
	 +i2kBcAGvHzwA==
Date: Thu, 23 Jul 2026 17:21:06 -0500
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
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260723222106.GA867236@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-2-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:04PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
> ...

> +#define pr_fmt(fmt) "PCI: " KBUILD_BASENAME ": " fmt

Is KBUILD_BASENAME buying us something important here?  Just from
code-reading perspective, it's more work because without some digging
I don't know what it will end up looking like in a dmesg log.

> +static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> +{
> +	struct pci_flb_outgoing *outgoing = args->obj;
> +
> +	WARN_ON(outgoing->ser->nr_devices);
> +	kho_block_set_destroy(&outgoing->block_set);
> +	kho_unpreserve_free(outgoing->ser);
> +	kfree(outgoing);
> +	pr_debug("Unpreserved struct pci_ser\n");

If this pr_debug() is useful, maybe it should include an address and
there should be a corresponding pr_debug() on the preserve side so we
could find things in a crashdump?

> +int pci_liveupdate_register_flb(struct liveupdate_file_handler *fh)
> +{
> +	pr_debug("Registering file handler \"%s\"\n", fh->compatible);

Is fh->compatible enough to identify a driver?
