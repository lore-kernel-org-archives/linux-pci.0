Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFB9466B63;
	Mon, 19 Oct 2026 04:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792384170; cv=none; b=t+V2KwFZMzqTMTw28xyZ1v2Pr+ujXTgysLhFaMgMWJfaEdlMp/1XS7bk2zvpA1faAbUrsXw2n4zBm6RLZnvaLseXlBsbnusPW6JHbWhSp7RtgKxprXLMKr3JC3MlzaeWCS+RnGgmtwuj5wsoAfrYx4rnro9aFOjLrvNEKNgBv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792384170; c=relaxed/simple;
	bh=hGEBTZeo+4uD/i+C8qWxW5X8VnOlOCZVXgQbjfZGwZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV52SJj2s3h5cBRzf4hYMCXE0pi97cn0CtYJFeTqUo2Bsa2sFjadz3PINu65JL53tyi/T+ixSEGN4L+NxcgVgzoqkV3bmU5OqNRTFDFtx3bzpl51n55y4h+DBMonkLViabyAe+di8gPj7MEUfnBjBe62yNRTgxyh2Ybw3y9MdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPigaIhl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPigaIhl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792384165; x=1823920165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGEBTZeo+4uD/i+C8qWxW5X8VnOlOCZVXgQbjfZGwZI=;
  b=UPigaIhlQX0sxClhY1RQ8MFrMklq9yJ5fo9MAisTNJ+EaGtozJa63smn
   bafMH1TV02BpGMiJlNRi3zSog5dybaqSz9kSHE0NuAf3re+ch2NqeQ8el
   emjU5DehNR+xu8d0Bidxr0YAMpmXZ4jNXd2Fwa0BNgRW3okyTVSI9ewzx
   Y/jotinFRBxj1gR1SfvR/RaGTNs8wV1WxVveMbD1zKEMKlDNKmRdOOVaJ
   f7eHZCeX5XdxhB0mrrmTEzVkMiI/2XdYdIdNrecjsyCOoD1uMLo85ihkd
   ssgSD4utsIvvEc1WWYJucc4J9y23PXjUNBAzWP/3puOz5MSYTtk/meDfX
   Q==;
X-CSE-ConnectionGUID: QPsvLA8sRT2mrxUTxG8jaQ==
X-CSE-MsgGUID: eUybyaOTQqWA6kaxJ9Sd+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="953297"
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="953297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2026 21:29:23 -0700
X-CSE-ConnectionGUID: rRthhWlHQlS8IG71+RgZHw==
X-CSE-MsgGUID: WJUQcRY3SECX+TcpzN9V3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,166,1787036400"; 
   d="scan'208";a="2790095"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 18 Oct 2026 21:29:22 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 8BF8399; Mon, 19 Oct 2026 06:29:20 +0200 (CEST)
Date: Mon, 19 Oct 2026 06:29:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Cole Leavitt <cole@unwrap.rs>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <westeri@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thunderbolt: Don't resume the software CM if the
 host controller is gone
Message-ID: <20261019042920.GX176164@black.igk.intel.com>
References: <20261018163750.130470-1-cole@unwrap.rs>
 <20261018163910.132231-1-cole@unwrap.rs>
 <20261018163910.132231-2-cole@unwrap.rs>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261018163910.132231-2-cole@unwrap.rs>

Hi,

On Sun, Oct 18, 2026 at 12:39:08PM -0400, Cole Leavitt wrote:
> nhi_resume_noirq() sets nhi->going_away when the host controller is not
> present anymore on resume (commit bdccf295d7cd ("thunderbolt: Do not
> touch the hardware if the NHI is gone on resume")). With going_away set
> tb_ring_start() refuses to start the control channel rings, but the
> software connection manager's tb_resume_noirq() still goes through the
> whole resume sequence. Every control channel request then fails with
> -ESHUTDOWN from __tb_ring_enqueue(), and tb_cfg_read()/tb_cfg_write()
> WARN for each one:

This is not supposed to happen with SW CM systems. I've seen a couple of
times Lenovo BIOS has the PCIe root port hotplug enabled and that's against
what the Barlow Ridge BIOS configuration checklist says. Please check if
there is newer BIOS (Lenovo has been fixing these) and of not report it to
Lenovo.
