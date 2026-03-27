Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881703F8DF6
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634053; cv=none; b=VvBrzvwdQBsqDLKmEp3cwkh82rGPzZzEQsQJo07wofgkChoAqTllJBvyDkD9FM2EEn5pFqLXFiVfGJlw804jb2hEqDvsAB7P0Zu3U0GQ5Utk2lZcuLW1i2e8uwwvDhKXEP3WFrfxFu9FAuCh0VgeOIHZHaqNoI/SH3UgySkMJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634053; c=relaxed/simple;
	bh=WuNMyda9U1RNqACcqfwBtwE+VdnXa9nklsb3K1Bmrgc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gJV6tlXyzR1qRXkYf5QDnxF+09OzljCOkDkmL97HVdulj6V9XFuqXBJDw2OTWXghxlvRdZQOXaLszlqwSodN0qL3l2QtBdW8xe416JDV8p9GvIEQaonFtFA1qcd7Gag2ooxhizoFlzIIvwQoVpKEn0BkR2SniJRW3pIdYTVCKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIJWC8bC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIJWC8bC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774634053; x=1806170053;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WuNMyda9U1RNqACcqfwBtwE+VdnXa9nklsb3K1Bmrgc=;
  b=kIJWC8bCF3O++LFJ/odYgYX1VfNZngkzCgiW3Rp2qmgGOr1VelPD7Ge2
   4g+N78u8qQnuRalhsmx8oD2Qu4bl3z8ulHtNm/ZSZNrgWCk5JeB2eeHtT
   Gj5wRv3I1UZIYubZSiixRapsraWUmIrUyDRxPrTGm3+VVxOkjAkt8m4Ay
   AfnYzttXphLwwXoPfEpEcpDlZmbKJDnmOJnhbY+OjzATdLfHjXRr3HBif
   qNHqQlMmTaqv+C2LkLSkptGGKzSRUviOFFg8HTR475QeO58+ukD1W+tvm
   NPlI1gB/PqgmkeJM4Z2N8TWQGmRGpHriGN7RGYCUjkwqjTduVQXvgiH9q
   Q==;
X-CSE-ConnectionGUID: t/CkWR1BSeyDRe8u6g3tJg==
X-CSE-MsgGUID: qCGsX8gPSZaO2vyu6+9JXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="86332261"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="86332261"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:54:12 -0700
X-CSE-ConnectionGUID: X1FmjMPOTHSBNw6u1tqPhA==
X-CSE-MsgGUID: jsOo6B6YTDa49jOI/bmSjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="263334435"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:54:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 27 Mar 2026 19:54:06 +0200 (EET)
To: =?ISO-8859-2?Q?Michal_Babi=E8ka?= <michal.babka@gmail.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [WARNING: UNSCANNABLE EXTRACTION FAILED][BUG] Apple Mac mini
 2018 + Thunderbolt 3 eGPU: PCI bridge window / BAR allocation failure prevents
 NVIDIA and AMD GPUs from initializing
In-Reply-To: <CAF4axAei9zwKrWrcoHQE65D2xY=mWS0onRAGxyjX0p2a+jXmUQ@mail.gmail.com>
Message-ID: <da0ede48-3197-e3df-a83a-4e0028b5f5c5@linux.intel.com>
References: <CAF4axAei9zwKrWrcoHQE65D2xY=mWS0onRAGxyjX0p2a+jXmUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-579266839-1774634046=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-579266839-1774634046=:1037
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 24 Mar 2026, Michal Babi=C4=8Dka wrote:

> Hello,
>=20
> I am reporting a reproducible PCI resource allocation problem on an
> Apple Mac mini 2018 with a Thunderbolt 3 eGPU enclosure.
>=20
> Hardware:
>=20
> Apple Mac mini 2018
> Razer Core X Chroma
> NVIDIA GPU tested
> AMD Radeon Vega 64 tested
> Zorin OS 18 Pro
> kernels tested: 6.12.x and 6.17.x
>=20
> Problem summary:
> The eGPU enclosure and GPU are detected and enumerated on the PCI bus,
> but GPU initialization fails because PCI bridge windows / BAR
> resources are not assigned correctly.
>=20
> This reproduces with multiple GPU vendors in the same enclosure on the
> same host, which suggests a PCI / Thunderbolt bridge resource
> allocation problem on this platform rather than a vendor-specific
> driver issue.
>=20
> Expected behavior:
> The kernel should assign valid PCI bridge windows and BAR resources so
> the GPU can initialize successfully and become usable.
>=20
> Actual behavior:
> The GPU is visible on the PCI bus, but bridge windows and BAR
> resources are incomplete or invalid, leaving the device unusable.
>=20
> Observed errors include:
>=20
> bridge window [mem size ...]: can't assign; no space
> NVRM: BAR1 is 0M @ 0x0
> RmInitAdapter failed
> NVIDIA initialization fails
> AMD shows similar behavior in the same enclosure on the same host
>=20
> Kernel command line used for the latest debug boot:
> BOOT_IMAGE=3D/boot/vmlinuz-6.17.0-19-generic
> root=3DUUID=3Df0048c61-b4fe-4edb-9af5-bc756f9e2e7d ro quiet splash
> "dyndbg=3Dfile drivers/pci/* +p" vt.handoff=3D7
>=20
> I also confirmed that dynamic debug for drivers/pci was enabled.
>=20
> I collected and attached two archives:
>=20
> egpu-logs.tar.gz
> egpu-logs-dyndbg.tar.gz
>=20
> These archives contain:
>=20
> full dmesg
> dmesg extract
> lspci -nnvvv
> lspci tree
> per-device lspci dumps for the relevant bridges and GPU
> /proc/iomem
> journalctl -b
> nvidia-smi output
>=20
> Please let me know which specific logs or excerpts would be most useful.

Did you have any logs with pci=3Drealloc. There are those claiming conflict=
s=20
resulting in clipping bridge windows from their original size so I'm=20
skeptical this case will work well without kernel rearranging the bridge=20
windows.

--=20
 i.

--8323328-579266839-1774634046=:1037--
