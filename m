Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450648;
	b=DSYnG0B0qSiuUwGrfA0Ww5pgcWIQOG6GXEBJgfyTUc6zc6Bw5AOk3RvUCVbbGhIaPQBA
	 9EXd8txMm/2k8igcYEgn5IXP0hJWmWcDJ9CUDFNUcSjdKdayZDydzpqB7lKgqzkLP033x
	 oZz6z0Io00X4WtUj/vUSRdoNHzFSREOpRC/G0Zs+wc3v+Db5Umjn174V5a8tOYO88HKBd
	 Ho7N7ByqCFntAAPLiRMx/1rvMrqlAWns1k34p4W8AibEPe2Q7OhsM5eBtW551gAujg9bP
	 wC5JmwuihVMPbioW/3/0WnxJNRHJqbdNaGpfzKS6wHQ27L+vptvkFDChfIrWQ054VKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xC2iRdavxA33k/5dHlcDqZFWkCm0IuqbjvsacQ1r/f8=;
	b=QvMBzD5fBxNpG7/0TptGGGBUWdKWEcYXWXvtqRuFjc8kUCuZJkouq03xJUD/4eLbP+q3
	 MYUEXNauN3Rg0lu9y9j8wPkn98wfWF4P+E/SkVLBKuLX/4tMgB1B+TldjX/aj5eeolGMl
	 9qvYfaBDWZGwbZXJV8g51fcFwIPDh6gD+IqhdmZUeWQs0D1XsJS4lUSGi7+c8ruB9U/Ik
	 uAk9JQvUdc57xTmEd2bQps/vPch5Xf/uaFyyo7dsMvw1yhIBaTFewqa1aJ0mL/de2FkPQ
	 UnBM0nzJ36tYbukx0lLDdKqmCrc9tyEtd3kbWwlUjTUwb7IsSPVSScDpYhUy8ZotE3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY6dJap6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A4606A323
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BY6dJap6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248841F00A0A;
	Thu, 12 Nov 2026 02:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794450647;
	bh=xC2iRdavxA33k/5dHlcDqZFWkCm0IuqbjvsacQ1r/f8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BY6dJap6bhiWXPPHs14l7QLlpeh/BOeYBOEKxbqOo+4j+XgE0w7bO1FfSTUPZAW6K
	 5A6CWSlR2lGn7Qt4E7iAC4OdtI77pBC+vwoAd2JgMHYOv5pfULIeCYYCZ/51R/bsIP
	 pCzvY3GUZRmlWBWM5+VPb/RPxEp0BMaVHOH4aLzQEh4UgcyLbR9zVt6f2Hfq5x9ki4
	 8mjjmStZvq4vkP5m4in/SMU1s9lpZzfB4RV5c4/EuDALRmPStG19k9GlBgMxuR+WLl
	 Zq+AjZm5aV0GKvWQBW5rebiPmlKQFJknNZ8hNI8qyQ8l63yvdQQEEeUfxkaOGuF8DS
	 iTcfn4SKGHN+w==
Message-ID: <sashiko-outbox-210197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] PCI: mediatek: Use pcie_get_link_speed()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261112022405.1230200-5-18255117159@163.com>
References: <20261112022405.1230200-1-18255117159@163.com>
 <20261112022405.1230200-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:30:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> MediaTek was added after pcie_get_link_speed() was introduced and still
> indexes pcie_link_speed[] directly.  Convert it to the helper so it does
> not depend on the array being exported and cannot go out of bounds on
> invalid speed values.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112022405.1230=
200-1-18255117159@163.com?part=3D4

