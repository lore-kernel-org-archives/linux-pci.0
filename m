Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9FB32F770;
	Mon, 22 Jun 2026 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140998; cv=none; b=C/bUmc1dKA8Sbdx90z4APs0bG/74YzTiz/Rqrfwyjvn0b89+lTZWswSZFnDckEd8aTkKPAMr2xFVqkfPhYo/DHWrfNdxWMC5PdXBP36U14g6Kb94eSN+ysPFjJIhXU52tjrDeFi2EUX3nPHM1Jtst5oRoM17Xn4eeE+Xr9fBISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140998; c=relaxed/simple;
	bh=bBpDr3hnG9J540C9A3q6S6YdQV7ovaXcUrIAhFmlCCY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CAQkCWfh4jdM2v8VBCPnV4d7Zus920uuPqdmJkhM0iWsx9gLP0Nu65hpqfcmtqQmNuy7NxHI+0UGvfojYQMbEf0zmX7VHrNJyE4k4VW52hjhhIwmm1JEg7PZV4llEsqoHrtz+simoiR+hEWHLnYE/GNzGPs1CG/IOuBJWB7vD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/131Bgb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/131Bgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782140997; x=1813676997;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=bBpDr3hnG9J540C9A3q6S6YdQV7ovaXcUrIAhFmlCCY=;
  b=I/131Bgbx9yasflrALSWmtZ0P3OM8AUsJpKucywqXCi7XOR7rTA4cKkw
   /cBRheGQHneckcXAbvgZRg9+QhwaY2rGqjtJbsA+CHPaVe08BehKczXMR
   9oCP+7oX+nAwDvYDUpRnVbzZeDpdG4Pns4vXRX591Q2MinzoqwP3zkFid
   xjh8D8/W3cXlpA4gW9m10BSxZvxqFazL4wn9Ug1k0L3cg7R6IV0NdLeoG
   1mxqr62UtAbk6NL0Xg0bvxQf/KXqI1oiPwrjQuM+bgxkoMdpoxmIWkh/3
   Mql6qu9E6jrNrX+q5f7+Nuu+pc51RscJBggF46YC+cxXsmVyPzwREcuCg
   g==;
X-CSE-ConnectionGUID: G8xgTb8xRrS2dxYvPFHEEQ==
X-CSE-MsgGUID: D2uT4dgIRV2Y3Sgbb0hzcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="81853778"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="81853778"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:09:56 -0700
X-CSE-ConnectionGUID: zvFEC+gISOChKPu2mAw16g==
X-CSE-MsgGUID: ZZOCVv4YQg+VOwmVw8k9xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="253146832"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.126])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 08:09:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 22 Jun 2026 18:09:51 +0300 (EEST)
To: Ding Hui <dinghui@sangfor.com.cn>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] PCI: Sort resources by size as secondary key
In-Reply-To: <d966ac57-52cc-415b-bb0d-1f175a4ebb0c@sangfor.com.cn>
Message-ID: <e81d1117-7578-4dfc-8673-d7e806a2e8d2@linux.intel.com>
References: <20260618072536.28199-1-dinghui@sangfor.com.cn> <8958b0af-7475-26b1-6eef-8e3ddf056196@linux.intel.com> <d966ac57-52cc-415b-bb0d-1f175a4ebb0c@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1402843355-1782140717=:1249"
Content-ID: <dfc4874e-cb10-34b4-2d46-cba2be189f44@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1402843355-1782140717=:1249
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8c762d92-1915-65e5-9440-efe8e7e755c7@linux.intel.com>

On Mon, 22 Jun 2026, Ding Hui wrote:
> On 2026/6/22 17:24, Ilpo J=E4rvinen wrote:
> > On Thu, 18 Jun 2026, Ding Hui wrote:
> >=20
> > > We encountered an issue on BCM57414 NIC where function 1 failed to
> >=20
> > Don't or "We" (or "I") in changelog sentences. Use imperative tone. Her=
e
> > you can start just with:
> >=20
> > BCM57414 NIC function 1 fails to ...
> >=20
> > > enable SR-IOV after remove & rescan. Investigation revealed this is
> > > caused by BAR allocation failure during rescan.
> > >=20
> > > Simplified topology:
> > >=20
> > >   +-[0000:30]-+- ...
> > >   |           +-02.0-[31]--+-00.0  Broadcom Inc. and subsidiaries BCM=
57414
> > > NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7]
> > >   |           |            \-00.1  Broadcom Inc. and subsidiaries BCM=
57414
> > > NetXtreme-E 10Gb/25Gb RDMA Ethernet Controller [14e4:16d7]
> > >=20
> > > iomem layout after init bootup:
> > >=20
> > >    22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=3D19M]
> > >      22fffec00000-22ffff3fffff : 0000:31:00.1  [align=3D1M  size=3D8M=
   BAR 9
> > > (VF BAR 2)]
> > >      22ffff400000-22ffffbfffff : 0000:31:00.0  [align=3D1M  size=3D8M=
   BAR 9
> > > (VF BAR 2)]
> > >      22ffffc00000-22ffffcfffff : 0000:31:00.1  [align=3D1M  size=3D1M=
   BAR 2]
