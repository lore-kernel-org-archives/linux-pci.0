Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059A476687
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759803; cv=none; b=HqPbFs2vk8Zar1miNvIuqNciJ1xelC7DRQWruY7ycKMcdKEtGNL6sFmFmE+xCZIRJwtXSkYp2FzFZUj0hN4W/tbx4xjqOWEYJtUrjpEbpo2TBbPyf5u5+1wbPupZwY9Z/BXejJj3+Qrq/q8gdLxp8LRL0Uynni7KtZnoPGPD840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759803; c=relaxed/simple;
	bh=NDRpbQ4sm1m1yejnXXPWgnuqmvwEhMWUAZyecv7cai4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HP4NZX2vxLh7+S6DnemrpwiRT/x2Vs1fDWfGzwYHlxzMdC63gMOyTF5YOzBiWWAY1RaZlYislEztkypQ0E/ZOccdoLf0Ed4wE3WW4uAPQadqvArE5p9mxILs2R65xdP3T23WLB8BSIv/HZ7KmAOxbjue8VBR2KAJ4UnIoDYp5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEgjOEqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEgjOEqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365E1F000FF;
	Wed, 30 Sep 2026 09:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759801;
	bh=NDRpbQ4sm1m1yejnXXPWgnuqmvwEhMWUAZyecv7cai4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hEgjOEqgIjonWoX+4lXAMrw+ZV183FYitA/SSXouZzZoJyauUdqoZ+mY3HNw9ov0V
	 alVc5HeQ9o6ZukL1Zy0VCqDICbqTEgRQuI02/6jMdOtI6HmGqIoPUsJlqbu6cEsI9+
	 1ypBi8tzJ+MNuC6eAfmpcXMSO3FkUUTjCV20m2RWxlSQpyDY70BCE1/IZyTjP5704Y
	 i6PLdkMizkXxbJmvYlxO7yYut6pN1aUiu2EqPdFDyvZNiCPxmwCzM3rDlCrzk9CYMd
	 bSjBngcqj2fAC2CGZxBEVvlefPdbPFsiVBuWaoR6SsMMeCidsK/vw2kEF0MqwbgeuX
	 nekmqifhwkFMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Rename dw_pcie_allocate_domains to
 dw_pcie_allocate_msi_domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <1790734930-217000-2-git-send-email-shawn.lin@rock-chips.com>
References: <1790734930-217000-1-git-send-email-shawn.lin@rock-chips.com>
 <1790734930-217000-2-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:16:41 +0000
Message-Id: <20260930091641.7365E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Rename dw_pcie_allocate_domains() to dw_pcie_allocate_msi_domains() so th=
at
> the name says what it allocates and cannot be mistaken for a generic doma=
in
> allocator.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/1790734930-217000-1=
-git-send-email-shawn.lin@rock-chips.com?part=3D1

