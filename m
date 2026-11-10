Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296125;
	b=sdzDrOEFVWn8M2n00hcYR65rAc3x78p1WbbqswItlddSFk2aQWUfwJg4rUX9fMokF5T6
	 SWTcfCzoIrq64fKG0nJHl3FCQ+8Kokt4UsqliuTaBMfBrStpARmfcuRfx6tIsu3GE7qUo
	 YMmu3Y3OWrVoLAT+VN3KNJtD6+WYF9S7peFLo/G9owVuThpPJrtvxxbmNjc/CNs3M/CUy
	 9tkYOBrUKA3KGx5eN1Tm55dd5DR8PZDk+LJbUi3KwXovwPrWpa99eeTgFy4FBl4srqRnb
	 z43EqacDg9nI6xN/ENhsKCz7It6K8XRuCXwRyjcbLiHI8nJPyr22kaIRXqPP8AqRdyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296125;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EtudwXeX/jnHK+VqfMNs78uykQjRvCRX9VZ4FlgDiuQ=;
	b=iVk+vfke6FjZybfGE+BkWxEQs3i+X8Nerx7q6u7ft3ts+ZWhkS7yiHJysXuhiZltCOo7
	 4iypyAAzgts8Zb1Wq4m6n5n3BBa5Y7AB1MIrvQZPE2VKI3nFylXpDewVAI+uSmEpQcMtb
	 8OPk9RpGicKSk/r6l+e64Chzg2QTK+PDiYRHFu5aYHLfdRpooTeILEWlD8KepVsky4u6+
	 kVs2K7rC2/yzFN+hqAqDFgHOuEpcfLiIL96hmDk6yc8Pxih8cZSFJrUCNj65jQSi9VPXF
	 /KzsbdEi9Bx8zk6wM0ruLgo0B69w96QMVf4ZRUklf+O0wvLdNepO2Gu7Jkz+dQULf0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EM0pAkjL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D060A5BC2;
	Tue, 10 Nov 2026 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EM0pAkjL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9774C1F008A2;
	Tue, 10 Nov 2026 07:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296124;
	bh=EtudwXeX/jnHK+VqfMNs78uykQjRvCRX9VZ4FlgDiuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EM0pAkjLOd1/mnJM1Yj/CuqkJ+PynbKhMTF4VvKklLxBCWsUdmOCuRFZ34w2Q6mjs
	 cLn6a7H9yUiW2o8g+pT4sPAqMquLapkPgsSgvZiy8dvQZy/RuZ0c/mpw0+2fxXe05N
	 YUR79iq9Pk0N7erAJyXuLdrAMxkDElvGIwSdxG641kyaKP/3CfGne0DyE8+99CMm6n
	 uvHloJfmHpT9fSytCKVSF9qI7sSRP9MFH3snNPPIrc1+LxmnVMzzqhVOJm1qJhRE3C
	 yhr2XpuvYchdnAo68hdJarAY5M6D/odOec62po9lOOC5PBzrfDaOAKv6/nFtsZKym2
	 NI8Q3rwDwIL9A==
Message-ID: <sashiko-outbox-206516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/19] driver core: Cover trust authorization and
 binding with KUnit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109-device-trust-core-v2-16-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-16-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] driver core: unskipped driver boot rules in device-trust-full
  KUnit tests
--

commit 8b5fffad66e1e6c0223d2943cea1b5d209f585ac
Author: Leon Romanovsky <leon@kernel.org>

driver core: Cover trust authorization and binding with KUnit

This commit adds KUnit test suites covering device trust policy parsing,
authorization, driver binding, and full-only manual attachment.

> diff --git a/drivers/base/test/device-trust-test.c b/drivers/base/test/de=
vice-trust-test.c
> new file mode 100644
> index 0000000000000..b6ad3b0c1b536
> --- /dev/null
> +++ b/drivers/base/test/device-trust-test.c

[ ... ]