> > >      22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=3D1M  size=3D1M=
   BAR 2]
> > >      22ffffe00000-22ffffe0ffff : 0000:31:00.1  [align=3D64K size=3D64=
K  BAR 0]
> > >      22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=3D64K size=3D64=
K  BAR 0]
> > >      22ffffe20000-22ffffe3ffff : 0000:31:00.1  [align=3D16K size=3D12=
8K BAR
> > > 11(VF BAR 4)]
> > >      22ffffe40000-22ffffe5ffff : 0000:31:00.1  [align=3D16K size=3D12=
8K BAR 7
> > > (VF BAR 0)]
> > >      22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=3D16K size=3D12=
8K BAR
> > > 11(VF BAR 4)]
> > >      22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=3D16K size=3D12=
8K BAR 7
> > > (VF BAR 0)]
> > >      22ffffea0000-22ffffea1fff : 0000:31:00.1  [align=3D8K  size=3D8K=
   BAR 4]
> > >      22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=3D8K  size=3D8K=
   BAR 4]
> > >=20
> > > iomem layout after remove function 1 by
> > >    echo "1" > /sys/bus/pci/devices/0000:31:00.1/remove
> > >=20
> > >    22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=3D19M]
> > >      22ffff400000-22ffffbfffff : 0000:31:00.0  [align=3D1M  size=3D8M=
   BAR 9
> > > (VF BAR 2)]
> > >      22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=3D1M  size=3D1M=
   BAR 2]
> > >      22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=3D64K size=3D64=
K  BAR 0]
> > >      22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=3D16K size=3D12=
8K BAR
> > > 11(VF BAR 4)]
> > >      22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=3D16K size=3D12=
8K BAR 7
> > > (VF BAR 0)]
> > >      22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=3D8K  size=3D8K=
   BAR 4]
