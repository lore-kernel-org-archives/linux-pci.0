Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1853C57C70B
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 18:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064293; cv=none; b=FU56IH9p5qEEIf4NWcdfGhYTaIsN/rc87ahDZMyAaKK8YGldlAikd/0DypU7q2BuPODEV0NC/6DsmYuHH6JrzfG+4G9uLWGxH5EHXJdBL6jlK1xJzH8hQnGhxSh4fNcnOolnZKjioXOmuSjWpSde683RWepY3CrynjpQVQEDdxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064293; c=relaxed/simple;
	bh=BcRCLwfFtgEsaonMTdFB0QlhfbglLCJnR2ISFzZiS2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=mcQWkjbnvE/mA5nAMjRyxIRlQjYjkl4ZxD35dMOLHm3xrzYx3QM3FOgvShkkMfHH2dw235QlH1NHLX0QpfLCzhyn/vmLuSINXGKN+xjqNmWPBeBabrNWf7ont84F2uqVAwIGjuVOzeoPPFWUVYnCNCI4dcp5X8ZGlh0NTweratQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fVXtjQ9w; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fVXtjQ9w"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260910181803epoutp03214ecb43e40fa2d7984e3b34139d39ab~UCHyRbqtD2900929009epoutp03T
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 18:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260910181803epoutp03214ecb43e40fa2d7984e3b34139d39ab~UCHyRbqtD2900929009epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789064283;
	bh=JLqdIAbN1Bz2zKeRYXAzqEzNmSDag8J0W93emDNj8vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVXtjQ9w7gn28jnJWmgt2y3MzdXux4qGJWeFzoTSL/Mu327XehfN5DCgkGmOnOuBN
	 9pG5Jiyc/sf1Q2ZKwu2PW0nOGY0AHbgfwY0y423uQ5eNxZD/H+R71ELHEnI0wg2DYs
	 p69vKmQf/zkbzFH+MhxZkQBI+Du/QES/xs+x7k0A=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260910181802epcas5p1136725a4f34fd60baf66310cef23609b~UCHxvJElr2654026540epcas5p1G;
	Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4hgmBL3LlLz6B9m6; Thu, 10 Sep
	2026 18:18:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134~T6ALc28UU2183821838epcas5p3o;
	Thu, 10 Sep 2026 08:22:55 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260910082254epsmtip2fc2403fbe0c89aff55a044934a0cc61e~T6AJufHmL2871328713epsmtip2P;
	Thu, 10 Sep 2026 08:22:54 +0000 (GMT)
Date: Thu, 10 Sep 2026 13:52:50 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
	dave@stgolabs.net, arun.george@samsung.com, dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com, vikash.k5@samsung.com, cpgs@samsung.com,
	gost.dev@samsung.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [RFC V2 0/9] hw/pci: hw/cxl: Add UIO support in CXL and PCIe
 stack.
Message-ID: <1742920067.01789064282454.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260830071953.399414-1-junjie.cao@intel.com>
X-CMS-MailID: 20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134
References: <20260826053410.1322176-1-shrihari.s@samsung.com>
	<1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
	<20260830071953.399414-1-junjie.cao@intel.com>
	<CGME20260910082255epcas5p3ebf61712e1937a736ee854929f2e8134@epcas5p3.samsung.com>

------KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/08/26 03:19PM, Junjie Cao wrote:
>Hi Shrihari,
>
>On Wed, 26 Aug 2026 11:04:00 +0530, Shrihari E S wrote:
>> This series is written on top of:
>>
>> Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
>> Repository: https://gitlab.com/jic23/qemu
>> Branch: cxl-2026-01-09-draft
>
>Applies clean there and builds; x86_64 cxl-test still passes.  I
>booted the patch-10 example topology and walked the extended
>capability chains and the HDM decoder registers: the v1 SVC/AER
>collision is fixed.  Two things are broken, both on 7/10: the
>switch USP never advertises HDM UIO -- its uio gate reads a flitmode
>field that nothing sets -- so the example topology can't advertise UIO
>end to end, and "-device ioh3420,x-svc=on" aborts QEMU.  Per-patch
>comments on 2, 3 and 5 through 10.
>
>Testing point 3 looks at whether existing configurations still work;
>the compat question is whether they still look the same to a guest.
>2/10 moves x-256b-flit onto pcie-root-port with the default left on,
>so every pcie-root-port on q35 comes up in flit mode with no compat
>entry -- an inbound migration already fails at that patch, I tried
>it -- and 7/10 shifts the CXL DVSEC offsets whether or not x-svc is set.
>
>Worth adding the PCI maintainers on v3 -- eight of the ten patches
>touch files under their entry, and both new capabilities land in
>hw/pci.
>
>I'll re-run the topology once the USP gate is settled.
>
>Many thanks,
>Junjie

Hi Junjie,

Thank you for the detailed review and testing. Your feedback helped
catch several issues that were missing in this patch series
(particularly the derived ports abort scenario). Will address your
comments in the next version of this patch series.

Thanks and regards,
Shrihari


------KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_
Content-Type: text/plain; charset="utf-8"


------KR5HVoSumO1REEIZ3EVwq6Eiu41rIw6slb8fC.K-NNProunu=_1c4e7_--

