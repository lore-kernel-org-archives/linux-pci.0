Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB98214A6A
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940821; cv=none; b=J48FvMyJCqeGwX4MH1q5FkWjrlYPQTSlWiihDhnpYwMIgL8X/gKVYqbk8bKPNkinNmeVz89oDMcL5RD6P4n2/wux+QgEowZK/iPLWdXxOnDgfXGsEo2Bz0TsyVzwZjho3H/h5nZCSqCEUuMRQl4AaFdru6WljCPOaWtyGbxMnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940821; c=relaxed/simple;
	bh=L9PtSxaaXXK+9dbaaF4KODSkOMTTZQb+gSCiVpBwCFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkeLky3Oi/G8GsO+3qy8FyNfaam5zBOI7v0SXw436XXVPCPi6wzAuCQ9cl1bLDwq/OyURTKZdXeyscFir7MzvfRJHzlroueEicYPVLFhNXNXWkGED0JgPARQJXjF8AiPRGLEyeTW2W3LaPv1GVD70e3NHnoQW7IZXQ1t6c/aJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5033A2C02052;
	Thu, 26 Jun 2025 14:26:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 26BBD3C176D; Thu, 26 Jun 2025 14:26:56 +0200 (CEST)
Date: Thu, 26 Jun 2025 14:26:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "Jozef Matejcik (Nokia)" <jozef.matejcik@nokia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: pci_probe called concurrently in machine with 2 identical PCI
 devices causing race condition
Message-ID: <aF08kFNy8qrI8LvD@wunner.de>
References: <AS4PR07MB85085806C2BF5CC518D52808937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
 <aF04PxJ5WqIA7Je0@wunner.de>
 <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR07MB8508CA1516E932B243AC5139937AA@AS4PR07MB8508.eurprd07.prod.outlook.com>

On Thu, Jun 26, 2025 at 12:20:48PM +0000, Jozef Matejcik (Nokia) wrote:
> The driver keeps internal global array of initialized devices and their
> count.
[...]
> I know this can be fixed in the driver by proper locking

Right.

> However, I think this can happen in any machine with 2 identical
> PCI devices, because as far as I know, existing PCI drivers usually
> do not assume that probe function can be called from multiple threads.

That can happen all the time and it would be a bug in the driver
if it caused issues.

Thanks,

Lukas
