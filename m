Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8A3783D1
	for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888355; cv=none; b=s14ZfCuV9Lmm5oTsBrvchf2WnOxD2aQM1JK8ViEAuIaWFgIO0ylMloztpWLkajuS2ZxILAGAZQj5evedAbUNMHMknbbopOKxRLm5olj6J484Y2gQyHui9xteqFhkCgYvUX9bpgmojVS2n12imtHTepPhVRM9kKJSl4RBz0yqi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888355; c=relaxed/simple;
	bh=SHMQ/u956dO3YRSw1/LDxtZEBkcgD88+g24Hqcq9GCM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LgVZ1CfGReeWFn/zD3LWSW81OU7oDPOJTLEdPgqQBPJNWAt2xSU2syQAtb4Y/svPXNFcSuQ3JNZWab1AsZEujEWJunT+CDKLhCDhHeTJdpXI688n9QQ9u/Sy7JKo+jRHQPNeeRVMBCCJfZL8QvX4zFGLIu2n3j4/ycwoBFy5QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzEg5NWU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzEg5NWU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774888354; x=1806424354;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=SHMQ/u956dO3YRSw1/LDxtZEBkcgD88+g24Hqcq9GCM=;
  b=MzEg5NWUATL7Z36gzy5v7lNkcIaFq0j2octQd75KWyyxhj4RwzfeFtSF
   eHK/xcDLb9ofoSancxqnrenp86SEMq8eB20JJnlaaNnlBQPN2M+4Gz/Wn
   30X70j4HRAAH6ilIyfOyB7/8AQ0neSLrCb+YsBuHmUqqo+3P5ZlbG90xB
   p0RsAUT3wQuTzf27MF6nT3hS3B6IWfcTH5qmkXwg4Tur0y7zpmShLqH46
   89yhLJree2sz/uKyy2+oRjecwtLB5gBVgehL7H287VvHWYF5bHKrL18jq
   EmzcNLoFAdBseS9PavnADNtLY6vZz623/yFvhjdjv6XiZrrLaW4TznFQ9
   g==;
X-CSE-ConnectionGUID: 6OoEnoXnT32TUjQsy3iEdw==
X-CSE-MsgGUID: 3/hsfb/PRuGepqZ5bI/7ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="74917431"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="74917431"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:32:33 -0700
X-CSE-ConnectionGUID: O8s/zpz+QpyY2DRP3Vq2sA==
X-CSE-MsgGUID: q/NY2QUEQE6BhOz9l/eH/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="230917620"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 09:32:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 30 Mar 2026 19:32:28 +0300 (EEST)
To: =?ISO-8859-15?Q?Jonas_H=F6glund?= <firefly@firefly.nu>
cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    regressions@lists.linux.dev
Subject: Re: [REGRESSION] amdgpu with Thunderbolt eGPU bracket fails since
 new bridge window alignment calculation code
In-Reply-To: <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
Message-ID: <4a7704af-4c30-3050-e8a6-cb1fa3fd7ec9@linux.intel.com>
References: <a5f23340-2b84-4734-be11-f5a97c188195@app.fastmail.com> <ec9af6c3-755b-488a-8400-cef9eeeac509@leemhuis.info> <740b10c4-a54a-f776-d564-d3c977d90ba6@linux.intel.com> <52614de3-9658-4390-8e0e-689963f364a4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1838993219-1774886953=:968"
Content-ID: <259c788a-40b5-d4b8-b983-04e9b355d159@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1838993219-1774886953=:968
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <20f0fc1d-6ec6-9cf2-09cc-b1a5306e3f56@linux.intel.com>

On Mon, 30 Mar 2026, Jonas H=F6glund wrote:

> On Mon, 30 Mar 2026, at 14:33, Ilpo J=E4rvinen wrote:
> > I'm skeptical it's exactly the same issue even if the end result is the=
=20
> > same.
> >
> > The resource fitting algorithm has been in a state of constant flux due=
 to=20
> > various fixes and improvements into it over all the recent two years.
> > Unfortunately, fixing one thing (or even moving towards fixing an issue=
)=20
> > may break another thing due to how different resource interact.
>=20
> Ok, yeah, I don't envy having to deal with that.  You're probably right
> it's more BAR-related, I mostly keyed in on the very similar symptom.

Definitely the gpu driver could handle an resource issue better than by=20
calling something that triggers a sanity check somewhere, but it's=20
secondary problem.

> > That "PCI: Improve head free space usage" series is certainly fixing tw=
o=20
> > known corner case with the commit 3958bf16e2fe ("PCI: Stop over-estimat=
ing=20
> > bridge window size") but with only heavily filtered logs, I'm unable to=
=20
> > confirm if it applies to this case as well.
>=20
> Sorry for not providing full logs from the get-go; I couldn't think of
> suitable location.  Here's a full dmesg for reference of the crash
> manifesting on 7.0.0-rc5:
>=20
> https://up.firefly.nu/pub/amdgpu-egpu-crash-7.0.0-rc5.dmesg.txt
>=20
>=20
> > From the limited logs, I suspect this is primarily a BAR resize rollbac=
k=20
> > failure which leaves the resources into a state worse than they were pr=
ior=20
> > to the resize. The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR=
=20
> > resize rollback path") attempts to rectify that. The entire series is h=
ere=20
> > (not all of it went to stable):
>=20
> > https://lore.kernel.org/all/20251113162628.5946-1-ilpo.jarvinen@linux.i=
ntel.com/T/#m9b0e316c94f7abc0686e58f902d05ff35aeac3ac
> >
> > The fixes to that series are here:
> >
> > 5528fd38f230 ("PCI: Fix Resizable BAR restore order")
> > 08d9eae76b85 ("PCI: Fix BAR resize rollback path overwriting ret")
>=20
> Unless I misread something, they should both be included in the recently
> tagged 7.0.0-rc6--I'll try building it and see if the issue is resolved.
>=20
> I'll reply once I've tested 7.0.0-rc6.

Hi again,

Now that I look more into the logs that probably won't help. For some=20
reason, it seems that resize is not even attempted and the errno is=20
-EINVAL which is a bit unexpected.

I'm starting to wonder that the problem fixed by this patch once again is=
=20
showing its ugly head (it's currently in pci/resource branch, so it won't=
=20
appear until 7.1-rc1):

https://lore.kernel.org/linux-pci/20260326200427.GA1340256@bhelgaas/

I still don't understand why pbus_select_window() would return NULL in=20
this case but it looks the most likely candidate where -EINVAL could come=
=20
from (I still don't understand what cleared resource's flags if that's the=
=20
case but it still seems the best explanation).

Please take logs from this point on with dyndbg=3D"file drivers/pci/*.c +p"=
=20
on the kernel's command line so there's little bit of extra info (and=20
check you are building with CONFIG_DYNAMIC_DEBUG).

--=20
 i.
--8323328-1838993219-1774886953=:968--
