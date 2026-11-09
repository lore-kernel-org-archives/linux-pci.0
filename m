Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218514;
	b=SFTLUyLSLTUV3A17G8gX9ThO81W/nGFnp22q5bpJuzSbQNGWTMfyjjtoEPu7eAtfJDZb
	 xQAsUPYeuCwC5fHhn/SJ19rWkE4Hqr1nuvjwQnVm39KWvDhVTe2KC3vm16n8H156ZIZ/y
	 nGatvhASkHuQ6lkiqISqItCMyD/yTqjqOxMHM6AAKKOrYBP6MMteU8TLhtDkW3LpIQwMz
	 QELvuLzu3ik/d4vN6L4biWQYEVBR+gQWVVxh3dCd9TzZOVHD4BZi8L4N7dqDvxIW+8pqx
	 EbLJQJqQirSJG3GhS40VVry829t1SbipDRmEC1d6Ogf3WSRIB9Y2JDjqjgEpi+ZYLmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218514;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Vrn55JPvAQ0yT0p3BRkIJljL3kQLPzmvbjeJapNiYxg=;
	b=qJJKUKUD8FDgPhrI4uLrYee1f172pBsW0qsatJ4z28F00BsbC/yh9B8pUkknvIM4ZU8r
	 JP0YGf46kvnYlnox8zREUMeEzU04YtjENHZsc+vtIAXbHy5k5j58HdIaO7WtJjcqt0u6u
	 csnmt9qPYKRwndUnQtwQp4pTqvm+sg+lroXfHfPuU4A8POoDTaBQLxgM3eTfeg/BqMZIK
	 nLXRsMJlR7I7BxdA5XnFHiLbwsw2m03R+1tJMs975P4jcSw7jLmLApbVf8OxEo4erFEom
	 lUFVZ2V3620MvIx0VMPxM+T8XPUKdGtOOAGQoDb5034ibk4eEJYgGoWxHrI8oX8IJJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbYyXbN1;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86830606A321;
	Mon,  9 Nov 2026 10:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86830606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CbYyXbN1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794218514; x=1825754514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lwL7Q+nPXqUW0WAtjO+yEB0WR5ea1mPrNXeXX7OmoYI=;
  b=CbYyXbN1rLQU3ONzAFoos8Lxg0sWREJsPKi24HueXC88lShZ8AXUMmUn
   QyzRfS/767+I/F4lnSV1mpB+75OA8yIAtRdhAYrb8NdmqWoBwu5TxQqLS
   fuZNfpx6qFwWjyjxEMtjlA745HHw6SM9hj0NssB30+YnFrp7H1NxghaMp
   F31EnkvcEG7zjyhWn4wDDBmJQ2twgMdGVhXCsArhRNN+Za+2G4WowX/UY
   dvb43gkFMYyIN/ed3tt6lnKa8wyTvim5b1nQdLPbi1NL7gj0poOaHwhv4
   XjxbSzf6uUuUBMnmST7wMWBeKTnIx1Z9NmQ67e6QmL8dZVQarG41YCUpk
   A==;
X-CSE-ConnectionGUID: TtFQpuS9SEKhnH3vT6yt4w==
X-CSE-MsgGUID: XnxrCl3ESieTXD9348BG9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2925933"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2925933"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 02:01:53 -0800
X-CSE-ConnectionGUID: 3sqQDv2kQFGXyMHcpt5QnA==
X-CSE-MsgGUID: fKuBgBPZTWq/3OYn5bBY/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7956135"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 02:01:51 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1C6CD99; Mon, 09 Nov 2026 11:01:50 +0100 (CET)
Date: Mon, 9 Nov 2026 11:01:50 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Li Yifan <yifan2.li@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, Li Lili <lili.li@intel.com>,
	Wang Jie <jie.wang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/PTM: Keep ptm_enable_cnt balanced when
 pci_enable_ptm() fails
Message-ID: <20261109100150.GI176724@black.igk.intel.com>
References: <20261104121457.2108515-1-yifan2.li@intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104121457.2108515-1-yifan2.li@intel.com>

On Wed, Nov 04, 2026 at 08:14:57PM +0800, Li Yifan wrote:
> Since commit e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically
> for Root and Switch Upstream Ports"), pci_enable_ptm() takes a
> reference on the device and on each port of the upstream path, and
> pci_disable_ptm() releases them. If pci_enable_ptm() fails, the counts
> can become incorrect in two ways:
> 
> 1. pci_disable_ptm() decrements dev->ptm_enable_cnt without a check.
>    Many drivers ignore the return value of pci_enable_ptm() and call
>    pci_disable_ptm() unconditionally, for example mlx5 and bnxt. If
>    pci_enable_ptm() failed, for example because the upstream port does
>    not support PTM, the count becomes -1 and stays negative after the
>    driver unbinds. Then pcie_ptm_enabled() returns true, and
>    pci_resume_ptm() can enable PTM on the device after a resume,
>    although the upstream path does not support PTM. Before
>    e1092d5e15e6, pci_disable_ptm() did nothing if PTM was not enabled.
> 
> 2. If __pci_enable_ptm() fails for the device after the upstream path
>    is enabled, pci_enable_ptm() drops the reference on the device, but
>    it keeps the references on the upstream ports. For example, this
>    occurs if the device has no PTM Capability and its upstream port
>    has one. Callers that check pcie_ptm_enabled() before
>    pci_disable_ptm() never release these references, so the upstream
>    ports keep PTM enabled with no user. Callers that call
>    pci_disable_ptm() unconditionally release them only through the
>    underflow in 1.
> 
> Fix both problems in one change, because a fix for only one of them
> makes the other one worse. Release the upstream references when
> __pci_enable_ptm() fails. Make pci_disable_ptm() do nothing if PTM is
> not enabled for the device, and use atomic_dec_if_positive() so that
> the check and the decrement are one atomic operation.
> 
> The fix for 2 is based on a patch from Wentao Liang [1].
> 
> Fixes: e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports")
> Cc: stable@vger.kernel.org
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/r/20261102222817.GA983941@bhelgaas
> Link: https://lore.kernel.org/r/20260616141733.1688264-1-vulab@iscas.ac.cn # [1]
> Signed-off-by: Li Yifan <yifan2.li@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
