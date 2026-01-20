Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4797350D49
	for <linux-pci@vger.kernel.org>; Tue, 20 Jan 2026 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929822; cv=none; b=Oj1GzBsVOl6IVDPW3B3HsmQoCqdC7V2fRgxw/wNHNvXRY2I8o6iMloseZKDiJ8fOsy7meeIHWpRgRd2kVMPRspa8v6L2VwKNIbnsDGMMPJzV5a0XIEO/jT5hUzPOzYIZOAnnRZaNr0ljTVfJB351KgkDDIlJ31YIYiJDy0J71Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929822; c=relaxed/simple;
	bh=SdjSdHKvO8THi45dn6X9NdTRCSJx540D5Bt52gH7aYo=;
	h=Message-Id:References:Cc:Subject:Date:Mime-Version:Content-Type:
	 In-Reply-To:To:From; b=TvWdCXwd+1Vu3TPI/YbqqKu0NUxIu2okqvqjI3EOVQNaXBU+hXuKZ80lS+KSIudVmFn3AOOfvENDm7lbt8oAw9u+hUOLmEjVHTBTXI0qNItkSE9FfgBXhlJKcry1gYjDne6AfQQA0lH+rdp7H+0g0c/MKi215jj8B7UFdp8gyQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AO20+pe8; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AO20+pe8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1768929812; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xqgOwEl7H5W1IO6M3fF4IcIp7BnqHPSKNoy+L7rxJ/M=;
 b=AO20+pe8JZl0NqRaT1dv6yCsbb6LYmQ6qZfsbeBmhr6iDiti4plA9dh3i1+RWz0MoCpSIF
 p0DPC9ItguLHHaCNAxPGbHSYP7BZEqY5Mqdx1gT9W6q14DIgq8Z/3PxMHHPisCahFNfcwF
 e/tXXAkHPT1FuGt9f8KwXgn7cRNoHTU1Wa/bcIxQlGgU0BdqEVNV+EVJUyua7kGS0nMlZ9
 p/JVa5huAX8ON2yoKrzsCFKRF4S5VomTxYYnfqhff704ywsRgSqVMBPe9eGwGsKIPwL5fy
 tFbyjt2wsJLFtLP1qnB8iRbUeFjtEEkEfYHmKaPIrFq1mdxmo/F+Q2AxBwpDHA==
Message-Id: <20260120172316.652-1-guojinhui.liam@bytedance.com>
References: <DFQX56VQ3FAV.3LIDGP9F41X1U@kernel.org>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: <alexander.h.duyck@linux.intel.com>, <alexanderduyck@fb.com>, 
	<bhelgaas@google.com>, <bvanassche@acm.org>, <dan.j.williams@intel.com>, 
	<gregkh@linuxfoundation.org>, <guojinhui.liam@bytedance.com>, 
	<helgaas@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-pci@vger.kernel.org>, <rafael@kernel.org>, <tj@kernel.org>
Subject: Re: [PATCH 2/3] driver core: Add NUMA-node awareness to the synchronous probe path
Date: Wed, 21 Jan 2026 01:23:16 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DFQX56VQ3FAV.3LIDGP9F41X1U@kernel.org>
Content-Transfer-Encoding: quoted-printable
To: <dakr@kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2696fba13+a931e8+vger.kernel.org+guojinhui.liam@bytedance.com>

On Sat Jan 17, 2026 15:03:08 +0100, Danilo Krummrich wrote:
> On Wed Jan 7, 2026 at 6:55 PM CET, Jinhui Guo wrote:
> > @@ -808,6 +894,8 @@ static int __driver_probe_device(const struct devic=
e_driver *drv, struct device
> >  	return ret;
> >  }
> > =20
> > +DEFINE_NUMA_WRAPPER(__driver_probe_device, const struct device_driver =
*, struct device *)
> > +
> >  /**
> >   * driver_probe_device - attempt to bind device & driver together
> >   * @drv: driver to bind a device to
> > @@ -844,6 +932,8 @@ static int driver_probe_device(const struct device_=
driver *drv, struct device *d
> >  	return ret;
> >  }
> > =20
> > +DEFINE_NUMA_WRAPPER(driver_probe_device, const struct device_driver *,=
 struct device *)
> > +
> >  static inline bool cmdline_requested_async_probing(const char *drv_nam=
e)
> >  {
> >  	bool async_drv;
> > @@ -1000,6 +1090,8 @@ static int __device_attach_driver_scan(struct dev=
ice_attach_data *data,
> >  	return ret;
> >  }
> > =20
> > +DEFINE_NUMA_WRAPPER(__device_attach_driver_scan, struct device_attach_=
data *, bool *)
>=20
> Why define three different wrappers? To me it looks like we should easily=
 get
> away with a single wrapper for __driver_probe_device(), which could just =
be
> __driver_probe_device_node().
>=20
>=20
> __device_attach_driver_scan() already has this information (i.e. we can c=
heck if
> need_async =3D=3D NULL). Additionally, we can change the signature of
> driver_probe_device() to
>=20
> 	static int driver_probe_device(const struct device_driver *drv, struct d=
evice *dev, bool async)
>=20
> This reduces complexity a lot, since it gets us rid of DEFINE_NUMA_WRAPPE=
R() and
> EXEC_ON_NUMA_NODE() macros.

Hi Danilo,

Thank you for your time and helpful comments.

Apologies for the delayed reply. I understand your concern: before sending =
this
patchset I prototyped a version that added __driver_probe_device_node() and
relied solely on current_is_async() to detect an async worker, without chan=
ging
driver_probe_device()=E2=80=99s signature. That proved fragile, so I abando=
ned it; your
suggestion is the more reliable path forward.

I=E2=80=99ve spent the last couple of days preparing a new patch and will s=
end it out
after testing.

Best Regards,
Jinhui
