Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388038F632;
	Thu,  9 Apr 2026 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722180; cv=none; b=uR4LIjzsc7499ykHiNYYe6cuzyBkLYHqdFkvngP71JTOr+hhklrdTGvp35YLZ25L3pcicDifNm/a+ktixcdYV3AajVr73mEG2g9kr/RUtwIRWmGlR4/LD6ZHdsoHJJTOjxriiPybchbg6rbbzgqnEU/6pAOSBIwA53rwbRpKvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722180; c=relaxed/simple;
	bh=s7vLuWVdXkInSQ+PLjlSyKVAvpYnO/1JlS4WPFrMOWQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CzHJVXK5qjpuHoSB7I8Fplv7zT7RSY+O5zh08hV4QLux327DFZYuRJpdeLIpE1wp8jHKZXVT4gLV/mgGyRFWNO9pV1hHjWtskfQl3pIyp8BmCCZowuBmwQ6IsaurC/p8WwYzJEb0Cfol+B7Nhm6Z6u7R8hrZdvnqjAdkU8Hajqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoTX1L1E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoTX1L1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775722179; x=1807258179;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s7vLuWVdXkInSQ+PLjlSyKVAvpYnO/1JlS4WPFrMOWQ=;
  b=RoTX1L1EjZyApU8/Q0uwd7RaIBVaziOo0N5CW160Yca//0ylll7BKoSX
   T7MxebId2zGim0XOtz1PQ7O9oCTNMXljDid7sBzJo8mIPcf/s3eke8Zbk
   oSJ3SoPbp9XpgrEq4r/ZCdOP+iZolK1s1BZzOBB4M9wacTPAqUHNaEkUc
   rp5rxQJBcPD6Ki4C85bXG8D32bsqWaT1T7cUHFbleKvzKKkg8qig59QP1
   i8UBrX+zHTXZI2QvQLWxFtJX4mkrKDBtp4Lhf1EcA49HKWNI8owh979Jc
   jc8eMxSUrUE3IPqpWDzaDzs0WO4ZMTGXNdGPQXDfyOF5KY/IuyAA1RslL
   g==;
X-CSE-ConnectionGUID: HbL2KCkqTYuLfx3WHDCP6g==
X-CSE-MsgGUID: uV2lDOSxRLaxjgA0ZeCA2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76609006"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76609006"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:09:38 -0700
X-CSE-ConnectionGUID: rp84gRATSNG29yxATMvG7w==
X-CSE-MsgGUID: Lf2fAWJaQvOn4LRr7iYH+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="266676380"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 01:09:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Apr 2026 11:09:31 +0300 (EEST)
To: Ziming Du <duziming2@huawei.com>
cc: bhelgaas@google.com, alex@shazbot.org, chrisw@redhat.com, 
    jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, liuyongqiang13@huawei.com
Subject: Re: [PATCH] PCI/sysfs: Prohibit unaligned access to I/O port
In-Reply-To: <e07f31e8-3e96-7d5e-b798-8fda66257fcb@linux.intel.com>
Message-ID: <e3424c19-b28f-35b5-292e-19fb43bfd0ff@linux.intel.com>
References: <20260408095532.1192625-1-duziming2@huawei.com> <e07f31e8-3e96-7d5e-b798-8fda66257fcb@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1432002655-1775722171=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1432002655-1775722171=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Apr 2026, Ilpo J=C3=A4rvinen wrote:

> On Wed, 8 Apr 2026, Ziming Du wrote:
>=20
> > Unaligned access is harmful for non-x86 archs such as arm64. When we
> > use pwrite or pread to access the I/O port resources with unaligned
> > offset, system will crash as follows:
> >=20
> > Unable to handle kernel paging request at virtual address fffffbfffe801=
0c1
> > Internal error: Oops: 0000000096000061 [#1] SMP
> > Call trace:
> >  _outw include/asm-generic/io.h:594 [inline]
> >  logic_outw+0x54/0x218 lib/logic_pio.c:305
> >  pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
> >  pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
> >  pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
> >  sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
> >  kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
> >  vfs_write+0x7bc/0xac8 fs/read_write.c:586
> >  ksys_write+0x12c/0x270 fs/read_write.c:639
> >  __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
> >=20
> > Although x86 might handle unaligned I/O accesses by splitting cycles,
> > this approach is still limited because PCI device registers typically
> > expect natural alignment. A global prohibition of unaligned accesses
> > ensures consistent behavior across all architectures and prevents
> > unexpected hardware side effects.
> >=20
> > Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port re=
sources")
> > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > Signed-off-by: Ziming Du <duziming2@huawei.com>
> > Link: https://lore.kernel.org/all/20260116081723.1603603-1-duziming2@hu=
awei.com/
> > Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/pci-sysfs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 16eaaf749ba97..c88910bcad262 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/of.h>
> >  #include <linux/aperture.h>
> >  #include <linux/unaligned.h>
> > +#include <linux/align.h>
>=20
> Not exactly the best place for adding this but since these headers are no=
t=20
> yet in the alphabetical order, not an end of the world (I'd have put it=
=20
> first to avoid having to reorder it when sorting the headers).
>=20
> >  #include "pci.h"
> > =20
> >  #ifndef ARCH_PCI_DEV_GROUPS
> > @@ -1157,6 +1158,9 @@ static ssize_t pci_resource_io(struct file *filp,=
 struct kobject *kobj,
> >  =09if (port + count - 1 > pci_resource_end(pdev, bar))
> >  =09=09return -EINVAL;
> > =20
> > +=09if (!IS_ALIGNED(port, count))
>=20


> Hmm, your commit message talks about "offset" but this doesn't check "off=
"=20
> but "count", aren't those two different things?
>=20
> ...What's also odd is that you seem to have this same thing already in v1=
=20
> so I'm not following why this ends up solving the mentioned issue.

Nevermind this comment. I was just badly confused myself ('port' is=20
assigned 'off' outside the visible context, and my 'count' vs 'off'=20
related talk is just plain wrong).

Except for the header order mentioned above, this seems fine,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1432002655-1775722171=:968--
