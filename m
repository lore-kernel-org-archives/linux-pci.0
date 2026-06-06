Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F62E7F3A
	for <linux-pci@vger.kernel.org>; Sat,  6 Jun 2026 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780744242; cv=none; b=rUs3B3Ivtz/ipAU+Hftnxq+Igk2NjCrRs6pxlSl4gvcBe8PM7Mm1tWRh0FQTJATkMfGJxPc7tvMjOlBe3pvUZ8X2TuoZ9idr8NWJfS4e57H7Qejp9XUQoQLfdoF8wmZ9y9g0T2950Jq1TxE49EEaiwmPKQza5lqDnQvBP6M3H2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780744242; c=relaxed/simple;
	bh=8rGT5m9JBzmFPEylx70cZknpUvaFHjWy4EYaVq8UyiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMJryt3CiChpyi3tO3kh/NLbb8bWkwL1tXWJ5ITrTyERJxXcvR8szvBKyYPUaVluvIenTS5eH4Gl+FSGo1tbJI4+9kg6YskxVCZgpFgE1GpyZwZXNIOt6nWRT4N65J6n7oYhX4zicKSXE9mWdXXJf0U6OCtYSGeXLHrcztU3FL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XkblMaQE; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XkblMaQE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-133362c30cfso19651c88.0
        for <linux-pci@vger.kernel.org>; Sat, 06 Jun 2026 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780744239; x=1781349039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1UvGUn3KRDrygvBE4DSDRKEnm/sK5Y67p5+Nbu/YEQ=;
        b=XkblMaQEmTxwt4sd2VW4eBWR30yK9bgRaaR+sSjlgNCqLN96DXeAgro8yGjyUB6YgA
         2VIC+intydL1m6gMixL38HNA+oIVlLICgrdCJlx8urbzlPzekkN38mN0Jujhjvtl0r9/
         9c4pQ6Zf8MrX5XCHMdHAbgYrhRSINFTJc0ZvLjsnlyZeTI+WDMmVH/RsZ83CswEe17N3
         RXrxaiE5MbhT2JJKss4+IDlFDGn6VOilog2UX930sd2mL77ZQGNaHKveVtoiOH/0LdRM
         zgqKf6b3KjqkRPTu0BWgqaTP/AiYAjdkFFBs02PEVtxtzxQZtjnM7dqIInQrIBYXLC+p
         4asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780744239; x=1781349039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1UvGUn3KRDrygvBE4DSDRKEnm/sK5Y67p5+Nbu/YEQ=;
        b=TqKFbgOF+1d5rd/JubJBxJKEIijeO+8Aj5jpt2ryFPrxI6wQ4VDuTBeAWOvOQcC79e
         zzLSGa2S8x59di/TWCm8W+W3c3hzzqxtMespgM3+CWBG2zxm73z7UpraQEGvQIVQZE2/
         P0s2D1+zhu7UKSsz/F3OWe2RY6YnOpkxWuCzDpo1iW9aX2XBsoDctm2yz30dTiV2+fGq
         9gTwV9vTmeBkBHOd+XQtAJV5Jiw+kvK9SokmX9KTEisE/g0iP82t3rFu/ZHz2pLK4Rkc
         EyotPqMVS2fToWyPhxFoeNUiF7V4GxkbLjzUDx6Ye1y+tjpyfP/QvJBEgJOOAOKT6Dva
         Tw8Q==
X-Forwarded-Encrypted: i=1; AFNElJ81hoVH4gE5CAD2D8nEOseA5ngzMVMlmxD1RBNmWKZ79zd3djcL9p+QCbUU5HH7ZSTfx8NnzbOHCsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRM0WqUw5yZZ4a2NmaCQ71L2wioZ1Lv4jL2Ij0C2xVb+KVypvu
	i6okMhcND+Rimp3LW66qVzhRgXfgzlCC46a9bVn4RE0Lb9mPNohdbihSgbaMTh+sfg==
