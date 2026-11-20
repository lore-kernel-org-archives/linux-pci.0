Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795133203;
	b=CbGlVXCvQz9cyIU11Czmgz7Guu50twHbNGAzQ12pYqfqAN2TaU8PWA6k4dAT68BEw3Pm
	 wathBwuRqJWyPujF+DzBUewbM3/EepZ7xzd8EBK9fJ+1KWFlbXeyCJoiX+hC+23TTt11X
	 PgHrXRyHaXS1+DhfNMdbZbkmgwFh4Q1Rg+cPBdKiYGzuJoeOKfT2fj2rGv/hnrP8Y/qAM
	 LMLHcxfgwHyIyVeVw+WYmPxdSpC1ZHoqwpPlGyXHb3QK9nbzDIg4uV/yh3yGjUVgew7RG
	 9nLDZNP80zYZdkgwIjjXHDSvEVHTM12mxJMAz30ZZZRB7wt+ggLIM6bW++mqGSlkLGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795133203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
	b=XhUuCPdi3wH6vzen7dC8l8JUNCEDJ8ao0JjItpV/LbO+lfi0Vz+yoKpEjFw2/zyEZtnc
	 WtmIDBFEHF3sPUZItRa7wJeD35vIOX5cGdfz9S8UrWHBtgBH9f6VKpfEqt8jRsQxd5i4g
	 HlF0Die30TScPwfs8fvUv1E+oV4xsW4zX8dSNvGWVCziSKpxR0u6+64F2prTx9dWUIt+D
	 gVQt3KLPK+xQJdV5d0bIfHjEGqQ+DSTqhpDu0iUQWyfLKahBY4o2n956sXXGCRBuT1pqj
	 g5iRgULScABGb8k0wvAmClE6c5CN1NxRjbNDNE3mqCGxGFm3kcJV82XLBEI4AuNF6IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="air2/dns";
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD9606A33D
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 00:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34BD9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=air2/dns
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so194247a91.2
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 16:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795133202; x=1795738002; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
        b=air2/dns5VZwLYk/f1lay/0cC8R/IakufjWjyjlVS/NkwIM6QfW17TQOWTR1hao4Ul
         +5QvgbPksfItTlbIwBAB1do88ljLq3LFNqPJVuAVVQFv3aEB+KPQ8jSq9GBqzZ5g2JDR
         EFBr3yhdik4sQcww1/fIZ3fpCAjfe9zkTGWlOp5IUe6ipu8m33Jtrbu7EmiZbLJugeoL
         wVtgKZxEkfjkaEmkOERrHCTZHodW25y0KaAF+y2rfv5XxI04uL3lmRYwSfyjbHRFoVbA
         rIr7fkQDwkDSG7cYJDYndfUBNdVoHG7JNeSwMQR4yQGxrzMjZgyPy7VEoOETd4Ylvcq1
         Rr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795133202; x=1795738002;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8PsDwtqZ7ZOXHEr9V4C4myUyqMWkC/3w4Fd9za5pDc8=;
        b=WgkdAxqNJXvpJBB7PhtFh7hSV+SspuU5qMjeAC5s3qWWqLBwvgRI8vi1D2S8qWIK0Y
         3pyzmKM/ct8covwvnrhLaUC4nzhxFsuEnYeQPJtsRHajDH/41UIpunRSSdth65zBpFfF
         kJFNgG28GLXwkPPuoFv7COZXy1kRhwWKQADcgssYmkhefZAiNbmstgUitR8U8fbOnXbC
         6sS+SazSbz0pkl6Q7FJc0140mJitHp0uMSAUS8nQMC7MXthuq032HIlxp5cim9zWGJE9
         X/npnbMHq5RKUgUiLVD4xZJbRouQXZiaXaRgV/DRzvmuDE37dyEB7wl7zJuF/IlAYqxw
         6QVg==
