Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795675722;
	b=lGw2vaRMcvN50k1+pnEum3lc/9Y58o5xlqef+j2NwfcNgej8mJ4+UHyLWFkSM6wCADWo
	 nXZpM9seTyOuaykUnwNTsbVJjCL196VB2NKQpYl1EEaLXsVuvaDr+7w5aJ8PIxScW8KFN
	 1zaY+J8G0edivN6s1cqQILH+iGPxR7jD6h9+qTvVlysI5fap3D8pXhKZLbXSQtQHrUmJ+
	 eyUUNjYx6FF6xaEywa85boSHm2IXROaLSa+A+cAC3ND+0btjTHiL7P3g1lzEH0w9ahVSz
	 IsNva4uuH2GSEIe2mozJrs5vS0o1v2okgbdyHo/YZHs9EOZG32VmxF4roDArgC2cEcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795675722;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=5YLjc7VnPsRFewiCI8g3WiBXnqqBztYYzZVy2pF8THk=;
	b=yW1ZLN0z41fK307EwK1+a/WpFrvm7OxCrYLE290BynNJFMjBSt6tW2Rkq+bJcQjUGfJB
	 yND/zNqzRG8bqfc+rc3Mzd70UtVL71pfereWGkYr/FDQKsRNlni/1nzyUPX5KLZiMmlk+
	 VwNTtvYwigqBdK4SCv5fcaj9rquYy/Fr2KULa6WFz35fO6w8Dhe9DmIZMVCEem8uRtCjx
	 A0Ieit13ZSmJWLh7UgngxJoxY/M4hCCapeoVc1wJCLSd6ZyGF/T8rwbTQYmm0pH+MdDBm
	 MWL4buNhIL7lV7JJrf2uFYjHNpUbxhNllmG66hppWUR6SjB6O3/IhNjdcgg7S1Jtlwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J95JRxAn;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BCB606A31C;
	Thu, 26 Nov 2026 06:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68BCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J95JRxAn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795675722; x=1827211722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lYjdectW2RKU1bEU2f272o7lhJl3HOXEa9UYjsc7jJ4=;
  b=J95JRxAny/mwkfEqwdX9iXEdcX1RG0yKetFgn8Scrwgg0Pu79JPf8G8O
   0jROWArqWCS0wwPEaOpvVwF0/tUtBJ9HpdPvkh0svr/IloYKWykEqOZlc
   ei1h9VWRMXrwaY/CXSfChLnvJrpCX/XFYMoTLWb4G/6HfYrujApLGJRYy
   bQxETjbCv3lkPR6aFW7cTH72SpVlyetHEEbLdk2Nof0N/Zdn3V+sHqxMY
   exl2/RP6Sct1vFHwm0XYAPbzmKq8EJe4jr3G9turg6rBWCkqymS/QHXkn
   rd+SYIM7B+eSgtnZWEk4GrotxzXSFt2+7e9Za83ck6/W1r2a+Lqvhu25M
   Q==;
X-CSE-ConnectionGUID: Ft9QYXHMR6ugcEOd6wqFbA==
X-CSE-MsgGUID: g7BoukOwTGmwatUH8UNNHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4542379"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4542379"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 22:48:41 -0800
X-CSE-ConnectionGUID: aRTPWwSQQIqlaBWj/K/0LQ==
X-CSE-MsgGUID: KhunosW+SUO0NEyMsCjTyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="13773070"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 25 Nov 2026 22:48:38 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 5724498; Thu, 26 Nov 2026 07:48:37 +0100 (CET)
Date: Thu, 26 Nov 2026 07:48:37 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Marco Sousa <marcomsousa@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, westeri@kernel.org, bhelgaas@google.com,
	lukas@wunner.de, rafael@kernel.org, superm1@kernel.org,
	Shyam-sundar.S-k@amd.com
Subject: Re: [BUG] AMD Strix Point USB4 (1022:150a): mid-s2idle pciehp
 hot-add causes D3cold->D0 failure and hard hang