> > >=20
> > > Rescan logs triggered by
> > >    echo "1" > /sys/bus/pci/devices/0000:30:02.0/rescan
> > >=20
> > > [   90.585067] pci 0000:31:00.1: [14e4:16d7] type 00 class 0x020000 P=
CIe
> > > Endpoint
> > > [   90.585107] pci 0000:31:00.1: BAR 0 [mem 0x22ffffe00000-0x22ffffe0=
ffff
> > > 64bit pref]
> > > [   90.585113] pci 0000:31:00.1: BAR 2 [mem 0x22ffffc00000-0x22ffffcf=
ffff
> > > 64bit pref]
> > > [   90.585116] pci 0000:31:00.1: BAR 4 [mem 0x22ffffea0000-0x22ffffea=
1fff
> > > 64bit pref]
> > > [   90.585119] pci 0000:31:00.1: ROM [mem 0xb0e00000-0xb0e7ffff pref]
> > > [   90.585216] pci 0000:31:00.1: PME# supported from D0 D3hot D3cold
> > > [   90.585253] pci 0000:31:00.1: VF BAR 0 [mem
> > > 0x22ffffe40000-0x22ffffe43fff 64bit pref]
> > > [   90.585255] pci 0000:31:00.1: VF BAR 0 [mem
> > > 0x22ffffe40000-0x22ffffe5ffff 64bit pref]: contains BAR 0 for 8 VFs
> > > [   90.585258] pci 0000:31:00.1: VF BAR 2 [mem
> > > 0x22fffec00000-0x22fffecfffff 64bit pref]
> > > [   90.585260] pci 0000:31:00.1: VF BAR 2 [mem
> > > 0x22fffec00000-0x22ffff3fffff 64bit pref]: contains BAR 2 for 8 VFs
> > > [   90.585263] pci 0000:31:00.1: VF BAR 4 [mem
> > > 0x22ffffe20000-0x22ffffe23fff 64bit pref]
> > > [   90.585265] pci 0000:31:00.1: VF BAR 4 [mem
> > > 0x22ffffe20000-0x22ffffe3ffff 64bit pref]: contains BAR 4 for 8 VFs
> > > [   90.585534] pci 0000:31:00.1: Adding to iommu group 11
> > > [   90.585575] pci 0000:31:00.1: BAR 2 [mem 0x22fffec00000-0x22fffecf=
ffff
> > > 64bit pref]: assigned
> > > [   90.585585] pci 0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit
> > > pref]: can't assign; no space
> > > [   90.585587] pci 0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit
> > > pref]: failed to assign
> > > [   90.585589] pci 0000:31:00.1: ROM [mem 0xb0e00000-0xb0e7ffff pref]=
:
> > > assigned
> > > [   90.585591] pci 0000:31:00.1: BAR 0 [mem 0x22fffed00000-0x22fffed0=
ffff
> > > 64bit pref]: assigned
> > > [   90.585599] pci 0000:31:00.1: VF BAR 0 [mem
> > > 0x22fffed10000-0x22fffed2ffff 64bit pref]: assigned
> > > [   90.585603] pci 0000:31:00.1: VF BAR 4 [mem
> > > 0x22fffed30000-0x22fffed4ffff 64bit pref]: assigned
> > > [   90.585606] pci 0000:31:00.1: BAR 4 [mem 0x22fffed50000-0x22fffed5=
1fff
> > > 64bit pref]: assigned
> >=20
> > Timestamps are irrelevant noise to the problem and should be removed.
> >=20
> > >=20
> > > Enable sriov failed logs triggered by
> > >    echo 2 > /sys/bus/pci/devices/0000:31:00.1/sriov_numvfs
> > >=20
> > > [ 1666.918432] bnxt_en 0000:31:00.1: not enough MMIO resources for SR=
-IOV
> > > [ 1666.918442] bnxt_en 0000:31:00.1 eth5: pci_enable_sriov failed : -=
12
> > >=20
> > > The resource allocation process during rescan is as follows:
> > >=20
> > >    dev_rescan_store
> > >      pci_rescan_bus
> > >        pci_assign_unassigned_bus_resources
> > >          __pci_bus_assign_resources
> > >            pbus_assign_resources_sorted
> > >              pdev_sort_resources
> > >              __assign_resources_sorted
> > >                assign_requested_resources_sorted
> > >                  pci_assign_resource
> > >=20
> > > We noticed that current sort algorithm is only by alignment.
> > > The BAR 2 (align=3D1M size=3D1M) is located before BAR 9 (VF BAR 2
> > > align=3D1M size=3D8M), so the 8M cannot be satisfied.
> >=20
> > I think you have a typo (located vs allocated)? The difference changes
> > meaning significantly. (located implies before in address, allocated
> > implies before in the order of made allocations).
> >=20
>=20
> My description could indeed be misleading. My intention was that BAR 2 is
> before BAR 9 in the sorted list, and therefore it is allocated before BAR=
 9.

Yes. First I misunderstood you but realized later what was your meaning=20
after I managed to decipher what is the story your logs told.

I'd prefer the changelog is written such that logs only prove things=20
happened the way you description they did. That is, even if all lines=20
would be deleted, the person looking at your patch should understand=20
what's going wrong.

> > > If we keep alignment as primary sorting key, but use size as secondar=
y
> > > key, all resource can be satisfied when remove & rescan.
> > >=20
> > > Does this approach only solve current specific case as a workaround,
> > > or does it also benefit general PCI resource allocation?
> > >=20
> > > I think it may help reduce allocation failures due to fragmentation
> > > theoretically, but I'm not sure.
> >=20
> > I suppose trying the largest first does generally increase the chances =
of
> > success in cases where the resource sizes are very heterogeneous like i=
n
> > your
> > case, not just in this case.
> >=20
>=20
> Thanks for agreeing with this point.
>=20
> > You should really rewrite the changelog text though. Try more to focus =
on
> > how the other allocations from the sibling make it possible to fit some=
 of
