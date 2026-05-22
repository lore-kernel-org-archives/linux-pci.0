Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F037B007
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433959; cv=none; b=hbls/3QCZAU35Tcrv6Si5Xa+Eyv/d/O4DbpySui8oqnIehpKmO/9ihe5CSr02emskJhlNYoLwILMbDo1ya50F14palWxbfdEk62soc2zCA8f0V1s9a9V+iH+rGXU+GScR0yYAaMqavNLWtUeXqBaUnoR5w2KREj7TOyfoxKbjUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433959; c=relaxed/simple;
	bh=6b3lj8JSvXCMX5G3AddZ494zXr/ttAQd6IXCGUWhVeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajy95NGznAtKt0TEvfcLdzrPkTXwykcVtqTIl72jCNUj3VPJyPjzEkwvdpPw7jLzmLjAdYgpMldcBL/P2+YCdp69fQPE6lYEkaoCKEmYoeesDWWL+c1oqZ9K3Smdp90A9cyVnR2LNpWJuR9KtD66r4sHfSWTJNCCrcLpBR4zDRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 6B08A376;
	Fri, 22 May 2026 09:12:24 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4926160B03EA; Fri, 22 May 2026 09:12:24 +0200 (CEST)
Date: Fri, 22 May 2026 09:12:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: weipengliang <weipengliang@xiaomi.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: Avoid unnecessary cpu_hotplug_disable() for
 non-NUMA devices
Message-ID: <ahAB2BFymPVFGKaG@wunner.de>
References: <20260522061124.1660-1-weipengliang@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522061124.1660-1-weipengliang@xiaomi.com>

On Fri, May 22, 2026 at 02:11:24PM +0800, weipengliang wrote:
> When a PCI device is on an invalid/offline NUMA node or is a VF being
> probed from PF context, the code path calls local_pci_probe() directly
> without needing work_on_cpu(). In these cases, the cpu_hotplug_disable()
> / cpu_hotplug_enable() round-trip is unnecessary overhead.
> 
> Move cpu_hotplug_disable() into the NUMA-valid else branch so non-NUMA
> devices skip it entirely, returning early after local_pci_probe().

Hm, this will retain the cpu_hotplug_enable() outside the else-branch,
which isn't very readable IMHO.  How about moving cpu_hotplug_enable()
directly below each rcu_read_unlock() call?

> @@ -392,9 +391,13 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>  	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>  	    pci_physfn_is_probed(dev)) {
>  		error = local_pci_probe(&ddi);
> +		dev->is_probed = 0;
> +		return error;
>  	} else {
>  		struct pci_probe_arg arg = { .ddi = &ddi };
>  
> +		cpu_hotplug_disable();
> +
>  		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
>  		/*
>  		 * The target election and the enqueue of the work must be within

I'd also move the cpu_hotplug_disable() below INIT_WORK_ONSTACK().
For one it minimizes the critical section, and also INIT_WORK_ONSTACK()
initializes a portion of "arg" declared immediately above, so it's
more readable to keep declaration + initialization together.

Thanks,

Lukas
