Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BE21E1DF0;
	Mon, 16 Mar 2026 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662277; cv=none; b=u+0nXS1AFAvoLUanxUfzXn/82OH6BQLD8NmpqXDf8ki0kTciL9FMDE8V+EooirERbqKWH0ExyMhY7jdnkZYx2dUnV7SuVZ9a7ctG6oG6yY7ho616kSG9oHzRH0Wu5w529SJdymD4Rwpojrkc2Twr12yPYrT1M970TYtvFtb5GOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662277; c=relaxed/simple;
	bh=q7+7F41K9BC0uii1Sxp2yvDVUn8AFQNiqJUgMG9XHok=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V+H6c5LKXJCUYPo8bymZ6KNo9llV/LJqtZx1I1VxBOsS5ya3XkzXLd07BGFhxrUY4BHAemJmj4RaoxVLhiBWv19PLr9JxyAM4BAbUNKstsCOpFcaB+Kq5QaH5z9J5qToVLiCPYUvsoa1sa86Pi9xIVWlucIUrIK45pH8VrWJbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oD7pxofH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oD7pxofH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773662276; x=1805198276;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=q7+7F41K9BC0uii1Sxp2yvDVUn8AFQNiqJUgMG9XHok=;
  b=oD7pxofHetWF3c7IbaFuIYRUz6iy5I+OjLMhHPefY13pBlVUHpP3/IQx
   arYp84bWheoh91sTllNtm6+a2ugvo80lT1Z0Yx17KRFu0GV5guLbopGQh
   M9I3SNU5GOQBgubZTAK/gfWDTbHdJpZRRP4vS4iO6FPFU+ZVGjxzay4V6
   0WAqots8CoV0Pyis/qR5SLEEi8W5s/+G+tuwoKxYI6NzZ1kMZm33LHhpm
   forvf1arKcRhdCEihqKZvZjec23hCiuDtaWdtGKrCTyi2TnOCdpJBPArn
   l+gtlX5vAVitPifjE8GEKr4N/CNG/f7AzLqgdmmzX/QsslxHMpJJIETG/
   g==;
X-CSE-ConnectionGUID: +fwaNsT0QVyoUSaGwesqxQ==
X-CSE-MsgGUID: Ek7sZjHqQyeQB3HOXJcaQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="86027879"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86027879"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:57:55 -0700
X-CSE-ConnectionGUID: j/KVNjjrRQ+lbfIu3GCe5w==
X-CSE-MsgGUID: NKBAWtJaQeu2j6nJeneCWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222100324"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.253])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:57:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Mar 2026 13:57:48 +0200 (EET)
To: =?ISO-8859-2?Q?Michal_Babi=E8ka?= <michal.babka@gmail.com>
cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-acpi@vger.kernel.org, regressions@lists.linux.dev, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window
 / BAR allocation failure prevents NVIDIA and AMD GPUs from initializing 
In-Reply-To: <FCEB17D3-3DC5-49C8-8C56-8051C875E2F9@gmail.com>
Message-ID: <baa658a5-5244-1fa4-4331-03139231667a@linux.intel.com>
References: <FCEB17D3-3DC5-49C8-8C56-8051C875E2F9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2032271365-1773661111=:1005"
Content-ID: <0e97a1fe-ed58-b893-b05e-e6f47d8a37ae@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2032271365-1773661111=:1005
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8e4b41bf-b1bb-8801-c078-858e9103699f@linux.intel.com>

On Sun, 15 Mar 2026, Michal Babi=E8ka wrote:

> Subject: Apple Mac mini 2018 + Thunderbolt 3 eGPU: PCI bridge window / BA=
R allocation failure prevents NVIDIA and AMD GPUs from initializing
>=20
> Hardware / platform:
> - Host: Apple Mac mini 2018
> - Connection: Thunderbolt 3
> - eGPU enclosure: Razer Core X Chroma
> - Tested GPUs:
>   - NVIDIA Quadro P400
>   - NVIDIA Quadro P4000
>   - AMD Radeon Vega 64
>=20
> Linux distributions / kernels tested:
> - Ubuntu-based systems
> - Zorin OS 18 Pro
> - Multiple kernels tested, including 6.12.x and 6.17.x

