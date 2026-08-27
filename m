Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF2347FCD;
	Thu, 27 Aug 2026 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787867226; cv=none; b=hvsAHbKVDd7jQkLPsYYKRjQGKQ7bCVQLHilsCf4Y46uTYxCWjJp0sk8QjV9XyZ5XdSEmhpWB0Jr25QBOaM52kH+UV7esaob788gyf1RSqf/VtgQYMI1Vy+Ds1o4EOWZxbqTlyiZ7sgTMyJLiMUGgS1FnldSv/0wJ8s/5BroqXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787867226; c=relaxed/simple;
	bh=NluID8D+ya+awqBtUdnu97nOTgoZh/yDZ+zuBJ/g3Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bMCe/xqZWcJ3imX5LUECiO2aAkZ3GxUFNCPXYyy+FqfooC4PUURbZPBzyXVFOO0mAr+PTlqah4+dfnJEb0D5bl1O+4RvfRmk6J6ot6FAYmWaxeLDE/LDI3VwpydHIdn/oWm3xvhV6z3blISqJJGL3m5uPdbu4tiSl83KtzQwUfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOnm5D+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOnm5D+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5EB1F000E9;
	Thu, 27 Aug 2026 21:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787867224;
	bh=tviM4X2nvvvLqMpeuQF9l7koJaDMsc88vWcy1La/8as=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OOnm5D+NhalAr8wIMcxMKb6VaxdR7MfXZrVr6waUND5kQ2IBfnaKblstAaUWXsZHe
	 yJ58QN3mCNgHX47Xtk9I7+p8DaT5sTD+VexFUJkz29OKusmhRsdT9Y6VngaWiB8PbT
	 VpiDPdcqlswFHeb5OZtylVmAX7ZxuZ0XmxtgOBj5/zvvfW8SnDc8MfF2A76BSFlQle
	 7Z1/avFAPLYTtPBdj3MZUI7cVEn+IB1SGbyKfXlTbzHSrtPHSPgNLm2y8ENTkPGjnu
	 HGpV8OOhAKSF7sqEjYJ48iGCXGgk7gTdlk80vG0Yi5u6Ioi8YHNuzvyVkKeq9Z3Avi
	 OoCVbShyvHzKg==
Date: Thu, 27 Aug 2026 16:47:02 -0500
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
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260827214702.GA1636952@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-3-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:56PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so the list of
> preserved devices can be handed off to the next kernel.
> 
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind an PCI-to-PCI bridges).

s/an//

> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
