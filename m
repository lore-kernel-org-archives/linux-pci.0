Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C622FDEA
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769419103; cv=none; b=kTrNFyRMdFL4L3lFl7Qq12fg3slKK1Hl+LShiEwvwbvGK+EyreHVFUkt4KX9ctzI6VTEMGbehdu7sWE+WupB47+MHK5jYiNztlSKp0Kt7IqzSqbMWlh5QotQ6a4Rg3jnH1ED+4/zdo7yTXHZOlKJg715y2fy6jBT4N+pqLkhHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769419103; c=relaxed/simple;
	bh=HUbtnk159Q+Nfccv+VAYJVo3k0789ZNDz4DNLJxAAIQ=;
	h=Subject:Mime-Version:In-Reply-To:Content-Type:Message-Id:To:Cc:
	 From:Date:References; b=KiqMMnNncgiwVfFxykT/oZaTA2s1ZhOJamT9XCmgx3o4LGnUIEacudm9PF2lOOkjm5xNggoTLw3LWsnalo9g/yj5XArkdOwqOS/Uy7Fn3mKYwzZvqDV7fRWjTNfbSFDoo7uOiFjuVoHZknWKR4rlWdQsRVPlhMcA24NHR2Z4KMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HX5LuoSg; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HX5LuoSg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1769419088; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SLuCNIDdD9jzHy6jPE9CzIigiKSLTaL1pcwFgzrh008=;
 b=HX5LuoSgZiiZ15Ml2AKXB2IgVoKLKGgCa7vYzyajWVcoUxgeFyxNEGRpG9/IC+IUggxTRA
 naK+LUvNz9VK2+Z06kun657cEQsr5SgPFCsgvrzwNQcFrpGEawnCZZsMhkM7XwIaNuvVTd
 LunZXZoVKEYpt4xit0eLQ7yieT3h2mP101hYwcZw6oM2xvBGCCc+cH5v3/SRJqFhiwLfQf
 Y5tW1dbNE05u747jDLoqHzIF+tASWByAIlfunq0SmZ1hIRcaJwiPz3Ni9i0UckM6mAfirO
 999+mTynG9OTEehjbvaZScKEjpPcg+wRrjQFtTjlweWzW1bbgK1BZB17iYql9Q==
Subject: Re: [PATCH v2 0/3] Add NUMA-node-aware synchronous probing to driver core
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <69741a9beae22_309510044@dwillia2-mobl4.notmuch>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260126091749.307-1-guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: <dan.j.williams@intel.com>
Cc: <alexanderduyck@fb.com>, <bhelgaas@google.com>, <bvanassche@acm.org>, 
	<dakr@kernel.org>, <frederic@kernel.org>, <gregkh@linuxfoundation.org>, 
	<guojinhui.liam@bytedance.com>, <helgaas@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, 
	<rafael@kernel.org>, <tj@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Mon, 26 Jan 2026 17:17:49 +0800
X-Lms-Return-Path: <lba+26977314e+72ca93+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: quoted-printable
References: <69741a9beae22_309510044@dwillia2-mobl4.notmuch>

On Fri Jan 23, 2026 17:04:27 -0800, Dan Williams wrote:
> Jinhui Guo wrote:
> > Hi all,
> >=20
> > ** Overview **
> >=20
> > This patchset introduces NUMA-node-aware synchronous probing.
> >=20
> > Drivers can initialize and allocate memory on the device=E2=80=99s loca=
l
> > node without scattering kmalloc_node() calls throughout the code.
> > NUMA-aware probing was added to PCI drivers in 2005 and has
> > benefited them ever since.
> >=20
> > The asynchronous probe path already supports NUMA-node-aware
> > probing via async_schedule_dev() in the driver core. Since NUMA
> > affinity is orthogonal to sync/async probing, this patchset adds
> > NUMA-node-aware support to the synchronous probe path.
> >=20
> > ** Background **
> >=20
> > The idea arose from a discussion with Bjorn and Danilo about a
> > PCI-probe issue [1]:
> >=20
> > when PCI devices on the same NUMA node are probed asynchronously,
> > pci_call_probe() calls work_on_cpu(), pins every probe worker to
> > the same CPU inside that node, and forces the probes to run serially.
> >=20
> > Testing three NVMe devices on the same NUMA node of an AMD EPYC 9A64
> > 2.4 GHz processor (all on CPU 0):
> >=20
> >   nvme 0000:01:00.0: CPU: 0, COMM: kworker/0:1, probe cost: 53372612 ns
> >   nvme 0000:02:00.0: CPU: 0, COMM: kworker/0:2, probe cost: 49532941 ns
> >   nvme 0000:03:00.0: CPU: 0, COMM: kworker/0:3, probe cost: 47315175 ns
> >=20
> > Since the driver core already provides NUMA-node-aware asynchronous
> > probing, we can extend the same capability to the synchronous probe
> > path. This solves the issue and lets other drivers benefit from
> > NUMA-local initialization as well.
>=20
> I like that from a global benefit perspective, but not necessarily from
> a regression perspective. Is there a minimal fix to PCI to make its
> current workqueue unbound, then if that goes well come back and move all
> devices into this scheme?

Hi Dan,

Thank you for your time, and apologies for the delayed reply.

I understand your concerns about stability and hope for better PCI regressi=
on
handling. However, I believe introducing NUMA-node awareness to the driver
core's asynchronous probe path is the better solution:

1. The asynchronous path already uses async_schedule_dev() with queue_work_=
node()
   to bind workers to specific NUMA nodes=E2=80=94this causes no side effec=
ts to driver
   probing.
2. I initially submitted a PCI-only fix [1], but handling asynchronous prob=
ing in
   PCI driver proved difficult. Using current_is_async() works but feels fr=
agile.
   After discussions with Bjorn and Danilo [2][3], moving the solution to d=
river
   core makes distinguishing async/sync probing straightforward. Testing sh=
ows
   minimal impact on synchronous probe time.
3. If you prefer a PCI-only approach, we could add a flag in struct device_=
driver
   (default false) that PCI sets during registration. This limits the new p=
ath to
   PCI devices while others retain existing behavior. The extra code is ~10=
 lines
   and can be removed once confidence is established.
4. I'm committed to supporting this: I'll include "Fixes:" tags for any fal=
lout
   and provide patches within a month of any report. Since the logic mirror=
s the
   core async helper, risk should be low=E2=80=94but I'll take full respons=
ibility
   regardless.

Please let me know if you have other concerns.

[1] https://lore.kernel.org/all/20251230142736.1168-1-guojinhui.liam@byteda=
nce.com/
[2] https://lore.kernel.org/all/20251231165503.GA159243@bhelgaas/
[3] https://lore.kernel.org/all/DFFXIZR1AGTV.2WZ1G2JAU0HFQ@kernel.org/

Best Regards,
Jinhui
