Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707F42A178;
	Wed,  8 Jul 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507714; cv=none; b=JL5J0fSlNZoYPh6vwWR0GH5xZgslFOMmVvcUsQ/RZINeyUw/QLPE4CqOIi7GRH2S4B0bErKMR+pgOYD4+QgSD+LT4aOSps+IPJLupis18dWoZnPxB6GSwT+RQPBzWF+/FBcECGCiBtJIC5hkTv8UWTXZQNsgd1e9ZoDGvGZrsoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507714; c=relaxed/simple;
	bh=3q1Tc+MrlY6u6Ky9tvYSqDvsGzCxws0MVOkL7UJ6W/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uhkCzB84bVh8j7AY6o0iH86rxAAgSyjH3qfzouH38Hjh1b56TEwNd6mA1Vwx0F0dbmsnolhdrhCmDLzDgt0B9IkiMgnQnilOFAxtVXcUXl4fXySkYGxXnhxh0/d8rMq30FjrVrr9g8od+2S4ylcxMVqOsadBguoV+0ChGga8JxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSchksLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSchksLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A141F000E9;
	Wed,  8 Jul 2026 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783507708;
	bh=0WzWp+5C4fvgBzmdEdAvq+313zf+Oq7pz9+UW3Z/Zm4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSchksLcPCvRlayQvME9Q3370NloUZsuppJ/gWAjzwQgMBMEN4nKMw3jvzpyW4Kcf
	 iPDDtt6Lq8DIdWBDU6APa5OBrIEX3+9CvUShdxfwHsC6LXzH4ZrnIH60uZmMd5W7/H
	 L7JKe8tQjnHI8PPlNuLr8j59TZcpAgf0RaMe7iF5uENp4JqcxGEkWXi/1c+JXSa2AQ
	 Qgtx268BcfXxhFY+yYGp/zr4+a0W2krwXzHAmaAerAN+SiAEXA3+p7z/1lnc0VVaf/
	 uKFIErs365q8eCHVf3chaNBv0TIfSc2eBlCZgmMTHtz2eJSyEE2kUNYrNSWRadcJWS
	 CjbfGuQuoH/CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 9/9] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-10-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:48:27 +0000
Message-Id: <20260708104828.01A141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the instantiation of devices described by a device-tree overlay
> applied on a PCI device, devlink displays the following kind of debug
> messages instead of creating the expected links:
>    'Not linking xxxx - might never become dev'
>=20
> Without those expected links, the device removal order cannot be
> correct.
>=20
> Those debug traces are printed by fw_devlink_create_devlink(). In our
> use case, they are all printed because the supplier of the link has at
> least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
> set.
>=20
> The culprit ancestor is the PCI root bridge.
>=20
> [ ... ]
> are correctly created.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D9

