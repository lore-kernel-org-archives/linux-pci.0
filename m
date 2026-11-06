Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985573;
	b=caVefpiWvibdFITxZxUNxlqlC+tUj+z5XJJ1wZrbJci6R+s5zE8VZG7dFc+bZRe78jmo
	 dIkAFm6vHJBYEuF9Lx0AVEMaJJ07VIp9SMQ0/maNhGxptiCFO7myZhlPZK8DQB9uu4I/p
	 jRcVjUZ3l/lwgjl5jRy6iwxmqCcjDAw8ihHtxBcfEtpOwtqZM2SV3w++hx//P3tblb6gb
	 434jsSzeZMct5Bs6AkZFXC6Prolz5Grx/ktFWbM6onrdB06udoEFKz6OgatTr+ZPtVmjf
	 iK/6Jce+xcSfsFChT9Mm3EH1bOeoC9q06W/nsZjDnfGeJf/bq20zi+ngRvPmZFkox1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=tEaeh2MQM8Yqh+InUxWcP/c3Ugn8r1gCgilB/e+XZTU=;
	b=T7/xooTIO4MfJ55ytv+h/gnKscnoD4NHkCu5Brdd8XHpSxOabaXHHFc1KaFrCoRjVWye
	 RQnHY1MRfK0RitvgrZCENGVSxo8KjRfEx5ujZK+V+RgHNzcP+RIxmGhc3wmps8Fi5gIA4
	 qhm/hBXtlLphfm8fuMHK3/xUvt3WqzCqFRfst6jZSJStisdfJVNsIILTcY+6+0zlD09Xp
	 0cGTu0rU08TRiNooGQtm8hq5F11L9ISOktPQRh6muxVyS+tT86GLXsQHzLk+Ufrc0s7ZE
	 ABnAWanqqNsTfORex8B35imOLXmMI5CUF+rVMHzCf3ARSSKPtIUl9uQEEoejwcdmd3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V3vuG2QG;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8E606A32F
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A8E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V3vuG2QG
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so551631a91.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 09:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985572; x=1794590372; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tEaeh2MQM8Yqh+InUxWcP/c3Ugn8r1gCgilB/e+XZTU=;
        b=V3vuG2QGjhL8r2VuA4Y+96OnzymPavm7o7EgEyvr170YdIQ6DRl7oV53qhL1GcFHq9
         pAuFDTumBKjC04cfsqiF/s9mzLQ7MxMB33+iWjjD6M/c6YfzXCbLDc+N7vG+f5wRPHnt
         YGfusFO0BTgDqxJC3GAGWNZSjKJIGzOR0waqOm65uqs4mfbkFPtcjPreR4HJO5uzAwIM
         aZJqv3Eu06A17GOsAL38uxdtzasGV3QnNWGft1JdKGB0XYClaHm6eqK5tjUpWsaDDnGv
         L3j4WwyzVfe0Q7LrBT5u/+m8/nbkT0KO2eRt94r5hQOTgl8rRxeGomxzWEId9K33GS3u
         IwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985572; x=1794590372;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tEaeh2MQM8Yqh+InUxWcP/c3Ugn8r1gCgilB/e+XZTU=;
        b=X4Hau1ZBL+AZaoex8mGph+EnsJspNPZLTZ0a/XVkoIQM51w1MM987zx54ODnFdy/nw
         kw4/mHs1Ji8cyTJmSWFlRCJbK7dtHZjole8FRVwkRnRl8+QHBAKay9Fn1c+s4eE+I5AW
         m2zM/uhRJhexGT3uC35EzXNp54aadmaGvd9Xh2ytwKhuBFrlTNM36SP3olJcoFIJmkxL
         fWXku7r0m5jZWbdzvRMR/leOKB56IiYo0vNZF3yV0qAjwkD12xDVhPHnPtc6nJruMEBK
         DgcNSQHrS4o3y5qQUHivK+BLO5rH2MMCydVQeLKndqPwJUptDYEzQzKebVisenoyYRD7
         wGFA==
X-Forwarded-Encrypted: i=1; AL+hErFIMsoNdpcfmgSoyYtyNjOo8wFvcsZBLgK8ldFyx3MByiKf82uw+XSEfHSrn2224ydAC/KO8ljeF6w=@vger.kernel.org
X-Gm-Message-State: APuU4Z972x8raBMe4KPuN4qye8SejMVVve4ziRFDGTDWgpblinsKwkvV
	1VPZJP97sk0LneKMfIpHtKvptesqJjNFtf8psyaAbdKmLrlLIOdXvy+2vxlmJnFlhw==
