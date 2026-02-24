Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00433BBCD
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 21:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967332; cv=none; b=VlCUNfxFZIs88VYy/MWgPxIlO6lHFrbsi1zR8xfrNZFjXa2PisDZ3WN7KBNtgKrYOxWt5ynsfp5blLyWqP/2J4Y+niVsHzvkROTe83bHIJ7bGvoU8Vbp5AGFTvDKBW4UTthk+9xzOzzT0ncIowuTr5zQAooNSvtLRfD5PdAdEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967332; c=relaxed/simple;
	bh=yZVE3IFGLgSzwdJm/9yVkBOGWvu/M2sKhlEwe2Wr6m0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o3PG2Hde1Zz9gDaLap9NtXzwXHGBmP+kL08Ze0LYXAE7p53yr3gQ4wFAepsXHSvkQO7HepRF7FhsA1Ba9WE7lELvZ4jiKR7e3NCY0yszqO1xXjQ4+GIhYmEuYRcFzy0/uon9z2c3HoiIJUqmefJ9BCAcu65Xv48xEfzROar9LRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MfUtpisb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfUtpisb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771967331; x=1803503331;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=yZVE3IFGLgSzwdJm/9yVkBOGWvu/M2sKhlEwe2Wr6m0=;
  b=MfUtpisbAQxtgqIkFAkVLRp4Vs5ahk6e2jvFeYrsf6l6rtYCRqcSkQXm
   KwgYafyR6RNS8uJ0Y77MdGQ0IcJadAV1l1bi8utBtjAsGtpVuugls7/+e
   l35GIgM3l1gJEDO98EUYJkAzgtfa597DqYYolqgZfBuEze4sQxCiEiUvh
   JSFhK5lwTXQPbLdRqagFPJHsYzNmZNxLCd0YB+UlaaF5JaSLMC6bGL08U
   5e7cbhyB4NN/I15u8opgeSpiU3uR26oU96hh38IKWJvz9ildgp81p4vKB
   ETkN1Diju/Sb/ZcOaDhjJEyzZAf73lRg1eG+nVlzS7DYQyTynjuGucxgx
   w==;
X-CSE-ConnectionGUID: N+I0jA4xR6Wa9q3f48dpTw==
X-CSE-MsgGUID: A4yNm3umQ/6xe4RuUx2cxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72967984"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72967984"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:08:50 -0800
X-CSE-ConnectionGUID: BBVJnObmTf6dX3BrMB6C6A==
X-CSE-MsgGUID: /P93JMUTRVaUi63HmbNT1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="213224721"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:08:50 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-pci@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lukas Wunner <lukas@wunner.de>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
 <richardcochran@gmail.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>,
 Mika
 Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/5] igc: Don't reset the hardware on suspend path
In-Reply-To: <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-4-mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 13:08:49 -0800
Message-ID: <87ldgh7sta.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> Commit c01163dbd1b8 ("PCI/PM: Always disable PTM for all devices during
> suspend") made the PCI core to suspend (disable) PTM before driver
> suspend hooks are called. In case of igc what happens is that on suspend
> path PCI core calls pci_suspend_ptm() then igc suspend hook that calls
> igc_down() that ends up calling igc_ptp_reset() (which according to the
> comment is actually needed for re-enabling the device). Anyways that
> function also poll IGC_PTM_STAT that will end up timing out because PTM
> is already disabled:
>
>   [  160.716119] igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register
>
> There should be no reason resetting the hardware on suspend path so fix
> this by avoiding the reset.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
