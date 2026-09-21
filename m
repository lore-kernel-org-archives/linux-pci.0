Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3122F7F0A;
	Mon, 21 Sep 2026 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789967107; cv=none; b=DdzyTQGw/GuxGhV4HdAlILlYZU4O0/o7b4TDj6uopRtIQlcfr7jP5KyvKikeBgkytKeteo0M+sprGdkIZBx8vpHRHSIkqaWGYuZDgAI+Mwaa9jLDG7np/ItI7u9i47wOS9Qd+POoqSLdElgxIw93oVwkLnz655mMjyXZWb01Vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789967107; c=relaxed/simple;
	bh=0YcJp1VTnAiIRfV0D+SZkL1YrSbTHsE6VVnIz7y1yWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzqEo9WugoHtX9JTu/5h2Y7De3fp+/fYItePq3e/ral/HxLpk5u9ToTLKOvUQDKnTAz2bAzgIkazNTTPW+riOyOJv3I2zllpRqPyE2LnhU4/Vl7qbNrIWlc145Fg/09Q+8vqvT/p4GYjgljHGdKadzfAppWUkz0Dr+WsuiwYcBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNW9/ENk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNW9/ENk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789967106; x=1821503106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0YcJp1VTnAiIRfV0D+SZkL1YrSbTHsE6VVnIz7y1yWA=;
  b=dNW9/ENkQJ1ZiJlGE5w6vzknRgfpdllT7LeV0tWAsFYIW+Q6ObCoawxk
   bqZmFNFcOvliNDPKPuJ9MHdWekX1ONdEaVZzTFiO06ZhShLxD1J28OEE4
   4S5CVfIDIJQ7xgOTpQO3a6ZG4qJTHOtVdT0iPDAIsVVIUAJ6bRt1PQLW/
   EXWI55oCIGWLm8/tdWqKzt0zRZRHD6DrpwWpmjK5ZTz8KnB4Eor3q40VG
   MB0U5uP0gEGMjHEaElmX9mbcj2znh98hibpqf1taRIrSAiCOe4slfGXMc
   reJQaCOKKWYsBBPaH39WwWvtXJ4w8uPKJn1cJPK/UHSfR5QlojyL1ARqq
   w==;
X-CSE-ConnectionGUID: I0EXkKXmTRmvJzYa6SDvIw==
X-CSE-MsgGUID: pWD2rXw8R/WgvCqMT/UE4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="78025452"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="78025452"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2026 22:04:59 -0700
X-CSE-ConnectionGUID: 41YesqgDTiSuvi8H+G7Vbw==
X-CSE-MsgGUID: J3kSkX22QEOlL1wsdXekSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271961239"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 20 Sep 2026 22:04:56 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6233B99; Mon, 21 Sep 2026 07:04:50 +0200 (CEST)
Date: Mon, 21 Sep 2026 07:04:50 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Freeman Z <SHD-ISAC@outlook.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"westeri@kernel.org" <westeri@kernel.org>,
	"andreas.noever@gmail.com" <andreas.noever@gmail.com>,
	"YehezkelShB@gmail.com" <yehezkelshb@gmail.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Sanath S <Sanath.S@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [BUG] PCI/USB4: AMD Phoenix 1022:14ef runtime suspend prevents
 JHL9480 downstream enumeration
Message-ID: <20260921050450.GM106095@black.igk.intel.com>
References: <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYCPR01MB1092795BE7AB51121BBAB292496862@TYCPR01MB10927.jpnprd01.prod.outlook.com>

Hi,

Adding AMD folks in case this is known issue.

On Sat, Sep 19, 2026 at 12:39:37PM +0000, Freeman Z wrote:
> Hello,
> 
> I am seeing a reproducible USB4/PCIe runtime-PM problem on an ASUS ROG
> Flow X13 GV302XV (Ryzen 9 7940HS / Phoenix) with a Kensington SD5000T5
> EQ Thunderbolt 5 dock connected to the laptop's USB4 host port.
> 
> The failure is reproducible with the official Arch Linux Live ISO using
> Arch's stock `linux` kernel:
> 
>     7.2.2-arch1-1
> 
> I have not yet tested a self-built kernel.org mainline/vanilla kernel.
> I can test patches, or collect additional traces if requested.

Can you provide full dmesg with "thunderbolt.dyndbg=+p" in the kernel
command line?

With the below steps (following your description):

0. Drop all non-standard command line options except the above.
1. Boot the system up, nothing connected.
2. Once up let the TB and the related PCIe root ports enter D3cold (don't
   run lspci it will wake them up but you can look at the runtime status that
   they are all suspended).
3. Plug in the dock.

We should see in the dmesg the PME if it works as expected. If not then it
may be that there is something wrong with the wakeup path.
