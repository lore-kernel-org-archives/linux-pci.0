Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042093D9549
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786738751; cv=none; b=aSUlca7APZvtSKwxUmAG4nHfNmN7tm5cvJlJg/IP4kJoVJaCxDvN3QNbgVOzf16caAiI00+SIxFgvbU9zeT7CNLauobivgEMWRLwlk+SSspw9w3I1oGDGXJ6Azh2Lj8ylvHY/w3P2IwYIEADgDhHqTll0u1/4WoLBqqqslxJ/7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786738751; c=relaxed/simple;
	bh=au40n6kHW+qwB/H0YuGeTxAqukfERDl2x6LQKJuooC8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJSMSMdxEO8/TMLdE9ME4+c/kH7+boWid9NL5yFRCYCmVAzqcFuLP7o58v2OCUBYgzEJWY5BqUShTkUTGUSLoR8hzbxsY7bDAYjlEw3k34R2U+nOkiSLfoZsSyHneRTwv4pxqtcQQyXnpJMFU93skmtQ4oC+ERD8iFg4DG1V2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3YCmyua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3YCmyua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E1A1F000E9;
	Fri, 14 Aug 2026 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786738749;
	bh=jQoBHvlgzS/BsOCSrz95zAP7GA6NEbTsAD9k3Bh/j6E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B3YCmyuaKMg9U7NebKvESuf2mO7vAXyQVVU0IabwAMxZOrI2nQoqF9O1K/BJUBqw0
	 0fQEnMVOM+uMM7w98ihK6J9pYiQxEaQRhDF4bOI/WVlAxSJcTJnfcQM+ThvaTZwC1v
	 h9MbMAOA5NTUeW+zyqkP50bz+EA9HjclPM1nUFn/B9339arXVKcxphq3Wsb5yGmWkr
	 YP8Hcypxcx4WufwikLqy2KeW2iWRSjV8+URD9QgdoWIae53zyN6yJEs8OBn/El+qB2
	 ehTFG5URIfSDbE0pzOX3EXN97OcWieT2sb2//niihqFNQqe2vnqSIaPaZk0s0QEROn
	 LJWjxg4wAbIlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 1/5] PCI: Add DEV3 14-Bit Tag Requester register
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814201621.2281245-2-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-2-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:19:08 +0000
Message-Id: <20260814201909.58E1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Device 3 Extended Capability advertises 14-Bit Tag Requester support
> in bit 2 of the Device 3 Capabilities register and carries the matching
> enable in bit 2 of the Device 3 Control register.  Only the register
> offsets and DEV3_STA.Segment Captured are defined today.
>=20
> Add both 14-Bit Tag Requester bit definitions.  There is deliberately no
> completer counterpart: a completer reflects the Tag field of the request
> it answers, so the spec defines a 14-Bit Tag Completer Supported bit but
> no completer enable, and software has nothing to program there.
>=20
> No functional change.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814201621.2281=
245-1-vidyas@nvidia.com?part=3D1

