Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F011DDA18;
	Wed, 25 Mar 2026 06:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419096; cv=none; b=hRUc/jAgoCXMtyl3EqXZR3i/Rvu5GxUEa8YjmG7A7cjcbiRGtF4BxAT7T3e3PIvq8OL11Cstl62moWEOkNBV51Kq5bptyZceWrWMwbE2J4KpjhsjYyrIxZyzR7AUbz3ZI8fWOR3q7y0JdEEvUylmSm+DIHKRDTDyW93gPH/3qnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419096; c=relaxed/simple;
	bh=S8V9A1MEOroW5S26Hdtfevnc1VpiTAKEl5Qxqijclcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqyJXaxLIZpR3L+s+24xeqLbLiCdEn4wv8ZH187vPV67Z9LfSzoSieAFu3uTz6LB0bTK+fMVglda95QXZUL0nMyxsud5yMlKvEXggba66M8DiPe+vSUzE0Zngs95RVKB8UjFJ0f9y4eiXOXydaZrD/5OIYoA6Rpu4Mm11aqGLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tjm40uHP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tjm40uHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774419094; x=1805955094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8V9A1MEOroW5S26Hdtfevnc1VpiTAKEl5Qxqijclcg=;
  b=Tjm40uHPFnG7FIj1uK6pPGHh4os1zMDmeJt/odRuGVPHk5dvHlCTrxWl
   92fCiWiZA04D2MmjixDwjKhVfR3x71VGSViHG30tcK3yWSpmQ2+SKsiR8
   yt46kGthxKukmbEFXLI2KJIma0S6WOngL8tA5BHSFb6X+/GCzi9KeIvln
   aRlE61t6kuNCeOHpF/NhieMlL0rn1fG6zTKZq/vJ4BEwoG//62UXyDtwl
   jDkX1wG2Oi+hCfHbtfJN/dF/n6YdI063uWvGUJRqXiyndFe52ipdxd3df
   xNDTBfgwZMpKEHS0/0NfmWjNtCtnqwMgy2ZgOqqtwJQTzUmtH6xJeGYCW
   Q==;
X-CSE-ConnectionGUID: HISwPVi2RKKujbnSdInolA==
X-CSE-MsgGUID: aVRV5FK8Q7eUeD4cVfelCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79043756"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79043756"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 23:11:33 -0700
X-CSE-ConnectionGUID: u3wxkj5zRhq/OER4RKfaFw==
X-CSE-MsgGUID: SO2shT+tQ7+BLD/98BK6Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="224532575"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 24 Mar 2026 23:11:32 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 28A5B95; Wed, 25 Mar 2026 07:11:31 +0100 (CET)
Date: Wed, 25 Mar 2026 07:11:31 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260325061131.GY2275908@black.igk.intel.com>
References: <20260323232437.GA1085990@bhelgaas>
 <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>

On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> > eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> > cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> > wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> > 
> > I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> > that wakeup.  I would think pciehp should field that, and it should be
> > able to figure out whether to bring the port out of D3hot.
> > 
> > Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
> > set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
> 
> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
> spurious wakeups as mentioned in Mika's patch.
> 
> Mika, any comments?

What do you have connected to the slot?

IIRC the interrupt triggers when presence change toggles (due to the link
going down).