Message-ID: <20261126064837.GK191152@black.igk.intel.com>
References: <CAHRsBfbYF3wocif+a0FRyBBkhcL+FtKF2qm=ne0jgLCzL8cH9w@mail.gmail.com>
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
In-Reply-To: <CAHRsBfbYF3wocif+a0FRyBBkhcL+FtKF2qm=ne0jgLCzL8cH9w@mail.gmail.com>

Hi,

On Wed, Nov 25, 2026 at 10:40:56PM +0100, Marco Sousa wrote:
> Hi all,
> I filed a bug report with full sanitized dmesg logs, lspci topology,
> controlled A/B test results, and a thunderbolt.dyndbg=+p boot log here:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=222327
> 
> Short summary:
> On an ASUS Zenbook S 16 UM5606WA (AMD Ryzen AI 9 HX 370 / Strix Point,
> BIOS UM5606WA.321, s2idle-only) docked to an HP Thunderbolt Dock G4
> (Intel Goshen Ridge 8086:0b26 + igc 8086:5502), reproduced on vanilla
> 6.18.65-lts and 7.2.4..7.3.6-arch1-1:
> 
> 1. At boot, tb_acpi_add_link() creates the device link from 0000:00:01.1
>    [1022:150a] (consumer) to 0000:c6:00.5 [1022:151c] (supplier):
>      [ 5.005536] thunderbolt 0000:c6:00.5: created link from 0000:00:01.1
> 2. Host router reset tears down the firmware PCIe tunnel:
>      [ 5.008763] thunderbolt 0000:c6:00.5: 0: resetting
>      [ 5.008813] pcieport 0000:00:01.1: pciehp: Slot(0): Link Down
>      [ 5.008895] pcieport 0000:00:01.1: pciehp: Slot(0): Card not present
>    0000:00:01.1 then runtime-suspends into D3cold (power resource
>    \_SB_.PCI0.GPP0.PWRS).
> 3. After dock authorization, tb_tunnel_pci() activates the PCIe tunnel
>    cleanly:
>      [ 9.429077] thunderbolt 0000:c6:00.5: 0:5 <-> 2:9 (PCI): activating
>      [ 9.430721] thunderbolt 0000:c6:00.5: PCIe Down path activation complete
>      [ 9.432080] thunderbolt 0000:c6:00.5: PCIe Up path activation complete
>    Yet 0000:00:01.1 remains asleep in D3cold and never wakes to enumerate
>    0000:01:00.0 / 0000:60:00.0 (igc).
> 4. On the first s2idle entry, pci_pm_suspend() runtime-resumes
>    0000:00:01.1 mid-suspend, invoking pciehp_runtime_resume() ->
>    pciehp_check_presence() concurrently with device_suspend:
>      pci 0000:01:00.0: PM: parent 0000:00:01.1 should not be sleeping
>      pcieport 0000:02:0x.0: Unable to change power state from D3cold
> to D0, device inaccessible
>      pcieport 0000:02:0x.0: pciehp: Slot #8191 ... /
> pcie_do_write_cmd: no response from device
>      igc 0000:60:00.0: PCIe link lost, device now detached
>    Entering s2idle in this unenumerated/wedged state causes a complete
>    hard hang requiring a ~30 s power-button EC reset.
> 5. Controlled A/B proof on 7.3.6: waking 0000:00:01.1 from D3cold once
>    before suspend (power/control=on + lspci, then restoring auto) makes
>    pciehp immediately see Slot(0): Card present / Link Up, enumerates
>    0000:01:00.0 + igc, and makes s2idle 100% reliable with full hardware
>    S0i3 residency (11-27 s, Last S0i3 Status: Success).
> 
> Also attached on Bug 222327 is a secondary drivers/thunderbolt/nhi.c:143
> (ring_interrupt_active) WARNING + Call Trace seen on dock hot-unplug.
> 
> I have the hardware on my desk and am happy to write and test a patch.
> Could you advise where the proper fix belongs?

I would start checking if you are running the latest BIOS for this machine?
This pretty much sounds like that something is mising on the BIOS side. The
AMD guys that are in Cc: hopefully can help to check if the "power
contract" _DSD is in place. It looks like it from the above but better to
check.
