Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA8C235358;
	Tue, 10 Mar 2026 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169966; cv=none; b=ter5XUzxyC5ZvGp+mXOrM95FpatxXrsrY5dWqZDvCi/TtsgZv3IR0gPlw+gi2N8LlYOKFNIr62slUUMl5b+IlBxaQj794fUHGBl5ZncwV1cb4edp513bfENawru39GpjmBy/j+xTTT3otE5KkYUJHIvZLsT4R3q9N1BGdmV0nYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169966; c=relaxed/simple;
	bh=pchNCTeWBuIso3MqwEPQmTgbMDOHGghbyhTfYohp4bg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h0Kib3fZB5Rbkq31LFdFGasCPCuMTLqaZjwUo48cz9fgC7vDezoFWD9NK8RsYM1rP8oFBvf3Rz39pyt/6gNS6oQikNm7QL8aDEp/CS/3QQQvOVbOr7D4ilW8evtsG0Y/2uUCxU8cyJbXUCF89pNNGbqQgFTYhmQkiDiXnYctDkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFCo6esZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFCo6esZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF093C19425;
	Tue, 10 Mar 2026 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169966;
	bh=pchNCTeWBuIso3MqwEPQmTgbMDOHGghbyhTfYohp4bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tFCo6esZ0UfkFMOz+12yP46Mo5PdFq+bIZlJtZQ/1e+HveqqKMRvyLSsvaDPEBToS
	 2hAu7WkTh3u3DANL56eyowAhOHD0vS0uTRH848akwwprtl/sQdM0Gu/9CUWMTW4/KM
	 ozhoWBSgcpz5H0RhGHkyeOOz2VRH1nW1ksA/N5VJQWklKLvSMnw+V6QRyxGPJ6Ibhr
	 lcL8c6v6g/H0JDjXGfrk3ioXy4BYEYw5sGi64KHX/P0FpVIzrkAPolK835k/aKAm2l
	 f8yGd9z9tuzb2zzLRAVLweWCUDg9MKTq+3C7e3BltrCqkW1Enf+xnTBzZ9yvOjYkNT
	 gaH60bidebVig==
Date: Tue, 10 Mar 2026 14:12:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, Frank.Li@nxp.com,
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/13] pci-imx6: Add support for parsing the reset
 property in new Root Port binding
Message-ID: <20260310191244.GA764308@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310015426.365675-1-sherry.sun@nxp.com>

On Tue, Mar 10, 2026 at 09:54:13AM +0800, Sherry Sun wrote:
> This patch set adds support for parsing the reset property in new Root Port
> binding in pci-imx6 driver, similar to the implementation in the qcom pcie
> driver[1].

What is this series based on?  It doesn't apply to v7.0-rc1
(preferred) or pci/next.
