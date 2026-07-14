Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288A435532
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057427; cv=none; b=FiPvh9Y8noDQ3/Zby4K7OFQlVcE7xTacZmoJdOsnvjZjsWRXoEAeTXIhqQDPu1hFpoNLPxg1d7/DRrKdz7imx0PN+jWnfZ4RcNPHLYpUyFASu8VR6ROQJTdByv/3C64QiPAJxDo3WoBgYrM2teik1qJ7zMFbkMuymns+5mF4W6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057427; c=relaxed/simple;
	bh=AitlDq/f8K5mzAUIlfZDHddh262j/H1IFptmFvifWV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cC4TwqtKRuWLbCVgJaLZhmXkQe27R7WWka29kApkJXCiVuKpsWHUyErT22xCNkQkN5gjR/hMQ7vsYwkL/NF6xDpLcI0NbM6I5qDWP8iOqQZsiiutGaLTqjsr566+SzTTZo/CWkBe7HVJCg1dl/LP37S79LF+rM99/xVbO4PcfyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltFyYkNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltFyYkNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E4E1F000E9;
	Tue, 14 Jul 2026 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784057426;
	bh=AitlDq/f8K5mzAUIlfZDHddh262j/H1IFptmFvifWV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltFyYkNHATgrkn8vf2O9zKaICd3gvqNlOLC13kFGAGWhgkP3F4hJ4vBqvOoZ20zsW
	 3TRP9mMjoSz2fQb3sS8iFfi7N41UFjYPLFF1jcQOkdE51E7WD5x9uxYGQSrrstVgUs
	 1s2Ny2s+cm3Sc8xSWNgdHJx148TKP7fgAaIPKK5kiBEDXBsLMmHselBkhKbu9+BOn5
	 MDpea0+3gnvr0YJVhJUNoaFQuH7zVdoji3O4tN5ImeuEGxKedZWN9nQgka3D/2TZde
	 dUMIqQdqJiu+sqDCiSZ+RzURL7rKdpW0VyrLWnxtWRlTW+/MxDhXB8A/i5+opq/Bzx
	 DLwD4OnXAv2wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] i2c: acpi: Convert to use
 acpi_dev_is_video_device() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714185915.865396-5-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:30:25 +0000
Message-Id: <20260714193026.28E4E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace open coded variant of acpi_dev_is_video_device() helper.
>=20
> Acked-by: Wolfram Sang <wsa@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714185915.8653=
96-1-andriy.shevchenko@linux.intel.com?part=3D4

