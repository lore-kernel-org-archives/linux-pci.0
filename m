Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6933D6F7;
	Thu, 11 Jun 2026 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152887; cv=none; b=c6ttRkNPMxHMbAMvRuWmsJY8wHHHvD2AYiVOCdJWZUis6hbAobDBjhMe8vXG+Eos1JHGSuOSZPvpLjASsyGksrPfnarJv9o76Aq1enO5rR6XSC9Nkelp8Cqg7YueUSJ8u57sRaHRPz8ckgiMCI6kx6mQXCrsTmujRBYLMTp6AYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152887; c=relaxed/simple;
	bh=BNlxgJPdEHB5fuZUsnvdGpuQrz1LJHMgOu/0iZHHQfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGGNuvslvVRkaSBQu8YuQM9j19HZ1BSecVrKh93H19YgJhmewhD7bFiutKDSVV9QkaFxMFjqVtEyeu4AQ3jAo9EkHlEblDFa72SfQIy26Ib8rRiL8dn8UFMH2Dv58Fp/64Dx3Y8nZRizyZtZKeUI6gbeZIK0pJofg3KTLVaRN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k56Uwmvx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k56Uwmvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781152886; x=1812688886;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BNlxgJPdEHB5fuZUsnvdGpuQrz1LJHMgOu/0iZHHQfo=;
  b=k56UwmvxyW66G66A1aBXNG53CWhjfc2mCxhUa24yW07g6rQ5TGXgJJ8o
   SNghqGV1wyTCJNiPl1koUUxcaFQtJ9USiX0zhKBKjls7zFdefCj0jUdSW
   UsvBbldqzstmZBdNHPwM/pQ+0ga2Obxal6ZwhsTGJ56XNyiBPa9SsGCA1
   b+r+peNii4oEsb9wBWS6KuuFZDIN65Qa/P9d/UKQKtSL416+PaFzgA9Hg
   L4aCa5KO9KKpUuotNl7+eeC5lS2TJG+WZjauTvuEDJtb3Y1bzLktJuHR5
   ma/QtU4OTlCeU9ivAiQuc/XzXrHC6LqyWcLC+yzvKetc9xNV3VhJew4bq
   A==;
X-CSE-ConnectionGUID: 1kIGEFFyTAGH23pR2YMbzA==
X-CSE-MsgGUID: 4AiPQZI1RcOsXfthgsTIDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104623977"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="104623977"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 21:41:25 -0700
X-CSE-ConnectionGUID: rYoH2Qq5TraWxtl29a2KKQ==
X-CSE-MsgGUID: S0XWLuD1SzCyZg5jM5BGPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="241941705"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 10 Jun 2026 21:41:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AA2D395; Thu, 11 Jun 2026 06:41:14 +0200 (CEST)
Date: Thu, 11 Jun 2026 06:41:14 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dag B <dag@bakke.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: Connecting multiple TB3 eGPUs via USB4 hub?'
Message-ID: <20260611044114.GU2990@black.igk.intel.com>
References: <f600c4de-955f-4403-9f47-4de1088a9f56@bakke.com>
 <20260608152640.GA35630@bhelgaas>
 <20260609120826.GN2990@black.igk.intel.com>
 <9507bfaa-c14e-49fc-8016-cf65bed9a76d@bakke.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9507bfaa-c14e-49fc-8016-cf65bed9a76d@bakke.com>

Hi,

On Thu, Jun 11, 2026 at 12:48:40AM +0200, Dag B wrote:
> 
> On 6/9/26 14:08, Mika Westerberg wrote:
> > Hi,
> > 
> > On Mon, Jun 08, 2026 at 10:26:40AM -0500, Bjorn Helgaas wrote:
> > > [+cc linux-usb (Thunderbolt maintainers), Ilpo, Lukas]
> > > 
> > > On Sun, May 24, 2026 at 04:56:56PM +0200, Dag B wrote:
> > > > I am attempting to connect two TB3 enclosures to the same USB4 port via a
> > > > USB4 hub.
> > > > 
> > > > I cannot figure out of this is in violation of the TB3, TB4 or USB4 spec.
> > > I'm not aware of a spec issue here.
> Thank you very much Bjorn, slightly more interesting trying to get it to
> work then.
> > It should be fine but typically PCIe resources for one tunneled PCIe root
> > port may not be enough for multiple GPUs. Therefore I suggest to connect
> > them directly to the host USB4 ports without a hub.
> 
> That makes perfect sense. Until you run out of physical ports. The entire
> point of this exercise started with trying to connect a 5th 3090 to my fw13
> motherboard. :-D
> 
> Hence the USB4 hub. But even with just the hub and two connected GPUs, it
> fails.

Yes most likely because a single GPU takes lots of resources and there is
quite small window reserved per root port for example:

  Memory behind bridge: 60000000-6c1fffff [size=194M] [32-bit]
  Prefetchable memory behind bridge: 6040000000-605bffffff [size=448M] [32-bit]

Looking at your logs you have all 4 PCIe root ports for tunneling listed
there so I would expect you have 4 USB4/TB ports available as well
(typically the root ports not available for tunneling will not be visible
to the OS).

> For now, I have limited my testing to just the USB4 hub and either one or
> two GPUs.
> 
> 
> > Second thing is that you have bunch of PCIe related command line parameters
> > that may affect. I suggest removing all of them, and retry. There is hardly
> > any reason to add these - the kernel should be able to handle this by
> > default.
> 
> Mhm. I have stripped the command line parameters for some of my tests. It
> absolutely works with nothing extra for a single GPU. And it absolutely did
> not work without command-line params and with 4 GPUs  when I started on this
> adventure. But that was around 6.16-6.17.
> 
> 
> > 
> > Then provide full dmesg along with output of 'sudo lspci -vv' so we can
> > look a the resource allocation.
> 
> This very quickly becomes a lot of data as I test various things. I put a
> repo with various data up on github.
> 
> https://github.com/dagbdagb/usb4_to_tb3_troubleshooting/

There seems to be no dmesg + lspci without the command line parameters? Can
you do this:

  1. Remove all the non-default command line parameters.
  2. Boot the system up, nothing connected.
  3. Plug in the USB4 dock, enable PCIe tunnel (this probably is automatic)
  4. Plug in the first eGPU to the dock, enable PCIe tunnel
  5. Plug in the second eGPU to the dock, enable PCIe tunnel

From this take full dmesg and output of 'sudo lspci -vv'. At least we can
see how the "default" kernel resource allocation fails.

> If you truly want all this on the mailing list, please let me know.
> 
> > 
> > > Below it looks like you hot-added the hub.  Does it make any
> > > difference if everything is connected before boot?
> 
> Yes. With both GPUs connected at boot, none of them will work. With just
> one, it works.

Okay that tells the BIOS does not even try to assign the resources for
both of them.
