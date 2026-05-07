Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F79371CF1
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140811; cv=none; b=tj0Y3c4cHwJm/D0PfWPxh+xbnfL6nPQSXfAbIeYXZAgqrMjpTscDaJ4ahfvGYuLY/Rl0TfIZWkxVBXGoUhE7ncws/3+0E2ZAbF0hskqkwYGlZDqJtEf5QI0fCm5p8cKfkbAFdnYtQjnb/8kguw+deuxfPU/x01loahxZpCMAriE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140811; c=relaxed/simple;
	bh=hjnJXMERz2ZGC+zhl+PjUMkgbnKfSvTESDI2udLpX6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+g1RVjCuxPfGwe06mHBEb/3NWWGhXV5azsDiDoisEYMqpJVjSG31yKpWdFBGfUy8lyv5+XvgV3GeGnEYruwzOIh7kSkj0tSq0mgJi58dBCt+z6EBmXWDOCrZ/y/jUr58DZ5E00+Z4OddyNvWklb1mwlcELbfDU3qZNxBuLIEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1iFUoPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1iFUoPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3ADC2BCB8;
	Thu,  7 May 2026 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140810;
	bh=hjnJXMERz2ZGC+zhl+PjUMkgbnKfSvTESDI2udLpX6Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q1iFUoPxkiFtx8oMy3U72d2tHi3Z0xW+PVL1XSiTF4eAiZGQ+Ii7m+38z+NYZPxic
	 FGzaGMLeVI2UWVOAD9nU3Xv/WFKdxULJFvH17AV20doUhgfLGPj+qulNh4iWkuyi01
	 Cx/loD+kqu7zQlXu8k4mbtq8U6WjSR3Tne0Lo0BMXqh4tXI6bhL0vxPl7NrQlfc59+
	 Sxt2NrOHsSyQVVYJMZWDifmq8OCreYfNrZDy6EmStDQobZdOYS1vM4yjBi8fZjByCd
	 1ImODjPBay4cFFQ6SR83I0xU2GV2LxmzVdMwYh1Tq1W0Ir9c57aHRwbieeQhF5/aJA
	 mwOObCiNdRhXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 30/31] phy: remove temporary provider
 compatibility from consumer header
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-31-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-31-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 08:00:09 +0000
Message-Id: <20260507080010.3E3ADC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] include/linux/phy/phy.h becomes non-self-contained due to missing <=
linux/err.h> inclusion.
--

commit 84b3f602007ce4ccbcbb1ef2bc28094bd50acb5c
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

phy: remove temporary provider compatibility from consumer header

This commit hides the definition of struct phy from public view by removing
the inclusion of phy-provider.h from the consumer header phy.h.

> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index e65865b4acfe5..ccf7e83f103ae 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -12,8 +12,6 @@
> =20
>  #include <linux/phy/phy-props.h>
> =20
> -#include "../../../drivers/phy/phy-provider.h"

Does removing this inclusion also remove the implicit inclusion of
linux/err.h?

The fallback inline functions in phy.h (used when CONFIG_GENERIC_PHY is
disabled) rely on ERR_PTR, -ENOSYS, and -ENODEV. Without an explicit
inclusion of linux/err.h, this header may no longer be self-contained for
consumers when CONFIG_GENERIC_PHY is disabled.

> -
>  struct device;
>  struct device_node;
>  struct phy;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D30
