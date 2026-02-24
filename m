Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5CD33C194
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771967309; cv=none; b=Y9Y4QtS2X+rzYMdp3Jtr2z+EksBxJVCKTw9H/J/F177PacgP3PFz5sO1IiW/UtilBj/4DVllmyDbVkcEdd3Mm24coItwpj8hSj3ARSIeXqjMes6+Sc31NkEX1RxzaP2EA81JMl2YUjks8dU8ltPnKlAlQ1gwalVTRfjsNB1rAVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771967309; c=relaxed/simple;
	bh=AQXanRAmXg0HtIipy0nniHzibAhiwalzJZWGFknrYJY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KwNPKdmHANgEMikKnP4OzWJMVXbiKh4me1aNBbfOPR4zdDq48BCag0sVrl0ZSenJPt3PfsvFJ+nLF0c7GhIbKMQCxP4jlD7eAaAYWLGSmMAGrIT7INPz1XsNVFtir+1D4jFc4rE4U5JkH88riipD0N8MBdSLzMgzZOhCvonRn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmnRGHO0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmnRGHO0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771967307; x=1803503307;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=AQXanRAmXg0HtIipy0nniHzibAhiwalzJZWGFknrYJY=;
  b=jmnRGHO0f1oqD77Yl3aeEbmr27KrAeOfEy1RszuV2C/SZ/7u2ztRlqYF
   5oZ1nMs420j7+UuOaLZfoFuFMJsJYiELtUS0XnFEycT42EzcNQrm9Jf3u
   rfmBUS4N5FL2Mkm7jNjPSomnhrx/JvFNc98a0dxr3zHQOyuFecG4rpOAX
   Vqufv/TN1OxlGdaEFKvkkAmR4ElnNq/MikZln8UWHyvJ/KhLA9K/6mh/H
   6nYYrfK5mlQkc9asncbMbQIXjgDv2Pp/QCZsCIwnizibpacfREWzjgiPC
   iqYooCtHYvjieDnTIsJ59OzP/eRJxl+jN+WekfKrJ5lkxJIXUoPEynXch
   A==;
X-CSE-ConnectionGUID: fY3fSQkgS1akO3/wuXIsuw==
X-CSE-MsgGUID: e3e6vvP8Rla2fUrj1+EipA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72967953"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72967953"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:08:26 -0800
X-CSE-ConnectionGUID: hFqcFEXrRYqb6ew2ymxhvw==
X-CSE-MsgGUID: qXrn6hXuQXiWMqxckTAqtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="213224711"
Received: from vcostago-desk1.jf.intel.com (HELO vcostago-desk1) ([10.88.27.144])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 13:08:25 -0800
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
Subject: Re: [PATCH 2/5] igc: Let the PCI core deal with the PM resume flow
In-Reply-To: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
Date: Tue, 24 Feb 2026 13:08:25 -0800
Message-ID: <87pl5t7sty.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> Currently igc driver calls pci_set_power_state() and pci_restore_state()
> and the like to bring the device back from low power states. However,
> PCI core handles all this on behalf of the driver. Furthermore with PTM
> enabled the PCI core re-enables it on resume but the driver calls
> pci_restore_state() which ends up disabling it again.
>
> For this reason let the PCI core handle the common PM resume flow.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


Cheers,
-- 
Vinicius
