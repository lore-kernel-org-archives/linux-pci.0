Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0CE3914FA;
	Thu, 26 Mar 2026 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505525; cv=none; b=Z8IwKtRiSQh6lXf/cXu4hMh+4dAAVLLhUGbKtqQI5+/p3RnF+zJnY7OBQQ3qICGir7b5NLNLPMaYwtOoMEStBHFiVRzPsNhe09CoMOAWul/OUFqos7OEePyUkMOdiNr9rh7tUSI4uwdu0M5Nt+SVODGjptGLtj2wLi3+4dGkziE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505525; c=relaxed/simple;
	bh=+A+Tk7CQ0t/y2EuhMvQ7se9wORdKTqsiuobWWrc8goE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l61hwrJ2Z3W8f2jNvS9qV3I+3S4h4CX+XuD3m+ccPFq4eW9TTIe5ecd8AviIc+FD6HMkwQ2ZvA3WmEkBlyPyDj1d+y4LuW2K9LYvgUgV83kO/gghQTPh846goXzb4UQqfiE0DJVChjZn3GyFnVFywtbTRzwIjNC8+e6T9mBHeW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkFCMxVu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkFCMxVu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774505524; x=1806041524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+A+Tk7CQ0t/y2EuhMvQ7se9wORdKTqsiuobWWrc8goE=;
  b=EkFCMxVuPeJurXkzMAacLN1sWna+ClN97uc/r9429WZm4k6RAEdU2/de
   +aRBAKahzzhHeoPYUSNQb0/q6VlEB+Y5N3VpgGatN/oUu27OQ/2Q9Lqr4
   58Fptd45vIMHWlaVr17ZKaCQyThwQvc5iumApTmyyzuwBP2qNPU6uAXuR
   zuDtAe1HnQ83FgH/3+gRaiHFxQIBknzgNnwq5gH9b5y+mnrPEjOZlNbZS
   Ap5dYKpGmMllNL/uyl5VoiVNkBQoJ2XKSTkqiaYKFaWAG6N7KYkyCLpYi
   dedNaBrqnl+NgH6t8Cbz+EsW6i7I/Tr7gInp3MapNMr6UFLEjsJh+q29Z
   g==;
X-CSE-ConnectionGUID: 2ZXJlnMdRHap0ZaIypzvng==
X-CSE-MsgGUID: ref0Wp/qSIidMbuH7l6wsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="93134221"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="93134221"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 23:12:03 -0700
X-CSE-ConnectionGUID: 49GAxq+KRBeBAyQleFzB4A==
X-CSE-MsgGUID: oc/PUNOER1yQnui8YGjAYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224098605"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 25 Mar 2026 23:12:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 49F0E95; Thu, 26 Mar 2026 07:12:00 +0100 (CET)
Date: Thu, 26 Mar 2026 07:12:00 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260326061200.GA3552@black.igk.intel.com>
References: <20260323232437.GA1085990@bhelgaas>
 <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
 <20260325061131.GY2275908@black.igk.intel.com>
 <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>

On Wed, Mar 25, 2026 at 02:12:48PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 3/24/2026 11:11 PM, Mika Westerberg wrote:
> > On Tue, Mar 24, 2026 at 02:45:25PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>> eb34da60edee ("PCI: pciehp: Disable hotplug interrupt during suspend")
> >>> cleared PCI_EXP_SLTCTL_HPIE so that when the link goes down, we
> >>> wouldn't get a PCI_EXP_SLTSTA_DLLSC interrupt and wake the system.
> >>>
> >>> I don't know the details of why the PCI_EXP_SLTSTA_DLLSC would cause
> >>> that wakeup.  I would think pciehp should field that, and it should be
> >>> able to figure out whether to bring the port out of D3hot.
> >>>
> >>> Anyway, with this patch it looks like we'll leave PCI_EXP_SLTCTL_HPIE
> >>> set, and potentially get that PCI_EXP_SLTSTA_DLLSC interrupt again?
> >>
> >> I have tested this patch on Catlow Lake. Enabling HPIE does not result in
> >> spurious wakeups as mentioned in Mika's patch.
> >>
> >> Mika, any comments?
> > 
> > What do you have connected to the slot?
> 
> A network card.

Okay.

Out of interest how do you hotplug it? :)

> > IIRC the interrupt triggers when presence change toggles (due to the link
> > going down).
> > 
> 
> I have tested the s3 mode. I was able to see message related to system entering
> suspend and then coming back again after (after user intervention). I also noted
> pcie_disable_interrupt() called before suspend and pcie_enable_interrupt() called
> after resume.

In case of S3 the BIOS also configures the hardware before entering
suspend. On client at least it's suspend-to-idle and any interrupt will
bring the CPU and the system out of it. It could be that that's the reason
you don't see any issue if this is server system and it goes into full S3?
