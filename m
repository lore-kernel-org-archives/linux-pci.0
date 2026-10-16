Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DECC3438B5;
	Fri, 16 Oct 2026 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792128309; cv=none; b=LUALxWyPVVHe0AF6jM3eYCwX9AZVwbEUd+SiMB+QssPOCt1nrC7PCtbGdXsMkasKVaYwl49bgRxvjdjnHznXBDTN3ePfh3IDH/j7h2qoqpJO7w2gVDGa+GY08Pa542/cQGIY6NFdS0EMbx34l3avyeFVHMrRjQvnGrV9xUvMvNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792128309; c=relaxed/simple;
	bh=eByVzL2E7k7RbyDf6wyaqiqPLOGXw3GCahy23VOqpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tl9E1Wb0tfVHoi9dO/l0ArdHfgZvu0JL0iUFBN4O+W2Q7Y0mb8q1k28hOuhpHv7WT9hmC5sy5DoZ/SENJ1SWiHmjdAG5XPkqB77SPM6rDn+N87L0X7qrQ87yBOCzi1HoZZ12C0k7/7zj89Nq//tj5Y4Q3eKdXehdMF/89DU0v8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eba1Mmt2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eba1Mmt2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792128307; x=1823664307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=eByVzL2E7k7RbyDf6wyaqiqPLOGXw3GCahy23VOqpJU=;
  b=eba1Mmt2wdGRNE8MP3vpOaej9HASfVYhSeytT6MWdx0Cv7KYkgoACECg
   y6RN3mo+eno7dOyjxptjES4kSUlq83sdMoBn4Rjys1/IwWhOr2CbefyZw
   idawJWvdEbCUSLJj1dMcKBM/oJnknXxgOHwoOYOdbE9cvY8fJ8klyzfjx
   PH6LgGMJ2T65QLY9FDAgsMhF/WkZ2pzDexb1oNjkZNnH+fmRTUQzZE8ex
   wPjjOE9nqiQ9sLYXuQ28KG/eWlLKuClpS8tC8UnHLeYfeL7MyoHVopOEw
   2ne67YnXDTuqsK/NPdqjASTGHs5g1v0pJUN7jf7KoR2E02uRA79H93De8
   g==;
X-CSE-ConnectionGUID: IygqKqekRhWKVWcqSV2zgQ==
X-CSE-MsgGUID: V0wW2HidR7i3LODyYL74qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="919414"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="919414"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 22:25:06 -0700
X-CSE-ConnectionGUID: +KGWfPOGQM2I3MWs9cFX7g==
X-CSE-MsgGUID: uroeG3RXS0a9qcGUtfzvQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2334020"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 15 Oct 2026 22:25:04 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 1410A99; Fri, 16 Oct 2026 07:25:03 +0200 (CEST)
Date: Fri, 16 Oct 2026 07:25:03 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: helgaas@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
	westeri@kernel.org, YehezkelShB@gmail.com, lukas@wunner.de,
	linux-usb@vger.kernel.org, d@rrell.co
Subject: Re: [PATCH] PCI: Extend Apple Thunderbolt power quirk to Alpine Ridge
Message-ID: <20261016052503.GT176164@black.igk.intel.com>
References: <20261008231744.GA938694@bhelgaas>
 <20261009025047.16129-1-fbeltranmillalen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261009025047.16129-1-fbeltranmillalen@gmail.com>

Hi,

On Thu, Oct 08, 2026 at 11:50:47PM -0300, Francisco Beltrán Millalén wrote:
> Hi Bjorn,
> 
> Thanks for looking at this one as well, and for copying the Thunderbolt
> folks.
> 
> On Thu, Oct 08, 2026 at 06:17:44PM -0500, Bjorn Helgaas wrote:
> > Thanks for all this detail.  I think it's too much for a commit log,
> > but it would be good to have it after the "---" where it's in the
> > email but not the git commit.  This is easily accessible via the
> > "Link: https://patch.msgid.link/" tag that we add when applying.
> 
> I'll move most of it below the "---" in v2 and keep the commit message
> to the problem and the fix.
> 
> > Wrap these to fit in 80 columns like the rest of the file.  Ideally 75
> > or so; that allows minor changes and typo fixes without overflowing.
> 
> I'll fix that in v2 too.
> 
> Before v2, though, I found something this week that changes the patch,
> so I'd ask you not to apply this version.
> 
> The quirk works today partly by accident.  On resume, the firmware of
> these Macs tries to write to the Thunderbolt controller through the
> PCIe2CIO mailbox of its upstream bridge, and on Linux those accesses
> currently go to the wrong device: ACPICA works out the PCI address of
> the bridge's config region while the bridge's bus numbers are still
> reset, and caches 00:00.0.  Each access then times out, which is where
> most of the ~16 s noirq resume that Darrell reported comes from.  There
> are two pull requests for this in ACPICA:
> 
>   https://github.com/open-acpica/acpica/pull/1235
>   https://github.com/open-acpica/acpica/pull/1236
> 
> With that fixed, resume drops to about 4 s, but the firmware's writes
> now succeed, and one of them sets bit 26 of dword 0x3c of the
> controller's switch config space (VSC_CS_20 in the plug events
> capability).  With that bit set, SXFP() really cuts power to the
> controller, and on resume Linux does not bring it back.  With the
> ACPICA change and this patch, and a USB disk attached, the controller
> with the disk was lost in 3 of 3 suspend cycles, in two of them
> together with the other controller, and resume took about 35 s.
> Clearing the bit through the same mailbox before SXFP() runs fixes it:
> 15 of 15 cycles resumed in about 4 s with the disk still there.
> Without the ACPICA change the firmware's write never lands, which is
> why this version works as posted and in Darrell's tests.
> 
> I also checked whether the ACPICA change makes the quirk unnecessary.
> It doesn't: in my test without the quirk, with the disk attached, the
> link to that controller still did not come up after resume (LnkSta x0),
> as described in the commit message.
> 
> So v2 would clear that bit before calling SXFP(), so that the quirk
> keeps working once the ACPICA change lands.
> 
> Mika, I only know what this bit does from measuring it: with it set,
> dropping the controller's power pin turns the NHI off; with it clear,
> the NHI stays up.  Do you know what bit 26 of VSC_CS_20 is on Alpine
> Ridge, and whether it is fine for the OS to clear it before cutting
> power this way?  If it has a name, I'd like to use it in v2 instead of
> a magic number.  And if you think this belongs in the thunderbolt
> driver rather than in a PCI quirk, I'm happy to move it there.

Sorry for the delay - I was on vacation. Unfortunately I can't expose any
of the non-public bits without going through an extensive paper work. I can
comment on the ACPI bits, though. I think they can be put into
drivers/thunderbolt/acpi.c if they are strictly TB specific.
