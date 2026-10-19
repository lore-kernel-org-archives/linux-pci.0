Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2549364A
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399344; cv=none; b=V0g/RcFKKz9sHBTK5SgB4xyXCHpdKyqHwiNsJa3Ydphd+tzX1uNtSx6fSvkYq6dAgcaz99zHuYgg+mFJqXA6cp9j7X+3uhlmKyU8LCgfz3J/4GN/16FckR2pL+acnEnMaO9eKgp9hHIwtp6FScxzRQXQstSsWdyWR8/PEKERaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399344; c=relaxed/simple;
	bh=lFs2E0AeiCYMcJFpGLqmC3zUrspTUYl6jM9VpcLR7Rc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=SLTdezCpJweEluZ329Rbe3TVHQhKvKzuV0TfNlbKaQEOdroRZ0FsMpEPezY4o+KuUJIwbqrzXnhcx52DdMh1igNZyJjQJsdEX5vVt5Y7XYTDhRkYSbSSMmlXlZkbTwizKWQJFzpKpufyxx/Ud5XsAWnBJplQpIPMkNO1sI3zzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKZHJ7sL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKZHJ7sL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314FF1F000C4;
	Mon, 19 Oct 2026 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399343;
	bh=lFs2E0AeiCYMcJFpGLqmC3zUrspTUYl6jM9VpcLR7Rc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MKZHJ7sLcARd6SO+oXCuQX/pbuQYCjs4AwDr0bp3Ln6XgBS6a/J6j+E+ctAzZ1nPO
	 ZfWwYPQe6R9DdNUNmjy3d6wX7Os4zKEywcA32vw0B49y3LZtDiaWjqTQKwvbY1cm2N
	 hhvv9RT6Sn3+FjTZ81GbrzLxyBvRFtILvgUkd0YsdTe+ct6NeJ9f37nkjKYvwwy3Vv
	 WQiEvCMbMHjtgqfeJcJFjofwqef7s8ckbzbv1y+qMBWFS4Az7xGUsGgZlvfRa/GM12
	 0vXxYA6pErVPx4olNbveo1P7vvPH6ci2SCD4nECyBvTy5meQnVTiFeii1nVguResmU
	 THqWK/1NFOOPQ==
Message-ID: <sashiko-outbox-176826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 07/13] i40e: Drop VF MSI state restore from PF
 reset_done
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261019083514.838640-8-lukasz.laguna@intel.com>
References: <20261019083514.838640-1-lukasz.laguna@intel.com>
 <20261019083514.838640-8-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:42:22 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCI core now saves and restores the config state of all enabled VFs
> around PF reset, including MSI state. Remove the driver-specific
> restore, as it's redundant now.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019083514.8386=
40-1-lukasz.laguna@intel.com?part=3D7

