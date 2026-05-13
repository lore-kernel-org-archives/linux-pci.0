Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57436A03B
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704096; cv=none; b=S08jNYgzjUEYClyga+obg5jL33uwaWgipYlsvmIiORYwHlnmPuArQBxgn1eFpfJSw2r/wOMTXcGatGIM6LUjkB4u7I+7ykR0vj8KWSqtqxQhJ/lCV8D4XbiZh8VXFjGiIXo5IZKLmDOe64Oey1xxINH5//piNh6u1Mu71H8IdJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704096; c=relaxed/simple;
	bh=7jcX3rkjLPtPOHeK9kz3zJ+5nh1FhELcCL/ofnAuCK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EonzVHqIykLg9EXh7teeqRDg/eqHauEgVj3ef/8Lkm8+WwBehX0s6Q4f5FX+Cl7QcYQ50NHa8+nAUXz7L+llR73G7g3JPRhK7nkBLRMS4wMHJgQoNEJ6S922U4gCoAmInCHBh2rxbj4fxU4pkwR75gasC8ffjU3/mXxYOkgQiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLQEiqL3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLQEiqL3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097ADC19425;
	Wed, 13 May 2026 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778704096;
	bh=7jcX3rkjLPtPOHeK9kz3zJ+5nh1FhELcCL/ofnAuCK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lLQEiqL3qTDx0DcXj10SdfwucxRC45xBYZk2ZLT+47lt1t0+Y/sdTOZpuh0o9z8/a
	 7wfe5mrStgdtviMoV5m32dR0WFS8KGajTVShmLwh0EO+21n+C3NINAHMtfnls5xEXR
	 75kZ7rw4bmM21TBXamCYTuwJMXPO1f8FTbtrRv85JpqHdpV16UMdAJhb47eWJ+/h5T
	 uPJn8VZ/JxlqZmmIDAGJmQQTOu6n4ei7pmWCPeVD43pFB1pYoc9r6+8nnssniLWGZd
	 ccoVLQ6RR2z4Kvhkx2imD2KYSm+jLIPHxWF5d68UgyVSAj3tTj1JaB1hepdsvFby9G
	 R7Yxx9YrAWRjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/16] vfio: selftests: Build liveupdate library in
 VFIO selftests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511234802.2280368-9-vipinsh@google.com>
References: <20260511234802.2280368-9-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 20:28:15 +0000
Message-Id: <20260513202816.097ADC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The VFIO selftest Makefile includes `../liveupdate/lib/libliveupdat=
e.mk`, which does not exist, causing a build failure and leaving `LIBLIVEUP=
DATE_O` undefined.
--

commit d3eae23e3b6d5e95208bbaa8caae8ddebad58cb5
Author: Vipin Sharma <vipinsh@google.com>

vfio: selftests: Build liveupdate library in VFIO selftests

Import and build the liveupdate selftest library in VFIO selftests to allow
using liveupdate ioctls.

> diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selfte=
sts/vfio/Makefile
> index 0684932d91bfc..7865b2aa011c3 100644
> --- a/tools/testing/selftests/vfio/Makefile
> +++ b/tools/testing/selftests/vfio/Makefile
> @@ -20,6 +20,7 @@ TEST_FILES +=3D scripts/setup.sh
> =20
>  include ../lib.mk
>  include lib/libvfio.mk
> +include ../liveupdate/lib/libliveupdate.mk

Is it possible this file is missing from the tree?

Neither the lib directory nor the libliveupdate.mk file appear to exist und=
er
tools/testing/selftests/liveupdate/. This will cause a build failure since
make requires the included file to be present.

> =20
>  CFLAGS +=3D -I$(top_srcdir)/tools/include
>  CFLAGS +=3D -MD
> @@ -27,11 +28,15 @@ CFLAGS +=3D $(EXTRA_CFLAGS)
> =20
>  LDFLAGS +=3D -pthread
> =20
> -$(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
> -	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
> +LIBS_O :=3D $(LIBVFIO_O)
> +LIBS_O +=3D $(LIBLIVEUPDATE_O)

Since the libliveupdate.mk inclusion fails, LIBLIVEUPDATE_O remains undefin=
ed
here. Does this also cause missing object files during linking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511234802.2280=
368-1-vipinsh@google.com?part=3D8
