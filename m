Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93542C2FF;
	Tue, 17 Feb 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347688; cv=none; b=epCHQd1zEi+fjnQ3mumZ4gdm3bZEdUeqECjuxUk70/blFmYn9XDKBINpIFL08RaHbYSMs8CSyEU+DLNFoSyOfWEoet/+yF/qBI1D3pgSae+P3x83P9HS/8SH4RnketjwaP7Qm8TrVKZPacstlUOPZL4XPPfKgMBAWuqMDQGQCZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347688; c=relaxed/simple;
	bh=79/P25WeQUr/f4oQd6LN6hVIR8JLPvPsZwvavPiRm6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZb9rmDRg/TI0KsiVxa2iaQKgxEa8CnRJm8zgpnu6eq/mMvYavZ18nqoUNgDoZG//rnTH7Bp30QotmgFFDOihfXswVYv45OO2m2BFx8rO8JF6l7RiTsKRc/dwLvw4DuW/EP2xsV4d6neJ0CgAJ+iZgjgQsQjd4UmoOmfIbuVqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPrp7vWn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPrp7vWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771347685; x=1802883685;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=79/P25WeQUr/f4oQd6LN6hVIR8JLPvPsZwvavPiRm6Q=;
  b=HPrp7vWn3XkSQfj02TcZmxUte0M3UdMcl8VTdSC3eXpVyZZEVVEHOk69
   wCkmy+GsM0Jo6f3EyiET4dmPjMrhsW8WUTyTwXdIsLVGHlgd1d4hVUi2f
   r/4DRkBqNt7a1Zh/cJTusnO10hgDQVKHjhvRBqlNRbMWwEvz+zzzNr7b6
   40S86M1/misl9uCOSCknUAH4xz+AA1Nk7vMN3uJpmBqn3tmYfXmW96bwP
   wT+ArNog2aE1fRVsQTVJmpOQQOwXScePqoYPTxmi+++llgt3nUX1/f6R3
   6fBwdE1FsTD1dojr3Zqed5CLZ1JXchkOs0XtuAFHdWjmVTK5/0e8sfm9i
   g==;
X-CSE-ConnectionGUID: nuQ6/7yPSmqAwevBZleusA==
X-CSE-MsgGUID: Vf833NIfR9mcqraJHN3LoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="97881965"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="97881965"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 09:01:24 -0800
X-CSE-ConnectionGUID: 1TIfPECESNquTIXXSiwQ7A==
X-CSE-MsgGUID: v7CTaxnJT8S6jNim9QGjRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213947691"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 09:01:26 -0800
Message-ID: <70533ce4-265e-449c-bd63-06f2d7f5bdf1@linux.intel.com>
Date: Tue, 17 Feb 2026 09:01:25 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <aZAPqQTiGQiDvX52@wunner.de> <aZCQsyL9RRessjMI@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <aZCQsyL9RRessjMI@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/2026 7:11 AM, Lukas Wunner wrote:
> On Sat, Feb 14, 2026 at 07:01:13AM +0100, Lukas Wunner wrote:
>> On Fri, Feb 13, 2026 at 03:14:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
>>> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
>>> update PME status registers (PME Status and PME Requester_ID in the
>>> Root Status register) during D3hot to D0 transitions, even though PME
>>> interrupts are delivered correctly.
>>
>> Hm, so in theory we could amend the PME driver to walk the bus below the
>> Root Port and see if anything has PME_Status set in the PMCSR register.
>>
>> But the PME interrupt is shared with hotplug, bandwidth control etc,
>> so we'd end up gratuitouly (and frequently) runtime resuming switches
>> below the Root Port to see if there's anything below which is requesting
>> wakeup.
>>
>> So just keeping the Root Port runtime resumed all the time, as this
>> patch does, is still a better approach IMO.
>>
>> I'm wondering though if this causes a power regression.  Does keeping
>> the Root Port in D0 prevent the Package from entering a lower power
>> state?  Or is this irrelevant because the PCH is a different chip
>> or tile?
> 
> I've just realized that pcie_disable_interrupt() isn't called from
> pciehp_suspend() if pme_is_native() is true.  Should disabling
> runtime PM cause a power regression, an alternative solution may be
> to make pcie_disable_interrupt() conditional on a new pme_is_broken()
> which checks for affected Catlow Lake PCH Root Ports.
> 
> The pm_runtime_disable() approach is slightly preferred because
> it keeps pciehp code clean.

I think pcie_disable_interrupt() is called from pciehp_suspend() when
pme_is_native() is true. Looking at the code:

static void pciehp_disable_interrupt(struct pcie_device *dev)
{
        /*
         * Disable hotplug interrupt so that it does not trigger
         * immediately when the downstream link goes down.
         */
        if (pme_is_native(dev))
                pcie_disable_interrupt(get_service_data(dev));
}

#ifdef CONFIG_PM_SLEEP
static int pciehp_suspend(struct pcie_device *dev)
{
        /*
         * If the port is already runtime suspended we can keep it that
         * way.
         */
        if (dev_pm_skip_suspend(&dev->port->dev))
                return 0;

        pciehp_disable_interrupt(dev);
        return 0;
}

pciehp_suspend() calls pciehp_disable_interrupt(), which in turn calls
pcie_disable_interrupt() only if pme_is_native() is true. So the interrupt
is disabled during suspend specifically when PME is native, not the other
way around. Did I misread your statement?

> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

