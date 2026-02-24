Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2833C192
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967267; cv=none; b=OEwA0U16kqK7Um82J/FJrYEaVqD7GTvAg2r+0A73rtci1M+4AqTdDgV8R16du978mytLfdcWVRkKXxHWfi2Pw8aDzkwHin8aRdlM0k68/C0fo96uw0650FJp4NB52ZvHjQAxjLIW76yaVqUJucfW/7sBSHgXSonrLUolKKDxBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967267; c=relaxed/simple;
	bh=vKIBtaARH7PRWjwpjY6J96lNoDByzUY/geYAam/OTIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SgBOaHlkk52No0lBdUe1VRwdo7CUwHbUc23Gh7r6HNmHcBLZoMn+CaUdz9keQtOFSpXOFFJ6ugTD9o9jcHhEfBqo51gJreiP3TYz7ZzKxiBr/lj0FwrDBcNaOGW0R4f3B6MHCvKa49FFusJZ7FoVIh675qsmcs9zJh/QCsIA5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5TXgwUv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5TXgwUv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771967266; x=1803503266;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vKIBtaARH7PRWjwpjY6J96lNoDByzUY/geYAam/OTIw=;
  b=U5TXgwUvVnC7aRdxE5GKI4ejruICEXYFkQfKHUFDmKcWxS20YsmYcbnn
   YRCeeCJQ8jT0wxoTXszpY6xwX0wwQ7TKF1RzdGoequthLzbSe3wFhpniH
   610NEBnnxgzeJMsoAhb11ixGI1UetkRSGAQ77GnEcS/vn3/gOq+DSSl2Q
   +1lnMUKhLcI1jhZOzu5PB5b21CJnAH/SfuF0bhWSGXUoG9jQR6DXaR8+e
   uD+GqlyHdpfV9XEG4Hak9w3UYCNxyRY9cbTdqii+31k5AQuM06W88DUG0
   zIGNeTzuDdXVUB9D32G6QChjmcCeL9bLsJ+7b9Tof9lRdsYMpaB9Cb7WG
   w==;
X-CSE-ConnectionGUID: EjcafE2CR7mWM9Sdeuhazg==
X-CSE-MsgGUID: Ex41VGHlTP6fzqIJVSVKEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73175343"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="73175343"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:07:45 -0800
X-CSE-ConnectionGUID: HjvEF+m1S/WtKYDGdB8YSw==
X-CSE-MsgGUID: YYb1drJ/Qd+8azGkruqmsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="220529667"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:07:46 -0800
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
Subject: Re: [PATCH 1/5] igc: Call netif_queue_set_napi() with rntl locked
In-Reply-To: <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-2-mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 13:07:45 -0800
Message-ID: <87tsv57sv2.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> When runtime resuming igc we get:
>
>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
>
> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> linking as "ops protected"") added check for this. For this reason drop
> the special case for runtime PM from __igc_resume(). This makes it take
> rtnl lock unconditionally.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---

Typo in the commit subject: rntl -> rtnl

I think it's worth fixing, anyway:

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