None of which are even near the latest when it comes to resource=20
allocation improvements and fixes (though you didn't specify .x).

> Problem summary:
> On Apple Mac mini 2018, an external GPU connected through Thunderbolt 3 i=
n a Razer Core X Chroma enclosure is detected and enumerates on the PCI bus=
, but GPU initialization fails because PCI bridge windows / BAR resources a=
re not assigned correctly.
>=20
> This is reproducible across different Linux installations and with GPUs f=
rom different vendors, which strongly suggests a platform/topology-level PC=
Ie resource allocation problem rather than a bug in one specific GPU driver=
=2E
>=20
> Observed behavior:
> - The Thunderbolt enclosure is detected correctly.
> - boltctl shows the enclosure as connected / authorized.
> - The GPU appears in lspci.
> - The kernel loads the vendor driver module.
> - GPU initialization then fails.
>=20
> For NVIDIA, nvidia-smi reports:
>   "NVIDIA-SMI has failed because it couldn't communicate with the NVIDIA =
driver."
>=20
> Relevant NVIDIA kernel messages include:
> - "BAR 1 [mem size 0x10000000 64bit pref]: can't assign; no space"
> - "BAR 3 [mem size 0x02000000 64bit pref]: can't assign; no space"
> - "This PCI I/O region assigned to your NVIDIA device is invalid"
> - "BAR1 is 0M @ 0x0"
> - "RmInitAdapter failed"
> - in some attempts also:
>   "fallen off the bus and is not responding to commands"
>=20
> With NVIDIA Quadro P4000, the same general failure pattern was observed:
> - the GPU is detected on the PCI bus,
> - the NVIDIA kernel module loads,
> - initialization fails,
> - and the logs again point to invalid / missing BAR assignments and resou=
rce allocation problems behind the Thunderbolt PCIe bridge hierarchy.
>=20
> For nouveau, the failure is visible as BAR/resource allocation failure as=
 well, for example:
> - "bar: one-time init failed, -12"
> - "init failed with -12"
> - "Device allocation failed: -12"
>=20
> With AMD Radeon Vega 64 installed in the same enclosure on the same host,=
 the same fundamental problem occurs:
> - the enclosure is detected,
> - the GPU enumerates,
> - initialization fails,
> - and the overall behavior indicates the same lower-level PCI resource / =
bridge window allocation issue.
>=20
> This strongly suggests the issue is not NVIDIA-specific.
>=20
> Thunderbolt state:
> boltctl reports the Razer Core X Chroma enclosure as connected/authorized=
 correctly, for example:
> - type: peripheral
> - generation: Thunderbolt 3
> - status: authorized
> - rx speed: 40 Gb/s
> - tx speed: 40 Gb/s
>=20
> Important conclusion:
> Thunderbolt authorization itself appears to work.
> PCI enumeration also works.
> The failure happens later, at PCI resource assignment / bridge window siz=
ing / BAR allocation time.
>=20
> Key dmesg patterns observed:
> - multiple "can't assign; no space" messages for PCI bridges and BARs
> - BAR1 / BAR3 of the GPU not assigned
> - bridge windows under the Thunderbolt hierarchy not large enough
> - reassignment attempts that still leave required windows unassigned or i=
nvalid
> - vendor driver subsequently failing device initialization
>=20
> Examples of affected topology in logs:
> - 0000:00:01.1
> - 0000:05:00.0
> - 0000:06:01.0
> - 0000:0b:00.0
> - in other boots, the same problem may appear under a different BDF addre=
ss after Thunderbolt re-enumeration
>=20
> Representative log excerpts:
> - pci 0000:0b:00.0: BAR 1 [mem size 0x10000000 64bit pref]: can't assign;=
 no space
> - pci 0000:0b:00.0: BAR 3 [mem size 0x02000000 64bit pref]: can't assign;=
 no space
> - pci 0000:06:01.0: bridge window [mem size 0x10000000]: can't assign; no=
 space
> - pci 0000:05:00.0: bridge window [mem size 0x20200000]: can't assign; no=
 space
> - NVRM: BAR1 is 0M @ 0x0
> - NVRM: RmInitAdapter failed
> - NVRM: The NVIDIA GPU ... has fallen off the bus and is not responding t=
o commands
> - nouveau ... Device allocation failed: -12
>=20
> Kernel command line options already tested:
> The following boot parameters were tested in various combinations:
> - pci=3Drealloc=3Don
> - pci=3Dhpbussize=3D0x33,hpmemsize=3D256M,hpiosize=3D2M
> - pcie_aspm=3Doff
> - pci=3Dnommconf
> - pci=3Dnoaer
>=20
> These mitigations did not resolve the issue.
>=20
> Why this looks platform/topology specific:
> - The same Thunderbolt eGPU enclosure is recognized correctly.
> - The same failure pattern appears with NVIDIA Quadro P400, NVIDIA Quadro=
 P4000, and AMD Radeon Vega 64.
> - The common denominator is Apple Mac mini 2018 + Thunderbolt PCIe topolo=
gy under Linux.
> - The failure mode is centered around PCI bridge window sizing / BAR plac=
ement, not around one vendor-specific driver alone.
>=20
> Expected behavior:
> The Thunderbolt eGPU should receive valid PCI bridge windows and valid BA=
R assignments so that the GPU driver can initialize the device successfully=
=2E
>=20
> Actual behavior:
> The GPU is visible on the bus, but bridge windows and BAR resources are n=
ot fully assigned, which leaves the device unusable and prevents the driver=
 from completing initialization.
>=20
> Request:
> Please investigate PCI resource allocation / bridge window sizing for Thu=
nderbolt eGPU topologies on Apple Mac mini 2018 under Linux, especially whe=
re large GPU BARs must be assigned behind multiple Thunderbolt / PCIe bridg=
es.
>=20
> Cross-vendor reproducibility on the same enclosure and same host strongly=
 suggests that the root cause is in PCIe/Thunderbolt resource allocation on=
 this platform rather than in a specific NVIDIA or AMD driver.

Hi,

Have you tried with this pending patch:

https://patchwork.kernel.org/project/linux-pci/patch/20260219153951.68869-1=
-ilpo.jarvinen@linux.intel.com/

This too might be relevant here (it has been recently accepted for=20
next):

https://patchwork.kernel.org/project/linux-pci/patch/20260313084551.1934-1-=
ilpo.jarvinen@linux.intel.com/i.

There are plenty of other fixes as well done relatively recently (though=20
some may be irrelevant for the kernels as old as you've been testing).

You didn't include any real logs that shows the error into this report,
those log snippets are useless in root causing where the problem=20
originates from. All dmesg logs should be taken with dyndebug enabled=20
(with CONFIG_DYNAMIC_DEBUG + dyndbg=3D"file drivers/pci/*.c +p" on the=20
kernel's command line). Please also dump /proc/iomem.

--=20
 i.
--8323328-2032271365-1773661111=:1005--
