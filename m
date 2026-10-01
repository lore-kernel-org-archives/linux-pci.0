Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F31332614;
	Thu,  1 Oct 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865396; cv=none; b=djQjJpmE9IVLpMdC2vnrYnXt09EkLLfQeRS3Wogatrv1csHThpJ9zEGpMMn+0aW8GDEs1CHjm+EHDVA8Jt9JFLFTNny3i0G6DXUf4PgYG4AjQaYRFc3APmG70tfL/6NlKmLgzaYymCGA0KmfTJ6fn/1QpEDlGkWpPic3nA70KWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865396; c=relaxed/simple;
	bh=o1uTRDcr5N8/eHlHw94omr0DwFbhZiH7rosqD9ypzQU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=drUoJ8m1R3I810H6fZkHjbHHygcqswW7UarCopIIS2fNsqxd+UJgCZsc9ZVBFvRgn8TPFb0Yfnx8mJkowsr3IIur0va9L8j1fVjA/2Lz7WwLn1AtmbhXj0yQszUKZhCuOizQ0j2Wecqddifn0cLZHNHeYRgkX6EK8qiEHALs8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZAd0zRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZAd0zRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901311F00898;
	Thu,  1 Oct 2026 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865390;
	bh=o1uTRDcr5N8/eHlHw94omr0DwFbhZiH7rosqD9ypzQU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZAd0zRbkaZmbmjdEpoXTSV8LH+vk9dX8NlhWXRrFIhhCxVvBP/4QdmZzRozn5RZV
	 XR5k2rr9mzcuY5cI537I9E2on8kwPU76Kfsad8+7AohA+bse7fttDi5spONOe21vbE
	 +7rWpryhpu3I95Q6PpsjQ3o2p+aka1cx/2JGa50W6+eCI2Lx4P3uPdd/eGP+wPXXH/
	 9VHYsM+fEgrUxRhjCKdzjy+BJjFTfbbcqQOovB+dsKbtdkrT88/6C/9bHPdJ8narIH
	 umBK7Rj2DUWYYoy+ObK8O4AisOZHEvlIJN/njev3FZ/SdXruv/y8QFCC2HNziVOpzs
	 Y4lTaEcwOjTKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/10] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001142815.277550-2-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:36:30 +0000
Message-Id: <20261001143630.901311F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D1