X-Gm-Gg: AYBFou0qkDv6XDMBd1nRq6O+xlFiU1rahiZb/0vZHqmwLtk4i4hX7UMr9fZvKeNN31U
	vPneCHzSdN1DHVnZRWc0+ecr7H53SlCyi4bq5lnP7OgFoU8oRufVUYmFxOXdwzjv/lOiZyf/C4Q
	L7ksJSNZNcxF/KyXPi6FSSAQy4dmgiZfaH+HnzQwNUu9HThrP28X/RpdRpPORPcW9aMQylW+mJE
	JbNe2omij6rtd4Iq/3DpU6nLkzjDc2LPwJDE7Io3fdb/ZmiV3NVVebnmZhu2KkNW2kPW4mE6mr8
	1lMzFC13g/EPW7dIGY+Gmbc3XbYn1r2CqEOJzGGn8qtBcDApJ/C41vrBlgc7QMLI+BwyVoRb8NO
	o6lWYUU38ldBjR/qxgQF9MQ+pvLAPyiRkjNbheoLA/6T2FB3A2eOVPyPq2e5O3qGEinoX5uBooI
	uvgEGurWxc/tw/7dpLKftxZSXNBe1Uym4FM8X3rfltoQMEgy72LNW7VGEygJk83vf6VFyTQkyGi
	O4XPW0EnScqUDVC33svsRCMtd4t/LFUU84Nwz1ThuvGuCGCtDtfEPtmklu5Q6Bory8SMl0PPFNd
	wunaRCQW2Wk6ZHfl5jVCKafhbNAtd9BTUAjoXzubA8JG/y6pnNzIDbaQIt0oMRo3
X-Received: by 2002:a17:90b:554d:b0:3ac:bfa7:b079 with SMTP id 98e67ed59e1d1-3b0db5edb73mr3411640a91.7.1793985571464;
        Fri, 06 Nov 2026 09:19:31 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm795231a12.25.2026.11.06.09.19.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:19:29 -0800 (PST)
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
Date: Fri, 06 Nov 2026 17:19:28 +0000
Message-Id: <DMOAT4VV939P.2DI8CEOMMSKMY@google.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>
Cc: <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <dmatlack@google.com>, <graf@amazon.com>, <jacob.pan@linux.microsoft.com>,
 <jgg@nvidia.com>, <jgg@ziepe.ca>, <jrhilke@google.com>,
 <julianr@linux.ibm.com>, <kees@kernel.org>, <kevin.tian@intel.com>,
 <leon@kernel.org>, <leonro@nvidia.com>, <lukas@wunner.de>,
 <mattev@meta.com>, <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
In-Reply-To: <20261102153656.1431701-12-vipinsh@google.com>

On Mon Nov 2, 2026 at 3:36 PM UTC, Vipin Sharma wrote:
> During retrieve():
>  * Validate the handed-over struct vfio_pci_core_device_ser header,
>    sizes, and flags.
>  * Locate the registered vfio-pci device matching the serialized domain
>    and BDF (requiring device->ops =3D=3D &vfio_pci_ops) under the device
>    lock. vfio-pci registers the vfio device before its probe completes,
>    and the probe holds that lock, so a device that is still being probed
>    is not returned.
[...]
>  * Open and return an anonymous VFIO cdev file via
>    vfio_device_liveupdate_cdev_open().

Here's an idea for how the device file could be created on retrieve,
which I'd like to hear your thoughts on.

The patches from Pasha at [1] lets userspace pass a
file-handler-specific argument to LIVEUPDATE_SESSION_RETRIEVE_FD. In the
next version of the tmpfs series, I'm planning to use that to have
userspace create the file and pass it in the argument, and the kernel
then restores the preserved file into it.

I wonder if VFIO should work the same way, e.g.:

  struct liveupdate_vfio_retrieve_arg {
          __u32 size;
          __s32 fd;
  };

Userspace would open /dev/vfio/devices/noiommu-vfioX itself and pass
the fd. retrieve() would check that it's an unbound vfio-pci cdev file
for the preserved device (domain/BDF, noiommu, incoming, cfg_size),
attach the incoming state to that file, and LUO would track that file
as the retrieved file. VFIO_DEVICE_BIND_IOMMUFD would then take over the
device as it does now. Since VFIO preservation is new, the argument
could simply be required.

I think this could get rid of some of the special handling:

 - There'd be no need to fake a cdev open with an anonymous inode, so
   PATCH 09 and PATCH 10 could probably be dropped.

 - retrieve() wouldn't need to look up the device by BDF, or reason
   about racing with probe under the device lock. If userspace was able
   to open the cdev, the device is registered and probed.

 - The device file would be opened through the normal cdev path, so the
   usual permission and LSM checks on the device node would apply.

 - It would be the same model across file types.

A few things I think would need care if you go this way. The file check
and the attach would need to happen under dev_set->lock so they can't
race with a concurrent VFIO_DEVICE_BIND_IOMMUFD on the same fd. And the
incoming state should probably be tied to that specific
vfio_device_file rather than just the vdev, so only the file passed to
RETRIEVE_FD can take over the device.

It would also change PATCH 12. Opening the cdev of an incoming device
would have to succeed, so the check would move to the first open of the
device instead: fail with -EBUSY if the device is incoming and the file
being bound doesn't have the incoming state attached. That one check in
vfio-pci would also cover VFIO_GROUP_GET_DEVICE_FD, which opens the
device right away, so vfio_liveupdate_incoming_is_preserved() and its
dev_is_pci() special case could be dropped from the VFIO core.

The next tmpfs version will also add a way for a file handler to say a
failed retrieve can be retried, and a helper to claim an existing file
before restoring into it (so a file LUO already manages, e.g. one that
is preserved in an outgoing session, is rejected). Both seem useful
here too, e.g. so that a mistake in the argument (wrong fd, an fd for
another device, an already bound fd) doesn't make the device
unretrievable. I'll Cc you when I send it, and I'm happy to share the
branch before then.

What do you think?

[1] https://lore.kernel.org/kexec/20261103010216.3447716-1-dmatlack@google.=
com/
