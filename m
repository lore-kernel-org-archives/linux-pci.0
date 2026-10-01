Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B2394498;
	Thu,  1 Oct 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865437; cv=none; b=MWPs8o0UWBP4bQHg+/GLQKO+dUnfYY8lRWozGAjdPGnNI6nXyb21LQKgi2aRC6xVlil6afzGtayLfc/W1WdicvCbNDm6U95jUCQ160pdjbS4XEav8lWi+xOICzgoTF7woaDxN5+6CZyBQTPi1wTfTLZezorsbLz3lGsKqVEcNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865437; c=relaxed/simple;
	bh=6BjYxq1CZvxwAl/7Re+gT6DM0tZI86U3T4kIInpe5og=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ww5rhrKikKm0SIsg9tRk8shzma/lAqB0qw2GgEVvUPQ8G6fHoHZDHglydremj5zHUMTgYTCjvgv651wVDP0faHeAnIIqwQulUmbl2cXmm3preqW/art0luD5KvSGRWqfvSvwoa32iwftk9n24H35i6gRdmNNzowV2Z2kzMnSXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPQofxiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPQofxiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D77D1F00898;
	Thu,  1 Oct 2026 14:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865432;
	bh=6BjYxq1CZvxwAl/7Re+gT6DM0tZI86U3T4kIInpe5og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hPQofxiGuxz8fdO+6jUinnO3yC7MnnXeuI7N21y5txTDhPRwsARl2V2kVcbxRhJTs
	 QamwCquYnlTyMZ9iepRUei3Iz6sDbESLflVkQAqbxQSg5k5sKo+9awULwvZV7L2r/j
	 UVTLdH2WOL97H2sBiLn/rcLpeT/aqdTRLeIJk4Ywke8FG1QaYF0LTmSaUJY0PyDBDm
	 0O5mvSxA68yXNu2rAdLoBiHbQJABKlorT4f0/IRYivKR/mdBHllDSLFLbgE8IohRUt
	 DDUpJCzPCngMyF4OPDb+E4cvXadJzQrUY9wcJnh6Nuor2KieNy5CV10JBZsscOq4Gb
	 /jdwGVxk60WSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/10] cxl/test: Use device_set_node()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001142815.277550-5-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:37:11 +0000
Message-Id: <20261001143712.2D77D1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly dev->fwnode.
>=20
> Use the dedicated helper to perform this operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D4

