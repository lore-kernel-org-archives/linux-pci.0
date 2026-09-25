Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607E3AFB06;
	Fri, 25 Sep 2026 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368878; cv=none; b=k44ABtRPrM+dqOUsbTA1FOFKn2iEW9AJmgG5J/SxTX1u77LbJ4jWwiQPIajIE3dIf+NXJylZgvLNIluq6R1LV45/SzUbEK6AkwFE4cMdjuvaZh4ClCYzkHaES7cIVvHLBWidY4E0qs2SyZg8WGmLAzy0ufkismgn+74gigSCM4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368878; c=relaxed/simple;
	bh=e09smwXb4XfYUPPvBg0iolq1lK/fM+M6JbT5JkWpZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TDgjEQLs5DTHxxoy84ZIRKzTf04qW0KnxWgmIsKvITrWcGTL3HK78MMSuqc4b/EdnHqez5dncQ1ZqGJ1E026Xajzivt4ba0qtGcmJgrPJJcDIrWe1M6lPzKmBlZXs8GeuRTozBECj2iipQF3U1h9/Nzzqa6f0S9/gNhmB3OvDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hr39Zsho; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr39Zsho"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A15E1F000FF;
	Fri, 25 Sep 2026 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368876;
	bh=na8PAI+6ga1GQK+sTI+pCTAUkoQSsH8cS8w0kTyUHL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hr39Zshoz7y7veoPBxXyeyI5h1VfvoGVc7sfuQSZhmhu2OARFEe2le+QeDrTKIG9q
	 H1fU0BLpRg2P+wykrgOdeDC6Nt+xSAjnT57D/0vye8xdltAPohFmLTLO0p6tUENr7X
	 c55ZaraAwreyHENT+iQKYyr9vN4UBIBJElIF8xW2V0pCNsRUYh71GEpylpg+e98rtS
	 1t4pHZpX9098ZV4g8/SXotORIFaGOx8gWf0i9oLU3RGdc+8xjGdPZ2Bnnu+23C9PnH
	 hGPmD1ML45EE79p04XdKlfz6+w+3/RtgMCOJwdr6iAkp47Q4DP8wLM5rhwrB5YMOLg
	 ZJBapdzmhiIUg==
Date: Fri, 25 Sep 2026 21:41:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 04/27] cxl: Add cxl_reset_dvsec_sequence() for
 vfio-pci
Message-ID: <20260925214110.3500b4d9@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-5-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-5-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:17 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> vfio-pci needs to run a CXL reset on a passed-through Type-2 device
> without the host-memory handling in cxl_reset_function(): the memory
> behind the decoder belongs to the guest, so the HDM range collection and
> host CPU cache flush that the host path performs must be skipped.

Hi Manish,

This cache flush being skipped bit concerns me.  Who is issuing the
necessary flushes in the vfio case? That is there to ensure we don't
end up with random lines cached by PA (as well as VA if relevant),
so they affect a guest just as much as the host.
I'm not sure why it makes any difference who the memory belongs to.

> 
> Add cxl_reset_dvsec_sequence(), which runs the DVSEC reset under the
> device lock and restores HDM state through
> cxl_restore_state_after_pci_reset(), and cxl_reset_capable() to gate it on
> a function-scoped reset. Both are exported to the vfio-cxl module so
> vfio-pci core does not import the CXL namespace.
> 
> CXL Reset always clears memory, so there is no caller Memory Clear choice.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
