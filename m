Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E631AF2D;
	Thu,  2 Jul 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007709; cv=none; b=IdYSV8cdW0cP05w3l3YL74wuxkSRcpZ3r9IcevjX4awaA1n9p+7rpazdTrqpqiftOSZIwbM3VnqwrR/6T0mMtkpe7FBUoPuY/I8BuJC5erbMN1C6eMYXdMk9y9G3xC4/IQ66NQEoQqw0U9WoGKn4T5h8qpHRvX+UEG+mTIrBPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007709; c=relaxed/simple;
	bh=b2FoS1WU3V+E9qG7HlreOa3MaaAEncF5cvMCzetqeEg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cyj/GqT48WUvx6LWTVBBcBFpIoCfTP2vI7Bz2T/XJe2lFjnUQg9nz5vg7Yi7oXMpTfKeoLt0I4+j2wSpuReWF68HKgO1FEl53+/EuVlO8mqLWQhFsnIIwdeJm87QWHkbeAdz7OWTnFcJuwHUBN9CywpMzrSVaOUKIjFa2OdG8V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbz0Eazb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbz0Eazb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CD01F00A3A;
	Thu,  2 Jul 2026 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783007708;
	bh=b2FoS1WU3V+E9qG7HlreOa3MaaAEncF5cvMCzetqeEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bbz0EazbDQjj8A928aixBobU49tx4UIV9tED6uFWIaqXtIC6AivdD1/dbir4mKuCS
	 KS8VpkAE75R2Af83m/fyDjBcnVM7B7WG0vvTvAfvJljPquq5OtTvGnXAeZAoRPsZeR
	 AL9TSBZS6L6i7E4tdlqvSeTDW5RJOD9Kntav6JzLYP8KipNYencLkIkioAMBX3i4n4
	 7dXP0X1VvtT5Kj5XwAxGpvmB5j5hAwk5Mp6GiIHDPx3hncsZok2r/KRq41m5/a5W1p
	 t0YsOcfT9UKQx33SOEXPPpPj1S/Cd/TfnWM0nwNXwLaBJ4Q0/i1jG25aikhPrnohev
	 i8wKHbtgu2wcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] cpu: Use sysfs_emit() for cpumask show
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-perf-users@vger.kernel.org, neil.armstrong@linaro.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260702154725.185376-5-ynorov@nvidia.com>
References: <20260702154725.185376-1-ynorov@nvidia.com>
 <20260702154725.185376-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:55:07 +0000
Message-Id: <20260702155507.D0CD01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> show_cpus_attr() is a sysfs show callback. Use sysfs_emit() and
> cpumask_pr_args() to emit the mask.
>=20
> This prepares for removing cpumap_print_to_pagebuf().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702154725.1853=
76-1-ynorov@nvidia.com?part=3D4

