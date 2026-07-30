Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F240336167E
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785389852; cv=none; b=YprXMfVlEXwf59qI89auKlFKJ23/3yjg92RYaO1HaaZV275MU61A54l4KrQFFzlIPo3y22xUHbOrQm7fCXwX9ZsXyJAgVlj7UfzQGl+XfSDy1xc1EHbJRsbeqJr6lNfhmfm8VjXZrUAdlowO4jghcCHx0QAGL2TtMDOENjvjc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785389852; c=relaxed/simple;
	bh=TUaZscGRKanmRmWSGNPmJx2xI41MmX13UKhlJAgIME8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nMvlmP8bOAj6bZWuXmez6+blgaWvMpEboSQEUvb4uCIpZ7wWCL1P8eqU8IUKTzmMAFKCRQwArDTSMqbP6+FW5VJH5iC8l9Q4lnukLXe46j1ngAoyb7qU4k3foFWgz78wdpe98gwqYH/Fk6Z2iLukIEEgqDIdQ9JnqPiKoMRjRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELHm/Da0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELHm/Da0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760951F000E9;
	Thu, 30 Jul 2026 05:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785389851;
	bh=TUaZscGRKanmRmWSGNPmJx2xI41MmX13UKhlJAgIME8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELHm/Da0rJib1dLcpBRlVXVoxkCU10TQOSd+b9mjBOh+wGPvYfOi+kz0NzF0tCaJb
	 OrQzvcMPIV8kC4NyTtoEcUFpX1qHR4Njfg+gZAuuIUd54iqN58a2a2XAhu1PqZAI6b
	 isMLUNO2IkIbCxQXOAPkwi8YpJjOeP0uUC6ToDV2jd3ZGIRdSkeBuPg767VoIjLxdO
	 4W8FF4+Tc8UDXCIdIPPhMHIKbd0ooNvyyOektDAhuj/zRF9zFGw68GQE0GSJ4d0w1e
	 rJRi7LWwK/IsOhho8PLEs1LGsUFYcArFgMvgV+wlwTVgC2Nzh9mI2LmpTqNBpsVR8b
	 oXNRchZbGfplw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Remove unnecessary static initialization to false
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiwon Kang" <kkjiwon04@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730053337.22427-1-kkjiwon04@gmail.com>
References: <20260730053337.22427-1-kkjiwon04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 05:37:30 +0000
Message-Id: <20260730053731.760951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Static variables are zero-initialized by default, so explicitly
> initializing to false is redundant. Remove the initializer to
> follow kernel coding style.

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730053337.2242=
7-1-kkjiwon04@gmail.com?part=3D1

