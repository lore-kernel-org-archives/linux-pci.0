Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862E527592
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897590; cv=none; b=Xitt5BJivUC78/EwRz9H8DXv9ohB+NJ/i2piO1rR8L/f/UjE3/CShxElrFA6ZWziANG1gq8BWS6Jh3YGL/yl+gYk9zeFBojhpAwcDbGLJfCFSiBDrl3cy6QyksgEiN02+AJe4p4AJ8z85DwHfBud1VOtR3d3PLdsvq1OYLs3aTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897590; c=relaxed/simple;
	bh=0TA2fu4qweH6sCim0fvYlyKjBdBXChJisXsvydZy0BI=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=dnyDe6OdBzijgEPvQ8+oXN+ZIuSyZYEWbHwXyX1iNmPOtOa/V6AR46dgUhQ3TDzAchOHolUAOcFKuDHv8ao7ekoOOgp/gL5oDy0Nh4J9VlH6LTZ6zaWqMZJoU2CrGv0/271HlKtIiBtlQuddb42zdv9EifLKBdH4f18/WTPW4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBBRezhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBBRezhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0621F000FF;
	Tue, 13 Oct 2026 13:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897589;
	bh=0TA2fu4qweH6sCim0fvYlyKjBdBXChJisXsvydZy0BI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OBBRezhqzru1FF9MKe7ogI6qMfkew/jbpSIR+SSkOys8TiDTne9fxeSJ8p5SOf8fu
	 Ad7+08ee7uwUJMDL2HZt7NW8qtgx9h7FDNmCFYWUGnHvJbuHFs/2Jz4dHSkQ44xPML
	 YI/wzUtq6WIxPRc/71Zu5qwwk7FM4PHgRYn0GZgGWQKQqjljyO9Ume7A1k+ZBmnP0N
	 63sxRj9oV/bvXX7CNwcFwqIQ27wlm6i6qk4LQw6k0jQ/+mcsljfdM5yfmYPvcVU3dU
	 galwXPrJxH0+tonu0az5VlwfNS2BuF26JV9/uASzvgYJ6d2mRoFutozikoREX/J8j5
	 ++Htf0XaZtkpw==
Message-ID: <sashiko-outbox-169793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/8] PCI: Place resources to either edge of the
 window
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261013130948.6231-7-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 13:19:48 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> PCI resource assignment phase based on a greedy algorithm. The
> resources are assigned in descending order of required alignment.
> Because the PCI BARs are power-of-two sized resources, it mostly works
> (bridge windows and VF BARs are composite resources that might not
> necessarily have power-of-two size but internally they are still
> composed of BARs).
>=20
> The resource assignment prior to the commit 9036bd0efcb6 ("PCI: Align
> head space better") placed resource to/towards the left edge of the
> window. The commit 9036bd0efcb6 ("PCI: Align head space better")
> altered assignment for resources whose size is not a perfect multiple
> of the required alignment by moving the remainder before the left edge
> of the window if possible.
>=20
> The behavior after the commit 9036bd0efcb6 ("PCI: Align head space
> [ ... ]
> Tested-by: Alexey Fomenko <alexey.fomenko@intel.com>
> Reported-by: Eric Auger <eauger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nikolas Joshua Britton <nbritton@exabit.io>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013130948.6231=
-1-ilpo.jarvinen@linux.intel.com?part=3D6

