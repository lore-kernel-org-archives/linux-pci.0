Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116584;
	b=fO6A62I5AL2rj76DJMlXABZI0oeIXAYgRLjl7Sbm+40uLet8p/WNjwA/EsuZlQJGKofJ
	 0acT+w8eJsBheK3841keqOLvqKnwZDibdrEcdMh8jkBsetTHtj3i6PCGrJgm2EZAxjby8
	 H0X+iGSHAdNbpq0/j7f1rl4VUiDQO0fhWtxcuK0NGCZsuxzedKN61D9aI/xzeVN6GSYPO
	 KesSFv3j5T4yUeWsPirO54OtH+eDfqpz6qR1exJRS+qA9p5gRj4Lzg+2C/rGOWe1KQ7H/
	 X/OTekLdv5WgrVoibwCTWXjA2B2sxllabtlgLTI5ALpvz/mXCkzOwEnb9YZOHK/0z9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yMZGrqYjtsgs4p7zSNtV3Ee9xxbVLiFYVPuO058wK6A=;
	b=2smOOj1AGPsSfAle5+uPJ+ITAicBgYOemAwDk93YlCY7v3iDRI3Y9P1KALnmWbRRhzEU
	 bT9vTFcaAvLp5YtF9+jmJXc1ozoMkhrx+KN5Oz/OLNxHobGoO5fCapJl66PtnwPpuCK9M
	 OAqVKuaaTsoxPBtLcuDXSxn6zr/8NiwKnQPtJ3iiPe4C4rBpz7pIzPGnkwRn5Zbqu8PHS
	 6iwwuLRerjQnUUtu7R6JIKe1VggK+t2Zl2gZeZr4SNQLN1GDANsHwzTUwv5yH1LXzyUJM
	 4YqXHdh4j5eQFV9o+rgMlvndyM8aHQi7UuYRslJHeP33Nb7JCfgBi44YNmScifyoQqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAii8sRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F660A5BDD;
	Thu, 19 Nov 2026 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAii8sRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B561F000C8;
	Thu, 19 Nov 2026 19:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116583;
	bh=yMZGrqYjtsgs4p7zSNtV3Ee9xxbVLiFYVPuO058wK6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAii8sRLYhcrkFQglf9ex0aoSdbRNE6RXwKHU+ZlmpdgoxOZ8KpX+ETyEM1cmKxe6
	 lZrcaaTsQI6zPyM7LEVlUfC3fnncpNa/8+T5efsj68jXONJvJcPNrWS9xJ3QYInToh
	 lM179nERxsqgi305AnyF1xs4m/WrocoXZDKmfQNAleJp5U45EmYo9q/oaPqEQH0yun
	 8tdppD35bDiob+WM4Q/KuQ7im5RNvARzRjacuOD07eH9QrAWASbu2yQTlmKct9Igo4
	 nv2/MMEXqvzp9QT/p+GgO3oTWhRqxu5LykqQc/KeyGxvP2x6c5eFMqVa7SXDciKsUl
	 byn3yJGteXdow==
Message-ID: <sashiko-outbox-223910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/31] driver core: Cover trust authorization and
 binding with KUnit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118-device-trust-core-v3-24-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-24-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] driver core: unawaited kobject release in
  device_trust_no_iommu_bind_test()
- [Low] driver core: unexported device_trust_attr_group used in modular
  KUnit test
--

commit dfca1229adeb2c0936d6f6bd4451a35161f0f99d
Author: Leon Romanovsky <leon@kernel.org>

driver core: Cover trust authorization and binding with KUnit

This commit adds KUnit test suites covering device trust authorization,
driver binding serialization, and boot policy precedence.

> diff --git a/drivers/base/test/device-trust-test.c b/drivers/base/test/de=
vice-trust-test.c
> new file mode 100644
> index 0000000000000..c78eec9424f4f
> --- /dev/null
> +++ b/drivers/base/test/device-trust-test.c
> @@ -0,0 +1,2461 @@

[ ... ]

