Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CC39281B
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022487; cv=none; b=PPEo3HkTXRv7D4uowqfOYUJivh942GR8xoysyYhAgG52UXyEiuv8mq28vBH2qTQUv8Ey6eivyxkFCl0Gjhwd5YvROMXxO/wsiF8XGxGqtXODbFOPaiL4TsfuF/1KTC1DD93h0a2tmWrRw0drtmcFJk25uzOFd+BHIvUbsqkRi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022487; c=relaxed/simple;
	bh=nddEDF/REC3XXEgzKrDWBOShctJRJmbP6OuFSYsEOdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gk9yL09EyPokwJsL/YxvmRe9WEU/UHxq9q69r75AyqWyHAmU0Vh/DVM/n+xi6dgJ9mduXCoeJOZkaniOf9sUHj3dKUd2rvYZALsHmjwjnF9znUaVYP4Y+DVqKj0faYfLZZ+WBjWUQgw5RLobs7JmDfpBRhFQOpkljGVu1okHTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n1nYKc5/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n1nYKc5/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772022486; x=1803558486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nddEDF/REC3XXEgzKrDWBOShctJRJmbP6OuFSYsEOdM=;
  b=n1nYKc5/UpVSFNEmkxKDKvdk4JODPFFlnXZY+GrEng+VfivPBC+S7fDa
   bWbjy89gxwhytpU4QoHsac0juWeW9KZm5+l9QbuUYI277sWC+5Ve52mr3
   Q21pglrWKaR/cAKY1NGLyKD2M5cbv+9iNfKJDbBDJkASRglDAk4xAwAFs
   HPNNOow1j67vNRAztjEVLKlhjtQqze8sK5VaxoFAkiiIqJTGx8Jhs2wUE
   MGbwatSNTAPFjt68nOGrc3tH+jKcdCPANFb4Q2XIWYvCPOUeMOgDAp2zm
   KQ1XuZxjA7qR85l+Qab/2YPkMFRW+QUGwwDEVkVvcHvolVWND1u34pcHu
   A==;
X-CSE-ConnectionGUID: PFXm/qmpRwK/piXtHaPn0g==
X-CSE-MsgGUID: Xt0LP7yETKquK9FzOkEeow==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90636513"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="90636513"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:28:05 -0800
X-CSE-ConnectionGUID: aCuYk1aBQ02HF7VWgoc8Rw==
X-CSE-MsgGUID: L9YXh2iZQaeNDh5W88SOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220714560"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 25 Feb 2026 04:28:00 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 3494698; Wed, 25 Feb 2026 13:27:59 +0100 (CET)
Date: Wed, 25 Feb 2026 13:27:59 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>
Subject: Re: [PATCH 0/5] PCI / igc: Improvements related to PTM enabling
Message-ID: <20260225122759.GB2275908@black.igk.intel.com>
References: <20260224111044.3487873-1-mika.westerberg@linux.intel.com>
 <20260224171308.GA3737399@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260224171308.GA3737399@bhelgaas>

On Tue, Feb 24, 2026 at 11:13:08AM -0600, Bjorn Helgaas wrote:
> On Tue, Feb 24, 2026 at 12:10:39PM +0100, Mika Westerberg wrote:
> > Hi all,
> > 
> > There is (still) an issue with Linux PCIe PTM enabling that happens because
> > Linux automatically enables PTM if certain capabilities are set. However,
> > turns out this is not enough because once we enumerate PCIe Switch Upstream
> > port we also enable PTM but the Downstream Ports are not yet enumerated.
> > This triggers floods of AER errors like this:
> > 
> >       pcieport 0000:00:07.1: AER: Multiple Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> >       pcieport 0000:00:07.1: PCIe Bus Error: severity=Uncorrectable (Non-Fatal), type=Transaction Layer, (Receiver ID)
> >       pcieport 0000:00:07.1:   device [8086:d44f] error status/mask=00200000/00000000
> >       pcieport 0000:00:07.1:    [21] ACSViol                (First)
> >       pcieport 0000:00:07.1: AER:   TLP Header: 0x34000000 0x00000052 0x00000000 0x00000000
> >       pcieport 0000:00:07.1: AER: device recovery successful
> >       pcieport 0000:00:07.1: AER: Uncorrectable (Non-Fatal) error message received from 0000:00:07.1
> > 
> > We have ACS Source Validation enabled so Requester ID 0 which is sent by
> > the not-enumerated Downstream Port triggers the ACS violation AER.
> > 
> > This can be prevented by enabling PTM when the whole topology has been
> > enumerated and doing it like that seems to be reasonable anyway because we
> > only have a couple of drivers enabling it now so it does not make sense to
> > enable otherwise as it consumes bandwidth.
> > 
> > I did that fix and the problem went away but wanted to test with a device
> > and driver that actually enables PTM. I have a couple of igc NICs here that
> > has this support. However, when testing I noticed that during power state
> > transitions we still get errors like this from igc:
> > 
> >   igc 0000:03:00.0 enp3s0: Timeout reading IGC_PTM_STAT register
> > 
> > and after this PTM for the device stays disabled.
> > 
> > This series includes fixes for igc that deal with the issues I found and
> > now PTM gets succesfully enabled and works accross suspend and runtime
> > suspend of igc, and there are no flood of AER errors as above. While there
> > there is one cleanup patch in the middle that drops unused parameter.
> > 
> > Mika Westerberg (5):
> >   igc: Call netif_queue_set_napi() with rntl locked
> >   igc: Let the PCI core deal with the PM resume flow
> >   igc: Don't reset the hardware on suspend path
> >   PCI/PTM: Drop granularity parameter from pci_enable_ptm()
> >   PCI/PTM: Do not enable PTM automatically for Root and Switch Upstream Ports
> 
> These last two don't look dependent on the igc patches, so I applied
> them to pci/ptm for v7.1, thanks!

Thanks!

> Let me know if there is some dependency and I can ack them and drop
> them from the PCI tree.

They can be separate. No dependency. Just wanted to "ship" them together
due the fact that all of them are needed to get rid of the errors.
