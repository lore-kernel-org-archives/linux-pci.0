Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3941DDA18;
	Fri, 25 Sep 2026 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314055; cv=none; b=bp66CKxu4Nj5+SSihrGUANd8IhwHcRZ2lrAXjM7zhNFQbasyVjpMWEo9rKwQ3AkdFtyexuMi9CVNqLGoGdZlZ1UxJ7GygejWWTUern3G7SZEbDkOnv0JCLHC8Vmb3Af/6XVxxyG0awKejHDMhh39F6DFfs7bVoDE8jIppLrKrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314055; c=relaxed/simple;
	bh=XvhUptsJqUl/Jg1Wu67H9eBVtsuC4nHCRspvGJorlsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O72cDMs9gaF2qnvsVT/kWjT5F1F49a43oK3S/iUi/W8OWYaOiV2hAq9is6nfoLo0QEwIlBJ3hmKei4pC+Kvgvtse1NPKIJocdCfW51WzjZKAErhsj3pUBGixy5QO/TsLXnWPSg2/QugoYJs+gqocwYk5MqKkdTnZU4kHOLF33v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPJZj4u1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPJZj4u1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790314053; x=1821850053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XvhUptsJqUl/Jg1Wu67H9eBVtsuC4nHCRspvGJorlsE=;
  b=MPJZj4u1dzKaXBPZhCZzio2nCh0Brm2SlowraoYXo/wGgIXPCwkACD3J
   +qr2KBt0dYFDEAy5fYjYr4RtQBVkpNWCa1qh5DNHUpT8IujHcq2uLhEBt
   hLiKsMHUhJQxxJucaAmNTc+xwU1CXSiUzQ/GTBj6Kylp9xZmYBQwBCoYI
   Ebj7hyfOyIW+KdT8Wj2UFaL/hVAaBQDeQRkKxvJm3Wh2D6Gu15wYMWKnQ
   QkS94KRanuS52oCBzsFnazCqDbzOEOhgjUPksvmI80db8qxIms+vd7Qvb
   16DSxWOCLEZlynO95feirI6jc7JiYdq9UjRNTiklPda9X+s5OtKGQibKz
   w==;
X-CSE-ConnectionGUID: q4r6KaDoRza22ClK1hk88A==
X-CSE-MsgGUID: Ya6LqjZMRDisigrnZrl0xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108587139"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="108587139"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 22:27:32 -0700
X-CSE-ConnectionGUID: e0s99+eAQsmK5wiKmLJIPA==
X-CSE-MsgGUID: SneSMkdKR026crwFvcNLsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="277993808"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 24 Sep 2026 22:27:29 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id AA63B99; Fri, 25 Sep 2026 07:27:27 +0200 (CEST)
Date: Fri, 25 Sep 2026 07:27:27 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Freeman Z <SHD-ISAC@outlook.com>
Cc: "Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"westeri@kernel.org" <westeri@kernel.org>,
	"andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>,
	"Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
	"Martinez, Juan" <Juan.Martinez@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Message-ID: <20260925052727.GV106095@black.igk.intel.com>
References: <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <20260921050450.GM106095@black.igk.intel.com>
 <f8b929da-b4ae-48ae-9667-3eb93aa0a4bd@amd.com>
 <TYCPR01MB10927E6DC71CDC3B39C26F35196832@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <BL4PR12MB9533BF5ABF7035E6DF151C0A9C832@BL4PR12MB9533.namprd12.prod.outlook.com>
 <eaaf891b-7b0b-4eea-b104-de2c0db7cb42@amd.com>
 <TYCPR01MB1092762E3E179C4A43874BBE696822@TYCPR01MB10927.jpnprd01.prod.outlook.com>
 <DS7PR12MB9550558C737D92A5762C3AAC9C822@DS7PR12MB9550.namprd12.prod.outlook.com>
 <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB109271EBFCFBEA8A8855D600496812@TYCPR01MB10927.jpnprd01.prod.outlook.com>

Hi,

I wonder if you could try the vanilla mainline kernel (not the stable
trees), this one:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/

Take for example v7.3-rc4 and see if the problem happens. If it does, take
say v7.0 or whatever is the closest the stable tree that has it working and
see if that works. If that works then we have the two points needed to
bisect the issue on the mainlne.

