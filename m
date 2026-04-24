Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559AE3CC9FE;
	Fri, 24 Apr 2026 12:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033991; cv=none; b=qostOgc/J2xCmUTRTtVKXW+dBFSCrlXhXwCVlz+ZBqE3snecvA5hOtd2Najzw7xwGndPnEeKqeaQn3WjT+xMRTgG7Gj9xycBOFnbsAhM3qfkjYHzc/U+/pWc7sCxp/tg75TAbRiLg0OO6Wg/3zroCKU/B3DAmekLBVL2MZfWMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033991; c=relaxed/simple;
	bh=m0zzjIAi6G3mbiTZhqEoSZO9I9LqVeMoE28CldoBOQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sfb3vk29yyvKag1lSF+3TlZg8hQGK6aCcoYIhgRNM6AuHAoIAUqZBaD82gEUrCzggLPVhJPGe1wLq5G7lLkoGKmiwoiBc3TfGQvco1jmb+GlibBPSmrav6v6HY0iGE/3Y3kGbUksY9LFakSZKhDaEBXZEMONrPnKMxir04EzLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLDco3bB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLDco3bB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B592C19425;
	Fri, 24 Apr 2026 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777033991;
	bh=m0zzjIAi6G3mbiTZhqEoSZO9I9LqVeMoE28CldoBOQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eLDco3bBc0PX4AYSurXPqBWJwbosfw7HJtTqQMEb1e7HgcJDAe2lM28587PkhaPlf
	 65Ybv2D8qAO2qCUzL4klNk66vCwfZaUL2iaIUwmPoboyVmiwjsSJWr3w5R7+2uw1ij
	 xGl/2h1ImWFD8mCquOSBL4AUB29FAxoOrHCDjoA+yL2OBuPkkPXwi+jeidmphGPEhV
	 KMoX5Tj2FsFwb01ItnjsOxDDTNrvMDxm00VuwVngUAlJ5KIAKdlSl4SYgSrlog1dyB
	 T0s0pJ+dPo4hV5tygEubPKF5IlbBSUmlRP4SNsGhqvjn+1jn/Eys+M7Qwq6Os0g1+d
	 3knpQBIl8aGWQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Joerg Roedel <joro@8bytes.org>,  Jonathan Corbet
 <corbet@lwn.net>,  Josh Hilke <jrhilke@google.com>,  Leon Romanovsky
 <leonro@nvidia.com>,  Lukas Wunner <lukas@wunner.de>,  Mike Rapoport
 <rppt@kernel.org>,  Parav Pandit <parav@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pranjal Shrivastava <praan@google.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Robin Murphy
 <robin.murphy@arm.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah
 Khawaja <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  Will Deacon <will@kernel.org>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the
 PCI core
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com> (David Matlack's
	message of "Thu, 23 Apr 2026 21:23:05 +0000")
References: <20260423212316.3431746-1-dmatlack@google.com>
	<20260423212316.3431746-2-dmatlack@google.com>
Date: Fri, 24 Apr 2026 14:33:04 +0200
Message-ID: <2vxzeck45yin.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi David,

On Thu, Apr 23 2026, David Matlack wrote:
[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9b7b6f9828e..94af31837375 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
> +PCI LIVE UPDATE
> +M:	Bjorn Helgaas <bhelgaas@google.com>
> +M:	David Matlack <dmatlack@google.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	drivers/pci/liveupdate.c
> +F:	include/linux/kho/abi/pci.h
> +

Can we please also add these files under the "LIVE UPDATE" entry. The
code here concerns both live update and PCI. We can figure out the
maintenance details as we go along, but I think the live update
maintainers should at least get all the patches for PCI live update.

Perhaps also add the kexec list here? We plan to use it to maintain the
LUO patches, and adding it will make sure we get the patches in case
someone updates the file list here but forgets to update it in the LIVE
UPDATE entry.

>  PCI MSI DRIVER FOR ALTERA MSI IP
>  L:	linux-pci@vger.kernel.org
>  S:	Orphan
[...]

-- 
Regards,
Pratyush Yadav
