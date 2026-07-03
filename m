Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881637756F;
	Fri,  3 Jul 2026 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062717; cv=none; b=ZU3dA1zYuqdb6a09GJB4CT1pD6myzljkb4pHX6dm6y2kBOqbpHu069yEuPFsw8X/vLYrRH1ll1S0031RexRHMO7dk0PE2/GkQ30FwUP6ZRNnEFvzmac5npV3vLf5QXzgffrsgcz3uduTfWP6CaGmsfO1gLyJktH9HDc9Nve2mGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062717; c=relaxed/simple;
	bh=0nwfuLIhb8ehv4aeFOOgM6KKzjp/tMqRwkaNOUinrYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnn54XpvmJVDlTtcmoGcvKB8s+az/W+hTCeMzk9FhKlNYP7rrlpiKoRquFqzFr/gY8eu0wbIuw8gLXrdaqqnZoYHz+m5M+RaTZP7ebeCk3Sz2d2rjrCZd5Ps/I8Y/xkt2R8ugKcumTuqesjRNzOKGEF5+AFR6fO0P70GLBAZczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N54amIAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N54amIAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149781F000E9;
	Fri,  3 Jul 2026 07:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062715;
	bh=0nwfuLIhb8ehv4aeFOOgM6KKzjp/tMqRwkaNOUinrYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N54amIANoXOnaWmydpNzkvtOg/2ivWlJjqRfjxZmogrFCaqVGF9PaA9u+vLCJzrXy
	 24n86h/nbP/w03LsLMqXGPvhHxKuzSNUGZBwwOvuaqCrhzLKcHmT7J13BON4kMeuQ0
	 X26beL3Fo13EVZtedBIybVoe9Rh6BsG10CcEI0WAtdhmSXEBwUtZEr4dh0u1BWiSdv
	 LBC8q3I7ftqubJH1fa/fD8fSYuarP1BrSP5sxHX5wfOEJxjO53744YFM+R3rkOmyJo
	 eVLOB1F+ZPg94mFUfGZlmx52U0KqwZ2BKeaoteMOjp2Xb4fA9PuDG7STkf8EpD/MrD
	 /VHwhZJYIpqag==
Date: Fri, 3 Jul 2026 09:11:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Message-ID: <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>

On Thu, Jul 02, 2026 at 12:46:13PM +0200, Loic Poulain wrote:
> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package

Why do we need device nodes for soldered connectors? Soldered stuff is
afixed one, not connectable connector, thus it has no point in DT
representation.

Best regards,
Krzysztof

