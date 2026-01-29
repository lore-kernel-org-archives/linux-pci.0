Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69C2FABE1;
	Thu, 29 Jan 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769712637; cv=none; b=QVYE1pKqpUdAkEg1iL6jas0t6nyascCltuYJqFPZdzQDVyBEeOsrWZYWZtxwo4rPJLiz0c3H2p6vJJHm+vSt2g9x8WwutJzcMMs52X1dtwh2McmRgvbhgZrThu4A1a+a3WFBxdgMhQe5ChJs/D/d2PH8LsjS/LEBx389K380Ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769712637; c=relaxed/simple;
	bh=cNrkc1YUDoFxcbq7+xlAnNvtemzG3rnBhBRuybwfbrA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JOJgu/+8YYZYy+w+jIavNSzD+Rmw+1PfGetXdjiNGJYOu5IXja21gHZaIz6KzZL8vfyF+Oboig/SrmsuifWbZkB5MV2F+ShEkE7g1aum4mAs9nb+P+hY/bdLI3dh3eTrWP8Jp9DdyFabc75TmdiIjUjgBjNDybxTNQ0CDwH70ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTyCFz9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTyCFz9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709FCC4CEF7;
	Thu, 29 Jan 2026 18:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769712636;
	bh=cNrkc1YUDoFxcbq7+xlAnNvtemzG3rnBhBRuybwfbrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iTyCFz9ns7rhPXyFXD5AuvWLqKpku46Ah6AWucQDNnnnOJNvDMgOIMyRqWMKhGzhg
	 2jUdRGzpFu0f56sryrZqUvN+nZX2DTYDe0yJK7KMUIPe3umijhOOKN+pZbdsP78WU7
	 D0w/KXPIE8IC9XrDXtg4PiLoPL17bHqdKA30Z8ija3d2ZuqYRalozLl55+xyG/TujV
	 uuLYp0VCKJWdtEhn9sQe/AktJgvyy3XnPTLFzJVmOuqYmqFG5XBhLowd1Fbcm2ZoXh
	 vVviMlRilruGtKb55I4gHqyix0IlNZIImzX/pK8QIv+oRkCQXYz6cm0Jm1RgIPg/yY
	 +x0sxF0CbhKeQ==
Date: Thu, 29 Jan 2026 12:50:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Johannes Thumshirn <morbidrsa@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 0/2] PCI: Init RCB from pci_configure_device and fix
 program_hpx_type2
Message-ID: <20260129185035.GA473061@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129175237.727059-1-haakon.bugge@oracle.com>

On Thu, Jan 29, 2026 at 06:52:31PM +0100, Håkon Bugge wrote:
> This series add the initialization of the Link Control register's RCB
> to pci_configure_rcb() called from pci_configure_device() and also
> cleans up the incorrect program_hpx_type2():
> 
> 1. It should only be called when we own the PCIe native hotplug and
>    not the AER ownership
> 2. It should only manipulate the AER-bits
> 
> In addition, the second commit adds a warning if the _HPX type2
> record attempts to modify the Link Control register.
> 
> The programming of the device's RCB is constrained to the device types
> where it is applicable and also skips VFs. If the Root Port's RCB
> cannot be determined, we also skip the programming of the device's
> RCB.
> 
> Then, we program the device's RCB according to the Root Port's setting.
> 
> Håkon Bugge (2):
>   PCI: Initialize RCB from pci_configure_device()
>   PCI/ACPI: Restrict program_hpx_type2() to AER bits
> 
>  drivers/pci/pci-acpi.c | 65 ++++++++++++++++++------------------------
>  drivers/pci/pci.h      |  3 ++
>  drivers/pci/pcie/aer.c |  3 --
>  drivers/pci/probe.c    | 33 +++++++++++++++++++++
>  4 files changed, 63 insertions(+), 41 deletions(-)

Applied to pci/enumeration for v6.20.

Thanks for your patience and persistence, I think this all looks great!
