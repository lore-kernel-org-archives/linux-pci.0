Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE8C2F3632
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169954; cv=none; b=bXhJFz23Mzl6Rwi6dLjo0rfgl570xoF6J2Kb2jKgbZXvxT+HrZPK00wUSzqirbEj0pyGDuVYlXRJYSQyjAr7Gy+tufZKlmGCssT/tW3kG8h8D0eo6nTugW6HO+Da41G3xHeEwkkqKqF2e12LRN3ljXUCyyTdWsp7zteHbjEoTzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169954; c=relaxed/simple;
	bh=G1uvdDqvU/10/Vm/fpzYStiDH10ZbmKdOSLIJkcFCaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RnTvav4CL72NoPV0z8ZoNpHANOmgemJC9asMkt0LchpkuermXdtY5u/i3YDX2OA5dFnUG/qEe/If1iuq90kmUKIKMaLA/VbdwpZohXzNRWUjrLtSKMQsqpPLcCnxe9Qfh0RqtRi6sE/SPOxjbUAs2WWUCC/R/JA0v7wyjZuxsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFWYL3yD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFWYL3yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420141F000FF;
	Fri, 11 Sep 2026 23:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789169952;
	bh=G1uvdDqvU/10/Vm/fpzYStiDH10ZbmKdOSLIJkcFCaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mFWYL3yDQfxrzllyUvPlEH+vl6RkF/VR31JlDaS0rR4BX3xjYf1U/nAmbKO+VJM9u
	 h6rMpmzKhBr7ulvQgMgGN/OxjQvTPc0Yz7JOlhK1ZW6Q6tWVoZlvHNo3HGrbVXy46q
	 8o6SNEg8R98w/0KsaBK5wMu79U6upb/TUeE1QWrsCjn50tn7lemT5qIgKNRiEOPQ6d
	 K0dZI9KVLhOQojv7HTAzD2F38kba16iL33fcY2UXOVoO4cMzWpbJhgdJY7NzASAmSS
	 sAMwQqWVl1EZ/7utYZICR10BrNIzkJnS2UYsAVpF7wJcGBn2+QjEmJPWM7pQZfyImW
	 oG5sIfa84d76A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] PCI: brcmstb: Remove redundant const specifier
 for struct fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Quinlan" <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911233541.1650895-2-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
 <20260911233541.1650895-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:39:11 +0000
Message-Id: <20260911233912.420141F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> All of the variables using this particular structure are declared as cons=
t.
> There is no reason to declare its individual fields as being const.
>=20
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911233541.1650=
895-1-james.quinlan@broadcom.com?part=3D1