> > the resource(s) only into a single place within the window. And therefo=
re
> > largest one should be requested first. I had to figure that bit myself =
as
> > you didn't clearly state why it fails but only talked vaguely about the
> > order of (al)location(s).
> >=20
>=20
> After .1 BAR 2 assigned, the iomem layout (deduce should be):
>=20
>   22fffec00000-22ffffefffff : PCI Bus 0000:31 [Window size=3D19M]
>     22fffec00000-22fffecfffff : 0000:31:00.1  [align=3D1M  size=3D1M   BA=
R 2]
>                                               [gap=3D7M]
>     22ffff400000-22ffffbfffff : 0000:31:00.0  [align=3D1M  size=3D8M   BA=
R 9 (VF
> BAR 2)]
>                                               [gap=3D1M]
>     22ffffd00000-22ffffdfffff : 0000:31:00.0  [align=3D1M  size=3D1M   BA=
R 2]
>                                               [gap=3D64K]
>     22ffffe10000-22ffffe1ffff : 0000:31:00.0  [align=3D64K size=3D64K  BA=
R 0]
>                                               [gap=3D256K]
>     22ffffe60000-22ffffe7ffff : 0000:31:00.0  [align=3D16K size=3D128K BA=
R 11(VF
> BAR 4)]
>     22ffffe80000-22ffffe9ffff : 0000:31:00.0  [align=3D16K size=3D128K BA=
R 7 (VF
> BAR 0)]
>                                               [gap=3D8K]
>     22ffffea2000-22ffffea3fff : 0000:31:00.0  [align=3D8K  size=3D8K   BA=
R 4]
>                                               [gap=3D368K]
>=20
> And then there is no suitable space available to satisfy both align=3D1M =
and
> size=3D8M (BAR 9),
> that lead to "0000:31:00.1: VF BAR 2 [mem size 0x00800000 64bit pref]: ca=
n't
> assign; no space".

I figured that out myself by deciphering your logs (which has quite high=20
cost from reviewer point of view). It would have been much easier to tell=
=20
expliciltly that resource tree ends up into this intermediate state=20
while doing the assignments.

That is, explicitly state before the log snippets there are 1M and 8M=20
empty gaps in the bridge window, and the greedy approach places=20
size=3D1M,align=3D1M one first into 8M gap, leaving no space for the=20
size=3D8M,align=3D1M resource.

> > There will still be some cases this greedy approach will not get right,
> > such as align=3D2M,size=3D2M & align=3D1M,size=3D8M. This algorithm is =
not really
> > designed for filling gaps in a window but the entire window from scratc=
h,
> > which is why it cannot handle all cases.
> >=20
>=20
> Does the "remove & rescan" is still a corner case for kernel, especially =
that
> only removing a single function rather than the entire device for a
> multi-function
> device, even after you've fixed multiple issues in this scenario?

I didn't say it's a corner case but just pointed up there will always be=20
some cases with which a greedy approach will end up in tears. How common=20
they are, I don't know (but suspect they're rare).

I'd prefer remove + rescan for the same device to work at least as good=20
as before remove.

To go beyond that, tracking things is hard with the current algorith.
The complexity comes from the disjoint nature of sizing and assignment.=20
We cannot easily retry sizing after learning there's an assignment=20
failure because we lack of persisting structure where to store the fitting=
=20
information (struct pci_dev_resource that would last across resource=20
fitting rounds/passes). Those challenges make it a bit harder to come up=20
better fitting strategies.

> Does the community resent the issues caused by this scenario?

I suspect those how encounter such issues feel powerless to make any=20
change to it, even if some would resent their failing cases. Also,=20
changing one thing easily breaks another scenario risking revert and=20
return to status quo. This algorithm is not exactly easy to approach to=20
and contains very much decades old code (largely unexplained, of course).

> > > Appreciate any comment and suggestion, thanks.
> > >=20
> > > Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> > > ---
> > >   drivers/pci/setup-bus.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 4cf120ebe5ad..63f224f0c6be 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -367,7 +367,8 @@ static void pdev_sort_resources(struct pci_dev *d=
ev,
> > > struct list_head *head)
> > >   =09=09=09align =3D pci_resource_alignment(dev_res->dev,
> > >   =09=09=09=09=09=09=09 dev_res->res);
> > >   -=09=09=09if (r_align > align) {
> > > +=09=09=09if (r_align > align ||
> > > +=09=09=09    (r_align =3D=3D align && resource_size(r) >
> > > resource_size(dev_res->res))) {
> >=20
> > This is not the only place where the algorithm does sorting.
> >=20
> > (And I also know one restore place is lacking restoring ordering.)
> >=20
>=20
> Do you mean in __assign_resources_sorted(), retry normal assign after add=
_size
> assign failed?

Yes.

> I noticed this function after being replied by Sashiko AI review.
>
> > I was planning to move to rbtree for storing the resources that need to=
 be
> > in a certain order as doing it everywhere results in small variations
> > which is error prone.
> >=20
> > So maybe it would be time to consider moving to that so we could do the
> > sort order in one place.
> >=20
>=20
> Thank you for your guidance.



--=20
 i.
--8323328-1402843355-1782140717=:1249--
