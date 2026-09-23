Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22613559D6
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170313; cv=none; b=cCTrExmn4qXL6w/k1kg5GbS3asA1CbVjjEPd81CNzHaCs60RktK9ltuU+/iErvznVXgsN4HFqOpA6OnKLlyaxIs/dlSB2ouzvT/eqo2+ayxZq9SrgUkIjrYhXG81XPXyZ3RgQ2lf7eQ8oGA+YIaRanlMo+6K8qrStGQx8XneFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170313; c=relaxed/simple;
	bh=5Xt5vw3Mfxrnc7Vad79uFNvjIXg3y8En9mPFlkBnoPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i/9YNavWSHhJ7GRF+DYUdN+2WxZFj26ZajWt3wkh4l3dc5f/382DuAmj5bymfnLiJb054ix4LqbH/SM+35ucs8p/gAEZqTQ74B8XfJAG7UEaxOh5PN4e2RPdK0/ehzawWoSQtJzVjjcT0VckuKNXdLSaGOXernKyLHQYoqGiqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fet56xUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fet56xUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D231F000FF;
	Wed, 23 Sep 2026 13:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170311;
	bh=SGigdT1C2io8GxE9+l2SDWoKo9YtAmIJ/rx5nGJNj70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fet56xUIBgjt9fmniSspz1z/LA8YE9ONPhw3qFIR2lD8urx6SJq0b7uIdoB4EoTdu
	 qa3UGC4MgfZlaw/wnc0qiFbh4O9eNXxqKvByScZTNbALpp4RF7p9TSxZHe3fNJ+5Bt
	 ZqwAP2m7UFms2IPBw4FYtTuQQfzJ78WQYD6HH0T9RmzGsc6LcmD/O5ROI4+x22CHWw
	 BrPD/XSE4iQGA+vqQbS05DQbYhyr90Rx7bV8N00hWrFfM+4HFK/9RVbk6/E+X0/a6p
	 FiGg8cR6nvQuTlFIOYdE0iqBG557+FFp8rRyenkZzvAruG5w8hsLj3zw/26Ueia6xO
	 ipGgGoGzrUExw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] PCI: Fix composite resource sizing
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260923131757.7792-5-ilpo.jarvinen@linux.intel.com>
References: <20260923131757.7792-1-ilpo.jarvinen@linux.intel.com>
 <20260923131757.7792-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:31:51 +0000
Message-Id: <20260923133151.70D231F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: bridge window gap calculation Rule 2 underestimates required =
size
--

commit f9f2d66b1a5c96f99a75fc82cb40a5f073968dfb
Author: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

PCI: Fix composite resource sizing

This commit modifies the bridge window sizing algorithm to add a gap size
calculator. The calculator determines the empty space required because of
non-aligning composite child resources, such as VF BARs and bridge windows,
to ensure alignment constraints are met when resources are placed.

Link: https://lore.kernel.org/linux-pci/20260903063124.9316-1-nbritton@exab=
it.io/

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7ca0e9f4ffb63..9d828a59bd002 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
[ ... ]
> @@ -1164,6 +1164,76 @@ static inline resource_size_t calculate_mem_align(=
resource_size_t *aligns,
[ ... ]
> +static resource_size_t calculate_win_gap_size(struct pci_bus *bus,
> +					      struct resource *b_res,
> +					      resource_size_t win_align,
> +					      bool optional)
> +{
> +	resource_size_t safe_gap =3D 0, remainders =3D 0;
> +	unsigned int nonaligning =3D 0;
> +	struct pci_dev *dev;
[ ... ]
> +			nonaligning++;
> +			remainders +=3D remainder;
> +			safe_gap +=3D win_align - remainder;
> +		}
> +	}
> +
> +	if (nonaligning =3D=3D 2 && (remainders <=3D win_align))
> +		return win_align - remainders;

[Severity: High]
Does this logic underestimate the required gap size by assuming two remaind=
er
parts can perfectly share a single alignment block's padding without verify=
ing
if their individual alignment constraints allow tight packing?

If a parent PCI bus contains exactly two child resources (e.g., downstream
bridge windows) whose sizes are not multiples of the bus's max alignment, a=
nd
their size remainders sum to less than or equal to the max alignment, this
bypass avoids the safe_gap fallback.

For example, if two 10MB windows require 4MB alignment, this calculates a g=
ap
of (4 - (2+2)) =3D 0MB, resulting in a 20MB parent window. However, because=
 both
resources require 4MB alignment, if the first is placed at 0..10MB, the sec=
ond
must be placed at 12MB. This requires a 22MB total span, which exceeds the
calculated 20MB window.

Could this underestimation cause PCI resource assignment to fail during
enumeration for devices or downstream bridges, leaving them uninitialized?

> +
> +	if (nonaligning >=3D 2)
> +		return safe_gap;
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923131757.7792=
-1-ilpo.jarvinen@linux.intel.com?part=3D4
