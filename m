Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104C392C2E;
	Tue, 11 Aug 2026 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786490568; cv=none; b=VJuE5bb9fdjQZQKX/pwnKHBugjNjepBDryx2bJ6iWD7hXuVRVAl203w3LIDL88uelpYMrVEAqwvTTpEFjAd2seUvgsi/dmUkr9ulXMTISTrQn3rVzyO6NZMWBW/L1oPT7V8zLkrr4n7bY6+fGnrHYoFcNnWVZszlN5mE52dbNSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786490568; c=relaxed/simple;
	bh=gT0cS86XN5fdg7RaScMnniDnb9BC3vj7g6J2Szu247Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BdzTX6DtMfb0CtJgonr2EnEwyWDXe0MWmhRn5Cn85XTQ53sZLqd8mkCJu023FtMdlqxSRVRtiRtWTwI4+204vn3qdIJbw2+z675rIVWTxwpcVwOBUIW8tCKlULaVHh8CJuVbxSPKU9BBwNbTtgvNcux/RElmT6Nax67Ya5a2vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MraZ0sa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MraZ0sa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865331F00A3A;
	Tue, 11 Aug 2026 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786490566;
	bh=Tkm0TisAl0qr5i46lsSTzLsYxaJvxTs+HDmF8BYPT+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=MraZ0sa3+7opD6aF68VEQZvE4uQj6Jmv3ZGVMBY2EsVYa/HpP9T0UR3I6+oxxWCuq
	 LR/QgplfWt6RId8QJqU0hSSFBJOqbzuZ/XsA1LomfPBsajY9igcbCZIoCgo0lI5iYw
	 uR5i8wfPLWR7gnvSvbv/7l0zzSPIhHBjygxKWsHHJNnGMcnhGVu5kDG3czbb7PzVFX
	 dpij0P8BHL8sey7lCaaGTu8aEiTcuuQXXp9YqsPbtOLLM7jAQPYd8vKT6SC3V0tGc0
	 WUGd/bf6tmEb7JOGN9MbB7NCKztmyEnG2z9xX7bVq5u5r8Q3nugYsTDXmlk26PzCq0
	 N+4HCTpCQthLg==
Date: Tue, 11 Aug 2026 18:22:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	mani@kernel.org
Subject: Re: [PATCH v2] PCI: Allow D3 for native Hotplug capable Root Ports
 on non-x86 platforms
Message-ID: <20260811232245.GA805297@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729165005.896725-1-manivannan.sadhasivam@oss.qualcomm.com>

On Wed, Jul 29, 2026 at 06:50:05PM +0200, Manivannan Sadhasivam wrote:
> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
> prevented native Hotplug capable Root Ports from entering D3 citing issues
> on old Intel SkyLake Xeon-SP platform.
> 
> But there is no reason to restrict D3 for native Hotplug capable Root
> Ports on non-x86 platforms. We recently enabled D3 on non-Hotplug capable
> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> do the same for native Hotplug capable Root Ports as well.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Applied to pci/pm for v7.3, thanks!

> ---
> 
> Changes in v2:
> 
> * Switched to CONFIG_X86 check instead of of_have_populated_dt() as per comments
>   from Lukas.
> 
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..94f8a4da6009 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3020,11 +3020,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return true;
>  
>  		/*
> -		 * Hotplug ports handled natively by the OS were not validated
> -		 * by vendors for runtime D3 at least until 2018 because there
> -		 * was no OS support.
> +		 * Hotplug ports handled natively by the OS on x86 platforms
> +		 * were not validated by vendors for runtime D3 at least until
> +		 * 2018 because there was no OS support.
>  		 */
> -		if (bridge->is_pciehp)
> +		if (IS_ENABLED(CONFIG_X86) && bridge->is_pciehp)
>  			return false;
>  
>  		if (dmi_check_system(bridge_d3_blacklist))
> -- 
> 2.43.0
> 
