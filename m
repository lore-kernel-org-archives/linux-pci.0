Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2028C84A;
	Tue, 31 Mar 2026 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930139; cv=none; b=bYm5Gf34mGBWR+C4L0ODlIy2wccGZLVB6MYauTzpv3F+NVhCsILKDXEP95b9Lcoi6kdddfELCCZAAVUqC0F07IQhB7VG3G1LeYsLzg07CN7qXcCXsewYtVE/3o7IGAQ4npqcFhvZ3ar9RVojgAHH/nFUpLf0iuZ8d+CI417HiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930139; c=relaxed/simple;
	bh=hgfzdGj7ieKAiWNMOG+35sEO4Zb+xxupemry8qx9Jdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5hzn7NUYBBaFaLvG4LGFG5y1PS8bT4D5YDffydQhl0SNbb9ZRkZMAPICdtOfenUSPbnedqHtQEN5rMkJUxNT4E170IS6kUs5aFy7axmOlmPtV/4QjlJ4YY0n8e5sV/8VwRW2b6yU3JTLSkJxml1VE8xqFnN201YwkUuROq7gEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Txicqa/N; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Txicqa/N"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UGNsYC3941072;
	Mon, 30 Mar 2026 21:08:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
	w9GBblbsUJXvW31jYa2LLE7PiPD25wsXjZDGf0w5rM=; b=Txicqa/NnZFj+IQtk
	qjvGVYtejAHOUkZWwZ1Wo2I7uKL3A5K759KZAhpFoCBVnj+1FEH5/yys/pd3ad/S
	Sw0dsE3twvzlqlIkEkWMTDu6+x7EpB4Tfc5GDoV4guR9Sw6qmrpmBDbSEViAYjqU
	im9PuD1b44gDlMV2X4fOUW4Q1f93L+Al+4F0CsSCKWIChdZ5x7Remzvky4NltmCj
	GBrDkMoShdZzswFtIzu31i4xpKuxvwLy7jdnRuT7J+Cg5dcbQkrftjFdOwFuYT9L
	k53i3i9shFyT4pafnTihiI3WEUw9+bKiikcVrXVo/M9nrx7dK3Kfd8FA8coRakA/
	3BfdQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d73873t61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 21:08:53 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Mar 2026 21:08:52 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Mar 2026 21:08:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 30 Mar 2026 21:08:51 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 2DC753F70A1;
	Mon, 30 Mar 2026 21:08:48 -0700 (PDT)
Date: Tue, 31 Mar 2026 09:38:47 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <vidyas@nvidia.com>, <bhelgaas@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <sbhatta@marvell.com>
Subject: Re: clarification: PCI device not getting enumerated
Message-ID: <actIz549-HWW0GKy@rkannoth-OptiPlex-7090>
References: <abkqm_LCd9zAM8cW@rkannoth-OptiPlex-7090>
 <20260317210640.GA84423@bhelgaas>
 <abojekUtFrMxM1RB@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abojekUtFrMxM1RB@rkannoth-OptiPlex-7090>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAzNyBTYWx0ZWRfX3TPfspyY1mLA
 tPXgQ0oNT3IecAIdgxWqQQ3rb4doxgK694Bw0u08IK1Cj3lSy2gJdmmuggqsRuO38AKiqOPqVyH
 ilaIs9M7NZ6MdvjsXJ+Q29PIzcdyg4tLAv6cN/8Srg2dVKQz3eWSmJvGqezoxc1+sUqiLVJw4Lt
 kcG1NJxugCiw75h8LOJdBnpnAMQ0i4V130VCMBhu6Hs7woRu+V2kPEoRtHhweWZKPlqg2cQblN4
 rwPloIY3qzGN62QIRt8cR5pCJK4FmK7rtiZzqoBdETrUSZ7VlsZnQmuSPA3iJlVRI9d78VtQesb
 lHQb78z29LSvZRWoUTEi8jw9YuHhbjTkEiatdPtHE8QrpaK1D4C66zbz8vtI9Rqm4xdFC4UoOGV
 Oq2BPj22kDLgsnjh16Zy6uv4BLqTy4JJYg7OKJjYafSaMArpPh/3K+B5ACGePIcGqBSwQ6d0izV
 Q1/pE6CU9XEZpeaYPcQ==
X-Proofpoint-GUID: hFl9cjFug0HsXzjIy02qfWhra3CmdJ3z
X-Authority-Analysis: v=2.4 cv=DMCCIiNb c=1 sm=1 tr=0 ts=69cb48d5 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=wjJ326II6ndfu_pIRNYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hFl9cjFug0HsXzjIy02qfWhra3CmdJ3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01

On 2026-03-18 at 09:30:58, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
> On 2026-03-18 at 02:36:40, Bjorn Helgaas (helgaas@kernel.org) wrote:
> > > Hi,
> > >
> > > Below commit breaks PCI enumeration of a marvell PCI endpoint (177d:a0e2).
> > > I am not familiar with PCI code, could you please help in debugging/fixing this ?
> > >
> > > Before the commit, the kernel set PCI_REASSIGN_ALL_BUS. So pcibios_assign_all_busses() was true,
> > > and in pci_scan_bridge_extend() the kernel took the “reassign” path and used EA
> > > (and pci_ea_fixed_busnrs()) to assign bus numbers.
> > >
> > > commit 7246a4520b4bf1494d7d030166a11b5226f6d508
> > > Author: Vidya Sagar <vidyas@nvidia.com>
> > > Date:   Wed May 8 23:11:38 2024 +0530
> > >
> > >     PCI: Use preserve_config in place of pci_flags
> > >
> > >     Use preserve_config in place of checking for PCI_PROBE_ONLY flag to enable
> > >     support for "linux,pci-probe-only" on a per host bridge basis.
> > >
> > >     This also obviates the use of adding PCI_REASSIGN_ALL_BUS flag if
> > >     !PCI_PROBE_ONLY, as pci_assign_unassigned_root_bus_resources() takes care
> > >     of reassigning the resources that are not already claimed.
> >
> > This commit appeared in v6.11.  Apparently on v6.6, 0002:1b:00.0 is
> > detected, and in the v6.12 dmesg below, we don't enumerate it.
> >
> > It looks like 7246a4520b4b can still be reverted cleanly from
> > v7.0-rc1.  Can you collect the complete dmesg logs from v7.0-rc1
> > (where I assume we won't see 0002:1b:00.0) and from v7.0-rc1 with
> > 7246a4520b4b reverted (where I assume we *will* see it) and output of
> > "sudo lspci -vv"?  Use the same kernel config and DT for both, of
> > course.
> Please find dmesg, lspci -vv and device tree output for v7.0-rc1 and v7.0-rc1 with patch reverted
> at bottom of this email. Used same kernel config and DT for both.
Sorry to bother.

Could you please advise on the preferred approach to address this issue? Alternatively, if further
testing or additional data would be helpful, I would be happy to carry that out and share the results.

Thanks a ton for your time !
