Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809980;
	b=2cUYjC91f/HQ3T15JApfloT5LEthmt4l5gF5x479a/oFq7J1w9iGlHiTRlMgpcc+JpvX
	 F74bvoQo7RjG1o2K1IvhWTdzjpts2wwhe7OBsJKBA2CfY7LlTnDFI3R0hnEccE9HJfHwZ
	 Tf1H5ppjOezNoTBEuRjl7s5HuMdZ8/2JNhdZhRgvbsCVBeKEOVECUZs5/ugrwrS4TKZEH
	 CNe4xCRW69KpGbF+1aufa4HQ3rwx0xCoLSFvqPTCrDwPLAvR+oFXSDsPbkhj4KLoyxiH/
	 aWOn/l//s51/PdiWk4X8U1kDq+pY/HdeXgKvSyxDf8zwx2KUuhnb+51DMMtnc9HIUOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809980;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qb2WFKlZgqsUyH8T4+nO5ZP9tYd2yloKMSgnPw3KZOQ=;
	b=aTJsgDmznNftNxZP4jlcyIR0uRRzgZkXu5RfKU5aJqGBwhrLQJaFzyvhP6/uwlq0Tt+H
	 YSuQdrkcePnEZyRfmDw8YRrn5Ef6o3tNeYeqAveFA4AP+s2LFOyQNQl0789skmsquw6Uj
	 A/n83Cp3pHIGoWob9AZmM/rF0u/QEclvbdU9ACFgFYq8HvF6DJPdJ/AOSIadwPxD/7x4n
	 7kq3W0UWZh1s8ydJWQGua5OO8vxL9FKZtjj29yC5tZQCQv639OF6G95xpNOEmdiIlSCar
	 MaPjDOu5E5Bpvh3kymXaATPYqRDC2ak7R9HOr7a7UQzzMr3ZW7CQO6WnfLQCkSmr92g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3b4XGg4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930F606A31B;
	Wed,  4 Nov 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3b4XGg4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998031F000C1;
	Wed,  4 Nov 2026 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809979;
	bh=qb2WFKlZgqsUyH8T4+nO5ZP9tYd2yloKMSgnPw3KZOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L3b4XGg4cIXjPIFn26VIa1dZGLo81odtlbJIP/eQOkI2sUf4U+fdgkNBks0F9vkfn
	 jna47/hYUwgEym35NMspZNn8hBNf6L/g1pWGjVTb5ThWs9I3kORYE6VF+Vu8D+aNzI
	 frxzqJSBaq/J1xzNzDZjSqq737aTdX8favRQbY/ShUiNMrqvuyPSdU3HTbyQzWX1sO
	 h+CmghBVaijtaTp2FsohSG7Df10xY7MR3eY/B/OyQQgBrFGSqs8WneblOPlP1GeW5E
	 6deE3iu3IzugaOOEuPvQ7kq1vOgMdYnYd7It5J7fgCKkAwok1ZLESQuzIZExHO7tlK
	 0Pjpz8139JnWw==
Message-ID: <sashiko-outbox-197622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/15] virt: coco: tsm: Complete PCI registration
 before publishing the device
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261104161632.3547423-4-aneesh.kumar@kernel.org>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:32:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] virt: coco: tsm: stale sysfs update and commit reference in comm=
it log
--

commit 5fae6df00051f68d8e86275946ecd6ac727fb344
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

virt: coco: tsm: Complete PCI registration before publishing the device

This commit moves PCI TSM registration ahead of device_add() in tsm_registe=
r()
so that a TSM device is not discoverable through class lookup while PCI
registration can still fail, and rolls back PCI registration if device_add()
fails.

>     virt: coco: tsm: Complete PCI registration before publishing the devi=
ce
>    =20
>     tsm_register() calls device_add() before initializing and validating =
the
>     PCI operations. This makes the new TSM discoverable through the class
>     lookup while PCI registration can still fail. This ordering was intro=
duced
>     by commit 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link
>     Encryption").
>    =20
>     An existing link TSM can keep the PCI connect attribute visible during
>     registration of another TSM. A concurrent write naming the new TSM can
>     therefore reach it through:
>    =20
>       connect_store()
>         find_tsm_dev()
>           class_find_device()
>         is_link_tsm()
>         pci_tsm_connect()
>    =20
>     If the new backend supplies both link and device security operations,
>     pci_tsm_register() rejects it before taking pci_tsm_rwsem. The regist=
ration
>     thread then follows:
>    =20
>       tsm_register()
>         tsm_register_pci()
>           pci_tsm_register() -> -EINVAL
>           tsm_dev->pci_ops =3D NULL
>         device_del()
>         put_tsm_dev() [cleanup guard]
>    =20
>     If connect has already attached a PCI context, its temporary device
>     reference does not protect the stored tsm_dev pointer after the call
>     returns. Registration cleanup can then free a TSM still referenced by
>     that context. The original tsm_register_pci_or_reset() error path also
>     had this problem: device_unregister() removed the class device and dr=
opped
>     its reference without tearing down an attached PCI context.
>    =20
>     Commit 37a73b0448ad ("tsm: Remove the device from lookup before PCI
>     teardown") subsequently added the unlocked pci_ops reset shown above.
>     That reset can also race with the connect path's accesses to pci_ops.
>    =20
>     Complete PCI registration before device_add() publishes the class dev=
ice.
>     On PCI registration failure, the TSM remains undiscoverable. If
>     device_add() fails instead, unregister the PCI operations to roll back
>     the counters and PCI sysfs visibility before releasing the device.
>    =20
>     With pci_ops initialized before device_add(), the class PCI attributes
>     are created with the correct visibility, so remove the subsequent sys=
fs
>     group update. Keep the PCI change notification after successful device
>     publication.
>    =20
>     Fixes: 3225f52cde56 ("PCI/TSM: Establish Secure Sessions and Link Enc=
ryption")
>     Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

[Severity: Medium]
Does the commit message match the actual changes in
drivers/virt/coco/tsm-core.c?

The final paragraph states that class PCI attributes are created with the
correct visibility and that a subsequent sysfs group update is removed.
However, in drivers/virt/coco/tsm-core.c, tsm_class only defines .name and
.dev_release without any class PCI attributes or attribute groups:

static const struct class tsm_class =3D {
	.name		=3D "tsm",
	.dev_release	=3D tsm_release
};

Neither tsm_register_pci() nor tsm_register() contained or removed a
sysfs_update_group() call; the patch only reorders tsm_register_pci() before
device_add(), adds pci_tsm_unregister() on the device_add() error path, and
moves kobject_uevent(&dev->kobj, KOBJ_CHANGE) from tsm_register_pci() into
tsm_register() after device_add().

Also, the commit message references commit 37a73b0448ad ("tsm: Remove the
device from lookup before PCI teardown"), which does not exist in the commit
history because the preceding commit in the series is 2ae926219f58 ("virt:
coco: tsm: Remove the device from lookup before PCI teardown"). Could the
commit message be updated to remove the stale sysfs group description and
reference the right commit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161632.3547=
423-1-aneesh.kumar@kernel.org?part=3D3
