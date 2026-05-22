Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA8273D77;
	Fri, 22 May 2026 18:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779472922; cv=none; b=gUd/NqWvDdYyTQgdS7GjGu2YqSJywAP01VMx1dsBSQCrl2JBNuO6AeluloQWLxd0ZgSuK7hBEITFVA+eiDtDSGqTMWue2pD6ilFngGtf0Hu3RG4wdsjMWcAhMv5u7DI+vbKTk3LvDHsCRnOb2QvzyVJ7SR1/2Lc9/cWINoU8yiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779472922; c=relaxed/simple;
	bh=8i9eOfbfVibPQwbyc18oYvOUSM5+myC1Cc+y1nUcrkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r2HHk5Cmiomyci99TETEubj2e590/fYYlfJbTx5t6hrfdSiobS9pXWZuoP/81tN/qiNsy/VKHxKiZjvnipCuXTomAEbdPgwgghd8/zybrJkqpPF5VAC1yurr30FJJY/B9zQ/3dJqOG/Uux1XWHLNtonK24fpcFSpvzAMQ5uQ7gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXo6wUbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXo6wUbv"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 91D7A1F000E9;
	Fri, 22 May 2026 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472920;
	bh=3pwqqJmK0UZHpTQbgMPdFytZpYtz+77BknUANKGAa1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TXo6wUbvp686W6gRZC9qm8zmd4BiXLPz+wTU2Jsq2lT4E9qOQM9JxVXC0FxlBZ5pg
	 iVw25MMaBsEi28vn1ODnZDud0jzMfw9NP4SR4+uPXPdaQLdtGDAKm+TIOPQSuX7fjx
	 yk/Z2M+PGaVjVwx1oP3yx6UayfL38rLK20qYZ+qf5KhiR4ygA7F/s3E+Fm1++h3vnl
	 Z07mNXiFezn3JCqacgY51FX6uymKGoCnYQPub6wfFXnuNVTZZJIVNpB7KgHDxNkwSC
	 unRmAtTZKUdsX9Fn3QNUMDYspPEoPO0/Xa2Weh/cf2OfnuHBRN2njlHAHVl6ZgSqzO
	 gfcXyx/Vw6YbQ==
Date: Fri, 22 May 2026 13:01:59 -0500
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
Subject: Re: [PATCH v5 10/11] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <20260522180159.GA231364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512184846.119396-11-dmatlack@google.com>

On Tue, May 12, 2026 at 06:48:45PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to minimize downtime and ensure continuous operation.
> Clearing the bus mastering bit would prevent these devices from issuing
> any memory requests while the new kernel boots.

s/minimize downtime and//

Ensuring continuous operation is the critical piece here.  Minimizing
downtime is always good but IMO it's not actually a reason for this
change.

I guess what this is probably saying is that the continuous operation
and Live Update are what minimizes downtime, and preserving bus
mastering is a piece of that.

> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
