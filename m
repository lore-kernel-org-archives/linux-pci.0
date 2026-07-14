Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9E44C669
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057787; cv=none; b=I6RZ3+JRAyQAAmim8Id/VtEbin/TgODMFhrACcejoWN9lgu03olVx+AUgdEvD5S0GCmQQgrmATeCeE03oOXEPMTZW5ILXmazmTYpBWqbC8OD8c2EPs1PvjeiuVTJ2LflmaoJp7M/j2brs48IXeUmRkpW1LUbaBRvZ2echWDXE00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057787; c=relaxed/simple;
	bh=u2WUOhMOXTi2I6+s7tN9z/BI5ImR58/zdAHHm5p9Qv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlMMxIcl6GjkQTNsAVam3/8rXQPS73F1QCDIaW44mLHFF+/0nnTPkWiughB2fXQT91oSuK+fJehFGuMuzOXDMe3m2f65rMaZHexL/UTIld2dhEtg/UzZAiId0woFBF1Q37kEUIbGmpGKtuCQBiZkajAK7wwCuIWKVlm1etyINuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg7rLEch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg7rLEch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29851F000E9;
	Tue, 14 Jul 2026 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784057786;
	bh=u2WUOhMOXTi2I6+s7tN9z/BI5ImR58/zdAHHm5p9Qv4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kg7rLEchS1ws6e50YGoYN0LhDHhpWIqNuvTIIQQyFd4W6bXfrAPKLjRzx06C9FWAx
	 G3qvkZmVzJBXuE63cVIIaxhvJlvOoixzVDsueu9pKDIvj3+NGcW1+h48bD+d6ftSZM
	 WosQDdmqVxYMOx3LrR6HiAMXVdMk5ZhXMTS56PbKc/l5VlxXpJXQYCPylL6DwCvZaU
	 Y75eijGCyjCKRitGea736khXGl3XucIwDBUkSwsMRm6w/Ry0ETMKMk2gVwY7qh/Yp8
	 z0u+RqZO8nKuvcLqrX+SFm58rcmZhOx1fZNXxpT7pNM5zeeRA6CfYrQgPkXeROP6Rz
	 k9fH5qFOV/bDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] PCI/VGA: Convert to use
 acpi_dev_is_video_device() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714185915.865396-6-andriy.shevchenko@linux.intel.com>
References: <20260714185915.865396-1-andriy.shevchenko@linux.intel.com>
 <20260714185915.865396-6-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:36:25 +0000
Message-Id: <20260714193625.C29851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace open coded variant of acpi_dev_is_video_device() helper.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714185915.8653=
96-1-andriy.shevchenko@linux.intel.com?part=3D5

