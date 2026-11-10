Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348149;
	b=2HW832mUGXzTDW/7gjyCCishyub7ZWtpYTN1EWMuv2kY8uzdmDsdcJGQCtXh64Uhp8AR
	 rL6y/C4ujlzkZKDuGu4QV6qFKDxKVRTFesXG7DZKtjHvEHQn7+FLNXyfyG0ebT3rf92Pn
	 rrGpX5AmLwo78nbyTDnI0KZnvn34hzwOKjAOtPK45aH01cc9043cin5xC6QcFOXTub2nV
	 aeWCB8HqdWOGJuQsJQS9HSX73ir+bzLcatxgIFBfEc5nb8TUSUGrc9Cu/agt1FIUyp8G/
	 44kgVMuWYkgtJSaP7LCQZdc1TaBoIFONLG3vfVDl7nJB2hNS9TaVEZsDzXo6g2FUTNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348149;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0KLs37i5fPHJo+dReSFejwLgaLFi/cT9owU42XeZTzA=;
	b=2fljU8rBC3lpuPhSLleIMMTcyWxEKbjfGMAoUAKUSO6avHERr9DVG4Z9NUc/6O7T32E+
	 yj34PanFgS0GalZREjuak44UXJl2B+blDZ5r1fMl8U70XcDUf7sBaDu9gUoS7nh4tB15V
	 ssGWz6/rjXCzHGDamx23kJwKbqsnn/YH6rqETEWleZTw3z2WD5Uvfj6bciiLvofijiuZZ
	 aTi22doV7FekHGBWZPUPs8EX1WdSCnKCxjOoPNKAQwLLcszFEVoGZcESzgkhmoQ6MO8Af
	 /sAZqY/zRALxBlEjZPDzy7Q8Ikl9W5rDCn8U9Nly7sAkF6mFBx0N97uEfYKWkGTdDLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mc9kjb2/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F2B606A325
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mc9kjb2/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F371F008A1;
	Tue, 10 Nov 2026 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348148;
	bh=0KLs37i5fPHJo+dReSFejwLgaLFi/cT9owU42XeZTzA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Mc9kjb2/DaEtFAAyk2986zuQPa0BXYmglbMAAsgFQjrmUVxMEK0vkpDoeMbG3Zgc0
	 TKUJ5iH0W9hQ/mG+irjTW8YgAhT1Ygpk9eifk9cUN1U1BRCPMgAezLLIo63IcDTAKu
	 9qtys4AGHbVSq/srDQkLZDt9hcm34oWX5PaRurd4ENc3FUw3iH+luH5t9iS243QduI
	 hkoXupBiV5K6Tpmc1/l0s4HNS2kONf9aiZ87sfkucM+zQttuQyuOCWyHKokh34S5Gl
	 YZRi4hcBkpOA0HvM/m3QW7SFI5cQeG40XEYH1R9QCPdj9iLLJcF/MkwAH3Cn8sn2xC
	 0EYSolYI8VVgg==
Message-ID: <sashiko-outbox-207809@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261110215614.3931232-3-yazen.ghannam@amd.com>
References: <20261110215614.3931232-1-yazen.ghannam@amd.com>
 <20261110215614.3931232-3-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:02:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] PCI/AER: incorrect unit scaling in
  aer_ratelimit_interval_attr() [1]
--

commit 3e212613eb554aa7ec8ef93c898bf101c6bb444e
Author: Yazen Ghannam <yazen.ghannam@amd.com>

PCI/AER: Clamp negative ratelimit burst to zero

This commit clamps negative values written to the AER ratelimit burst sysfs
attributes to zero and updates the ABI documentation accordingly.

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6f24602314225..401cd3a1b3d0e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group =3D=
 {
>  		if (kstrtoint(buf, 0, &burst) < 0)			\
>  			return -EINVAL;					\
>  									\
> +		if (burst < 0)						\
> +			burst =3D 0;					\
> +									\
>  		pdev->aer_info->ratelimit.burst =3D burst;		\
>  									\
>  		return count;						\

[Severity: Medium]
This problem wasn't introduced by this patch, but shouldn't the companion
aer_ratelimit_interval_attr() macro convert pdev->aer_info->ratelimit.inter=
val
back with jiffies_to_msecs() in name##_show() [1]?

drivers/pci/pcie/aer.c:aer_ratelimit_interval_attr() {
	static ssize_t							\
	name##_show(struct device *dev, struct device_attribute *attr,	\
					 char *buf)			\
	{								\
		struct pci_dev *pdev =3D to_pci_dev(dev);			\
									\
		return sysfs_emit(buf, "%d\n",				\
				  pdev->aer_info->ratelimit.interval);	\
	}								\
    ...
		if (interval <=3D 0)					\
			interval =3D 0;					\
		else							\
			interval =3D msecs_to_jiffies(interval); 		\
									\
		pdev->aer_info->ratelimit.interval =3D interval;		\
}

name##_store() converts the millisecond value into jiffies before storing i=
t,
so reading *_ratelimit_interval_ms back emits raw jiffies instead of
milliseconds when HZ !=3D 1000.

[1] https://sashiko.dev/#/bug/linux-3e0972eb-98a1-4365-b40e-82736dd85f13

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110215614.3931=
232-1-yazen.ghannam@amd.com?part=3D2
