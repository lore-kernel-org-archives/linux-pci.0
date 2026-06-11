Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A092F8E8F;
	Thu, 11 Jun 2026 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781155720; cv=none; b=iu9qrMjK6M6T2jht6G5sLzkMR710SavoDkyTYpzU3bkZcuJ/YlK4X88eXYDttePYVjSOC50E81sgpt+IINrLDE0BrtcqRmb0StbS7t93UjNkNUu12KznbQCIM/h5XxdOtH414D8n+xb3KkmHOhYaT5mQsaqC6b8zUnlN19J4A9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781155720; c=relaxed/simple;
	bh=hvGQtU132bRK5LnRpKnC3s/BPrckx89/NlcgTB6bLr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/H4mCjaxpqN5hyaWjfPTxBem1zbvbvAl1npBx7eGB3s79WyzreJ7tgN6A/vLbre6770gSYZ+YlwXs44KSTAcsvBUgWT26s+Xxp6Yc2/xxN9KJ/rT1Y0YchYCMIHGgswXQ44+Wb6IcRwsew9z5pgJZSNB0/M24pedGB5Awb4FFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VV1iSb+Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VV1iSb+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781155713; x=1812691713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hvGQtU132bRK5LnRpKnC3s/BPrckx89/NlcgTB6bLr8=;
  b=VV1iSb+ZSE4J4VyKIRdBxSXny4PPo74l8pS3mcVQgR00prlSOVw6/TKP
   fXn4wa8rX3jObVpS2gMq/7qCWWpq8V7gOyzUc6ap4EolUodnA6qMUcQcN
   dnuHXFFDW7O+q+M7lHD+rJfoqGcw9G+3b1Cf1RFoNmaNC5AGee69P2PJf
   wpu68UYLK7pYsKFP60ebjbPUCw4N9MBtqYRVYBz/XFBKOBewy/ITC0LH7
   We3k/1H1Xn07XU0MF698M5oUNsjsZaBYt1nubPK+9fgogdjgHvxjkusd0
   8fIR7YCZnzQpTny95zu6SwqCE4creut96iIP8fZ0TtuWzjkCw7cHHZF/3
   A==;
X-CSE-ConnectionGUID: KkkkCk1qS9yIIHshTZHibg==
X-CSE-MsgGUID: VWIBMlc1QXetnepSuCO0Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81868976"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81868976"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 22:28:33 -0700
X-CSE-ConnectionGUID: uyFfTHqEQQm5biJoGcW6Wg==
X-CSE-MsgGUID: vDBnVZEATFev0MdKY766Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="250304014"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 10 Jun 2026 22:28:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 95B1495; Thu, 11 Jun 2026 07:28:29 +0200 (CEST)
Date: Thu, 11 Jun 2026 07:28:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Dag B <dag@bakke.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: Connecting multiple TB3 eGPUs via USB4 hub?'
Message-ID: <20260611052829.GW2990@black.igk.intel.com>
References: <f600c4de-955f-4403-9f47-4de1088a9f56@bakke.com>
 <20260608152640.GA35630@bhelgaas>
 <20260609120826.GN2990@black.igk.intel.com>
 <9507bfaa-c14e-49fc-8016-cf65bed9a76d@bakke.com>
 <20260611044114.GU2990@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611044114.GU2990@black.igk.intel.com>

On Thu, Jun 11, 2026 at 06:41:14AM +0200, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Jun 11, 2026 at 12:48:40AM +0200, Dag B wrote:
> > 
> > On 6/9/26 14:08, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Mon, Jun 08, 2026 at 10:26:40AM -0500, Bjorn Helgaas wrote:
> > > > [+cc linux-usb (Thunderbolt maintainers), Ilpo, Lukas]
> > > > 
> > > > On Sun, May 24, 2026 at 04:56:56PM +0200, Dag B wrote:
> > > > > I am attempting to connect two TB3 enclosures to the same USB4 port via a
> > > > > USB4 hub.
> > > > > 
> > > > > I cannot figure out of this is in violation of the TB3, TB4 or USB4 spec.
> > > > I'm not aware of a spec issue here.
> > Thank you very much Bjorn, slightly more interesting trying to get it to
> > work then.
> > > It should be fine but typically PCIe resources for one tunneled PCIe root
> > > port may not be enough for multiple GPUs. Therefore I suggest to connect
> > > them directly to the host USB4 ports without a hub.
> > 
> > That makes perfect sense. Until you run out of physical ports. The entire
> > point of this exercise started with trying to connect a 5th 3090 to my fw13
> > motherboard. :-D
> > 
> > Hence the USB4 hub. But even with just the hub and two connected GPUs, it
> > fails.
> 
> Yes most likely because a single GPU takes lots of resources and there is
> quite small window reserved per root port for example:
> 
>   Memory behind bridge: 60000000-6c1fffff [size=194M] [32-bit]
>   Prefetchable memory behind bridge: 6040000000-605bffffff [size=448M] [32-bit]
> 
> Looking at your logs you have all 4 PCIe root ports for tunneling listed
> there so I would expect you have 4 USB4/TB ports available as well
> (typically the root ports not available for tunneling will not be visible
> to the OS).
> 
> > For now, I have limited my testing to just the USB4 hub and either one or
> > two GPUs.
> > 
> > 
> > > Second thing is that you have bunch of PCIe related command line parameters
> > > that may affect. I suggest removing all of them, and retry. There is hardly
> > > any reason to add these - the kernel should be able to handle this by
> > > default.
> > 
> > Mhm. I have stripped the command line parameters for some of my tests. It
> > absolutely works with nothing extra for a single GPU. And it absolutely did
> > not work without command-line params and with 4 GPUs  when I started on this
> > adventure. But that was around 6.16-6.17.
> > 
> > 
> > > 
> > > Then provide full dmesg along with output of 'sudo lspci -vv' so we can
> > > look a the resource allocation.
> > 
> > This very quickly becomes a lot of data as I test various things. I put a
> > repo with various data up on github.
> > 
> > https://github.com/dagbdagb/usb4_to_tb3_troubleshooting/
> 
> There seems to be no dmesg + lspci without the command line parameters? Can
> you do this:
> 
>   1. Remove all the non-default command line parameters.
>   2. Boot the system up, nothing connected.
>   3. Plug in the USB4 dock, enable PCIe tunnel (this probably is automatic)
>   4. Plug in the first eGPU to the dock, enable PCIe tunnel
>   5. Plug in the second eGPU to the dock, enable PCIe tunnel
> 
> From this take full dmesg and output of 'sudo lspci -vv'. At least we can
> see how the "default" kernel resource allocation fails.

Actually there is dmesg.6+hotplug_egpu_2 and lspci-vv.6+hotplug_egpu_2.
Sorry missed that.

The first GPU seems to fit fine:

[   24.538295] nvidia 0000:66:00.0: enabling device (0000 -> 0003)
[   24.539803] nvidia 0000:66:00.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=none:owns=none
[   24.590905] NVRM: loading NVIDIA UNIX Open Kernel Module for x86_64  610.43.02  Release Build  (portage@localhost)  Wed Jun 10 19:38:57 -00 2026

But then the second one has not enough resources left, the 55:03.0
downstream port that is used to connect the second GPU has only these left:

   I/O behind bridge: b000-bfff [size=4K] [16-bit]
   Memory behind bridge: 66e00000-6a2fffff [size=53M] [32-bit]
   Prefetchable memory behind bridge: [disabled] [64-bit]

Some BIOSes has an option that you can increase the amount of resources for
the root ports but some vendors hide it.
