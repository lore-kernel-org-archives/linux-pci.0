Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357BC46D0A5
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853061; cv=none; b=uhbyxckjTolUexVHbT6A8gUe8Ec4YbUzg8PFOiXUeWqMDiSSt4mLgH0ngm5iIaJbqDApVLTOKzuGs80tbQiQBiSPEc/60u1Zrwf1C8APWLiVGOunebcn26kOWUqOQM3HbHraG+UWf3XPoILCV/0lvYuXjQoOgrsadxtiAdkmixQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853061; c=relaxed/simple;
	bh=RXc62Z1jk4XJf0WcX2q/jBCfFqKv6Kby2/l+scl+8kg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F2VbzaKb/4YOO99xx2yIQ6JA7uvIdkRu0ojNKq8wP33adTVJmhigMkFbV2hp7yd3x7BVtvT0osSOH3gdCshs2H3uMZhAtJCUIEkh9pBPyQuKX4g5SVqmeyZgDjC5cniszWwgcHX102jWdGreWhkucIlnUGXdG2TiV4tUWD1Zf04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLJfEWxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLJfEWxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567571F000E9;
	Tue,  4 Aug 2026 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853047;
	bh=1PmVElSSLFCWuW9L+JKD9kj0MEm4YfKecxf28Uxzfgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLJfEWxgcJxZbp3DODECGhKY5vB4znRld3F//Ooa3hpqzAKm3QmCpPdK/9UXanBJP
	 Gq3tG5O28mRxrJnKMld9hcNINq7EmYygfPc0WZ1EIPg8Po0e44bSZVPazyk9mJCGVW
	 uTn+p+YHWaDdEya3HatYlQuj4BMoJC1xpn9DkI1piPFLrj+vsHI8HvLWoQyT3rvbGR
	 txdzLFlVI9iKHBQ0byT5/s7AmitT9ehYe6Na//orkK50YFS7PjXxSxhPEqg0r0iHW+
	 DYZFg2QKlLJ+P+KvPvZcW+YfRruZ5XXk6cREUFZIjo+71ISYDs34sRit2/sqZczQ7z
	 k2lUvMELc7fvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 03/14] i3c: master: Do not treat master device as a
 duplicate target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, Frank.Li@kernel.org, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804133810.184905-4-adrian.hunter@intel.com>
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 14:17:26 +0000
Message-Id: <20260804141727.567571F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unregistering an I3C master causes a use-after-free if its sysfs a=
ttributes (e.g., `pid`, `bcr`, `dcr`) are read concurrently.
--

--- Patch [3]: [PATCH V3 03/14] i3c: master: Do not treat master device as =
a duplicate target ---
commit a98a06e576b08be2cd4e71df3fa63ba688a254ca
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: master: Do not treat master device as a duplicate target

This commit updates i3c_master_search_i3c_dev_duplicate() to exclude the
master controller itself from matching when searching for duplicate target
devices. Since the controller is not a target device, it should not be
returned as a duplicate.

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index c7bb52b71d884..abb582645a2ed 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2545,7 +2545,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_=
desc *refdev)
> =20
>  	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
>  		if (i3cdev !=3D refdev && i3cdev->info.pid &&
> -		    i3cdev->info.pid =3D=3D refdev->info.pid)
> +		    i3cdev->info.pid =3D=3D refdev->info.pid &&
> +		    i3cdev !=3D master->this)
>  			return i3cdev;
>  	}

[Severity: High]
This is a pre-existing issue, but unregistering an I3C master appears to
cause a use-after-free if its sysfs attributes are read concurrently.

Looking at i3c_master_unregister() in drivers/i3c/master.c:

i3c_master_unregister() {
    ...
    i3c_master_bus_cleanup(master);
    pm_runtime_disable(&master->dev);
    device_unregister(&master->dev);
    ...
}

The call to i3c_master_bus_cleanup() calls i3c_master_detach_free_devs(),
which frees all devices in the list including master->this.=20

However, because device_unregister() hasn't been called yet, the sysfs files
remain exposed to userspace.

If userspace reads a sysfs attribute like pid during this window, could this
trigger a use-after-free?

drivers/i3c/master.c:pid_show() {
    ...
    desc =3D dev_to_i3cdesc(dev);
    ret =3D sysfs_emit(buf, "%llx\n", desc->info.pid);
    ...
}

Since master->this is already freed but the pointer is not NULL,=20
desc->info.pid would dereference the freed memory.

Could device_unregister() be called earlier to prevent the sysfs files=20
from being accessed while the cleanup happens?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804133810.1849=
05-1-adrian.hunter@intel.com?part=3D3
