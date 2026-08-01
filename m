Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B435957
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785557170; cv=none; b=ixCSf9xUzCAoSb6QJt4Lw75RReZUu6qe/uU+/zTKrx8kKsxRw+lSVfbS9otAn2i7ALybem+M8yXK1Bzfx5aQNrYxWHSEMjxgxJDOp5e1TMile9nc45Zy9rWMp74y2BvijXcmi5wok39zPfiFkWO423eWRldb/1GaRWQ+Yku2XaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785557170; c=relaxed/simple;
	bh=W4GyncGSOBetkwqyArcaAFBNz9k/udEdTtLtRlYM0Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJc/XqZ2/Lu4yslMmPLAkplSwAUAJcDBCJBJSaq3NBMUMJP7y5UKmhdzUw9MeJQlEAn9sTlRVTXQVHGlcXyXIALWgheNHFiOPitUO+mTszJGNlxe1Lbn8ZQDmB5hhu4oYnZZPIRMGPApPL5j+dAWXKPQJbgSYLn+S7g2gyB6qH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOefJDzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOefJDzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE621F00AC4;
	Sat,  1 Aug 2026 04:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785557169;
	bh=r0rlTUOcIt0Nu00bFXvrlOsakPEFsVfywqwE/KbewPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOefJDzBFwX6QNvZusprjxBZ0V1ZJBRid44tz4nP9TdRKiydzgUUto6gDdFz3uWhK
	 H5GQulbigVj4ff8SBrttxZlv9rd8UVrumfa4SEzL511KxZM60rz8Eh1CdFe2C60A18
	 7NyG296YELrO4buja/QxDrcZiS7dYpA9yDyADuX/S3h7u51m+yXOemz0ScyFc2ktqm
	 GZHiYHPoDqffmztVdA2dbmNtp/I//DTh4cDR6L3Y6T5RtR0UyX0qC+e/sKEe/2sulz
	 leMai19TGbj5IZuDBCinteyLpCDcBWDn4QZR1icssYUXIYglWn7udYIT9iiEfQ8HRN
	 cylWwe2kC8t5g==
Date: Sat, 1 Aug 2026 13:06:07 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ira Weiny <iweiny@kernel.org>, Kees Cook <kees@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/proc: Warn on writes to kernel-exclusive config
 space regions
Message-ID: <20260801040548.GC3183355@rocinante>
References: <20260729075413.1215821-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729075413.1215821-1-kwilczynski@kernel.org>

Hello,

> Currently, a driver can claim a region of a device's config space as
> exclusive using pci_request_config_region_exclusive(), after which a
> write to that region originating from user space is expected to emit a
> warning and taint the kernel.  The check is advisory only, as the write
> itself is still allowed to proceed.
> 
> Since commit 278294798ac9 ("PCI: Allow drivers to request exclusive
> config regions"), the sysfs config space attribute performs this check
> in pci_write_config(), but the procfs interface was never updated.  A
> write performed through /proc/bus/pci/BB/DD.F therefore bypasses the
> detection entirely, even though both interfaces offer the same level
> of access.
> 
> Thus, add the same resource_is_exclusive() check to proc_bus_pci_write().

Applied to the procfs branch.

Thank you!

	Krzysztof
