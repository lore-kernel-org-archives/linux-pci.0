Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025B392C2C
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285790; cv=none; b=XzWphQYr1cAMjLK+64Fn5rN+vKPaU2CDdMnaz59c0ps8AHsVVTRDs3ShEPP5vbf0Uxn2kcu8P8u36nVi0YnxGSrtIieTCjcu8c5IKO6KpHKMB+d0OKSeB3wLP9u/E6KAUYw1Y0eP8GFh6PI91PsUErMKF0X8d2SApfRGnCHbNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285790; c=relaxed/simple;
	bh=jbBFYU/lMtksEwVPBD/znMfo2cM3W43qsM5Qt1I+/aI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=oZeypZcb6zopT1atqKx2omP/OFslsPkk2hlQeeVGSj+ZAv+9jlDjeNwoaZWTFnW7GPsWO6OecwtlfRv5Q0a9xiFQhQqZo2maZMpMmcAZ/UfkAsX9MmaoUOckLsADRMxQWyx1dItuUXLPj9xUGXHSlK5wvfqYIqamAHLNgPvV30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=msljClRi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="msljClRi"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260624072304epoutp0216d2d13698919073b0432f936a33e536~783p3lXGy1911519115epoutp02t
	for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2026 07:23:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260624072304epoutp0216d2d13698919073b0432f936a33e536~783p3lXGy1911519115epoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1782285784;
	bh=Zx+GK9SEZ82lWmgsSqYliXVinMXaugcnvdzvMvb0uuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=msljClRianM1i7iLAkGDaotg4OBBIBRSFKa5jVPES0BBik2be5XfPo2MOKMGgeXES
	 s/IHlVzzQCFu1jHWIHx80M7VrIayvz/1KoDGlHjGd1SJEWp17CK8xyGkQYRnEtGYiu
	 M8HuiAcJZJoBy85JPZhQze7FSezfXqC6q736kugc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260624072304epcas5p1c318f3f3b57b6a52cdbece56e6614b8e~783pLAPBQ2269122691epcas5p1F;
	Wed, 24 Jun 2026 07:23:04 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4glYLc0dw2z3hhTD; Wed, 24 Jun
	2026 07:23:04 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1~781o3-WPM1059310593epcas5p1N;
	Wed, 24 Jun 2026 07:20:46 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260624072044epsmtip2ef2cbfeba78fb7c84ddc1fd3ef3be652~781nA6DXa2004820048epsmtip2h;
	Wed, 24 Jun 2026 07:20:44 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:39:52 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
	vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
	dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC)
 capability.
Message-ID: <1987169128.61782285784075.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260617154521.520191-2-junjie.cao@intel.com>
X-CMS-MailID: 20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
	<20260609105836.3702787-7-shrihari.s@samsung.com>
	<20260617154521.520191-2-junjie.cao@intel.com>
	<CGME20260624072046epcas5p10787cf7e14b0b8e72d4d11fb782b3ca1@epcas5p1.samsung.com>

------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 17/06/26 11:45PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Tue,  9 Jun 2026 16:28:34 +0530, Shrihari E S wrote:
>>      if (flitmode) {
>> -        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
>> +        uint32_t pos = dev->exp.exp_cap;
>> +
>> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>>                                     PCI_EXP_LNKSTA2_FLIT);
>> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>> +                                   PCI_EXP_FLAGS_FLIT);
>
>Following up on Jonathan's observation here -- I'd also noticed a
>bogus Interrupt Message Number on a plain flit-mode root port, so I
>checked what the stray write actually does to the Flags register.
>The impact is wider than just UIO:
>
>The first set_mask writes PCI_EXP_LNKSTA2_FLIT (0x0400) into
>PCI_EXP_FLAGS (cap offset 0x02) instead of PCI_EXP_LNKSTA2 (0x32).
>0x0400 falls in the Interrupt Message Number field (bits 13:9) of the
>Flags register, so a flit-mode port ends up reporting a nonzero
>Interrupt Message Number (it reads back as 2).
>
>pcie_cap_fill_lnk() runs for every flit-mode port, and x-256b-flit
>defaults to on for pcie-root-port, so even a plain
>"-device pcie-root-port" comes up with the corrupted field.
>
>The second line (PCI_EXP_FLAGS_FLIT into Flags) looks correct and
>should stay.  The first one looks like a typo in the destination
>register -- it was PCI_EXP_LNKSTA2 before this series (visible in the
>hunk above), so I'd restore it there rather than drop it.
>pcie_cap_flit_write_config() does maintain the LNKSTA2 flit bit, but
>only on guest LNKCTL writes; it doesn't run at realize/reset, so
>dropping the line would leave LNKSTA2 flit status reading 0 at reset
>instead of its pre-series value.
>
>Many thanks,
>Junjie

Hi Junjie,

   Yeah, it's a typo. The destination register should be "PCI_EXP_LNKSTA2".
   Thank you for pointing this out. We will rectify it in the next version.

Thanks,


------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_
Content-Type: text/plain; charset="utf-8"


------8xxTakeuJ66kI_IBZqWF_Qqy5yET_M96iI-s.dWLk22.0KCZ=_53c69_--