> +static void device_trust_full_boot_policy_test(struct kunit *test)
> +{
> +#if IS_BUILTIN(CONFIG_DM_KUNIT_TEST)
> +	struct device_trust_test_context *ctx;
> +	enum device_trust_policy policy;
> +	bool allowed;
> +	int ret;
> +
> +	ctx =3D device_trust_full_test_register(test, &device_trust_test_plain_=
bus, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +	policy =3D ctx->dev.trust_policy;
> +	allowed =3D device_trust_test_global_full(test) &&
> +		(policy =3D=3D DEVICE_TRUST_POLICY_DEFAULT || policy =3D=3D DEVICE_TRU=
ST_POLICY_FULL) &&
> +		(!device_trust_full_test_driver_rules(test) ||
> +		 ctx->dev.p->trust_policy_override);
> +
> +	ret =3D device_driver_attach_full(&ctx->drv, &ctx->dev);
> +	KUNIT_ASSERT_EQ(test, ret, allowed ? 0 : -EPERM);
> +	KUNIT_EXPECT_EQ(test, device_is_bound(&ctx->dev), allowed);
> +	KUNIT_EXPECT_EQ(test, ctx->probe_count, allowed ? 1 : 0);
> +	KUNIT_EXPECT_EQ(test, ctx->configure_count, 0);
> +	KUNIT_EXPECT_EQ(test, ctx->dev.trust_policy, policy);
> +	KUNIT_EXPECT_EQ(test, device_get_trust_level(&ctx->dev),
> +			allowed ? DEVICE_TRUST_FULL : DEVICE_TRUST_DISABLED);
> +	KUNIT_EXPECT_EQ(test, device_get_committed_trust_level(&ctx->dev),
> +			allowed ? DEVICE_TRUST_FULL : DEVICE_TRUST_DISABLED);
> +	if (!allowed)
> +		KUNIT_EXPECT_PTR_EQ(test, ctx->dev.driver, NULL);
> +#else
> +	kunit_skip(test, "boot policy coverage requires built-in tests");
> +#endif
> +}
> +
> +static void device_trust_full_attach_test(struct kunit *test)
> +{
> +	struct device_trust_test_context *ctx;
> +	struct device *parent;
> +	int ret;
> +
> +	if (!device_trust_test_global_full(test))
> +		kunit_skip(test, "requires device_trust.default=3Dfull");
> +	parent =3D root_device_register(test->name);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
> +	ret =3D kunit_add_action_or_reset(test,
> +					device_trust_test_parent_unregister, parent);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	ctx =3D device_trust_full_test_register(test, &device_trust_test_plain_=
bus, parent);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	device_lock(parent);
> +	device_lock(&ctx->dev);
> +	ret =3D device_driver_attach_full(&ctx->drv, &ctx->dev);
> +	device_unlock(&ctx->dev);
> +	device_unlock(parent);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[ ... ]

> +static void device_trust_full_probe_failure_test(struct kunit *test)
> +{
> +	static const int errors[] =3D { -EIO, -EPROBE_DEFER };
> +	static const int expected[] =3D { -EIO, -EAGAIN };
> +	struct device_trust_test_context *ctx;
> +	int i;
> +
> +	if (!device_trust_test_global_full(test))
> +		kunit_skip(test, "requires device_trust.default=3Dfull");
> +	ctx =3D device_trust_full_test_register(test, &device_trust_test_plain_=
bus, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +	ctx->drv.probe =3D device_trust_full_test_probe;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(errors); i++) {
> +		ctx->probe_ret =3D errors[i];
> +		KUNIT_ASSERT_EQ(test, device_driver_attach_full(&ctx->drv, &ctx->dev),
> +				expected[i]);

[Severity: Low]
Should device_trust_full_attach_test() and
device_trust_full_probe_failure_test() also skip when device_trust.driver=3D
boot rules disallow full attachment?

Unlike device_trust_full_boot_policy_test(), both tests only check
device_trust_test_global_full(), which inspects device_trust_init() on a
stub device.  When the kernel is booted with both device_trust.default=3Dfu=
ll
and a device_trust.driver=3D rule, device_trust_prepare_full() rejects the
unoverridden test device with -EPERM, causing the device_driver_attach_full=
()
assertions in both tests to fail instead of skipping.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D16
