Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064234078E5
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804751; cv=none; b=SSCyVjDoYo27Va5IUK8Q5rAXWncxYmMNVF7Ruft6cP8SBGoWyK9uaYmKgdebiZnyVS3fc55/NhUSBLaZaonNYXOMaN8YKQTg8raigQQLPAL1MZg1er01nDJgfYckH95vCXUjT3sBvT9HJR6c0olnsDG+IcyyWxDj95ivehPEd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804751; c=relaxed/simple;
	bh=iY668NGhBcuOu/rlNRHPMGCPuxjhVZJEzwteSy/p8UE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GwDbfnpUaTOglYPb8Hm/uxxJ5w9OFV/T/52TErXkCh2UE1KOIuwziefNjdjezF4x9xCJRBgVSJ1uYmcm0gbVmzJU3mCJaS/hdCzHgXCW6nekSj1avDAr97GYlEcnaUDHz1vzdHnPeSH/1Z103b06oItUY9QLSXNYQbUobru2ezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WamrsOBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WamrsOBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9061F000FF;
	Wed, 30 Sep 2026 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790804749;
	bh=rmQQOobtpIoqxOPSQuz50yMnve5e821Qv9rJ1Ebf0Nw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WamrsOBcSUGw2YVm6iA0xcOuC0hKU1YiSc1qs5F4zv4v6XoTNgz+mrfT9HmTPfigH
	 JvVMOULtPrba3Ux/1ybFSyilifm6/M0ACNRcz+T18Z7Gez0/kMsLaOhbPWYrA1+gL4
	 Gd4QIgp+xHj37HzcRBOrfVuMEh1YZlYMMWbbl2U7cuviNUufOfiDuJgIvwPKxEJWMr
	 txzCzTlm3PewHZnplJb8k+gbkUGlEKJ3JQLeANxahTNstnI4zTQ633JkTLNdY87mYI
	 2oxsP+K1LEHiooYsv9/EW86pgsywxXaJN9vONNzJroiv+B3px0ijOMnVJXo4aw+3ti
	 6EGv9qtMbz+Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] PCI/PM: Split out code from
 pci_pm_suspend_noirq() into helper
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930213923.566846-2-superm1@kernel.org>
References: <20260930213923.566846-1-superm1@kernel.org>
 <20260930213923.566846-2-superm1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 21:45:48 +0000
Message-Id: <20260930214549.7E9061F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In order to unify suspend and hibernate codepaths without code duplication
> the common code should be in common helpers.  Move it from
> pci_pm_suspend_noirq() into a helper.  No intended functional changes.
>=20
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930213923.5668=
46-1-superm1@kernel.org?part=3D1

