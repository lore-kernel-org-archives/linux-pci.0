Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562BA2D839C
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139570; cv=none; b=XckJlEXzvlkOdyz7cAJZeAf6GTB9rbhLXJNtA9Nm/rkpEQek4Kiorh4EnRsHEeqamN4xH5kawyACluxlDPHVvC505GMDAcXwpsRsh5VKTiFOcLN7HUgC5+xxxLaQ6iDbM1cTVVdrh1IOHouTEe6Z04JexhHID3v+F/GPWAbSyhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139570; c=relaxed/simple;
	bh=w3KBXFKicCgx9jB8PRneJxoCocaMY5xvn0hj7iJu8b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK0qChpQ0ce4a5azLn4LBDobkboo07f2g/QW4AEBldwDgSoSc7iwH4HooqkGD9LGc8Er1262ELSAhQhWuMNI4t2+hEwnWmw+p6VTKAbxqTMjICpLXt+WNCKz+RQ6dc2IYecnuARFIioSl8yNkGC9CmdA2G2DJBHSLc5NaIxGDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVbpnO9n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVbpnO9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E851F000E9;
	Mon, 22 Jun 2026 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139569;
	bh=j6sg2nVaKAKt9RSd9XFRjdGBDJRXI2+ANHSchDUpDYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XVbpnO9nwhlDkHb+UqauXjI5cWV5HILf+1o3VvUtkqO3GMFhNvozCKO2fVFbXVRWp
	 vcMK7+63wMHzCAuTRmWJC37sHNKl2307vl99J2I3AKT5iMBlEXovK6oTgNALJ6CnK7
	 VILUAYAVrhapMQYkEuCP9AOqoNCySB28KdZ34yc4oB+h98OocG08NCon4elvbLrTBD
	 D/d4eQaaChBOInrM87yl9WP9oUlz3fOZXBQgRTyRjZKVP/KMJZw38hADtm2gDcdqb1
	 ao2CGCo26eQ5Lipbp3cWn1x30vyTGmib8AgIdoe9ZH5WZSCbomt11D+RvL3iOHRUjl
	 JFQ/APvz0z+Fw==
Date: Mon, 22 Jun 2026 16:46:02 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, lpieralisi@kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Message-ID: <h3o4qkhtanmhwcnnum7pufh2zq6hiyitnnn2cap22k7uwqvi7u@xyu4yqcaf3zn>
References: <20260604185953.17177-1-ali.alaei.tabatabaei@gmail.com>
 <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604214051.11132-1-ali.alaei.tabatabaei@gmail.com>

On Thu, Jun 04, 2026 at 11:40:51PM +0200, Ali Alaei wrote:
> Intel Arrow Lake-HX platforms (e.g., Core Ultra 9 275HX) use VMD device
> 8086:ad0b, which is already in the driver's ID table. However, on these
> platforms the VMCONFIG register's BUS_RESTRICT_CFG field returns 3 during
> probe. vmd_get_bus_number_start() only handles values 0-2 and returns
> -ENODEV for anything else, causing VMD probe to fail and leaving NVMe
> drives behind the VMD controller invisible to the OS.
> 
> Handle cfg=3 the same as cfg=2 (busn_start=224).
> 
> Also add a PCI_POSSIBLE_ERROR() check after reading VMCONFIG: when a
> device is removed or a config read fails, pci_read_config_word() returns
> 0xFFFF, and BUS_RESTRICT_CFG(0xFFFF) = 3. Without this check the new
> case 3 would silently treat a read failure as a valid configuration,
> masking the error instead of aborting probe. The driver already applies
> this pattern for the VMLOCK read in vmd_get_phys_offsets().
> 
> Tested on: Acer Predator PH16-73 with Intel Core Ultra 9 275HX
>            (VMD controller 0000:00:0e.0, 8086:ad0b).
> 
> v2: Add PCI_POSSIBLE_ERROR() guard after VMCONFIG read to avoid treating
>     a config read failure (0xFFFF) as a valid cfg=3 value.

Changelog should go into the comments section i.e., after '---' below. Also, you
didn't CC all relevant people including VMD maintainers:

./scripts/get_maintainer.pl drivers/pci/controller/vmd.c
Nirmal Patel <nirmal.patel@linux.intel.com> (maintainer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Jonathan Derrick <jonathan.derrick@linux.dev> (reviewer:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
Lorenzo Pieralisi <lpieralisi@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
"Krzysztof Wilczyński" <kwilczynski@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Manivannan Sadhasivam <mani@kernel.org> (maintainer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Rob Herring <robh@kernel.org> (reviewer:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS)
Bjorn Helgaas <bhelgaas@google.com> (maintainer:PCI SUBSYSTEM)
linux-pci@vger.kernel.org (open list:PCI DRIVER FOR INTEL VOLUME MANAGEMENT DEVICE (...)
linux-kernel@vger.kernel.org (open list)

- Mani

-- 
மணிவண்ணன் சதாசிவம்