On Thu, Sep 24, 2026 at 07:18:30AM +0000, Freeman Z wrote:
> Hi Alex, Mario and Mika,
> 
> Yes. I have now tested self-built vanilla kernel.org Linux 7.0.12
> and 7.2.6 on the same machine, with thunderbolt.dyndbg=+p.
> 
> The external monitor is connected through the Kensington SD5000T5
> dock.
> 
> For both vanilla 7.0.12 and 7.2.6, I see the following behavior:
> 
>   - Cold or warm boot with the dock already attached:
>     enumeration works normally in my tests.
> 
>   - Boot/reboot with the dock disconnected, wait until
>     0000:00:04.1 and 0000:6b:00.6 are runtime-suspended in D3cold,
>     then hot-plug the dock:
>     the failure reproduces before running lspci.
> 
> In the failing runs on both vanilla kernels:
> 
> Before hotplug:
> 
>     0000:00:04.1
>       power/control        = auto
>       power/runtime_status = suspended
>       power_state          = D3cold
> 
>     0000:6b:00.6
>       power/control        = auto
>       power/runtime_status = suspended
>       power_state          = D3cold
> 
> After hotplug, before lspci:
> 
>     0000:00:04.1
>       power/control        = auto
>       power/runtime_status = suspended
>       power_state          = D3cold
> 
>     0000:6b:00.6
>       power/control        = auto
>       power/runtime_status = active
>       power_state          = D0
> 
>     0000:09:00.0
>       missing
> 
> Thunderbolt dynamic debug reports both:
> 
>     PCIe Down path activation complete
>     PCIe Up path activation complete
> 
> Only after running:
> 
>     lspci >/dev/null
> 
> does the root port wake and PCIe hotplug proceed. I then see:
> 
>     0000:00:04.1
>       power/runtime_status = active
>       power_state          = D0
> 
>     pcieport 0000:00:04.1: pciehp: Slot(0-1): Card present
>     pcieport 0000:00:04.1: pciehp: Slot(0-1): Link Up
> 
>     0000:09:00.0
>       present
> 
> This does not appear to be a 7.0 -> 7.2 upstream regression:
> vanilla 7.0.12 and vanilla 7.2.6 show the same D3cold/hotplug
> failure.
> 
> The Ubuntu 26.04.1's 7.0-based 7.0.0-30-generic kernel 
> successfully enumerated the same hotplug in my previous
> test, whereas vanilla upstream 7.0.12 does not.
> 
> There is one additional difference in my testing:
> 
>   - Vanilla 7.0.12 / 7.2.6:
>     dock already attached at boot -> works so far.
> 
>   - CachyOS 7.2.6:
>     I have also reproduced the failure with the dock already attached
>     at boot.
> 
> The D3cold hotplug failure is reproducible on vanilla upstream,
> while CachyOS may have an additional boot-time difference on top of
> that.
> 
> Regarding the display, it is connected through the dock. Both vanilla
> 7.0.12 and 7.2.6 also log DP DPRX read timeout(s), followed by
> successful capability reads during dock setup.
> 
> I attached a sanitized archive containing the complete
> before-hotplug, after-hotplug-before-lspci, and after-lspci dmesg/state
> captures for both vanilla kernels.
> 
> Thanks,
> Freeman
> ________________________________________
> From: Kovacs, Alexander <Alexander.Kovacs@amd.com>
> Sent: Wednesday, 23 September 2026 19:37:13
> To: Freeman Z <SHD-ISAC@outlook.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
> Subject: RE: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents JHL9480 downstream enumeration
>  
> AMD General
> 
> Also, is the external monitor hooked directly to the system or through the dock?
> 
> Replied or Forwarded By:
> Alex Kovacs
> 845-625-4422
> akovacs@amd.com
> 
> -----Original Message-----
> From: Freeman Z <SHD-ISAC@outlook.com>
> Sent: Wednesday, September 23, 2026 6:52 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; Kovacs, Alexander <Alexander.Kovacs@amd.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org; bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com; YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents JHL9480 downstream enumeration
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Hi Mario, Mika and Alex,
> 
> I tested the Kensington SD5000T5 dock again by using Ubuntu 26.04.1 Live with kernel 7.0.0-30-generic and thunderbolt.dyndbg=+p. The dock was disconnected at boot, and I did not run lspci before the hotplug log and power states had been saved.
> 
> In this Ubuntu run the PCIe/USB enumeration worked without any workaround:
> 
>  426.716: USB4 dock connection detected (host port 0:2, link up)
>  426.753: Kensington SD5000T5 discovered
>  428.410: PCIe Down path activation complete
>  428.411: PCIe Up path activation complete
>  429.025: pcieport 0000:00:04.1 reports Card present / Link Up
>  429.026: downstream 0000:09:00.0 (8086:5786) enumerated
> 
> After the dock had connected, but *before* running lspci, the sysfs states were:
> 
>  0000:00:04.1  power/control=auto; runtime_status=active; power_state=D0
>  0000:09:00.0  present
>  0000:6b:00.6  runtime_status=active; power_state=D0
> 
> The downstream USB devices and dock Ethernet also enumerated. I then ran lspci once: 0000:00:04.1 remained active/D0, 0000:09:00.0 remained present. Thus this run cannot show an lspci-triggered wakeup or a resulting PME event: it was already working.
> In my previous failing CachyOS runs, invoking lspci could wake 00:04.1 and make 09:00.0 appear. I do not see an explicit PME delivery message at hotplug in the Ubuntu dmesg.
> 
> The external display did still flicker. The Ubuntu log includes one DP tunnel DPRX read timeout at ~431.188s, followed by a completed capability read at ~431.239s, I do not know if it's related.
> 
> Attached are the full Ubuntu dmesg after/before hotplug and the state files.
> Unrelated USB serial numbers and network interface MAC addresses are redacted.
> 
> Thanks,
> Freeman
> 
> ________________________________________
> From: Mario Limonciello <mario.limonciello@amd.com>
> Sent: Wednesday, September 23, 2026 4:00
> To: Kovacs, Alexander <Alexander.Kovacs@amd.com>; Freeman Z <SHD-ISAC@outlook.com>; Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>; linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; bhelgaas@google.com <bhelgaas@google.com>; westeri@kernel.org <westeri@kernel.org>; andreas.noever@gmail.com <andreas.noever@gmail.com>; YehezkelShB@gmail.com <yehezkelshb@gmail.com>; rafael@kernel.org <rafael@kernel.org>; linux-pm@vger.kernel.org <linux-pm@vger.kernel.org>; S, Sanath <Sanath.S@amd.com>; Natikar, Basavaraj <Basavaraj.Natikar@amd.com>; Martinez, Juan <Juan.Martinez@amd.com>
> Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents JHL9480 downstream enumeration
> 
> > -----Original Message-----
> > From: Freeman Z <SHD-ISAC@outlook.com>
> > Sent: Tuesday, September 22, 2026 11:41 AM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>; Mika Westerberg
> > <mika.westerberg@linux.intel.com>
> > Cc: linux-pci@vger.kernel.org; linux-usb@vger.kernel.org;
> > bhelgaas@google.com; westeri@kernel.org; andreas.noever@gmail.com;
> > YehezkelShB@gmail.com; rafael@kernel.org; linux-pm@vger.kernel.org; S,
> > Sanath <Sanath.S@amd.com>; Natikar, Basavaraj
> > <Basavaraj.Natikar@amd.com>; Kovacs, Alexander
> > <Alexander.Kovacs@amd.com>
> > Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend
> > prevents JHL9480 downstream enumeration
> >
> > [You don't often get email from shd-isac@outlook.com. Learn why this
> > is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> >
> >
> > Hi Mika, Mario,
> >
> > I reproduced the failure following the requested sequence on my installed CachyOS system with kernel 7.2.6-1-cachyos and thunderbolt.dyndbg=+p.
> >
> > For this trace the dock was physically disconnected at boot. I did not run lspci before or during the reproduction.
> >
> > Before plugging the dock:
> >
> >      0000:00:04.1
> >        power/control        = auto
> >        power/runtime_status = suspended
> >        power_state          = D3cold
> >
> >      0000:6b:00.6
> >        power/control        = auto
> >        power/runtime_status = suspended
> >        power_state          = D3cold
> >
> > After plugging the Kensington SD5000T5 and waiting about 15 seconds:
> >
> >      0000:00:04.1
> >        power/control        = auto
> >        power/runtime_status = suspended
> >        power_state          = D3cold
> >
> >      0000:09:00.0
> >        missing
> >
> >      0000:6b:00.6
> >        power/control        = auto
> >        power/runtime_status = active
> >        power_state          = D0
> >
> > The Thunderbolt dynamic debug log shows the NHI/control channel waking and the USB4 fabric being configured. In particular:
> >
> >      thunderbolt 0000:6b:00.6: control channel starting...
> >      thunderbolt 0000:6b:00.6: 0: resuming switch
> >      thunderbolt 0000:6b:00.6: 0:2: is connected, link is up (state:
> >2)
> >      thunderbolt 0-2: Kensington SD5000T5 EQ Thunderbolt 5 Dock
> >      thunderbolt 0000:6b:00.6: 0:5 <-> 2:9 (PCI): activating
> >      thunderbolt 0000:6b:00.6: PCIe Down path activation complete
> >      thunderbolt 0000:6b:00.6: PCIe Up path activation complete
> >
> > However, I do not see a PME message corresponding to the dock insertion.
> > The PME messages in the full dmesg are the early-boot
> > "PME: Signaling with IRQ ..." initialization messages.
> >
> > So in this reproduction, the NHI at 0000:6b:00.6 wakes from D3cold to
> > D0 and the Thunderbolt driver successfully programs the PCIe tunnel in
> > the
> > USB4 fabric, but the AMD 1022:14ef PCIe root port/tunnel at 0000:00:04.1 remains in D3cold and the downstream 0000:09:00.0 hierarchy never appears.
> >
> > I attached the full dmesg captured after the dock plug, plus the small before/after state files. I redacted only unrelated local network identifiers, the hostname, and filesystem/LUKS UUIDs; the Thunderbolt debug data and device UIDs are otherwise unchanged.
> >
> > This particular dynamic-debug trace was collected on CachyOS rather than the Arch stock kernel used for my earlier reproduction.
> >
> It sure sounds like a PME doesn't deliver properly for some reason.
> 
> I suppose that while in this state - if you ran lspci the root port at
> 0000:00:04.1 exits D3cold and 0000:09:00.0 shows up, right?
> 
> Does the PME show up in the logs after you've done this?
> 
> Any chance you can easily check Ubuntu 26.04.1 live media?  There is a
> 7.0 based kernel there, and I would like to know if this regressed from that.


