Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390B83DEAD1;
	Tue,  9 Jun 2026 07:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990520; cv=none; b=i7i5MTzooDDtPcTRHyna2RqySyKPm1smgM/4SPuGWSYZoyBE9LcY907KJH27dU+y9aERuOi8LgJMfK2vdPpPCexfrEYEoqaYcA6yZeoHLaQ0WyYv1+3oztkXubFWWya2BLy7eYLd9QcD5Azb9fm3wY9uYaZVhWW1JmGpeynEGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990520; c=relaxed/simple;
	bh=ATXEGcoKkNSQII+YlcHasrynV/Aez66zbrj8bQ6x57Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3VABW19ezkja27TxMWr0urhcIOLNCE0MSNW+fdodM8n8ZPv1KzQVK6sC453BmWPp+OawlejMM4BGeHi9Fun0lTcDhIfIiojg+5uAFw24V2cYPNQHmENdmFuf+v0OG/3e1eRK8a9bB8tJE+6qkVf8Eg2HfIlbIITMH+S3Q84bcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fREYq8xL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fREYq8xL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC661F00893;
	Tue,  9 Jun 2026 07:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780990519;
	bh=ATXEGcoKkNSQII+YlcHasrynV/Aez66zbrj8bQ6x57Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fREYq8xLUJt/1DEpZhM0r19wTpGD0BgNEykkJynqv3PZma7VYy5HksRI0UzTMKVrR
	 VrJ/ZSuhv7gXFSDwQElrjYwjDK9eatKwXre2KtQKqThbFWdsyAuZAbPzTB24yU/9A4
	 1Zq0ipNn4EeC4r+LDuW1iqVWZvxk2U6zVjsLe8Uq/oq0llNtmIlky3aJZTX30RNzLT
	 FtQg+amzUKJ/XTgZh46wWKWEFoTgL478XlvHI7KNrKNNA74xc5u8Ze1z5ihbJzjDIB
	 xI+dKfqBAVUSlJo1TEW5EjS+NcBzRADLbHU5T+CZmVJi6N/L53vz1qgVSSf//Xp1Ea
	 gE0mSssGnAlww==
Date: Tue, 9 Jun 2026 09:35:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Message-ID: <20260609-unique-magnificent-eel-eb623f@quoll>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
 <20260609034408.BC69D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609034408.BC69D1F00893@smtp.kernel.org>

On Tue, Jun 09, 2026 at 03:44:08AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The `vpcie3v3aux-supply` property describes a non-existent hardware feature on the M.2 Key E connector to work around a software policy.

Feels valid. Describe which pin on M2 connector are you representing.

Best regards,
Krzysztof