> +static void device_trust_test_sysfs_release(struct kobject *kobj)
> +{
> +	const struct device_trust_test_sysfs *sysfs =3D
> +		container_of(kobj->ktype, struct device_trust_test_sysfs, type);
> +	const struct kobj_type *original =3D sysfs->original;
> +
> +	kobj->ktype =3D original;
> +	kfree(sysfs);
> +	original->release(kobj);
> +}
> +
> +static int device_trust_test_isolate_sysfs(struct device *dev)
> +{
> +	struct device_trust_test_sysfs *sysfs;
> +
> +	sysfs =3D kzalloc_obj(*sysfs);
> +	if (!sysfs)
> +		return -ENOMEM;
> +	sysfs->original =3D dev->kobj.ktype;
> +	sysfs->type =3D *sysfs->original;
> +	sysfs->ops =3D *sysfs->original->sysfs_ops;
> +	sysfs->ops.store =3D device_trust_test_sysfs_store;
> +	sysfs->type.sysfs_ops =3D &sysfs->ops;
> +	sysfs->type.release =3D device_trust_test_sysfs_release;
> +	dev->kobj.ktype =3D &sysfs->type;
> +	return 0;
> +}

[ ... ]

> +static void device_trust_no_iommu_bind_test(struct kunit *test)
> +{
> +	struct platform_device *pdev;
> +	struct platform_driver *drv;
> +
> +	drv =3D kunit_kzalloc(test, sizeof(*drv), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, drv);
> +	drv->driver.name =3D test->name;
> +	drv->driver.probe_type =3D PROBE_FORCE_SYNCHRONOUS;
> +	drv->driver.suppress_bind_attrs =3D true;
> +	drv->probe =3D device_trust_platform_probe;
> +	pdev =3D kunit_platform_device_alloc(test, test->name, PLATFORM_DEVID_N=
ONE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
> +	KUNIT_ASSERT_EQ(test, device_trust_test_isolate_sysfs(&pdev->dev), 0);
> +	KUNIT_ASSERT_EQ(test, device_set_driver_override(&pdev->dev, "none"), 0=
);
> +	pdev->dev.trust_policy =3D DEVICE_TRUST_POLICY_BLOCKED;
> +	KUNIT_ASSERT_EQ(test, kunit_platform_device_add(test, pdev), 0);

[Severity: Medium]
Can device_trust_test_sysfs_release() run after the test module is
unloaded?

device_trust_test_isolate_sysfs() sets pdev->dev.kobj.ktype->release to
device_trust_test_sysfs_release().  Unlike
device_trust_test_device_unregister(), kunit_platform_device_add()'s
teardown calls platform_device_unregister(pdev) without waiting for the
kobject release callback to finish.  When CONFIG_DM_KUNIT_TEST=3Dm and
kobject release is delayed (for example, under
CONFIG_DEBUG_KOBJECT_RELEASE=3Dy), unloading the module allows
kobject_delayed_cleanup() to call into unmapped module memory.

[ ... ]

> +static bool device_trust_unrestricted_test_boot_rules(struct kunit *test,
> +						      bool *driver_rules,
> +						      enum device_trust_policy *default_policy)
> +{
> +#if IS_BUILTIN(CONFIG_DM_KUNIT_TEST)
> +	return device_trust_test_parse_boot_rules(test, saved_command_line,
> +						  driver_rules, default_policy);
> +#else
> +	kunit_skip(test, "boot policy coverage requires built-in tests");
> +	return false;
> +#endif
> +}

[ ... ]

> +static void device_trust_sysfs_boot_policy_test(struct kunit *test)
> +{
> +	struct device_trust_test_context *ctx;
> +	struct device_attribute *attr =3D NULL;
> +	struct attribute **attrs;
> +	enum device_trust_policy policy, target, default_policy;
> +	const char *value;
> +	bool configured, driver_rules, allowed, override;
> +	ssize_t ret;
> +
> +	configured =3D device_trust_unrestricted_test_boot_rules(test, &driver_=
rules,
> +							     &default_policy);
> +	ctx =3D device_trust_unrestricted_test_register(test, &device_trust_tes=
t_plain_bus, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +	policy =3D ctx->dev.trust_policy;
> +	override =3D ctx->dev.p->trust_policy_override;
> +	for (attrs =3D device_trust_attr_group.attrs; *attrs; attrs++) {

[Severity: Low]
Can referencing device_trust_attr_group fail modpost when
CONFIG_DM_KUNIT_TEST=3Dm?

device_trust_attr_group in drivers/base/trust.c is not exported with
EXPORT_SYMBOL_IF_KUNIT().  When CONFIG_DM_KUNIT_TEST=3Dm, avoiding an
undefined symbol reference here relies on the compiler inlining
device_trust_unrestricted_test_boot_rules() and eliminating the code after
kunit_skip().  Either exporting device_trust_attr_group with
EXPORT_SYMBOL_IF_KUNIT() or guarding device_trust_sysfs_boot_policy_test()
with #if IS_BUILTIN(CONFIG_DM_KUNIT_TEST) (like
device_trust_unrestricted_boot_policy_test()) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D24
