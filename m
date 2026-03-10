Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F01D381AF8
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142666; cv=none; b=UfRYM1sH1qYrF8MmMZaZSeHrjgjo3WJi8i7aKwYO2BiSDpr2a2IVSezfSnilomAimhr3Jf11/CWuDI0cVVI4Tdjle+MwBuNEJRe3Cvb9jJ2Q7BtHJYzXkGpQK6/dKHLKPN2E3kQxnVufrTi+fYC2G7nCCYF8/YN0BKQt05y3lQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142666; c=relaxed/simple;
	bh=zK5Jh59GAbn4En/eW1Dtts2Spbt7++8xZNGEZnpVOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3oqLmG3HT2giEc7hXfFZ/oMzSoNDsEpBUpv+/yy53AupfvfdhrwCLvBE3m6lNEVJooE3hg9A6b5zbQkK/LbsXjBLlp8unyIEHU8BmuOwQzvymL7ipvolEE+6LdxKEu8ljo+y5nTSYVbWPYfRhQ2Qo9ZgBBiCvFM1V0H/XoizQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ri3tZu3e; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ri3tZu3e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773142666; x=1804678666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zK5Jh59GAbn4En/eW1Dtts2Spbt7++8xZNGEZnpVOOM=;
  b=Ri3tZu3eUjs6bNn9PZMgPuyixKTvMbSslsDfY72TVBhQaVwz4Y6kuoeq
   nimB5frTJ/wLhr8qLwU53HkwigdKscBoya8Y6QpdcdjaYCzHInAPumZSN
   cQCx+in9+Z6VZb+pd7FQkyuBTPY1aWgjI6l68kWrqjBk0abWKfr9GFoCH
   8idBKqE+HYxqJIXsDDhbYC+a1wX+abTFGheuZWP114W5d00+y8rIlf9Rn
   sJcgFvqWUmSWN3hMXF0HI6w/IWhFGwy2Y6ni5OVYOHxjf6OUqKhpfwjgX
   mKkeNcEzf7zeV7mW8sdriYxYhUTZPtLYKRPwccQfsWNXVC8bOKA0J9FhO
   A==;
X-CSE-ConnectionGUID: fQDzmUhDTZWYrcekiog6cg==
X-CSE-MsgGUID: Y8vUJJ7sQ9Wlk2zRS/pYzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85662785"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85662785"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:37:46 -0700
X-CSE-ConnectionGUID: WKFysl9bQC2xmFKIChwLoQ==
X-CSE-MsgGUID: CHngzzXkTCCp14kBfXf1qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="243099015"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.33])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:37:43 -0700
Date: Tue, 10 Mar 2026 13:37:40 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-pci@vger.kernel.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 4/5] pci: check if VGA decoding was really activated
Message-ID: <abAChDpsUQhpnOcT@intel.com>
References: <20260307173538.763188-1-Simon.Richter@hogyros.de>
 <20260307173538.763188-5-Simon.Richter@hogyros.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260307173538.763188-5-Simon.Richter@hogyros.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland

On Sun, Mar 08, 2026 at 02:35:37AM +0900, Simon Richter wrote:
> PCI bridges are allowed to refuse activating VGA decoding, by simply
> ignoring attempts to set the bit that enables it, so after setting the bit,
> read it back to verify.
> 
> One example of such a bridge is the root bridge in IBM PowerNV, but this is
> also useful for GPU passthrough into virtual machines, where it is
> difficult to set up routing for legacy IO through IOMMU.
> 
> Signed-off-by: Simon Richter <Simon.Richter@hogyros.de>
> ---
>  drivers/pci/pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f..e60b948f8576 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6197,6 +6197,12 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  				cmd &= ~PCI_BRIDGE_CTL_VGA;
>  			pci_write_config_word(bridge, PCI_BRIDGE_CONTROL,
>  					      cmd);
> +			if (decode) {
> +				pci_read_config_word(bridge, PCI_BRIDGE_CONTROL,
> +						     &cmd);
> +				if(!(cmd & PCI_BRIDGE_CTL_VGA))
> +					return -EIO;
> +			}

Maybe this should also have a comment or spec quote to explain
that it's legal behavior?

The slightly bigger concern I have is whether we need to unwind
the previous steps if this fails? Looks like we don't update
vgadev->owns on failure (even though we may have partially
enabled things). But since the bridge should never forward any
VGA accesses, leaving some extra PCI_COMMAND enable(s) set on
the device shouldn't matter in practice. So I guess this should
work even without unwinding. Well, not sure about 
arch_set_vga_state() since that's 100% magic...

>  		}
>  		bus = bus->parent;
>  	}
> -- 
> 2.47.3

-- 
Ville Syrjälä
Intel
