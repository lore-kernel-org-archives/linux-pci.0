Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5E521234
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068240; cv=none; b=kw6d0KIhIpXRopEeC/yb7o1Mizy9kI3zZcQ+4TKAFhEHQ4cyJ490dyVL3Zp0MV1rqG3vWu73KQUnm9hPYcOSm/1g1ubCJZUKafFrEYFfU+AQemEHCpXt+C/nVfRHvVvC/nGxvIWNloTTr4+Eg0Te8QvpBABe+h7STC5QT4y+0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068240; c=relaxed/simple;
	bh=IGMGrXYoQoSMqfN4RRS08r54RjkM4+MtnCgB+WwPpL4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dhr3EN6q/mmbKY/vZvceEPUCcx6Wq9uwbe8o+egEk/xtIObf8Z+nk9g6wMtTxBtDMFihXtWkYl5ZmxhLHeiWv9mEb0Rz0lia7xsGbJFoVIMzM+EThBV4eyGy0Z1UFInGkpOzXoF9Ioju9ZaugYVWq+77UMRnRPqW6PrEZ3p/ooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoQy9/L5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoQy9/L5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E940C1F000C4;
	Thu, 15 Oct 2026 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068239;
	bh=IGMGrXYoQoSMqfN4RRS08r54RjkM4+MtnCgB+WwPpL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QoQy9/L5X9Gp6lpaHCIf4e4JcGkyZRhVg0xzTzlCzFApXaLwolDfUJxLufkVDSSST
	 eCoI4o8WeDixwNTQjX9RR3SisquI5F9oM3CfoTuFKWMW/YrflQNLBcRFnADur/Atwo
	 +/Z3daM6T/cPbOUszLcA6nAJFzf3NxSBarhw5lIQwgAR3LvhyUQjPs0XisMId3DF6E
	 5Du3pZUMTbPbSylwvYnYcT1SAKZ2zLW1aB8j1UX24A83Zc+Iu+zK3nIWxwWcE1Gxx2
	 io63Qh7rltoBSjNlWgLijijIj41L5eDm+daQcKFaZ8haqUmm5qdU6Ed6bkM5j4B09z
	 5BjuEBnnnrqIQ==
Message-ID: <sashiko-outbox-172853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] drm/tyr: mark read-only and write-only registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015-io-access-modes-v1-7-93611b84b5e3@collabora.com>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-7-93611b84b5e3@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:43:58 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The documentation in regs.rs describes some registers as read-only or
> write-only, but nothing enforces it, and most registers do not document
> a mode at all.
>=20
> Declare every read-only and write-only register with the `#[ro]` and
> `#[wo]` attributes of `register!`, so that writing a read-only register,
> or reading a write-only one, does not compile. The modes follow the
> documentation in regs.rs where there is one, and otherwise the register
> permissions in Arm's kbase driver for v10 GPUs. Both halves of a 64-bit
> register get the same mode, and so do the aliases of `GPU_COMMAND`.
>=20
> No existing access goes against these modes, so the driver code does not
> change.
>=20
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-io-access-=
modes-v1-0-93611b84b5e3@collabora.com?part=3D7