X-Forwarded-Encrypted: i=1; AL+hErGI5GNXo0tUXiPZseuf3e85M9vZDgnE2raeKwRdmUWuQICg4uUpkoskCLIbMTg9LdsANOlebO+3pVI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DMu/NRdy8ClRrL3XQKCoJCSecL8ilOFZLTep6E0mFXkx9CHEg
	uLNgNX/nEO+/a5eGdjAA4cMED7qIoyO8en/2WRYro9KiPTKSvcM1QlsRoLZO/wdhJw==
X-Gm-Gg: AZFdTZccHE4b6ZpKZYoMIvqjiZn4Bw/44NKr0/6hm0Yx/mXgTIxKE+WlzC2qzcMtYCc
	YoEVBbigVwIQ2iUaF9A3GxI1d6ETL+xoVTjTnSh9EZdmu2xfrj+1E7KGJRl31SybdxFrkS0jeI3
	hG4mIjN8vlKxZKcJ6D11/KWgRQ18SFH4rdc9vO8SAmdewcCUKYiUqOar1vfBkDLFFyek9JEpUE1
	s8ZM7lUolVb9K55cqIsIXXYuT5okJemHp2MxLFnjZHoe/CEoatyxIUp8oRZfRwuTnB1Jrkt+cVa
	wstA4qQCB4n/cyhORuKq/KGaz/OGwmfFV7H5FmNGHwY+uG4c/mbBZXrgdWRtiku7g3/TQHidoUR
	31N8Y0wwzOdiuk9BgyMiF9NQxJJsEJu6gHIMn0wShkMychEMWKOJDeRPufBDtIYkXhYp0nAkqI9
	9RKNdj8+KykJ5BjazKtvSvVPZU8rzMXltMAKpyQPrZw4Y9nUmbT8e5IbsjMx8lmVIZJtXZRYYkj
	+GMLFv5nqU0vTdLLei6gkLjbcMGJHlafyfHXrlCQ3o+Y/wjydm+rydICqoBBVOL+QYMNEooZRQh
	1avKreV9akvxPhrNIH+7dWsaMgspFgLdbHzohaLuREdFIBKyCn/J9h2Q2bhb+/mK
X-Received: by 2002:a17:90b:442c:b0:3b3:ab74:cc9b with SMTP id 98e67ed59e1d1-3b41c554624mr967136a91.0.1795133201767;
        Thu, 19 Nov 2026 16:06:41 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ff5d3easm328044a91.1.2026.11.19.16.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 16:06:40 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 16:06:38 -0800
Message-Id: <DMZLLYOVIGOU.1RXWYJN6UQTM@google.com>
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 07/27] vfio/pci: Preserve vfio-pci device files
 across Live Update
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-8-vipinsh@google.com> <auzftbPFO_6XBYVw@google.com>
 <20261117220059.GA2250529.vipinsh@google.com>
In-Reply-To: <20261117220059.GA2250529.vipinsh@google.com>

On Tue Nov 17, 2026 at 10:44 PM PST, Vipin Sharma wrote:
>> pci_config_map doesn't need to be preserved. PATCH 14 already rebuilds
>> it with vfio_config_init() in the next kernel and only uses the
>> preserved copy to check that the two are identical.
>>=20
>> I assume the intent is to detect changes to vfio-pci's config emulation
>> between the two kernels, but the map isn't a good proxy for that. It
>> changes for differences that don't matter (e.g. hiding a capability or
>> learning the length of a new extended capability), which would fail
>> take-over and lose the Live Update on exactly the kernel upgrades Live
>> Update is meant for. And it doesn't change for differences that do
>> matter, like which bits are virtualized or writable within a capability.
>
> I think it does matter because reads and writes of unitialized
> capabilities in VFIO PCI config space goes to hardware directly. So, in
> the new kernel if pci_config_map changes it from PCI_CAP_ID_INVALID to
> others then those reads/writes can go to vconfig which will contain
> stale unitialized data from the old kernel's heap.
>
> This also changes behavior under a running user. Writes that reached
> hardware before Live Update can be silently dropped or redirected to
> vconfig. See the comment above struct perm_bits unassigned_perms{}
> in vfio_pci_config.c

