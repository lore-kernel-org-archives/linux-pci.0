Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526802;
	b=D4tv77VGuRtNdMT/Zh58rO3EQfJU96gFEz/1E5PxVPf7YpjeTqx31OIkdrDx87JGnOyf
	 HE623yVmFhlWaRLnISsdd9AyNd3unFCl/S0spivEejh8cafs0JMBiQuS7Ia06eE634GYp
	 iQTXh39ZLD8iZAdFYaai73QloKTN3wtzabe82QxNmfPs98qwJmGwMT9VynIy2+mTmpAsF
	 l49pJ5eOqMrbV0aSKCP17CaRPz8HWuynyeSwGBEFVPxZz6A+a+DWkFyzpSISlJ8S8xW0I
	 zvSzaaNFbzQLeyggUhwjQQPxHu92YmgL3N/Zduy/qr/VgiObOdCuxoiQb/+CVRPcW7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526802;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=51d7Hjkss66lBP5vv+XJb6BNuDcdS0Ogfcckps/05kE=;
	b=iJkeK0luRtUFRikEdd0ilpIi9wPZ/c3H49H/cKoFHkG3uLn1EbUMiVMPymyEZtpk/Dz1
	 8Udv5+bTKYqyeR/S8OTkC5WYubt31uusGErt0Y4fU1gfb7mz/6u7sycroUPEZkl7y//NX
	 7mq0/LdqgY9b/GT3ZJbR/v0ZdbJRcJ0NCTDuoNzd2P94YokY2WR4RzcJ0Uq7I8UeqmQyd
	 2g+SHHu9V6S1clUooUf54U6Ka0DwGVsPRLFy3DShLPoS0K4hqv/XeZqfWR0dStfZbPxyj
	 5ep5YxnMvyXqx0kgQPWjxCiR7jwpEslu2g8W1BLGUsJmND+3SORYJth/FJ01GFYSNjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0cgrtTE;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689DF606A322;
	Tue, 24 Nov 2026 13:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689DF606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T0cgrtTE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795526802; x=1827062802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z/DWyL0A6zmh4VbCs9zmXC38a5oMz4PJV4CZsHZSATs=;
  b=T0cgrtTEH3V0k1GZQIXPl9iK4SCA3ybL70KNdStqwM/jwL4rY26avPz/
   4kGuLFmejmJJTBYtcareiHz6oMWEu09MtYHyDLYkdhvJK2pnixm0IUzSh
   hBCGN0Cr+WdB5BrMFjHSdwgrOO/yeAhvq99/F8eOwlw+x7F6CsRD1MtTg
   Doqy1tK37YaIq1ODoZEIJvIBFxwXZCUfAKawutkc5/7ibJyDScjsrg091
   GvRTJtbLfMiKT1zZP1Bm25BBkggHhhEadbgd17foJGeNfE2A4MiHibzSH
   g/4/DqfYJqO4G2UakliaeHEhlSyMakVkt+kctJ7mZtJdS+Mi9FPF+8lN+
   Q==;
X-CSE-ConnectionGUID: Po3pgy8jRwKUh9DrJWP0HA==
X-CSE-MsgGUID: 4Duh4iGKQe+2GPksUpejsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4416269"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4416269"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 05:26:41 -0800
X-CSE-ConnectionGUID: dTBriG0TTxGpiAiOFdzJ1g==
X-CSE-MsgGUID: IQrsLZwKQxCxggu4xvD31w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11887873"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 24 Nov 2026 05:26:39 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 58E2594; Tue, 24 Nov 2026 14:26:38 +0100 (CET)
Date: Tue, 24 Nov 2026 14:26:38 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: Re: [PATCH v3] PCI: Correct PCIe port type field encoding
Message-ID: <20261124132638.GO229695@black.igk.intel.com>
References: <20261124085038.17299-1-Gokulkrishna.Sekar@harman.com>
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
In-Reply-To: <20261124085038.17299-1-Gokulkrishna.Sekar@harman.com>

On Tue, Nov 24, 2026 at 08:50:38AM +0000, Gokulkrishna Sekar wrote:
> set_pcie_port_type() validates PCIe port topology and corrects
> invalid upstream/downstream port type information in the cached
> pcie_flags_reg value.
> 
> When performing these corrections, the code updates
> PCI_EXP_FLAGS_TYPE using PCI_EXP_TYPE_UPSTREAM or
> PCI_EXP_TYPE_DOWNSTREAM directly. The PCI_EXP_TYPE_* values are
> decoded port type numbers, not values encoded for the
> PCI_EXP_FLAGS_TYPE bitfield, so the corrected type is stored in the
> wrong bit position.
> 
> As a result, a device whose type has been corrected may subsequently
> be reported as PCI_EXP_TYPE_ENDPOINT instead of the intended
> upstream or downstream port type.
> 
> Use FIELD_MODIFY() to update PCI_EXP_FLAGS_TYPE so the corrected
> port type is encoded consistently with the format used in the PCI
> Express Capabilities Register.
> 
> Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
> Reported-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Link: https://lore.kernel.org/all/20241213070241.3334854-1-gthiagarajan@marvell.com/
> Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>

Reviewed-by: Mika Westerberg (Intel) <westeri@kernel.org>
