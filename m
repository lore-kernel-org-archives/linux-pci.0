Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E79282F27;
	Sun, 11 Oct 2026 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685342; cv=none; b=Qr9QKyC6yVXO/8ahjOqCA6jGfdDAOOg2dNGzgFvr0wkrP6+xop3ntu4ueMPOF1O7MJOFEnndtkHzgv0zP+d0kQZsYrSf6VTTu+3xwsC3AfSvcOW3XFb9zup8ArRb3fOq2CA4a3m4uYsJrP8afJ0KFmZdSvyVr4ton7sKGTABkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685342; c=relaxed/simple;
	bh=VxcRzbw20TWCxK5pkphEPbSmLYLXwcg/kNlZITfScWk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DKeEX4eqId5zHNWmksbwQgwO/edsmbEI3JLC7BFZQHLIqinQq02ywyFYmWGROoctREOHP9zlcjXeJAU7TyYkAw2AskAoMcgTZTbuiONHAL5EGyB7Sl09Oiz48K8tzzf9zCXJxGF+LjvM3tMhtkHroV2pRQXImIwfics67ChvUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+PtV6Rr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+PtV6Rr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A35C1F000FF;
	Sun, 11 Oct 2026 02:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685341;
	bh=VxcRzbw20TWCxK5pkphEPbSmLYLXwcg/kNlZITfScWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l+PtV6Rr8xKx79AhQbNmAudsibUBhiRKqGeUj6fjt9lZ7Ponob0+V3hwF0PIKqhES
	 Xz9XoBfEGlUPR+jRkGfI1kM8QpWdh4c1qhwL68tHsvvvCJcW8Ol35fhMx52e8xZnKK
	 O6VVewHetcRiVYPSvoPkDPhSLEMq9K/fycPDqkbkzQj+Ui5o6bSf4W+nl7WDugsvGB
	 hkbhZqnnRQWBQ311T32UKOEnvhTh12PUI2BBPR7BJ0cIJlI/8pB7KOHpeMUAd+SpUH
	 KO6UUV+2LfKsT5aXAKjxJk2If8Pz1Ywi2SqH8pkTBsob3360NjzEKpMTAhzKHUlj9b
	 KCC7PkFb68FTg==
Message-ID: <sashiko-outbox-166972@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 05/16] cxl: Introduce endpoint HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261011021422.3428136-6-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:22:20 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Keep common decoder configuration in cxl_decoder_config and represent
> endpoint DPA skip in cxl_endpoint_decoder_settings. Share range
> programming, but keep endpoint skip and switch target-list writes in
> their respective commit paths.
>=20
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/co=
mmit/?id=3D20f9084b5b763238e2f18f629916bbbb46ec9f7d
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D5