That's true. Unassigned bytes passed through and vconfig is never
initialized for them, so hiding or exposing a capability does matter.
For example, 6467d0740a2b ("vfio/pci: Add DVSEC PCI Extended Config
Capability to user visible list") changed DVSEC from hidden (all bytes
raw) to exposed with a virtualized header. Across that boundary, v6
would have served DVSEC from uninitialized bytes in vconfig.

> How would a userspace opt-in? New kernel can change a capability visiblit=
y
> or virt and write permission of the bits inside a capability. Kernel
> cannot know if userspace used the capability or not. Creating a VFIO
> device in the new kernel by default results in a opt-in and currently
> there is no way for userspace to opt-out unless we add a new
> functionality where userspace can disable/enable features something
> similar to KVM capabilities.
>
> For now, I think we don't need to worry about it. As this version will
> be a base and if any serialized data with flags set received in this
> kernel will lead to erroring out restore.

We don't need an opt-in mechanism in this series. Detecting mismatches
is enough to make Live Update safe in both directions: if the next
kernel would emulate the device in an incompatible way, retrieve should
fail.

But an opt-in is needed to make rollback possible once vfio-pci starts
changing its emulation. I imagine something like a VFIO_DEVICE_FEATURE
that userspace can use to enable new emulation behavior right after
opening the device, with the enabled bits recorded in a field appended
to struct vfio_pci_core_device_ser behind a required flag. Devices that
don't opt in keep the baseline emulation and stay compatible with older
kernels. But that can come in a follow-on series.

> In the next version, I will not preserve pci_config_map. Hopefully,
> anyone changing VFIO code doesn't forget to update flags if they change
> capability or permission bits (I will write comments at appropriate
> places.)
>
> If we want to be very careful, we can do two things in this series:
>
> 1. Create a per bit valid mask for the vconfig and compare this between
>    new and old kernel during restore. In the new kernel, VFIO then takes
>    each bit from the preserved copy only where the mask says it was
>    valid, and keeps its own freshly initialized value elsewhere.
> 2. Create a hash or store virt and writable bits in config space.
>    Compare it with the new kernel.
>
> Both of the above combined will safeguard against forgotten flag update
> in the code.
>
> We don't have to do it but it safeguards against mistakes. Let me know
> what you prefer.

I think we should do both in this series, as two per-bit masks over
config space, preserved in place of pci_config_map:

 - virt[]: the bits whose value vfio-pci keeps in vconfig and returns
   instead of the device's value. This says which bits of the preserved
   vconfig are valid.

 - write[]: the bits whose writes take effect. For bits in virt they
   update vconfig, and for other bits they are forwarded to the device
   (possibly after validation). Writes to other bits are ignored.

The masks should describe what vfio-pci actually does rather than copy
perm->virt and perm->write.

vfio-pci can keep changing its implementation in ways that don't break
Live Update, e.g. start intercepting writes to a register to sanity
check them before forwarding them to the device.

Something like:

  struct vfio_pci_core_device_ser {
          ...
          u8 virt[PCI_CFG_SPACE_EXP_SIZE];
          u8 write[PCI_CFG_SPACE_EXP_SIZE];
          u8 vconfig[PCI_CFG_SPACE_EXP_SIZE];
  } __packed;


[ Note: I'd probably store virt[], write[], and vconfig[] on their
  own folios to avoid multi-order folio allocations, but I am embedding
  them here for simplicity. ]

The outgoing kernel computes virt[] and write[] through a helper in
vfio_pci_config.c and saves vconfig[] during freeze().

The incoming kernel computes its own virt[] and write[] masks and
requires both to match exactly with what's in vfio_pci_core_device_ser,
otherwise it fails the retrieve. On take-over it uses the preserved
value for bits in virt and its own freshly initialized value for the
rest, like your option 1.

I'd store the full masks rather than a hash, so that a mismatch can be
pinpointed.
