Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3735E37FF5C
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140808; cv=none; b=ec1P95CXj5nZ5CBNVa+l0a2PgqiluzoKwh3QdkudHFj+weMs4ma7WWdmpGIy1pdo/B5gwcheXA2cBoMjB2MNNLD4pAMn4NTJWqW9NiRUIFTqzh6NrQbsk3xUjY0KC0XdRvlx+SeecSGjhikudr6DYwEOWy6k3SQvBXG0TuxOtdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140808; c=relaxed/simple;
	bh=nDljSIuX+8VTht2wTJZtuUhYWCcLJNbeMRhwunn0HSs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F6UurdYepSaCbe1s9gjfuQjs8o+M4uK8asmVmL+nGcgmCciqrg1jcmuZyPzJD6+C6UlSA2ZeyCfM4X2QK6zZie6f8DCaj+djGZ1EVjfcw5CneQHtzCtzzEnOd7dmye08S+OYF0HDlUqudkzbCC5iwctI4gbLdmbcsWe0mKgAg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzZtqLKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzZtqLKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E1FC2BCC9;
	Thu,  7 May 2026 08:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140807;
	bh=nDljSIuX+8VTht2wTJZtuUhYWCcLJNbeMRhwunn0HSs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PzZtqLKcS/5cUOKEGRsm28WurwksTaUja1+NZf5zw6kVbqBIf4N8PIuzKjJspA1DT
	 n6HxxsfoZT0Kfx1XFSXqRZUWTHHGOWWNyyCHtpH/bgndNjhmhT1d99pidnp6pnEHT/
	 DpmTF/2i2UPqocHeu2fi8y51o9uAeNifhU30YRqqCaNgM9kjqaRXIVVj/FVv8Ss9ke
	 tLNYje26U7ElA7xDOC6oW5VCnuzapmb9G1gHsAAFTo9oFWxzS8oLHFSeOcL+aRnsDp
	 BOw1pyLHUS6q15M+Y5y2z4LCnycDlV9/ARMGkyAdZholqINuVABis4O2uUtUeOpLUs
	 K7jwWDv1i4vRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 24/31] net: renesas: rswitch: include PHY
 provider header
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260505100523.1922388-25-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-25-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:06 +0000
Message-Id: <20260507080006.D0E1FC2BCC9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Pre-existing data races and flawed power/initialization state trac=
king (API abuse)
--

commit 2d0a78469a71c1f0b6d4b9cc19ca73b858d63917
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

net: renesas: rswitch: include PHY provider header

As a PHY consumer driver, the Renesas rswitch dereferences internal fields
of struct phy, which is being made an opaque pointer. This commit works
around the new boundary by explicitly including the internal PHY provider
header to keep the driver working as before.

Link: https://lore.kernel.org/linux-phy/20260211194541.cdmibrpfn6ej6e74@skb=
uf/

> diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/et=
hernet/renesas/rswitch_main.c
> index 6fe964816322a..132be5f15073c 100644
> --- a/drivers/net/ethernet/renesas/rswitch_main.c
> +++ b/drivers/net/ethernet/renesas/rswitch_main.c
> @@ -27,6 +27,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sys_soc.h>
> =20
> +#include "../../../phy/phy-provider.h" /* FIXME */

This isn't a new regression, but while the commit message notes this driver
needs a complete rethink, actively preserving this behavior by including the
provider header bypasses the boundary and leaves a race condition and logic
error intact.

Could the driver track its own power and initialization states locally inst=
ead
of relying on the internal global state of the generic PHY framework?

In rswitch_adjust_link(), the driver reads rdev->serdes->power_count
without holding phy->mutex:

rswitch_main.c:rswitch_adjust_link() {
...
		if (phydev->link)
			phy_power_on(rdev->serdes);
		else if (rdev->serdes->power_count)
			phy_power_off(rdev->serdes);
...
}

Can this lockless access create a TOCTOU (Time-Of-Check to Time-Of-Use)
data race?

Furthermore, because multiple ports can share the same PHY in a QSGMII setu=
p,
does using the global power_count to deduce this port's state cause logic
errors?

If Port A's phy_power_on() fails, but Port B subsequently turns on the PHY,
Port A will read power_count > 0. When Port A's link goes down, won't it
incorrectly call phy_power_off(), stealing Port B's power vote and turning
off the shared PHY while it is still in use by Port B?

Similarly, in renesas_eth_sw_suspend(), init_count is read without a lock:

rswitch_main.c:renesas_eth_sw_suspend() {
...
		if (priv->rdev[i]->serdes->init_count)
			phy_exit(priv->rdev[i]->serdes);
...
}

Would it be safer to add local boolean flags (e.g., bool serdes_power_on or
bool serdes_init_done) directly to struct rswitch_device to track successful
calls?

>  #include "rswitch.h"
>  #include "rswitch_l2.h"
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D24
