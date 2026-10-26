Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010007;
	b=djLOeQ7+xdLwQwAWGu4PYvh1JB13MYUNhDGxgUeKX+z2TU05d+5vapQP1MgoNqV2mSS3
	 n3GNrtCOfPyNAblGijGQ1U3YF780JxubFpxL51aEaL6OZSO8MKrKLeucVJD2Gxe5i5EGf
	 oPhTMD/TacrOLoDhrTOscuIffh/8uN/mDnZJ6JEUXFnDPeCyy70hPNQM6zMwkaotW3Tzl
	 MiScJzjVYSzZCieEo5L1+Dtb1x5MVjLNMSno6pet1OVk7sriD5xeZBQ2k4p1E5JgHCO3M
	 EEZCuMEXyLE21AXd2vi6DYloYtCkEx3lLomndsUdRIDIc04YX+LGe8kfdM4GQDPMGYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010007;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=yfnX5hzY3bC5Xp4lxh1XT+4MtLePDgXbQ+AxeuDQN7o=;
	b=zl/GgnPQiCA3Xp/ocU3n/ADuehOhF2wbJ95la2OJ3ghI4u71BfCZQ/+d6Fztcm7bAq7b
	 RUBbtg3LDhXa8l6/JIlEWAnVYDUn9TuDg/VOPNq/dgFmsvIJKptEiRlE29rsmD/heBhFs
	 LcZtVeWqhxZgLbgTsW1zSbZjsh3i07Xeb/9t89Z5Q9U3f/qPIz+nGiTw4zOw/U3zbg1wL
	 h4tx480GFOMQ1BkM+VGCUC5p3otd6n1Cf8KaE2J2JfjYc+tABeZpBbXPZJqL6tpuhUPW8
	 5GpbRWfpt0n5YjkhcVh9N10coSrJAvNavFfm4s1m6QVBRGibGksRU5p+ZmAs8HQm8WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Chi6Bne8;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C5606A324
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 10:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2C5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Chi6Bne8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793010007; x=1824546007;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=80s2DjEbZBE/QNlrsxYCvCrmg/E6x0dG867HeX2GXbc=;
  b=Chi6Bne8qvzf/njLBjIKIV3B0nBQsPikkK/EZszZOtT9MDsQon7YCbJn
   T4IQctMhotUR85OvqlDMILf514LInG6uYT1/mqhTQo7Ldb9Zw8h3X/5FM
   om5+9O+YyKh8pApZ656hSs+1a5Y2+o1yVpxBKuccQI1FP4XYRDkOuem6n
   KoXHEbxM/M36xrgWIWrTU+M576xgMgcKGfMwihapoUtmNGzITN8zhg0wO
   7RQhT0cNCY7psYYIYsqkyhyIqTsCopsB0oAVbqNXyEK2pKjmM1Qqt7gkj
   4W3MyydTM19Ug2yto4bPljZqAzC4WWIIaFqjKj+zTzMWI8WRuj3popYLj
   g==;
X-CSE-ConnectionGUID: JaXzVWJuRwqWWPJL5wKL5g==
X-CSE-MsgGUID: LQgBF+8JSgap2msAJjcF4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1699419"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1699419"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:20:06 -0700
X-CSE-ConnectionGUID: tAelqv8nQJGgkk1E0DaKkA==
X-CSE-MsgGUID: tvR5pO2URH+6gI2f1b+rgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4176526"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:20:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 26 Oct 2026 12:19:58 +0200 (EET)
To: Maciej Grochowski <Maciej.Grochowski@sony.com>
cc: Nikolas Joshua Britton <nbritton@exabit.io>, 
    Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>, 
    Alexey Fomenko <alexey.fomenko@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Mesih Kilinc <Mesih.Kilinc@sony.com>
Subject: Re: [PATCH v4 0/7] PCI: Resource placement algorithm fixe
In-Reply-To: <20261023224518.80653-1-Maciej.Grochowski@sony.com>
Message-ID: <b20cffba-3515-b8a8-1b6f-6483facac5af@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com> <20261023224518.80653-1-Maciej.Grochowski@sony.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Oct 2026, Maciej Grochowski wrote:

> Hi Ilpo,
> 
> Thank you for the v4 patches, and sorry for the delayed feedback on v2.
> Mesih (CC'd) tested your full v2 seven-patch series on our
> Switchtec-based platform, with positive results.
> 
> The test used a backport to our Linux 6.18.20 platform tree, with
> additional allocator prerequisites included and our local
> max() -> ALIGN() workaround reverted. This is therefore feedback
> on the backported series rather than a test on its upstream base.

Hi,

Okay, thanks for the test.

> The kernel boots successfully, all eight endpoints have
> BAR0, BAR2 and BAR4 assigned, and switchtec detects all nine
> switches. No BAR assignment failures were observed in the boot log.
> 
> One difference from my original report is that BAR4 is enabled in
> this test; the earlier report described a configuration with BAR4
> suppressed. The total BAR allocation across the eight endpoints
> is now 288 MiB.
> 
> We also compared /proc/iomem against the earlier kernel carrying
> our ALIGN() workaround. The enclosing prefetchable bridge window
> is 387 MiB with the backported v2 series, versus 384 MiB with the
> workaround, while the total endpoint BAR allocation is unchanged.
> So this test shows successful assignment, but no address-space
> reduction for this configuration. I do not yet have the detailed
> placement traces needed to explain the 3 MiB difference.

You want to look at the place where the window is sized and work 
backwards why pbus_size_mem() calculated that size. In the printouts 
(for non-assigned bridge window), the start address is the alignment
and size is end-start+1. If the window has an optional part, the add_size 
printout is there but otherwise the prints are a bit scarse.

When trying to debug pci resource issues, dyndbg might be helpful here and 
there so I always add this to kernel's cmdline myself:

dyndbg="file drivers/pci/*.c +p"

It will give a bit more information about resource decisions in dmesg and 
their basis (things could be better in many areas still but most of the 
missing details are inferrable, e.g., what resources are considered 
optional, etc.).

> We will now also test v4 and report back. Could the changes since v2
> affect this window-size result, or is this amount of padding expected
> for this topology? Please let us know which logs or allocator traces
> would be most useful to collect with the v4 test.

I suggest you wait until I send the next version which addresses the 
problems sashiko located in v4. I've basically tested the update locally 
and should get to sending it today or tomorrow.

I normally use iomem, dmesg with pci dyndbg on, and lspci.

Generally, I normally look /proc/iomem for quick overview of the layout. 
If you have something to compare with, it's even easier to see what 
changed and focus on those. E.g. you know commit x broke something so a 
kernel before that commit or the problematic commit reverted vs the broken 
one. The less there are other changes in between, the less noisy the 
diff is.

lspci is mainly needed to map resources to BAR/ROM/VF BAR as the iomem 
format conceal what the resource is. Again, diffing pre (when available) 
vs post saves lots of time in focusing on the relevant bits.

For diffing dmesgs, I've this tool:

$ cat dmesg-diff 
#!/bin/bash
 
diff -u <(cut -d ']' -f 2- "$1" | cut -b 2-) <(cut -d ']' -f 2- "$2" | cut -b 2-)

-- 
 i.

