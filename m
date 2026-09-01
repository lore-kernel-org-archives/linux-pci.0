Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B64766A5;
	Tue,  1 Sep 2026 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255733; cv=none; b=kV4dqh4n7sse//O5A28Kfh0FUgolgcBqlh0vKCbp0evgy7dBflhfaGfapKAQkuFFFG3pM/w4ZP18RrzuigsqJdyEYy7sTQli1txM08WCgJy+2/8lkH8FgvMVT2gf03IX9sWE2gaiBRCO1dX3n4f5SvBu47LU/DgJXMHsthHa/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255733; c=relaxed/simple;
	bh=1BFufhe/xwNTvBFs03uF29vGS+gnhD695BxFIdNDxyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dtfwxc4nrh/qD1kGmJxSxoZgfEYJX7xeqn6nVolTHfxAeAplE/A5Fs0VKXONssWPOFJ/V3XzRQnMU1xajnMPVa8zTWP6lL/HvL0t4wsd9nSe/enlvxZYv2tW1oJibu1sAYWSzFU27djvNHa5hyGxoDe61/gv/bS6ZJybCMi8X0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpqdp64S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpqdp64S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC171F000E9;
	Tue,  1 Sep 2026 09:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255727;
	bh=1BFufhe/xwNTvBFs03uF29vGS+gnhD695BxFIdNDxyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bpqdp64Sk48OwznnwqhhYUaYFyEvvQBzfpfUhKeUaDYJMY30NPsZ97wfy4hqgvC34
	 X4/UvuT61e/wYEaaTGAuUZw3mW1eK6vcecqk+ECCtBK9NkD9nMPlbuOA+r0MwwEgkN
	 k6MQKgTH+0AP4NBl6uRPDSfM/PyGn+CzhB1yv4hOtxm0ls6PWi+izbfRKftliQHNIl
	 Czhaeono0Z6Xedda7NbgXMuVwF18swSlUOVw+KLEysFguH+oUEaDwJE8acaAl2P77g
	 74g9iso5SgLYPGJF2WjxqfPI0LrB7JXv7IUfEm/JiGANg7YBMfHCvp8w3tOgatXjYE
	 sZaG0XjCKq1aA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/19] vfio/pci: Serialize interrupt operations with
 recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-10-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-10-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:42:06 +0000
Message-Id: <20260901094206.BCC171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Hold recovery_lock for reading around INTx, MSI and MSI-X capability
> queries and configuration changes. ERR and REQ are software-only indexes
> and stay available while recovery blocks device access. INTx is covered
> by the same test even though its count comes from the virtual config
> space, so that one rule applies to every index which can reach hardware.
>=20
> The test is on the index alone, so a blocked device also refuses the few
> requests on those indexes which would not have touched it: signalling an
> eventfd for test purposes, and adding or removing the virqfd behind INTx
> masking. Both return -EIO until access is unblocked, which for a
> non-fatal error is the time the host takes to log it. Reading the flags
> or the count of a request is not enough to tell whether it reaches the
> device, and refusing a few extra requests for the length of an error
> event is cheaper than getting that classification wrong.
>=20
> Copy the IRQ payload from userspace before taking recovery_lock. The copy
> can fault, and with userfaultfd the fault is serviced by userspace, so
> holding the lock across it would let a user stall error_detected() for as
> long as it likes. The count read and the interrupt operation each take
> the lock for themselves.
>=20
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D9

