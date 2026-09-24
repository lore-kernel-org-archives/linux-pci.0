Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20330C165;
	Thu, 24 Sep 2026 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213394; cv=none; b=Ob+gUEbLHiSRaEEKySD0dat9H7J0lE/VKxXjS1BnvLAl9yVubKWHlaDgy8jMlVmXrPUtFsNSAK23KfmAnrOw13s46xQk1KgJmFgkKtuDZcZiDKS56gEDSrXpY9BsIGs7TJmur+m7U621SOKdST4GnfDHCBUy3tmmM59DPKZ6GWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213394; c=relaxed/simple;
	bh=pj0jHwkVYBdX7kqJM8efKHTfipm8FC8rVLCSapBCxT4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJpOqIwnOeoVw304TDlWHd1pvWcRMxl3KtWeqCxAkuHRDoO6HrvKJuzA2GQ7Don0l88R21HSpDUEKbdCEG10scTBR1BBUf/LVPU0yjs6uQeBloYCRr8/lFquSBVt/nQNqnAIErCkMqx41tcyFGSpR5YmIvblIagt5hxl99XVcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDqmkMIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDqmkMIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E801F000FF;
	Thu, 24 Sep 2026 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213393;
	bh=N6QOJhN7/fWsre07emNYlhsWwp+fLxSmp4LKaZ3dZpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UDqmkMIurPSxLLsfG6Dq8kfYg4IkPtxidoT4mK+B6/cnUMue+PzOYas48B7P0wYqH
	 B0vtKb/uKS9yurhb7hMLhpJfkenmTBjnNrI1iz38y9MdRT9Wp9nWh3p7yVowVxuxGL
	 8MMXeNqAlyOoHbXibGD1UNJ48u/FiwRbtoIu0YvlrbqXy0HE1jHEiDlapXItBHGps8
	 Q5dJetUO0DZzFd+LO0YFQDQQvAXcSRdH5oJ7C+aLheXSlyBUILh1LTtcFGS7R7XTb/
	 szLq5A7KI3iOTOrdSfGpNEHZj+fLP2NIT7inLvIE8YRlag0XwLLCfYxRC0MU9mOGF6
	 zF2C8vMlq4ztg==
Date: Thu, 24 Sep 2026 02:29:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v13 03/15] cxl: Move HDM decoder programming helpers
Message-ID: <20260924022946.4e158d17@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-4-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-4-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:12 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Move the HDM decoder programming helpers and cxl_rwsem from hdm.c to
> resource.c for reuse by reset restoration. Keep their behavior unchanged
> and expose only the cross-object helpers within cxl_core.

I'd very briefly mention that the ordering of patches was chosen for
minimal code churn, but that it necessitates some functions are
use cross module in a fashion that is dropped in later patches.

> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Otherwise much more readable!  Thanks for splitting it all up
into more bitesized chunks.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

