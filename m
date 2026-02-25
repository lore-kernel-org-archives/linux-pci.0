Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C3F387343
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063808; cv=none; b=tcag6nXjGYA2Y4ay/1NL5ueJaFR13mxtmyVAAGbLjR34AaOcIE1LmZUGtkJtJC5qTda9skvASQQWCmxzWWDZQ7xoSN6nA+iJfHynkJQGRVv7iYEuq6Q33dEdnOrcsp1380YjBfIaxpX5cW1p4q8njSw0QguUJRtqYAtTYAVbnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063808; c=relaxed/simple;
	bh=PUDRRJUvwufwpdxAeV/prfHMJbc5bfvWNHyTsiVnrog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewwuL20H6xIhAs1667gxK9/0ODsjxtKteBP4RGRC+/sOZyLkc4xu0i4IcHPkIyF/Iiz2kXorpWn/EzVzbNtz2e+KKgCXD8NCEv184AW5uEt9dYjZBX19cnB0AuU75PcViP/+vcqRxfXOkQEo76Wee0EG44gPxFwP+h6Ro9KLh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvK5jCdB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvK5jCdB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772063806; x=1803599806;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PUDRRJUvwufwpdxAeV/prfHMJbc5bfvWNHyTsiVnrog=;
  b=TvK5jCdBGLn10jWhfTRw7h9xpzJOD3+7jKvRC8D3AkWluVhltxwizR/K
   HGeZQ4Rv6QRr7Kdjgz5MrnBk8PlS/t/EnLvX97P5QMrifWhBWIx+RhyxI
   Q0NzsL/eZuYc1dXQnMOOwqlzb0V4Q0XIwLfZvw4xYR85CjtDRHYHMUlJL
   q3aAfsHSRZ3KAesVLXiM9/Yo0MZ97NWI7DBniMkKoqq+QZUtutU9Ke1u/
   4oAlYFtst05kp2i4hm2o9IdGjuryvOnNB+chLypXRtcBkOWzefULQ1lwQ
   W6t33Xbzz9mAIsc+b+D8StMq+vrBAbZgSugc9QbxPpZmRNd3vuM7yNrZJ
   w==;
X-CSE-ConnectionGUID: 5VQmgi5LQwa7f+Pr8COVxA==
X-CSE-MsgGUID: Nld1kGi1Qpykjv+NHEi6WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73296033"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73296033"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:56:45 -0800
X-CSE-ConnectionGUID: OHcdCXSgQxiLJtblpsZj+A==
X-CSE-MsgGUID: w2L6W3WVTdeZm1ACxOS+Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="254143884"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.125.111.103])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:56:45 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Bjorn Helgaas
 <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org, Bjorn
 Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Richard Cochran
 <richardcochran@gmail.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Vitaly Lifshits
 <vitaly.lifshits@intel.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: Re: [PATCH 2/5] igc: Let the PCI core deal with the PM resume flow
In-Reply-To: <20260225122619.GA2275908@black.igk.intel.com>
References: <20260224111044.3487873-3-mika.westerberg@linux.intel.com>
 <20260224165837.GA3736201@bhelgaas>
 <20260225122619.GA2275908@black.igk.intel.com>
Date: Wed, 25 Feb 2026 15:56:44 -0800
Message-ID: <87jyw09y2r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mika Westerberg <mika.westerberg@linux.intel.com> writes:

> On Tue, Feb 24, 2026 at 10:58:37AM -0600, Bjorn Helgaas wrote:
>> On Tue, Feb 24, 2026 at 12:10:41PM +0100, Mika Westerberg wrote:
>> > Currently igc driver calls pci_set_power_state() and pci_restore_state()
>> > and the like to bring the device back from low power states. However,
>> > PCI core handles all this on behalf of the driver. Furthermore with PTM
>> > enabled the PCI core re-enables it on resume but the driver calls
>> > pci_restore_state() which ends up disabling it again.
>> > 
>> > For this reason let the PCI core handle the common PM resume flow.
>> > 
>> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>> 
>> I love it, thanks a lot for doing this!
>> 
>> Do we still need the pci_enable_device_mem() and pci_set_master()
>> in __igc_resume()?
>>
>> I suppose some of that is related to the pci_disable_device() in the
>> suspend path (__igc_shutdown()), but there are only a few dozen
>> drivers that do this, so I'm not sure it's essential.
>
> I think they are just as you describe due the fact there are explicit
> pci_disable_device() calls. Probably we can get rid of them as well but
> that requires careful testing that nothing accidentally breaks.
>

This series is solving real problems (thank you btw), I think the
pci_disable_device() one would be better as a separate series.


Cheers,
-- 
Vinicius
