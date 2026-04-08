Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE43B47FC;
	Wed,  8 Apr 2026 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642550; cv=none; b=KZZWY6rQTCl6WR749fiBIs7L+j8a4JNYI2Mh97UBz46F4AFDA5NBQ/YMipimoyJdkCGg2Erjsqz/2z5CiF1onuE0LaMn1HboNCawO4Usaen4kKleb+gDmnN4DxZ4/1bZ2GriRZqpVBlU6k8wtoElwHDTMmqIuc/Mh8nKa++s2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642550; c=relaxed/simple;
	bh=ZZYgYAxvhu4mtgrf1rwy6nih39Un+3noeJRbk4FQNHY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LqskMoYbq5UK8IDGqYta8zSLm6+qrSjyzMUpOxhgxfoPwAKIGCMYjl/l0ECFepQ5fVfq7Vv6emyuGvQFv3eZz0z59MeH+xnhZ/4V+Monjh/nI3fk9ZgbVL32XX3GddNbttUyU7j9bJGDBbjGU8Rbag4vuSB10GN1hwksMitiiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecPdtA+N; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecPdtA+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775642543; x=1807178543;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZZYgYAxvhu4mtgrf1rwy6nih39Un+3noeJRbk4FQNHY=;
  b=ecPdtA+N+uiEZXweTDpHWXi05U3anpWMkzdpzNT239nN3Kp59ZED4SH2
   zDOlW3qXZXnWl0MGU7O3+GwN6SRSN6KVjH1ciohHSKkCmzD/2MaL2yXdn
   ELtAu2teaqQmbrMtIz+/vzTZGWgzG6rmBArxGCOAWffwLHRYvVHwvbig9
   ZBvHzOkpnrgX1Wt8o3p9+S8V1UVFUgTSsfkQ476+yx+LY1NsCAx3H0N9O
   SI0kJKVbd2Hhq22i4nVhv7FcT2mJHKzU+sVb5VJWOTV0uuVeqrGhy0xz9
   h+Yu4JoGQjTAUmxuN92kfCXb+HETnxFMakRpw+VrzDJ4MBhWMba9fN01N
   Q==;
X-CSE-ConnectionGUID: jQeh1h9fSh+KWdyTgeASbA==
X-CSE-MsgGUID: 36Led/IBTV+yNSj8XJvyqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="94009861"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="94009861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:02:22 -0700
X-CSE-ConnectionGUID: Gct1DTD3SLCl/1D9mn49mA==
X-CSE-MsgGUID: x7g4f2m5Qwaw8YzdAQEZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="224137446"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 03:02:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Apr 2026 13:02:15 +0300 (EEST)
To: Ziming Du <duziming2@huawei.com>
cc: bhelgaas@google.com, alex@shazbot.org, chrisw@redhat.com, 
    jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, liuyongqiang13@huawei.com
Subject: Re: [PATCH] PCI/sysfs: Prohibit unaligned access to I/O port
In-Reply-To: <20260408095532.1192625-1-duziming2@huawei.com>
Message-ID: <e07f31e8-3e96-7d5e-b798-8fda66257fcb@linux.intel.com>
References: <20260408095532.1192625-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1995627233-1775642535=:971"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1995627233-1775642535=:971
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 8 Apr 2026, Ziming Du wrote:

> Unaligned access is harmful for non-x86 archs such as arm64. When we
> use pwrite or pread to access the I/O port resources with unaligned
> offset, system will crash as follows:
>=20
> Unable to handle kernel paging request at virtual address fffffbfffe8010c=
1
> Internal error: Oops: 0000000096000061 [#1] SMP
> Call trace:
>  _outw include/asm-generic/io.h:594 [inline]
>  logic_outw+0x54/0x218 lib/logic_pio.c:305
>  pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
>  pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
>  pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
>  sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
>  kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
>  vfs_write+0x7bc/0xac8 fs/read_write.c:586
>  ksys_write+0x12c/0x270 fs/read_write.c:639
>  __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
>=20
> Although x86 might handle unaligned I/O accesses by splitting cycles,
> this approach is still limited because PCI device registers typically
> expect natural alignment. A global prohibition of unaligned accesses
> ensures consistent behavior across all architectures and prevents
> unexpected hardware side effects.
>=20
> Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port reso=
urces")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> Link: https://lore.kernel.org/all/20260116081723.1603603-1-duziming2@huaw=
ei.com/
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci-sysfs.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba97..c88910bcad262 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -31,6 +31,7 @@
>  #include <linux/of.h>
>  #include <linux/aperture.h>
>  #include <linux/unaligned.h>
> +#include <linux/align.h>

Not exactly the best place for adding this but since these headers are not=
=20
yet in the alphabetical order, not an end of the world (I'd have put it=20
first to avoid having to reorder it when sorting the headers).

>  #include "pci.h"
> =20
>  #ifndef ARCH_PCI_DEV_GROUPS
> @@ -1157,6 +1158,9 @@ static ssize_t pci_resource_io(struct file *filp, s=
truct kobject *kobj,
>  =09if (port + count - 1 > pci_resource_end(pdev, bar))
>  =09=09return -EINVAL;
> =20
> +=09if (!IS_ALIGNED(port, count))

Hmm, your commit message talks about "offset" but this doesn't check "off"=
=20
but "count", aren't those two different things?

=2E..What's also odd is that you seem to have this same thing already in v1=
=20
so I'm not following why this ends up solving the mentioned issue.

> +=09=09return -EINVAL;
> +
>  =09switch (count) {
>  =09case 1:
>  =09=09if (write)
>=20

--=20
 i.

--8323328-1995627233-1775642535=:971--
