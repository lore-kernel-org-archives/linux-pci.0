Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417B03AE71E;
	Fri, 24 Jul 2026 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925172; cv=none; b=Gx9zPuLFN06PEZcTNkhiC6QN+nnadgTgmOlBHrbZMpoirqvkBJ+W8eZ62DKGExiOeEdjXSlX09LNC8c3enKQNaOwwn446VtrBiLd4JcXKmg8TjnLAol5rSzi9fzdibKGTj5m3WjwqtmLLXHdC5Tx82/H3Wg2ffN7Gm285WW9mpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925172; c=relaxed/simple;
	bh=xAIFeqkZO2RIGQc1VSgrPNni+2EKc5ca+GM41pZV3Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dygvobuiTNcyCBm09nkuV4APtYvMsSE1Jq/wPDFryE81q7l7IuT30rWwiZDNJv6BSAnVlFPVroM8gwwSZ0Sd04FrXVPvQNwUOZRCly4CTFnVjfEcQocFZL6fzwOQ/8SrrpAXjYrGMwhOcrRcmxJ+ktytk7dJx8ezMofoo2xwz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMBvjMyc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMBvjMyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F0D1F000E9;
	Fri, 24 Jul 2026 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784925170;
	bh=ZKQYivscj2/YLitJTr85nVGb3DcdncClDyomNie32W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lMBvjMyc2ADRRvgYO7Si5PcjiSQSr5it1WztjtKdT5vjbWClOEsrOrjW3ofWdtYfH
	 qY32i4tEpHCBD4Mk6wgQcyrclEAtjJ/PyKX8hekEPUjzN7bYF0Qp+wSJyfEzum6Y8s
	 ch9DH0xsWI6UY9vX2KspJTFw23p+foJLZIkGbpDv3Uq9ozpqJK5St52wuLIjzmuwm/
	 tmQQi51M4YEeH6IPo+uSf6l7FgqA18Z3vFp/BGwvx1MVr29TJfAep47O8oSuX1TpYj
	 Y9IJC6d6F9PLPw/2QMcqnW3IXzspoFpC5TEl2RxCXyb06cQvqhFLLRoRaMiWRf+fzn
	 H85M2Nv5O2FJg==
Date: Fri, 24 Jul 2026 15:32:49 -0500
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
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260724203249.GA1033821@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:05PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> ...

> +++ b/include/linux/pci_liveupdate.h

> +#include <linux/kho/abi/pci.h>
>  #include <linux/liveupdate.h>
>  #include <linux/types.h>
> +#include <linux/spinlock_types.h>

Alpha order unless there's a special rule about spinlock_types.h.