X-Gm-Gg: Acq92OGl4daSyXodGvVt4krazilajNklHLKqGAilTVhbzLwl3VpdJd/Ege3m/kATH1o
	RugrjRvi4hKi8N6nkRZehqysIVyGVVYFIi+wkIt+CvYSOUGPVaUdHIu+VV21PKTLdKuzgix3278
	/9WsDoVGsBk8nQFAGqhMG7YOOE5H326tHJcnD5yWsdUq81RrPbh+lcBKn9T3IaiGO5veJk7bNX0
	9WD0s0qwvxSOXOkBxRX+kjEIcQ7i7Pjn1673k45iHjACssSNEH84+dLeSy4bpvvmfQ3FkZubrwV
	deDgO77sFVHB5RENNlVNPaktUzWht9kw+aDxRV/52Q7zS/OKczBswrrmzx6CcUVVff4tGyBFIUR
	9oSxk/JVqn8uXXukZyDGwuC3yovSruBz+M6YrgSi3QUWBHx/3ZJzxZlCGS/DlqW8qPvwkeO2e3x
	w4aiphwg3W/3/wrkozJ42d3tN1Q4uEt/414Y80QXBsC2HL2Mjifc0cne7YefjIps9/Lfk+G+FhI
	q8jyprruw==
X-Received: by 2002:a05:7022:38f:b0:133:12e0:aab7 with SMTP id a92af1059eb24-13807c6a877mr251422c88.11.1780744238685;
        Sat, 06 Jun 2026 04:10:38 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13803eb106esm4391089c88.5.2026.06.06.04.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:10:38 -0700 (PDT)
Date: Sat, 6 Jun 2026 11:10:29 +0000
From: Pranjal Shrivastava <praan@google.com>
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
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <aiQAJRINEKiwCmVm@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>

On Fri, May 22, 2026 at 08:24:03PM +0000, David Matlack wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
> 
> To keep bus numbers constant, always inherit the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices are being preserved. Note that
> the kernel inherits bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.
> 
> If a bridge is scanned with a broken topology or has no bus numbers
> set during a Live Update, refuse to assign it new bus numbers and refuse
> to enumerate devices below it until the Live Update is finished. This is
> a safety measure to prevent topology conflicts.
> 
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +-
>  drivers/pci/Kconfig                           |  2 +-
>  drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
>  drivers/pci/liveupdate.h                      | 14 ++++
>  drivers/pci/probe.c                           | 17 +++-
>  include/linux/pci_liveupdate.h                |  4 +
>  6 files changed, 119 insertions(+), 7 deletions(-)
> 

[...]

> +		incoming = pci_liveupdate_flb_get_incoming();
> +		if (!incoming) {
> +			dev->liveupdate.inherit_buses = false;
> +			goto out;
> +		}
> +
> +		/*
> +		 * It is safe to sample incoming->ser->nr_devices and then
> +		 * drop the rwsem since nr_devices will only decrease. Thus the
> +		 * only "race" is that the current scan will be overly
> +		 * conservative and force bus inheritance.
> +		 */
> +		dev->liveupdate.inherit_buses = incoming->ser->nr_devices;

Nit: inherit_buses is a bool, while compiler will handle it correctly,
maybe we could:

dev->liveupdate.inherit_buses = !!incoming->ser->nr_devices 

OR

dev->liveupdate.inherit_buses = (incoming->ser->nr_devices > 0)

for readability?

> +		pci_liveupdate_flb_put_incoming();
> +	}
> +
> +out:
> +	return dev->liveupdate.inherit_buses;
> +}
> +
 
[...]

>  		/*
> @@ -1497,8 +1501,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> -			if (pcibios_assign_all_busses() || broken)
> -
> +			if (assign_new_buses || broken)
>  				/*
>  				 * Temporarily disable forwarding of the
>  				 * configuration cycles on all bridges in
> @@ -1512,6 +1515,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			goto out;
>  		}
>  
> +		if (liveupdate) {
> +			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
> +			goto out;
> +		}

Quite helpful! Thanks :)

> +
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> @@ -1572,6 +1580,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  
>  	pm_runtime_put(&dev->dev);
> +	pci_liveupdate_scan_bridge_end(dev, pass);
>  
>  	return max;
>  }

With the minor nit above,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
