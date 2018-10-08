Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3057EC677E4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 22:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7539213A2
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 22:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Xlyxg0AZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7539213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbeJIFuU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:50:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33770 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJIFuU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Oct 2018 01:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CWnpOOBkKQWogsEZ4LkgxknNLMlJeh3wZTnJLuTeg8E=; b=Xlyxg0AZvSgPNZhzc82L53il9
        Zlb6Pmskhd/umvwC3jwiVsIBd+M5D2kcC0vr0hqFI/BrKh+aiss/8Rb9PAp005jFB3YOk4CTSdl7r
        sTT4lUutf/t48sHij0AspRepR2gttbwD01Crx+egPzOrI2twx3U6tM+leARy99r2GXLgI=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g9e84-0003K2-9M; Mon, 08 Oct 2018 22:35:56 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7CBE0440078; Mon,  8 Oct 2018 23:35:55 +0100 (BST)
Date:   Mon, 8 Oct 2018 23:35:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linaro-kernel@lists.linaro.org,
        linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-build-reports@lists.linaro.org
Subject: Re: next-20181008 build: 2 failures 22 warnings (next-20181008)
Message-ID: <20181008223555.GC4440@sirena.org.uk>
References: <E1g9cV0-0008Sg-4U@optimist>
 <20181008212021.GB4440@sirena.org.uk>
 <20181008213006.GP120535@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
In-Reply-To: <20181008213006.GP120535@bhelgaas-glaptop.roam.corp.google.com>
X-Cookie: Save gas, don't eat beans.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 08, 2018 at 04:30:06PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 08, 2018 at 10:20:21PM +0100, Mark Brown wrote:

> > introduced in e3fbcc7c4b130(PCI/AER: Covertly inject errors with ftrace
> > hooks).  This field is not present on arm.

> I dropped e3fbcc7c4b130 and related patches already, so this should be gone
> in my current "next" branch (18b4baa4d9fc).

Great, thanks!

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu728oACgkQJNaLcl1U
h9AZKgf/XrttVoBik3Ae3xV3ITN2e/UhUOlxb95c666bag+2PI4WGvOF+roDvFUh
pa9yUWVjqaymcEp8dMuHcfea2miQWzbuQhfnijfRjzWA8DCvz5R2W5TJBPAuSk22
KzcF9sp+1tonxJK8M9mwz4I5/Gd5QPvH5txYvNGRdwLZClrayyhLfpyAhf4l1ZfO
Z/hM7BNR86IOOCQsjbhM3Kn+du4fsg6tigszMep0CuYzERBQaia5Syg+spYfDw1u
95ESxmwkA4OFBi9TU/DajKPqVlTLf+vmrHv+cNpXaQyTIc/slVpncy4Dr+j0AFWn
BaNGTV6sESBZjBaFsovP9IYqiPKt0Q==
=pUMI
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
