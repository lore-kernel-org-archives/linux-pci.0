Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF1389106;
	Tue,  1 Sep 2026 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255840; cv=none; b=ZM76N0OL+cMhx4emUu1gSL1yXqJfkY6IViPwjVNFB8FmsTwl3IH8OWKncumS+MdZEPmnG09IINtbo1HCwn7CgNyzgs29xB2mmYF1ooi947ITSvEF52M/4iW/18smFL24ekS+hCE/H0jNrvL9QBY0V7KJuWwljPkDYTv1CT6XKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255840; c=relaxed/simple;
	bh=E+aK7rLDFtKURQtDZZeD2jnx2eapjwJHsCRCYnZ/fo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JMCkRGYso49vi68RT1PXoSP5fHImBfu0nsxUQCCBYqR+PxQUnn+EWLxwOVHOZo5B5DYb1HatW3LTcKeXt3JC32ktpB34po+1TSjZjmwDaRIz/1NLUwcjKmsz6xagmPO8OYfkdEmD6Cvjnt3oX1EBcj9gJK0Eo8a85O6BW94qKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GM4rZS1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GM4rZS1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A00A1F000E9;
	Tue,  1 Sep 2026 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255832;
	bh=E+aK7rLDFtKURQtDZZeD2jnx2eapjwJHsCRCYnZ/fo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GM4rZS1T88Jb+gAo9Cko9MadNyqbLqNEhidv9OAHLfHEbl2ybQshdxUneJf+bzdv8
	 ysa3dir4strXqhz5sXa84nIvpvjNIr5c2e9Nje7UMTTzJZ0qNUftsvTbUgjhwtAFy1
	 0Dsn8ykYVaJs6MOjOMxM/2kFPt6nWnTLK5+Foveq+XA7PXrfk8XlaEuXSYBxB1p2Jm
	 hMMafg5rDe8RCtNyh2TR4c04jCKFQgVndT2zDjyG/RZ+2MqWmI6q1rizgErB21fJG2
	 j/tW9bzpX1x2pimw2GBdTb8liw01cQFF5SU2kl1nT/Bp5HMBUTkdLzTFbRGWKNvRzj
	 WwXsNOvMLBbQQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 13/19] vfio/pci: Serialize DMA-BUF export with
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260901093217.8539-14-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:43:52 +0000
Message-Id: <20260901094352.9A00A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move the BAR iomap check under recovery_lock and hold the lock for
> reading from there until the export is on vdev->dmabufs, so recovery
> cannot invalidate the mapping in between. An export attempted while
> access is blocked is refused by vfio_pci_core_access_begin() like any
> other device access.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D13

