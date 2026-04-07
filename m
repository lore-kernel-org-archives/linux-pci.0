Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7938F248
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546772; cv=none; b=HxWnGy/IP414rPWq6TuOSOKTzaXG0l/Zddha4zqtAY47bSrW54LewTI3CI0bcQUDWig7EB2aBey7ANUp4teBZ7lqb/cy0cbdQspTJ5HPpmJBBjIkB37WJ8T1duu5J4D/t23N6TVqS2ibQhI3NJjOzve5Zc+ILHxHK2E4useDmC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546772; c=relaxed/simple;
	bh=1EglCTjoeIcN7j9cjIiwgRLnj+07sdnD6g8NVY6OuTo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t3LqZEB7VMbbs/bUcJqdv+otT+6JOtl/cXphEkYCqD/LIXUZQzKBbIhKPxrq14a6QtIvJh1MdGBJ/F+iQXRt5qMh7KlNTVzVpUIwy7dG0NoCsLdZAB40sMZ8GFEZpB18U4oLXe/elAnEl7pujI+9bAH4Xgi3Iqopw7MEWnJlZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJcelzs9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJcelzs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775546771; x=1807082771;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=1EglCTjoeIcN7j9cjIiwgRLnj+07sdnD6g8NVY6OuTo=;
  b=HJcelzs90Hx2oCaZ0xrm7Se8pYHqh/B/8wXO/w3F+C7X/ewBEmb9ntOc
   9Ztlc7JkE6WMYTD1lXz2TaSvHEFiunBI9XJxJqR99KmbjD7vnp0Vl2Yto
   cXaTpSIdDXkQlE5WmJbh6f/bdofpft6t04E56NKYPr8CcScFKn4XjdbVt
   3kZRbNQFi6CURB+gGaKycMcs+/RR3VJNvFPM5QoMmgukRzAn5kpw2+9IZ
   n78t9+Qrq4H9IddpXJd1WYrgmJ41UFl8ZO/RTHboyAeWhsDA8loQTd1sY
   fhKIz+fOanyth3rK1xakF9iNQlcLRf8kxp0fg/jXyCoPAgyDt9lBcknqE
   g==;
X-CSE-ConnectionGUID: pvI94jj1TeOst+w9gXE03g==
X-CSE-MsgGUID: zLw4Wx65TXeThyBXfwAY1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76627125"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="76627125"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 00:26:10 -0700
X-CSE-ConnectionGUID: Qh1GOQp9Qfm8zoixUWdoAw==
X-CSE-MsgGUID: biQUsbzVQwOo9cu+fQuTJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="224892211"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 00:26:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 Apr 2026 10:26:04 +0300 (EEST)
To: =?ISO-8859-15?Q?Jonas_H=F6glund?= <firefly@firefly.nu>
cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since
 new bridge window alignment calculation code
In-Reply-To: <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
Message-ID: <9026cb2a-8b3b-9518-5db9-6ae9169c7763@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com> <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info> <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com> <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
 <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com> <ac71d5ee-5895-417e-a7af-51cdecec8b67@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1224114887-1775545366=:983"
Content-ID: <e7491340-d5e2-d1fb-adfb-86e8909f464a@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1224114887-1775545366=:983
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <092f60a5-a7c3-955e-8a0b-a19f7b736763@linux.intel.com>

On Thu, 2 Apr 2026, Jonas H=F6glund wrote:

> On Mon, 30 Mar 2026, at 16:32, Ilpo J=E4rvinen wrote:
> > On Mon, 30 Mar 2026, Jonas H=F6glund wrote:
> >>=20
> >> Unless I misread something, they should both be included in the recent=
ly
> >> tagged 7.0.0-rc6--I'll try building it and see if the issue is resolve=
d.
> >>=20
> >> I'll reply once I've tested 7.0.0-rc6.
> >
> > Hi again,
> >
> > Now that I look more into the logs that probably won't help. For some=
=20
> > reason, it seems that resize is not even attempted and the errno is=20
> > -EINVAL which is a bit unexpected.
> >
> > I'm starting to wonder that the problem fixed by this patch once again =
is=20
> > showing its ugly head (it's currently in pci/resource branch, so it won=
't=20
> > appear until 7.1-rc1):
> >
> > https://lore.kernel.org/linux-pci/20260326200427.GA1340256@bhelgaas/
>=20
> Seems your hunch was right--I've now gotten around to testing with
> 7.0-rc6 as well as the pci/resource branch.  The problem persists in the
> former whereas it seems docking succeeds in the latter.
>=20
>=20
> > I still don't understand why pbus_select_window() would return NULL in=
=20
> > this case but it looks the most likely candidate where -EINVAL could co=
me=20
> > from (I still don't understand what cleared resource's flags if that's =
the=20
> > case but it still seems the best explanation).
> >
> > Please take logs from this point on with dyndbg=3D"file drivers/pci/*.c=
 +p"=20
> > on the kernel's command line so there's little bit of extra info (and=
=20
> > check you are building with CONFIG_DYNAMIC_DEBUG).
>=20
> Here are dmesg logs (with the appropriate dyndbg cmdline flag) for both
> cases, in case it's useful:
>=20
> https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc6.dmesg.txt
> https://up.firefly.nu/pub/amdgpu-egpu-good-pci-resource.dmesg.txt
>=20
>=20
> That's good enough on my end, knowing the issue is addressed already
> upstream and slated for 7.1.  I'm happy to test anything else if it'd
> be useful (for eventual backports or so), but otherwise I think I'll
> just pick thoes patches from the pci/resource tree for now.

Hi,

Thanks. It certainly looks the commit dc4b4d04e1ca ("PCI: Prevent=20
shrinking bridge window from its required size") I referred to above might=
=20
indeed help here (For Thorsten's convinience: as mentioned above, it is=20
currently in the pci/resource branch slated for 7.1).

With the extra debug enabled, "shrunken by" lines appear in the log which=
=20
indicates the hotplug memory distribution algorithm goes to mess with the=
=20
calculated bridge window sizes in between resource sizing and resource=20
assignment and my fix aims to prevent that from happening.

If that fix does not help or does not fully solve the issue, please do=20
take a new log with that patch included into the kernel (preferrably with=
=20
all the fixes that are currently in the pci/resource branch so we don't=20
hit yet another issue that already has a fix). If you need to take more=20
logs, please include also /proc/iomem dump (as figuring the iomem layout=20
from dmesg is pretty tedious and error prone).

Also if you see this line, it's worth to posting the log (even if things=20
would appear as working):

amdgpu 0000:3e:00.0: Not enough PCI address space for a large BAR.

=2E..I'll see if I can somehow improve that as well (not a guarantee but=20
it's still worth taking a look, it appears also in the case you labeled=20
"good").

--=20
 i.
--8323328-1224114887-1775545366=:983--
